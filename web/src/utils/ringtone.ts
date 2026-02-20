/**
 * 铃声播放器 - 使用 Web Audio API 生成来电/去电铃声
 * 无需外部音频文件
 */

type RingtoneType = 'incoming' | 'outgoing';

class RingtonePlayer {
  private audioContext: AudioContext | null = null;
  private isPlaying = false;
  private loopTimer: ReturnType<typeof setTimeout> | null = null;
  private activeNodes: { osc: OscillatorNode; gain: GainNode }[] = [];

  private ensureContext(): AudioContext {
    if (!this.audioContext || this.audioContext.state === 'closed') {
      this.audioContext = new AudioContext();
    }
    return this.audioContext;
  }

  async play(type: RingtoneType): Promise<void> {
    this.stop();
    this.isPlaying = true;

    const ctx = this.ensureContext();
    if (ctx.state === 'suspended') {
      try { await ctx.resume(); } catch { /* ignore */ }
    }

    if (type === 'incoming') {
      this.loopIncoming();
    } else {
      this.loopOutgoing();
    }
  }

  stop(): void {
    this.isPlaying = false;
    if (this.loopTimer) {
      clearTimeout(this.loopTimer);
      this.loopTimer = null;
    }
    this.activeNodes.forEach(({ osc, gain }) => {
      try { osc.stop(); } catch { /* already stopped */ }
      try { osc.disconnect(); gain.disconnect(); } catch { /* ignore */ }
    });
    this.activeNodes = [];
  }

  /** 来电铃声：双音节 beep-beep，间隔 2s 循环 */
  private loopIncoming(): void {
    if (!this.isPlaying) return;
    this.beep(880, 0.15, 0);
    this.beep(880, 0.15, 0.25);
    this.loopTimer = setTimeout(() => this.loopIncoming(), 2500);
  }

  /** 去电回铃音：长音 1s，间隔 3s 循环 */
  private loopOutgoing(): void {
    if (!this.isPlaying) return;
    this.beep(440, 1.0, 0);
    this.loopTimer = setTimeout(() => this.loopOutgoing(), 4000);
  }

  private beep(frequency: number, duration: number, delay: number): void {
    try {
      const ctx = this.ensureContext();
      const osc = ctx.createOscillator();
      const gain = ctx.createGain();

      osc.type = 'sine';
      osc.frequency.value = frequency;
      gain.gain.value = 0.3;

      // 淡入淡出避免爆音
      const startTime = ctx.currentTime + delay;
      gain.gain.setValueAtTime(0, startTime);
      gain.gain.linearRampToValueAtTime(0.3, startTime + 0.02);
      gain.gain.setValueAtTime(0.3, startTime + duration - 0.02);
      gain.gain.linearRampToValueAtTime(0, startTime + duration);

      osc.connect(gain);
      gain.connect(ctx.destination);

      osc.start(startTime);
      osc.stop(startTime + duration);

      const entry = { osc, gain };
      this.activeNodes.push(entry);

      // 自动清理已结束的节点
      osc.onended = () => {
        try { osc.disconnect(); gain.disconnect(); } catch { /* ignore */ }
        const idx = this.activeNodes.indexOf(entry);
        if (idx >= 0) this.activeNodes.splice(idx, 1);
      };
    } catch {
      // AudioContext 不可用时静默失败
    }
  }
}

export const ringtone = new RingtonePlayer();
