# Wenping Ma, Xiaoting Yang, Licheng Jiao et al. - Video diffusion generation comprehensive review and open problems

Accepted: 15 July 2025 / Published online: 20 August 2025
© The Author(s) 2025
Extended author information available on the last page of the article
Video diffusion generation: comprehensive review and open
problems
Wenping Ma1 · Xiaoting Yang1 · Licheng Jiao1 · Lingling Li1 · Xu Liu1 · Fang Liu1 ·
Puhua Chen1 · Yuting Yang1 · Mengru Ma1 · Long Sun1 · Ruohan Zhang1 · Xueli Geng1 ·
Yuwei Guo1 · Shuyuan Yang1 · Zhixi Feng1
Artificial Intelligence Review (2025) 58:338
https://doi.org/10.1007/s10462-025-11331-6

## Abstract

Video generation has become an increasingly important component of AI-generated con­
tent (AIGC), owing to its rich semantic expressiveness and growing application potential.
Among various generative paradigms, diffusion models have recently gained prominence
due to their strong controllability, competitive visual quality, and compatibility with multi­
modal inputs. However, most existing surveys provide limited coverage of diffusion-based
video generation, often lacking systematic analysis and comprehensive comparisons. To
address this gap, this paper presents a thorough and structured review of diffusion models
for video generation. We first outline the theoretical foundations and core architectures of
diffusion models, and then the key design principles of representative methods for video
generation were introduced. We propose a unified taxonomy that categorizes over two
hundred methods, analyzing their key characteristics, strengths, and limitations. In addi­
tion, we compared the performance of classical methods and summarized commonly used
datasets and evaluation metrics in this field for ease of model benchmarking and selec­
tion. Finally, we discuss open problems and future research directions, aiming to provide
a valuable reference for both academic research and practical development.
Keywords  Review · AI-generated content (AIGC) · Video diffusion models · Video
generation
1  Introduction
At present, AI-generated content (AIGC) (Cao et al. 2023; Xu et al. 2024; Wu et al. 2023)
has become one of the mainstream directions in artificial intelligence and computer vision
(Voulodimos et  al. 2018), achieving significant breakthroughs across various domains.
AIGC enables intelligent functionalities such as speech synthesis (Zhang et al. 2023), image
generation (Epstein et al. 2023; Chen et al. 2025), and video generation (Singer et al. 2022;
Ho et al. 2022). Among these, video plays a particularly prominent role due to its rich
information content and dynamic semantics (Han and Xi 2020) in today’s digital era. Conse­
1 3
W. Ma et al.
quently, recent years have witnessed a surge in video generation algorithms driven by AIGC
technologies. Notably, diffusion-based video generation models (Song et al. 2024; Croitoru
et al. 2023; Yang et al. 2023) have emerged as a leading paradigm, gradually replacing tra­
ditional generative approaches (Chu et al. 2020; Pradhyumna et al. 2021; Yan et al. 2021).
Originally designed for text-to-image synthesis (Saharia et al. 2022), diffusion models have
been rapidly extended to the domain of video generation (Singer et al. 2022; Ho et al. 2022),
supporting various tasks such as text-to-video (Wu et al. 2023), image-to-video (Ni et al.
2023), video-to-video translation (Yang et al. 2023), and multimodal generation (Ruan et al.
2023). Figure 1 illustrates the distribution of representative diffusion-based video genera­
tion methods across different task categories. Compared to traditional video generation
algorithms (Chu et al. 2020; Pradhyumna et al. 2021; Yan et al. 2021), diffusion models
offer superior output quality and generalization capabilities while significantly enhancing
the flexibility and creativity of video generation.
Among various diffusion models for video generation, Denoising Diffusion Probabilis­
tic Models (DDPMs) (Voleti et al. 2022) have demonstrated superior image quality and
more stable training compared to traditional generative models such as GANs (Chu et al.
2020). Latent Diffusion Models (LDMs) (Khachatryan et al. 2023; Wang et al. 2023) fur­
ther improve efficiency by mapping visual data from pixel space to a lower-dimensional
latent space, significantly reducing the computational cost of video generation. Models like
DALLE-2 and Stable Diffusion (Singer et al. 2022) incorporate multimodal architectures,
such as Transformers (Yang et al. 2022), to translate natural language into the latent space of
images. Recent advancements in video diffusion models (Ho et al. 2022; Voleti et al. 2022)
enable multimodal video generation conditioned on text and images. Diffusion models
effectively leverage their intrinsic advantages to generate high-quality videos with strong
subject consistency and temporal coherence. However, challenges remain, particularly in
generating long videos with high fidelity and ensuring consistency across multiple subjects.
These issues present important directions for future research.
Fig. 1  Distribution of Research Methods in Different Categories of Diffusion-based Video Generation.
The horizontal axis represents our six major classifications of models in this field, and the vertical axis
represents the percentage of models under each classification
1 3
Page 2 of 55
Video diffusion generation: comprehensive review and open problems
Recent studies have shown that numerous AIGC-related surveys (Xing et al. 2024; Li
et al. 2024; Cho et al. 2024) have covered aspects of video generation. Specifically, Xing et
al. (Xing et al. 2024) present a broad and systematic overview of video diffusion models,
encompassing video generation, editing, and understanding. It provides a comprehensive
summary of representative works, benchmarks, and settings in this domain, serving as an
essential reference for researchers. Li et al. (Li et al. 2024) focuses on long video genera­
tion, detailing modal types, control signals, and key techniques such as Divide And Con­
quer and Temporal AutoRegressive paradigms. This survey highlights important challenges
related to video quality and hardware considerations. Meanwhile, Cho et al. (Cho et al.
2024) emphasizes a broader range of video synthesis topics, including non-text-conditioned
generation, text-video relationships beyond generation tasks, and analysis of survey articles
and under-cited works.
Building upon these prior surveys, our work offers a more in-depth and structured
analysis of diffusion-based video generation. We systematically review theoretical foun­
dations, architectural mechanisms, and nuanced strengths and limitations across different

## Method

models, which offer promising potential for enhancing scene coherence and complex event
synthesis. By expanding upon the insights offered by these survey, this survey organizes
the discussion around key theoretical foundations, representative networks, classification
schemes, strengths and limitations, application scenarios, performance benchmarks, and
future research challenges. Our main contributions are as follows:
(1)	 This paper provides a structured analysis of the theoretical foundations and core archi­
tectures of diffusion models. The Video Diffusion Model (VDM) (Ho et al. 2022) is
selected as a representative method to exemplify the fundamental principles and design
mechanisms in video diffusion generation. In addition, we briefly introduce the role of
model fine-tuning and the integration of large-scale language models in video genera­
tion to help readers better grasp recent advancements in the field.
(2)	 This paper categorizes over two hundred diffusion video generation methods, analyzes
their key characteristics, and discusses both their advantages and disadvantages.
(3)	 The paper also reviews commonly used datasets and evaluation metrics in video gen­
eration and presents comparative results of representative models to facilitate bench­
marking and model selection.
(4)	 In light of current development trends, this paper systematically discusses future
research directions and open problems of diffusion video generation while also out­
lining potential application scenarios to support further exploration and real-world
deployment.
The rest of this paper is organized as follows. Section 2 introduces the development of diffu­
sion models and their foundational network structures, providing readers with a clear under­
standing of the core principles and technical evolution. Section 3 systematically reviews
representative and breakthrough video diffusion generation methods, categorizing them by
generation type and discussing the strengths and limitations of each category. Section 4
summarizes commonly used datasets and evaluation metrics for video generation. Section 5
provides a comparative analysis and visual presentation of the performance of representa­
1 3
Page 3 of 55
W. Ma et al.
tive algorithms. Section 6 we discusses future research directions and open problems of
video diffusion generation. Finally, Sect. 7 provides a summary of this paper.
2  Related work
In this section, we review the principles of diffusion models and their advanced variants,
and summarize the conditional video generation algorithms built upon them. The overall
structure of the diffusion model is shown in Fig. 2.
Diffusion models, introduced in recent years as a type of generative model, progressively
evolve a simple data distribution into a complex one through reversible steps, enabling the
creation of entirely new data samples based on training data. They are widely applied in
image generation and video generation algorithms, and in the field of image synthesis, they
have surpassed traditional Generative Adversarial Networks (GANs) with their powerful
generative capabilities. Representative models, such as Denoising Diffusion Probabilistic
Models (DDPM) (Ho et al. 2020), Score-Based Generative Models (SGM) (Song et al.
2020a), Denoising Diffusion Implicit Models (DDIM) (Song et al. 2020b), and Latent Dif­
fusion Models (LDM) (Rombach et al. 2022), have made remarkable progress in the field
of video generation in recent years. Let’s introduce each of the diffusion models mentioned
above one by one.
2.1  Denoising diffusion probabilistic models
By gradually adding noise to the data sample and generating new data through the reverse
denoising process, DDPM progressively maps the data distribution to a simple Gaussian
distribution (noise distribution) and then generates new data through reverse denoising.
This model was first proposed by Ho et al. (2020) and has achieved excellent performance
in image and video generation tasks. The generation process is divided into two stages: the
forward process and the reverse process.
Fig. 2  The overall operational process of diffusion model
1 3
Page 4 of 55
Video diffusion generation: comprehensive review and open problems
2.1.1  Forward process
The forward process, also known as the diffusion process, adds noise to the sample at each
step until the data completely degenerates into Gaussian noise. Its essence is a Markov pro­
cess of adding noise at a predefined time, which can be described using Eq. (1).
q (xt | xt−1) = N
(
xt;
√
1 −βtxt−1, βtI
)

(1)
where q(·) is the conditional probability distribution of the forward process, βt is the noise
schedule corresponding to time step t, and 0 < βt < I, N represents a normal distribution.
At the same time, we can directly represent real data at any time t through a recursive Eq.
(2):
{
xt = √¯αtx0 + √1 −¯αtϵ,
ϵ ∼N(0, I)
s.t
¯αt = ∏t
s=1(1 −βs)

(2)
where ¯αt is the accumulated attenuation coefficient, ϵ is a standard Gaussian distribution.
2.1.2  Reverse process
The reverse process is to gradually remove noise and generate data from noise based on the
reverse process of the forward process. The reverse process is also a Markov process, with
the goal of estimating and removing noise at each step.
pθ(xt−1|xt) = N(xt−1; µθ(xt, t), Σθ(xt, t))
(3)
where p(·) is the conditional probability distribution of the reverse process, µθ(xt, t) is the
mean parameterized by neural networks (such as UNet) used to predict the denoised data at
each step, and Σθ(xt, t) is the covariance matrix, which can be fixed as a constant or learned
using neural networks.
Overall, compared to GANs, DDPMs have better training stability and can generate
high-quality images and videos. They are also more flexible and can control noise sched­
uling or incorporate external conditions (images or text) to guide the generation process
(Dhariwal and Nichol 2021).
2.2  Score-based generative models
Based on the idea of score matching, SGM generate new data by learning the score function
of the data distribution, which is the gradient of the logarithmic probability density of the
data distribution. This method can be seen as a variant of the diffusion model, using a score
function to guide the generation process. The forward process is similar to that of DDPMs.
xt = x0 + σtϵ,
ϵ ∼N(0, I)
(4)
1 3
Page 5 of 55
W. Ma et al.
where σ is the time-varying noise intensity, and ϵ is the standard Gaussian noise. Through
Eq.(4) Add noise to gradually move the data away from the true distribution, ultimately
becoming Gaussian noise. In the reverse process, SGM gradually removes noise by learning
the fractional function of the data distribution, such as Eq.(5) As shown:
∇xt log p(xt)
(5)
Among them, t represents the time step, and the original data x0 can be restored to the
maximum extent by adjusting the current state xt. The reverse process formula is shown in
Eq.(6) as shown:
dxt
dt = 1
2∇xt log p(xt)
(6)
2.3  Denoising diffusion implicit models
As an improvement of DDPM, DDIM reduces the number of generation steps through a
deterministic generation process while maintaining generation quality. Therefore, DDIM
can generate high-quality data similar to DDPM while greatly reducing the number of gen­
eration steps.
It is still a Markov process, adding noise at each step t to gradually diffuse the real data
into standard Gaussian noise. The key innovation of DDIM lies in the reverse process as
shwon in Eq.(7).
xt−1 =
√
¯αt−1
(xt −√1 −¯αt · ϵθ(xt, t)
√¯αt
)
+
√
1 −¯αt−1 · ϵθ(xt, t)

(7)
where ϵθ(xt, t) is the noise predicted by the model at time step t, ¯αt is the cumulative noise
scaling factor during the forward process. Unlike DDPM, the reverse process of DDIM is
deterministic rather than based on random sampling. DDIM predicts the next state through
a direct mapping, thereby reducing the number of generated steps.
2.4  Latent Diffusion Models
LDM is an efficient diffusion model, and the core idea of LDM is to compress image or
video data into a low dimensional latent space, perform diffusion and denoising on the
latent space, and then map the generated latent representation back to a high-dimensional
pixel space through a decoder. This method combines the powerful generation capability
of diffusion models with the efficient representation learning of autoencoders such as VAE.
1 3
Page 6 of 55
Video diffusion generation: comprehensive review and open problems
2.4.1  Forward process
LDM diffuses in latent space, and the diffusion process is similar to traditional DDPM, as
shown in Eq.(8), adding noise to the latent representation at each step until Gaussian noise
is finally obtained.
zt = √¯αtz0 + √1 −¯αtϵ,
ϵ ∼N(0, I)
(8)
where z0 is a latent representation obtained through an encoder, ¯αt is the cumulative scaling
factor during the diffusion process. ϵ is standard Gaussian noise.
2.4.2  Reverse process
In the reverse process in Eq.(9), LDM starts from Gaussian noise in the latent space, gradu­
ally removes the noise, and restores the original latent representation. Then, the latent rep­
resentation is mapped back to the high-dimensional data space through a decoder to obtain
the generated samples.
zt−1 =
√αt
(
zt −1 −αt
√1 −¯αt
ϵθ(zt, t)
)
+ σtϵ
(9)
where αt is the noise scaling factor for time step t, σt is a random term in the reverse denois­
ing process, usually set according to noise scheduling. ϵθ(zt, t) is the noise predicted by the
model at time step t.
2.5  Spatiotemporal extension for video generation
While this model provides an efficient framework for image generation in latent space,
modeling the temporal dynamics in videos requires additional architectural considerations.
Representative works such as Video Diffusion Models (VDM)(Ho et al. 2022) extend 2D
UNet to 3D UNet structures and introduce spatiotemporal attention mechanisms to jointly
capture spatial and temporal dependencies. As shown in Fig. 3, by decoupling spatial and
temporal attention and leveraging relative position embeddings, these designs enhance tem­
poral coherence across frames while maintaining computational efficiency, laying a solid
foundation for later video diffusion models.
A key innovation in VDM is the use of reconstruction-guided sampling to improve con­
ditional generation. This technique addresses the challenge of generating coherent, longer
videos by adjusting the denoising model to include a gradient term based on the model’s
reconstruction of the conditioning data. The adjusted denoising model is defined as:
˜xθ (zt) = ˆxθ (zt) −wr
αt
2 ∇zt ∥xa −ˆxa
θ (zt)∥2
2
(10)
where the ˜xθ (zt) is the output of the standard denoising model, and xa is the conditioning
data (e.g., previous frames or low-resolution frames), the wr is a weighting factor (typically
wr > 1 for improved sample quality). αt is a coefficient related to the time step t.
1 3
Page 7 of 55
W. Ma et al.
The architectural design of VDM enables high-resolution and temporally consistent
video generation. It represents a significant advancement in extending diffusion models
from static images to dynamic video sequences.
2.6  Model finetuning in video diffusion
Model finetuning has emerged as a crucial component in the diffusion-based video genera­
tion paradigm. Finetuning leverages pre-trained diffusion models by adapting them to spe­
cific tasks or domains. This process narrows the gap between general-purpose, large-scale
models and high-performance, task-specific video generation systems. The key significance
of model finetuning lies in its ability to substantially enhance video generation quality,
including improved visual fidelity, temporal coherence, and alignment with conditioning
inputs such as text, pose, or style, while maintaining high computational efficiency.
Finetuning methods, such as Parameter-Efficient Fine-Tuning (PEFT) (Lester et  al.
2021), Low-Rank Adaptation (LoRA) (Hu et al. 2022), and prompt tuning (Lester et al.
2021), have been increasingly applied to enhance the adaptability and scalability of diffu­
sion-based video generation systems. These techniques allow efficient updating of a subset
of model parameters while leveraging the knowledge from large pre-trained models, thus
reducing computational cost and data requirements.
Specifically, in the video diffusion field, models like Tune-A-Video (Wu et al. 2023),
FreeInit (Wu et al. 2024), and FreeNoise (Qiu et al. 2023) have employed efficient finetun­
ing strategies to adapt text-to-video models for high-quality video generation under lim­
ited computational resources. For instance, Tune-A-Video uses temporal linear adaptation
modules to fine-tune large pre-trained text-to-image diffusion models for video synthesis,
demonstrating the effectiveness of PEFT-like techniques in video generation tasks.
Fig. 3  The 3D UNet architecture and network of Video Diffusion Models (Ho et al. 2022). The model cap­
tures spatial-temporal features from high-resolution inputs (N2, M1) to compressed forms ( N
2 )2, Mk,
with progressive upsampling ensuring both resolution and motion consistency
1 3
Page 8 of 55
Video diffusion generation: comprehensive review and open problems
Other finetuning strategies include Adapter Layers (Houlsby et al. 2019), which insert
trainable modules into pre-trained models; BitFit (Zaken et al. 2021), which only updates
bias parameters; and meta-learning based finetuning such as Model-Agnostic Meta-Learn­
ing (MAML) (Finn et al. 2017), which enables models to quickly adapt to new video gener­
ation tasks. Incorporating these model finetuning strategies represents a promising direction
for improving performance and flexibility across diverse video diffusion applications.
2.7  Vision-language foundation models in video generation
Recent advancements in vision-language foundation models (VLFMs), such as CLIP (Rad­
ford et al. 2021), BLIP (Li et al. 2022), BLIP-2 (Li et al. 2023), Flamingo (Alayrac et al.
2022), and PaLI (Chen et al. 2022), have greatly enhanced the integration of visual and
textual modalities in generative tasks. These models, pre-trained on massive-scale imagetext datasets, produce semantically rich, cross-modal representations that align visual con­
tent with natural language descriptions. These models capture both global and fine-grained
semantics, enabling strong contextual understanding and robust cross-modal alignment.
In the context of diffusion-based video generation, VLFMs play an increasingly piv­
otal role. By incorporating pre-trained vision-language embeddings, models can effectively
guide the generation process to produce videos that are not only visually realistic but also
semantically aligned with input text. For example, cross-attention mechanisms in video dif­
fusion models can seamlessly integrate BLIP-generated textual embeddings into the latent
space, enabling precise control over content generation and enhancing temporal consistency.
In addition, Flamingo introduces a retrieval-augmented multimodal transformer archi­
tecture that extends vision-language modeling to handle long sequences and dynamic video
data. PaLI further advances this by integrating multilingual text and diverse visual repre­
sentations, supporting richer global context and accommodating complex user instructions.
CLIP, while primarily designed for contrastive alignment, provides a robust foundation
for conditioning diffusion models through its powerful image-text embedding capabilities,
often used in zero-shot video understanding and retrieval.
Incorporating vision-language foundation models into diffusion-based video generation
brings several key benefits. Firstly, it enhances the semantic fidelity of generated videos,
ensuring that they closely align with complex and nuanced natural language prompts. Sec­
ondly, it improves the controllability of generation processes, enabling precise adjustments
to aspects such as style, motion, and content. Lastly, it opens up possibilities for multi-modal
and multi-lingual generation, which is crucial for addressing the challenges of global-scale
video synthesis.
Despite these benefits, current diffusion-based video generation methods largely rely on
simple text encoders or static embeddings, which limit the generative capacity in com­
plex scenarios. The integration of advanced VLFMs provides a path towards more intel­
ligent and human-aligned generation systems, enabling models to interpret nuanced textual
instructions and generate temporally coherent, high-quality videos. This trend underscores
the importance of incorporating VLFMs into future video diffusion frameworks, paving
the way for next-generation text-to-video models capable of handling long-duration, multiscene, and richly conditioned video synthesis tasks.
1 3
Page 9 of 55
W. Ma et al.
3  Classification of methods
In this section, we introduce a comprehensive classification of diffusion-based video gen­
eration methods, as well as the model characteristics, analysis of advantages and disad­
vantages, and future research directions of each classification, as shown in Table 1. This
classification is organized according to multiple dimensions of current research. Specifically,
we divide the methods into six primary categories: Task Complexity-Based, Multi-Modal
Conditioning, Controllable Generation, Conditional Generation, Unconditional Generation,
and Video Completion. Each category is further refined based on shared characteristics in
training requirements, conditioning modalities, or generation targets. This structured tax­
onomy not only facilitates a clearer understanding of the research landscape but also high­
lights emerging trends and gaps for future exploration. Figure 4 visualizes the distribution
of works under this classification. Below, we introduce the models corresponding to each
category as organized in Table 1.
In addition, to better illustrate the evolution of diffusion-based video generation, we pro­
vide a timeline of milestone works covering the years 2020 to 2025 (see Fig. 5). This visual
summary highlights key breakthroughs and influential models in the field, including foun­
dational developments, architectural innovations, and representative works that have driven
major progress in video quality, controllability, and realism. In particular, we emphasize
the most influential and recommended works in each year using a yellow star (⋆), guiding
readers to the most impactful models for further study. These include early foundational dif­
fusion models (DDPM, DDIM), the introduction of temporal and latent modeling in VDM
and LVDM, the first action-aware architecture in AnimateDiff, and the recent breakthroughs
such as Sora, which marks a leap toward large-scale end-to-end text-to-video generation.
3.1  Task complexity-based
In this part, we introduce a video generation classification method based on task complexity.
This classification method mainly focuses on the duration and complexity of the generation
task, dividing the model into training-based long video generation and training-free long
video generation:
3.1.1  Long video generation (training-based)
The training-based long video generation methods requires large-scale pre-training or finetuning of specific tasks to generate high-quality long videos with temporal consistency.
Usually, these methods have high computational costs, but they perform better in terms of
video quality and detail control compared to other methods. The key characteristics of this
category are summarized below.
●
Multi-stage generation mechanism: Most methods adopt a stepwise, autoregressive
strategy to generate long videos frame by frame, ensuring coherence by referencing
previous frames. ViD-GPT (Gao et al. 2024) and StreamingT2V (Henschel et al. 2024)
follow this approach, while FlexiFilm (Ouyang et al. 2024) introduces a temporal con­
ditioner to enhance multimodal alignment.
●
Time consistency and long-term memory: Ensuring temporal consistency is crucial.
1 3
Page 10 of 55
Video diffusion generation: comprehensive review and open problems
Task Complexity-Based
Long Video (Training-based)
FreeNoise (Qiu et al. 2023), NUWA-XL (Yin et al. 2023), Gen-LVideo (Wang et al. 2023), VIDiff (Xing et al. 2023), StreamingT2V
(Henschel et al. 2024), FlexiFilm (Ouyang et al. 2024), ViD-GPT
(Gao et al. 2024), Multi-sentence (Feng et al. 2024), Cono (Wang
et al. 2024), Video-Infinity (Tan et al. 2024), DiVE (Jiang et al.
2024), ARLON (Li et al. 2024), SCA-CRV (Yan et al. 2024), Owl-1
(Huang et al. 2024), Mind the Time (Wu et al. 2025), MaskFlow
(Fuest et al. 2025), WorldDreamer (Wang et al. 2024), WM-ML
(Liu et al. 2025)
Long Video (Training-free)
FIFO-Diffusion (Kim et al. 2024), FreeLong (Lu et al. 2024),
DiTCtrl (Cai et al. 2024), ConFiner (Li et al. 2024), TVG (Zhang
et al. 2024), TFL (Ma et al. 2025), Ouroboros-Diffusion (Chen
et al. 2025)
Multi-Modal Conditioning
Mutil-modal
VideoComposer (Wang et al. 2023), MovieFactory (Zhu et al.
2023), NExT-GPT (Wu et al. 2024), MM-Diffusion (Ruan et al.
2023), PEEKABOO (Jain et al. 2024), CMMD (Yang et al. 2024),
Fine-grained (Huang et al. 2023), GPT4Video (Wang et al. 2024),
Panacea (Wen et al. 2023), SparseCtrl (Guo et al. 2023), AnimateL­
CM (Wang et al. 2024), ActAnywhere (Pan et al. 2024), Custom­
Video (Wang et al. 2024), MoonShot (Zhang et al. 2024), UniCtrl
(Xia et al. 2024), Magic-Me (Ma et al. 2024), InteractiveVideo
(Zhang et al. 2024), Direct-a-Video (Yang et al. 2024), Boximator
(Wang et al. 2024)
Controllable Video Generation
Multi-View and Camera
Control-Based
InterDy (Akkerman et al. 2024), OmniDrag (Li et al. 2024), Syn­
CamMaster (Bai et al. 2024), CamI2V (Zheng et al. 2024), Cavia
(Zheng et al. 2024), Training-free Camera Control (Hou et al.
2024), ObjCtrl-2.5D (Wang et al. 2024), v3d (Chen et al. 2024),
ReCamMaster (Bai et al. (2025))
Animation Generation-Based
AnimateAnyone (Hu et al. 2024), AnimateAnything (Dai et al.
2023), FlipSketch (Bandyopadhyay and Song 2024), X-Portrait
(Xie et al. 2024), LivePortrait (Guo et al. 2024), ExAvatar (Moon
et al. 2024)
Motion Trajectory Control-Based
DragNUWA (Chen et al. 2023), Generative Inbetweening (Fu et al.
2024a), 3DTrajMaster (Fu et al. 2024b), Motion Prompting (Geng
et al. 2024), FreeTraj (Qiu et al. 2024), MotionClone (Ling et al.
2024), TrailBlazer (Ma et al. 2024), Motion-Zero (Chen et al. 2024)
Model Optimization-Based
EasyControl (Wang et al. 2024a), FRAMER (Wang et al. 2024b),
Tora (Zhang et al. 2024), HumanVid (Wang et al. 2024), Cinemo
(Ma et al. 2024), Still-Moving (Chefer et al. 2024), Image Conduc­
tor (Li et al. 2024), Identifying Conditional Image Leakage (Zhao
et al. 2024), MimicMotion (Zhang et al. 2024), MOFA-Video (Niu
et al. 2024), Champ (Zhu et al. 2024), ReCapture (Zhang et al.
2024), Motion-Ctrl (Wang et al. 2024)
Conditional Video Generation
Table 1  Overview of diffusion-based video generation
1 3
Page 11 of 55
W. Ma et al.
Task Complexity-Based
Text-to-Video(Training-based)
VDM (Ho et al. 2022), Imagen Video (Ho et al. 2022), Make-AVideo (Singer et al. 2022), MagicVideo (Zhou et al. 2022), LVDM
(He et al. 2022), Cogvideo (Hong et al. 2022), PYoCo (Ge et al.
2023), AnimateDiff (Guo et al. 2023), VidRD (Gu et al. 2023),
Fusionframes (Arkhipkin et al. 2023), Latent-shift (An et al. 2023),
Videodirectorgpt (Lin et al. 2023), Text2Performer (Jiang et al.
2023), NUWA-XL (Yin et al. 2023), DSDN (Liu et al. 2023),
ModelScope (Wang et al. 2023), VideoGEN (Li et al. 2023),
Video Adapter (Yang et al. 2023), SVD (Blattmann et al. 2023),
VersVideo (Xiang et al. 2023), Control-A-Video (Chen et al. 2024),
Dysen-VDM (Fei et al. 2024), Simda (Xing et al. 2024), LAVIE
(Wang et al. 2024), W.A.L.T (Gupta et al. 2024), GridDiff (Lee
et al. 2024), FlexiFilm (Ouyang et al. 2024), PixelDance (Zeng
et al. 2024), Cogvideox (Yang et al. 2024), EMU-video (Gird­
har et al. 2024), RF (Long et al. 2024), CMD (Yu et al. 2024),
Snap Video (Menapace et al. 2024), GenTron (Chen et al. 2024),
Lumiere (Bar-Tal et al. 2024), ART•V (Wang et al. 2024), Vlogger
(Zhuang et al. 2024), Hierarchical Spatio-temporal Decoupling
(Qing et al. 2024), DiffPerformer (Wang et al. 2024), Generative
Rendering (Cai et al. 2024), Hierarchical Patch-wise (Skorokhodov
et al. 2024), Grid Diffusion Models (Lee et al. 2024), MotionDi­
rector (Zhao et al. 2024a), MagDiff (Zhao et al. 2024b), MoVideo
(Liang et al. 2024), HARIVO (Kwon et al. 2024), EvalCrafter (Liu
et al. 2024), Make Pixels Dance (Zeng et al. 2024), Mind the Time
(Wu et al. 2025), Show-1 (Zhang et al. 2024), DrivingDiffusion (Li
et al. 2024), E2HQV (Qu et al. 2024), WM-ML (Liu et al. 2025),
WorldDreamer (Wang et al. 2024), MagicVideo-V2 (Wang et al.
2024), Mora (Yuan et al. 2024), FancyVideo (Feng et al. 2024),
Factorized-Dreamer (Yang et al. 2024), DirectorLLM (Song et al.
2024), Sora (Cho et al. 2024), HunyuanVideo(Kong et al. 2024),
BlobGEN-Vid (Feng et al. 2025), VideoFactory (Wang et al. 2025)
Text-to-Video(Training-free)
Text2video-Zero (Khachatryan et al. 2023), Tune-A-Video (Wu
et al. 2023), FreeNoise (Qiu et al. 2023), FlowZero (Lu et al. 2023),
AdaDiff (Zhang et al. 2023), DiffSynth (Duan et al. 2024), Con­
ditionVideo (Peng et al. 2024), GPT4Motion (Lv et al. 2024), F3
-Pruning (Su et al. 2024), FreeInit (Wu et al. 2024), TRAILBLAZ­
ER (Ma et al. 2024), VideoElevator (Zhang et al. 2024), FIFODiffusion (Kim et al. 2024), Mevg (Oh et al. 2024), Bivdiff (Shi
et al. 2024), A Recipe for Scaling (Wang et al. 2024), Fine-gained
Zero-shot (Chen et al. 2024), Broadway (Bu et al. 2024)
Pose-guided
DreaMoving (Feng et al. 2023), AnimateAnyone (Hu et al. 2024),
MagicDance (Chang et al. 2023), Dancing Avatar (Qin et al. 2023),
DreamPose (Karras et al. 2023), StableAnimator (Liu et al. 2024),
MOFA-Video (Niu et al. 2024), MimicMotion (Zhang et al. 2024),
Champ (Zhu et al. 2024), Action Reimagined (Wang et al. 2024),
Do You Guys Want to Dance (Xu et al. 2024a), MagicAnimate (Xu
et al. 2024b), DisCo (Wang et al. 2024), Follow Your Pose (Ma
et al. 2024), SG-I2V (Namekata et al. 2025)
Motion-guided
DragNUWA (Yin et al. 2023), Customizing Motion (Materzynska
et al. 2023), Lamd (Hu et al. 2023), AnimateAnything (Dai et al.
2023), MCDiff (Chen et al. 2024), MotionClone (Ling et al. 2024),
MotionCtrl (Wang et al. 2024), Tora (Zhang et al. 2024), MOFAVideo (Niu et al. 2024), Champ (Zhu et al. 2024), Motion-I2V (Shi
et al. 2024), Motion-Zero (Chen et al. 2024), Pix2Gif (Kandala
et al. 2024)
Table 1  (continued)
1 3
Page 12 of 55
Video diffusion generation: comprehensive review and open problems
StreamingT2V (Henschel et al. 2024) uses a Conditional Attention Module (CAM) to
reference prior segments, while ViD-GPT (Gao et al. 2024) maintains coherence via
unidirectional temporal attention based on preceding frames.
●
Detail enhancement and multimodal support: To improve visual quality, methods
like FlexiFilm (Ouyang et al. 2024) apply resampling to reduce detail loss, and MultiSentence (Feng et al. 2024) enhances diversity by combining video editing with textdriven clip generation.
Task Complexity-Based
Image-guided
NUWA-Infinity (Wu et al. 2022), I2vgen-xl (Zhang et al. 2023),
Make-It-4D (Shen et al. 2023), LaMD (Hu et al. 2023), Condi­
tional I2V (Ni et al. 2023), SparseCtrl (Guo et al. 2023), IdentityPreserving (Yuan et al. 2024), PhysGen (Liu et al. 2024), Ti2v-Zero
(Ni et al. 2024), TimeNoise (Zhao et al. 2024), Noise Rectification
(Li et al. 2024), AtomoVideo (Gong et al. 2024), Animated Stickers
(Yan et al. 2024), Consisti2v (Ren et al. 2024), I2v-adapter (Guo
et al. 2024), LivePhoto (Chen et al. 2024), VideoBooth (Jiang et al.
2024), Decouple Content and Motion (Shen et al. 2024), Genera­
tive Image Dynamics (Li et al. 2024), Follow-Your-Click (Ma et al.
2024), ID-Animator (He et al. 2024), MegActor-Σ (Yang et al.
2024), LeviTor (Wang et al. 2024), ControlNeXt (Peng et al. 2025),
Consistent Human Image and Video Generation (Cao et al. 2024),
DreamVideo (Wang et al. 2025)
Audio/Sound-guided
Diverse-AVGen (Yariv et al. 2023), tpos (Jeong et al. 2023), AA­
Diff (Lee et al. 2023), DiffAligner (Xing et al. 2024), TAVGBench
(Mao et al. 2024), Draw-an-Audio (Yang et al. 2024), Tell-WhatYou-Hear (Liu et al. 2024), AV-Link (Haji-Ali et al. 2024), Hallo
(Xu et al. 2024), Context-aware (Xuanyuan et al. 2024), EMO
(Tian et al. 2024), AGAV-Rater (Cao et al. 2025), UniForm (Zhao
et al. 2025), MusicInfuser (Hong et al. 2025)
Brain-guided
Cinematic Mindscapes (Chen et al. 2023), NeuroCine (Sun et al.
2024)
Depth-guided
Animate-A-Story (He et al. 2023), StableV2V (Liu et al. 2024),
Make-Your-Video (Xing et al. 2024)
Unconditional Video Generation
UNet-based
VIDM (He et al. 2022), VPDinPL (Yu et al. 2023), GD-VDM
(Lapid et al. 2023), LEO (Liang et al. 2023), Hybrid VDM (Kim
et al. 2024)
Transformer-based
TGV-TST (Ge et al. 2022), VDT (Lu et al. 2023), RTM-VQGANTrans (Liu et al. 2024), Latte (Ma et al. 2024), MegActor-Σ (Yang
et al. 2024), WF-VAE (Li et al. 2024)
Video Completion
Enhancement and Restoration
CaDM (Zhou et al. 2022), Look Ma, No Hands! (Chang et al.
2023), AVID (Zhang et al. 2023), Motion-Guided Latent Diffusion
(Yang et al. 2023), LDMVFI (Danier et al. 2023), Upscale-A-Video
(Zhou et al. 2023), Inflation with Diffusion (Yuan et al. 2024),
Towards Language-Driven Video Inpainting (Wu et al. 2024),
ReconX (Liu et al. 2024)
Video Prediction
MaskViT (Gupta et al. 2022), RaMViD (Höppe et al. 2022), McVd
(Voleti et al. 2022), Diffusion Probabilistic Modeling for Video
Generation (Yang et al. 2022), Flexible Diffusion Modeling of
Long Videos (Harvey et al. 2022), LG-CVD (Yang et al. 2023),
Seer (Gu et al. 2023), Control-A-Video (Chen et al. 2024), AID
(Xing et al. 2024), STDiff (Ye and Bilodeau 2024)
Table 1  (continued)
1 3
Page 13 of 55
W. Ma et al.
●
Optimization of computing resources and efficient inference: Long, high-resolution
videos demand substantial resources. ViD-GPT (Gao et al. 2024) reduces redundancy
via KV caching to speed up inference, while Video Infinity (Tan et al. 2024) adopts dis­
tributed inference across GPUs to accelerate large-scale video generation.
Fig. 5  The timeline showcases representative models and their contributions, year by year. Major mile­
stones include the introduction of diffusion mechanisms (DDPM, DDIM), early video-specific adapta­
tions (VDM, LVDM), multimodal fusion (Make-A-Video, AnimateDiff), and state-of-the-art end-to-end
systems (Sora, HunyuanVideo). Yellow stars (⋆) highlight the most recommended and impactful works
of each year
Fig. 4  Proportion of diffusion-based video generation papers in different categories
1 3
Page 14 of 55
Video diffusion generation: comprehensive review and open problems
3.1.2  Long video generation (training-free)
Training-free long video generation methods aim to synthesize extended video sequences
without the need for task-specific pretraining or fine-tuning. These approaches typically
leverage pre-trained image or short-video generation models and adapt them through prompt
engineering, adapter modules, or lightweight optimization strategies. While they generally
reduce computational overhead and enhance flexibility, challenges remain in achieving con­
sistent temporal coherence and scene continuity over long durations. Below, we summarize
the key characteristics of this method.
●
Efficient generation without training: Training-free methods leverage pre-trained
short-video models to extend to long video generation without additional training. Free­
Long (Lu et al. 2024) reduces resource costs via frequency balancing, TVG (Zhang
et al. 2024) applies Gaussian Process Regression for smooth transitions, and FIFO Dif­
fusion (Kim et al. 2024) enables infinite generation with limited memory via a queuebased mechanism.
●
Frequency-domain temporal consistency: These methods enhance consistency by
optimizing in the frequency domain. FreeLong fuses global low-frequency and local
high-frequency features to ensure visual balance without retraining.
●
Flexible inference process: Training-free approaches allow flexible content control.
FreeLong supports multi-segment prompts generation with seamless transitions, and
TVG enhances transition naturalness through interpolation control and frequency fu­
sion.
3.1.3  Analysis of the advantages and disadvantages
In this section, we present a structured analysis of the advantages and limitations of diffu­
sion-based long video generation methods. Below, we explain the details of these advan­
tages and disadvantages.
•Advantages:
Temporal Coherence: Both training-based and training-free methods strive to maintain
consistent motion and visual flow over long durations. Approaches like StreamingT2V and
FreeLong enhance frame continuity through temporal conditioning and frequency-aware
design.
Flexible Architectures: Training-based models (e.g., FlexiFilm, Video-Infinity) adopt
hierarchical or staged generation with time resampling and memory-aware modules to bet­
ter handle long-range dependencies, while training-free models like FIFO-Diffusion extend
short video capabilities without retraining.
Efficiency and Scalability: Training-free methods significantly reduce resource usage by
reusing pre-trained models, enabling practical generation of long sequences at lower cost,
with structures like causal queues and fast inference modules.
Multimodal and Fine-Grained Control: Training-based approaches offer stronger fidelity
and fine control by integrating complex input conditions (text, image, keyframes), enabling
accurate content generation over extended temporal spans.
•Disadvantages:
1 3
Page 15 of 55
W. Ma et al.
High Resource Requirements: Training-based long video generation consumes large
GPU memory and time, with growing difficulty as video length increases. Distributed train­
ing is often necessary (e.g., Video-Infinity).
Suboptimal Quality in Training-Free Models: While efficient, training-free approaches
usually lack fine-tuning mechanisms, leading to lower realism and weaker temporal align­
ment in complex scenes.
Limited Generalization: Some models are optimized for specific domains (e.g., ani­
mation or simulation videos) and may overfit or underperform when transferred to opendomain video generation.
Slow Optimization and Deployment: Training large models for long video generation is
time-consuming and sensitive to hyperparameter tuning, which slows down development
cycles and scalability across datasets.
3.2  Multi-modal conditioning
Multimodal video generation has rapidly advanced in recent years, enabling the synthesis of
coherent and semantically rich videos by integrating conditions such as text, audio, images,
and other modalities. Below we present the significant characteristics of multimodal video
generation to reflect the technological evolution and diverse applications in this field.
●
Multimodal Conditioning: Multimodal models integrate inputs like text, images,
audio, or sketches to enable expressive and flexible video generation. Works such as
Moonshot (Zhang et al. 2024) and InteractiveVideo (Zhang et al. 2024) showcase how
diverse modalities and interactive prompts enhance customization.
●
Controllability and Customization: Fine-grained control over motion, layout, and
camera dynamics is key for personalized outputs. Direct-a-Video (Yang et al. 2024)
and VideoComposer (Wang et al. 2023) offer spatial-temporal control mechanisms for
precise content manipulation.
●
Temporal Consistency: Maintaining frame-to-frame coherence is essential. Methods
like UniCtrl (Xia et al. 2024), MM-Diffusion (Ruan et al. 2023), and VideoComposer
introduce unified attention and motion-guided modules to enhance temporal stability.
●
Cross-Modal Alignment: Ensuring semantic alignment across modalities is crucial.
MM-Diffusion and Moonshot achieve this through attention-based mechanisms that
align audio, text, and visual inputs, improving consistency and fidelity.
●
Unified Frameworks: General-purpose models such as NExT-GPT (Wu et al. 2024)
aim to unify diverse modalities within one architecture, enabling any-to-any generation
via LLM-based adaptors and diffusion decoders.
●
User-Centric Interaction: Modern systems like InteractiveVideo and MovieFactory
focus on intuitive interfaces and language-driven pipelines, lowering the barrier for nonexperts and enabling more creative, interactive video generation.
3.2.1  Analysis of advantages and disadvantages
In this part, we respectively introduce the advantages and disadvantages of mutilmodal
video generation based on diffusion model. Below, we explain the details of these advan­
tages and disadvantages.
1 3
Page 16 of 55
Video diffusion generation: comprehensive review and open problems
•Advantages:
High-Quality Video Generation: Multimodal diffusion models can produce high-reso­
lution, temporally consistent videos with rich details, meeting the increasing demand for
realistic video synthesis. For instance, MovieFactory (Zhu et al. 2023) achieves cinematiclevel quality with seamless transitions.
Flexible Input Modalities: These models support a wide range of input modalities, such
as text, images, and audio, allowing users to generate videos based on diverse prompts.
Examples include Direct-a-Video (Yang et  al. 2024) and NExT-GPT (Wu et  al. 2024),
which enable customized video creation by separately controlling object motion and cam­
era movement.
Enhanced Controllability: Fine-grained control mechanisms, such as those in MovieF­
actory and VideoComposer (Wang et al. 2023), empower users to adjust specific elements
like object appearances, spatial layouts, and temporal dynamics, enhancing the precision of
video synthesis.
Cross-Modal Alignment: By leveraging advanced alignment mechanisms (e.g., crossmodal attention), these models ensure synchronization and consistency across different
modalities, such as video and audio, as demonstrated in MM-Diffusion (Ruan et al. 2023)
and CMMD (Yang et al. 2024).
•Disadvantages:
Computational Complexity: The high computational demands of handling multiple
modalities and maintaining video quality can result in significant training and inference
time, especially for large-scale models like MovieFactory (Zhu et al. 2023).
Scalability Issues: Although modular approaches (e.g., NExT-GPT (Wu et al. 2024))
address scalability, performance may degrade when adding more modalities, primarily if
significant differences exist between them.
Temporal Consistency Challenges: Despite efforts to enhance temporal consistency (e.g.,
MM-Diffusion (Ruan et al. 2023), VideoComposer (Wang et al. 2023)), complex dynamic
scenes with rapid movements or multiple objects can still result in frame inconsistencies or
distortions.
Dependency on Alignment Mechanisms: The quality of multimodal alignment is critical.
Inadequate alignment can lead to inconsistencies between modalities, such as mismatches
between audio and video or poor synchronization.
3.3  Controllable video generation
Controllable video generation enables fine-grained manipulation over video synthesis,
allowing users to dictate motion, style, structure, and character identity through various
control mechanisms. This field has rapidly evolved with advancements in generative models
and diffusion-based architectures. Below, we analyze four major branches in controllable
video generation, each addressing a unique aspect of control and customization.
3.3.1  Multi-view and camera control-based video generation
This class of methods enables the controllable generation of videos with flexible camera
viewpoints and trajectories, supporting 2.5D/3D scene understanding and cinematic motion
synthesis. The following are the key characteristics of this method.
1 3
Page 17 of 55
W. Ma et al.
●
Camera Motion Control: Methods such as SynCamMaster (Bai et  al. 2024) and
CamI2V (Zheng et al. 2024) allow users to manipulate camera motion (e.g., pan, tilt,
zoom) during generation, enabling realistic scene navigation and storytelling. ReCam­
Master (Bai et al. 2025) extends this capability by introducing a camera-controlled gen­
erative video re-rendering framework that leverages pre-trained text-to-video models to
reproduce dynamic scenes of an input video under novel camera trajectories, effectively
bridging existing video and new camera path synthesis.
●
3D-Aware Scene Modeling: Models like v3d (Chen et  al. 2024) and ObjCtrl-2.5D
(Wang et al. 2024) integrate 3D representations or geometry-aware controls to synthe­
size spatially consistent multi-view sequences.
●
Training-Free and Intuitive Interaction: Approaches like Training-Free Camera Con­
trol (Hou et al. 2024) and OmniDrag (Li et al. 2024) support intuitive drag-based ma­
nipulation and viewpoint adjustment without retraining, improving user controllability
and efficiency.
●
Object-Camera Dynamics: InterDy (Akkerman et al. 2024) and Cavia (Zheng et al.
2024) jointly modal object and camera interactions to produce dynamic and coherent
video outputs under complex scene transformations.
3.3.2  Animation generation-based video synthesis
These methods focus on animating static characters or objects with controllable motion,
often used for portrait animation, sketch-to-video, or avatar-based generation.
●
Generic Object Animation: AnimateAnything (Dai et al. 2023) and AnimateAnyone
(Hu et al. 2024) support universal animation of arbitrary inputs, enabling broad applica­
bility across human bodies, animals, and objects.
●
Portrait and Face Animation: X-Portrait (Xie et al. 2024), LivePortrait (Guo et al.
2024), and ExAvatar (Moon et al. 2024) specializes in realistic facial animation, pre­
serving identity and expression through audio, pose, or sketch conditioning.
●
Sketch-Based and Style-Driven Animation: FlipSketch (Bandyopadhyay and Song
2024) enables frame-consistent animation from hand-drawn sketches, offering control­
lable style transfer and keyframe interpolation for creative animation workflows.
3.3.3  Motion trajectory control-based video generation
Motion trajectory control-based video generation focuses on synthesizing videos by explic­
itly guiding object or human movement along predefined trajectories, enabling precise con­
trol over spatial-temporal dynamics in both 2D and 3D space. The following outlines the
key characteristics of this generation paradigm.
●
Custom Motion Paths: Methods like Generative Inbetweening (Fu et al. 2024a) and
3DTrajMaster (Fu et al. 2024b) provide deep-learning-based interpolation between key­
frames, ensuring natural motion transitions.
●
Motion-Conditioned Generation: Approaches such as FreeTraj (Qiu et al. 2024) and
Motion Prompting (Geng et al. 2024) incorporate motion priors or prompts to synthe­
size physically plausible trajectories with dynamic consistency.
1 3
Page 18 of 55
Video diffusion generation: comprehensive review and open problems
●
Interactive Refinement: Models like DragNUWA (Chen et al. 2023), TrailBlazer (Ma
et al. 2024), and FRAMER (Wang et al. 2024b) support user interaction via text, key
points, or bounding boxes, enabling fine-grained motion editing without additional re­
training.
3.3.4  Model optimization-based video generation
Model optimization-based video generation emphasizes improving diffusion-based video
generation’s efficiency, scalability, and flexibility through lightweight architectures, train­
ing-free adaptation, and enhanced motion control. The following highlights the key charac­
teristics of this class of approaches.
●
Efficient Fine-Tuning: EasyControl (Wang et al. 2024a) enables fast adaptation with
parameter-efficient tuning and lightweight design, reducing resource demands for realtime and scalable generation.
●
Style Adaptation and Personalization: Tora (Zhang et al. 2024) and Cinemo (Ma et al.
2024) improve cross-domain generalization and temporal coherence by learning robust,
style-aware embeddings.
●
Motion Consistency and Artifact Reduction: Identifying Conditional Image Leakage
(Zhao et al. 2024) and Image Conductor (Li et al. 2024) reduce motion artifacts and
enhance realism by addressing over-reliance on conditional inputs and enabling better
control over dynamic scenes.
●
Novel View Synthesis: ReCapture (Zhang et al. 2024) and MOFA-Video (Niu et al.
2024) extend control to camera and scene-level trajectories, supporting cinematic mo­
tion planning and immersive video generation.
Each branch contributes to the broader field of controllable video generation, enhancing
user interactivity, motion realism, and computational efficiency in modern video synthesis
frameworks.
3.3.5  Analysis of the advantages and disadvantages
This part analyzes the key advantages and disadvantages of controllable video genera­
tion based on diffusion models. Below, we explain the details of these advantages and
disadvantages.
•Advantages:
Fine-Grained Control: Controllable video generation enables precise manipulation of
object motion, camera viewpoints, and animation styles. Models like ControlNeXt (Peng
et  al. 2025) and DirectorLLM (Song et  al. 2024) allow users to guide video synthesis
through textual, visual, and motion inputs, enhancing customization.
Diverse Control Mechanisms: Different approaches, such as condition-based (ControlA-Video (Chen et  al. 2024), SparseCtrl (Guo et  al. 2023)), multi-view camera control
(OmniDrag (Li et al. 2024), CamI2V (Zheng et al. 2024)), and trajectory-guided motion
(DragNUWA (Chen et al. 2023), TrailBlazer (Ma et al. 2024)), provide versatile methods to
control video generation across various applications.
1 3
Page 19 of 55
W. Ma et al.
Enhanced Temporal Consistency: Advances in trajectory modeling (e.g., Motion-Zero
(Chen et al. 2024), FreeTraj (Qiu et al. 2024)) and pose-guided animation (e.g., AnimateA­
nything (Dai et al. 2023), X-Portrait (Xie et al. 2024)) improve temporal coherence, reduc­
ing flickering and maintaining smooth transitions between frames.
Scalability Across Domains: Controllable video generation frameworks are adaptable
to multiple domains, from animation (Animate Anyone (Hu et al. 2024), LivePortrait (Guo
et al. 2024)) to cinematic video production (Cinemo (Ma et al. 2024), HumanVid (Wang
et al. 2024)), expanding their applicability in content creation.
•Disadvantages:
High Computational Cost: Fine-grained control mechanisms require significant compu­
tational resources, particularly for models relying on diffusion processes (e.g., ControlNeXt
(Peng et al. 2025), MotionCtrl (Wang et al. 2024)). Real-time inference remains challenging.
Limited Generalization to Open-Domain Videos: While trajectory-based and multi-view
models perform well on structured datasets (e.g., Human3.6M), their ability to generalize to
arbitrary open-domain videos remains limited (e.g., DragNUWA (Chen et al. 2023)).
Trade-off Between Control and Realism: Increased controllability may introduce artifacts
or degrade natural motion, as observed in motion-conditioned models (e.g., Motion-Zero
(Chen et al. 2024), MotionClone (Ling et al. 2024)). Overconstraining object trajectories
can lead to unnatural deformations.
Complex User Input Requirements: Some methods (e.g., TrailBlazer (Ma et al. 2024),
Control-A-Video (Chen et al. 2024)) require precise keyframe annotations or bounding box
inputs, making them less accessible to users without prior expertise in motion design.
3.4  Conditional video generation
Conditional video generation enables explicit control over the video synthesis process using
different conditioning inputs such as text, pose, motion trajectories, and external visual

## References

alignment with user-specified conditions. Below, we analyze the key characteristics of vari­
ous condition-based video generation approaches.
3.4.1  Text-to-video (training-based)
Text-to-video (training-based) generation methods rely on large-scale supervised training
or fine-tuning to model the mapping from text prompts to coherent video sequences. These

## Approach

pipelines, and sophisticated cross-modal alignment mechanisms to ensure high video fidel­
ity and strong semantic consistency with the input text. The following summarizes the key
characteristics of training-based text-to-video generation models.
●
High-Fidelity Video Synthesis: High-resolution video generation methods such as Im­
agen Video (Ho et al. 2022), Make-A-Video (Singer et al. 2022), and LVDM (He et al.
2022) adopt cascaded or frame-insertion strategies to refine spatial quality and object
details progressively. VideoGEN (Li et al. 2023) combines scripts and keyframes to en­
hance cross-shot consistency, while Show-1 (Zhang et al. 2024) integrates pixel-based
and latent-based VDMs for better text alignment and high-resolution outputs.
1 3
Page 20 of 55
Video diffusion generation: comprehensive review and open problems
●
Temporal Coherence and Motion Consistency: Maintaining motion smoothness
across frames is critical. Dysen-VDM (Fei et al. 2024) and LVDM (He et al. 2022)
introduce scene-aware modeling and optical flow refinement. In contrast, VidRD (Gu
et al. 2023) injects temporal layers into the decoder to strengthen long-range coherence
without relying on separate prediction modules.
●
Modular and Efficient Generation: ConFiner (Li et al. 2024) decouples video genera­
tion into structure control and spatiotemporal refinement, leveraging diffusion experts
for each subtask to reduce computational cost while maintaining visual quality.
●
Structured Layout and Content Control: VideoDirGPT (Lin et al. 2023) introduces
GPT-based video planning, converting textual input into structured scene layouts and
movement instructions. This enables controllable and coherent synthesis of complex,
multi-entity scenes.
●
Compositional Modeling and Scene Adaptation: VideoFactory (Wang et al. 2025),
PYoCo (Ge et al. 2023), and W.A.L.T (Gupta et al. 2024) enhance spatial-temporal in­
teractions through advanced attention mechanisms, video priors, and transformer-based
encoders. CMD (Yu et al. 2024) disentangles content and motion latent spaces for faster
and more controllable generation using pre-trained image diffusion backbones.
●
Scalability and Efficiency Improvements: Scaling video generation models efficiently
is a growing focus. Snap Video (Menapace et al. 2024) and GridDiff (Lee et al. 2024)
reduce memory and training overhead via video-first and grid-based representations.
GenTron (Chen et al. 2024) scales Transformer-based diffusion models to 3B param­
eters, achieving improved visual fidelity and motion-aware T2V synthesis.
3.4.2  Text-to-video (training-free)
Training-free methods have recently emerged as a lightweight and flexible alternative for
video generation. These approaches typically adapt pre-trained text-to-image diffusion
models to handle temporal dynamics, enabling zero-shot or few-shot video synthesis with­
out expensive retraining. Next, we introduce the key characteristics of training-free text-tovideo generation.
●
Fast Adaptation to New Prompts: Text2video-Zero (Khachatryan et al. 2023), GPT­
4Motion (Lv et al. 2024), and TrailBlazer (Ma et al. 2024) enable quick video genera­
tion from new prompts by leveraging pre-trained text-to-image models, eliminating the
need for task-specific fine-tuning.
●
Temporal Consistency via Adaptive Inference: FreeInit (Wu et al. 2024) improves
motion smoothness by refining low-frequency components in initial latent noise. In
contrast, FIFO-Diffusion (Kim et al. 2024) adopts a queue-based strategy to support
infinite-length video generation with stable frame transitions.
●
Temporal Interpolation and Motion Synthesis: FlowZero (Lu et al. 2023) uses LLMgenerated dynamic scene syntax (DSS) to guide motion composition, avoiding direct
optical flow. DiffSynth (Duan et al. 2024) reduces flickering by introducing latent de­
flickering and patch blending for smoother transitions.
●
Condition-Guided Temporal Control: ConditionVideo (Peng et al. 2024) enhances
motion accuracy and temporal coherence by combining a UNet branch with a control
branch, using sparse bi-directional spatial-temporal attention and conditioning on exter­
1 3
Page 21 of 55
W. Ma et al.
nal inputs such as video and text.
●
Inference Acceleration and Resource Efficiency: AdaDiff (Zhang et al. 2023) acceler­
ates inference by adaptively adjusting denoising steps based on input complexity, while
F3-Pruning (Su et al. 2024) improves runtime by pruning redundant temporal attention
modules without retraining.
●
Multi-Event Video Generation with Latent Optimization: MEVG (Oh et al. 2024)
enhances visual coherence across multiple events using a last-frame-aware latent refine­
ment strategy, while a prompt generator improves semantic alignment through struc­
tured text conditioning.
●
Visual Quality and Temporal Diversity Enhancement: VideoElevator (Zhang et al.
2024) boosts frame-level quality and structural consistency by decomposing generation
into temporal refinement and spatial enhancement, leveraging T2I priors without extra
training.
Training-free text-to-video generation offers a promising, fast, flexible, and resource-effi­
cient video synthesis alternative. While current methods still face limitations in motion
coherence and prompt adherence, ongoing research in adaptive frame interpolation, LLMguided video synthesis, and lightweight diffusion modeling gradually bridges the gap with
training-based approaches.
3.4.3  Pose-guided video generation
Pose-guided video generation leverages human pose sequences or key points as structural
conditions to generate dynamic visual content. This approach enables control over human
motion, body structure, and action dynamics, making it especially suitable for character
animation, dance synthesis, and motion transfer applications. The following outlines the key
characteristics of pose-guided video generation methods.
●
Pose-Conditioned Motion Transfer: Methods like StableAnimator (Rings 2024),
MagicAnimate (Xu et al. 2024b), AnimateAnyone (Hu et al. 2024), and Champ (Zhu
et al. 2024) generate human videos guided by pose keypoints, enabling precise skeletal
control through two-stage training and pose-aware encoders.
●
Style and Identity Preservation: StableAnimator (Rings 2024), DreaMoving (Feng
et al. 2023), and Champ (Zhu et al. 2024) preserve character appearance by combining
identity-aware modules with pre-trained T2I backbones, maintaining visual consistency
and text-editability across frames.
●
Expressive and Realistic Human Motion: MOFA-Video (Niu et  al. 2024), DisCo
(Wang et al. 2024), and DreamPose (Karras et al. 2023) improve motion realism using
pose-conditioned attention and dynamic embeddings, enabling smooth and expressive
body articulation from sparse control signals.
3.4.4  Motion-guided video generation
Motion-guided video generation utilizes explicit motion trajectories or motion representa­
tions (e.g., optical flow, velocity maps) as conditions to control dynamic content in the
generated video. This paradigm enables fine-grained manipulation of object motion and
1 3
Page 22 of 55
Video diffusion generation: comprehensive review and open problems
scene dynamics, providing greater realism and controllability in motion portrayal. Below,
we summarize the key characteristics of motion-guided video generation methods.
●
Motion Trajectory Control: Models like Tora (Zhang et al. 2024), Motion-I2V (Shi
et al. 2024), and MOFA-Video (Niu et al. 2024) offer fine-grained trajectory-based mo­
tion control. Tora encodes motion paths via a 3D compression network to generate vid­
eos that precisely follow user-defined trajectories.
●
Dynamic Scene Adaptation: Tora (Zhang et  al. 2024) and FRAMER (Wang et  al.
2024b) adapt motion synthesis to varying durations, resolutions, and layouts. These
models maintain motion fidelity across diverse video settings through modules like
Motion-Guidance Fuser.
●
Cross-Modal Motion Transfer: MotionClone (Ling et  al. 2024) and Motion-Zero
(Chen et al. 2024) support motion transfer from reference videos or text prompts. Mo­
tionClone leverages sparse attention for lightweight transfer, while Motion-Zero intro­
duces LLM-guided motion decomposition for region-specific control.
3.4.5  Image-guided video generation
Image-guided video generation focuses on synthesizing videos conditioned on single or
multiple reference images, enabling the transfer of spatial content such as appearance, struc­
ture, or identity into temporally coherent sequences. These methods are particularly effec­
tive for tasks like image-to-video translation, video reenactment, and content preservation.
Below, we outline the key characteristics of image-guided video generation approaches.
●
Identity and Appearance Preservation: Maintaining a consistent identity is key in
an image-driven generation. ConsisID (Yuan et al. 2024) preserves facial structure via
frequency-aware control, while VideoBooth (Jiang et al. 2024) enhances subject coher­
ence through coarse-to-fine prompt injection and attention guidance.
●
Motion Generation from Static Images: To infer dynamics from a single image, Phys­
Gen (Liu et al. 2024) introduces physics-based attributes, TI2V-Zero (Ni et al. 2024)
combines text-image prompts with inversion, and LFDM  (Li et  al. 2024) generates
flow-conditioned motion for spatial and temporal realism.
●
Controllable and Structured Generation: AtomoVideo (Gong et al. 2024), Consis­
tI2V (Ren et al. 2024), and LaMD (Hu et al. 2023) provide structural and latent-level
controllability using adapters, spatiotemporal attention, and prompt-guided latent mo­
tion control, enabling flexible and consistent generation.
●
Temporal Consistency for Long Videos: NUWA-Infinity (Wu et al. 2022), Dream­
Video (Wang et al. 2025), and Make-It-4D (Shen et al. 2023) improve long-term coher­
ence through memory caching, subject-motion decoupling, and 4D scene modeling,
achieving stable and realistic video synthesis over extended durations.
●
Robustness and Identity Leakage Mitigation: Identifying Conditional Image Leak­
age (Zhao et al. 2024) and Noise Rectification (Li et al. 2024) reduce over-conditioning
and enhance robustness via noise-aware scheduling and tuning-free correction strate­
gies, improving generalization and detail preservation.
1 3
Page 23 of 55
W. Ma et al.
3.4.6  Audio/Sound-guided video generation
Audio/Sound-guided video generation leverages audio signals—such as speech, music, or
environmental sounds, as conditioning inputs to control or synchronize the visual content
in generated videos. This category emphasizes audio-visual alignment, semantic coherence,
and expressive motion generation. Below, we highlight the key characteristics of audio/
sound-guided video generation methods.
●
Audio-Driven Motion and Expression: Models like Hallo (Xu et al. 2024), EMO (Tian
et al. 2024), and TPoS (Jeong et al. 2023) generate expressive facial and gesture motion
from speech using phoneme-to-motion mapping and emotion-aware conditioning.
●
Context-Aware Sound Synthesis: Context-Aware Talking Face (Xuanyuan et al. 2024)
aligns visual motion with beats, rhythm, and ambient sounds, enabling scene-aware and
music-driven animations.
●
Audio-Visual Synchronization: AADiff (Lee et al. 2023) and Hallo (Xu et al. 2024)
use cross-modal attention and latent fusion to achieve precise lip-sync and temporal
coherence between sound and frames.
●
Cross-Modal Alignment: AV-Link (Haji-Ali et al. 2024) and Diverse-AVGen (Yariv
et  al. 2023) enhance semantic and temporal consistency between audio and video
through aligned attention and AV-specific metrics.
●
Latent Mapping and Adaptation: Uniform  (Zhao et al. 2025) and AV-Link (Haji-Ali
et al. 2024) build shared latent spaces or use adaptors for audio-to-visual conditioning
without full model retraining.
●
Benchmarks and Evaluation: TAVGBench  (Mao et  al. 2024) and AGAVQA  (Cao
et al. 2025) propose datasets and metrics (e.g., AVHScore, AGAV-Rater) for evaluating
alignment and perceptual quality in audio-driven generation.
3.4.7  Brain-guided video generation
Brain-guided video generation utilizes brain activity signals—typically captured through
modalities such as fMRI or EEG—to guide video synthesis. These methods aim to recon­
struct or generate visual content aligned with cognitive or perceptual states, exploring the
intersection of neuroscience and generative modeling. Below, we analyze the key character­
istics of brain-guided video generation techniques.
●
Spatiotemporal Brain Decoding: Models like Mind-Video  (Chen et  al. 2023) and
NeuroCine (Sun et al. 2024) decode dynamic visual content from fMRI signals by lev­
eraging masked brain modeling, temporal interpolation, and contrastive learning, ena­
bling biologically aligned video reconstruction.
●
Diffusion-Based Generative Frameworks with Interpretability: These methods in­
corporate temporally-aware diffusion models and attention-based decoding, achieving
high-fidelity synthesis and neural interpretability through alignment with known brain
structures.
1 3
Page 24 of 55
Video diffusion generation: comprehensive review and open problems
3.4.8  Depth-guided video generation
Depth-guided video generation leverages depth information as a conditional input to guide
the synthesis of temporally coherent and geometrically accurate videos. These methods can
enhance spatial consistency, preserve structural details, and improve motion realism in gen­
erated sequences by incorporating depth cues. Below, we analyze the key characteristics of
depth-guided video generation approaches.
●
Depth-guided Structural Control: Models like StableV2V (Liu et al. 2024) and An­
imate-A-Story (He et al. 2023) use depth maps to guide motion and ensure shape-con­
sistent generation across frames. This improves visual coherence and controllability by
aligning motion with scene geometry.
●
Controllable and Personalized Generation: Animate-A-Story  (He et  al. 2023) re­
trieves motion structures from reference clips and combines them with text prompts,
These methods highlight the effectiveness of depth cues in enhancing spatiotemporal
consistency and enabling scene-aware control in video generation.
3.4.9  Analysis of the advantages and disadvantages
This section summarizes the overall advantages and disadvantages of diffusion-based con­
ditioned video generation methods. Below, we explain the details of these advantages and
disadvantages.
•Advantages:
Cross-Modal and Fine-Grained Control: Conditioned generation enables precise control
over spatial layout, temporal dynamics, and appearance by incorporating diverse inputs
(e.g., text, pose sequences, depth maps, and audio signals). Representative models like Vid­
eoDirectorGPT (Lin et al. 2023) offer structured scene planning for multi-entity coordina­
tion, while MagicAnimate (Xu et al. 2024b) ensures identity preservation and fluid skeletal
motion in human animations.
Temporal Coherence and Realism: Advanced models maintain smooth transitions and
long-range temporal consistency through autoregressive or refinement strategies. MOFAVideo (Niu et al. 2024) and DreamPose (Karras et al. 2023) improve fluidity with dense
motion modeling, while FreeInit (Wu et al. 2024) and NUWA-Infinity (Wu et al. 2022)
leverage initialization or memory to extend generation length with reduced flicker and
artifacts.
Scalability and Training Efficiency: Training-free paradigms like Text2video-Zero (Kha­
chatryan et al. 2023), F3-Pruning (Su et al. 2024), and AdaDiff (Zhang et al. 2023) enable
fast deployment and reduce computation by leveraging pre-trained backbones and pruning
techniques. Meanwhile, hybrid pipelines such as Show-1 (Zhang et al. 2024) and Grid­
Diff (Lee et al. 2024) combine coarse-to-fine generation with modular structures, balancing
visual quality and efficiency.
Domain Versatility and Personalization: Conditioned generation is widely applicable
across diverse domains—from audio-driven talking faces (Xu et al. 2024; Tian et al. 2024)
to brain-guided scene reconstruction (Chen et al. 2023; Sun et al. 2024). Models like Video­
Booth (Jiang et al. 2024) and PhysGen (Liu et al. 2024) further support personalized outputs
1 3
Page 25 of 55
W. Ma et al.
with controllable identity, emotion, or spatial layout, demonstrating flexibility in content
customization.
•Disadvantages:
High Resource and Data Requirements: Many high-quality, training-based approaches
(e.g., Imagen Video (Ho et al. 2022), Make-A-Video (Singer et al. 2022) demands largescale training on multi-modal datasets, significant GPU resources, and fine-grained annota­
tions (e.g., audio-visual or pose-aligned data), limiting their accessibility and scalability.
Generalization and Motion Limitations: Moreover, image/video-guided methods such as
DreamVideo (Wang et al. 2025) may inherit static priors from their reference inputs, which
hinders motion generalization and causes repetitive or unnatural dynamics.
Semantic Ambiguity and Alignment Issues: For audio-driven generation (Lee et al. 2023;
Jeong et al. 2023), aligning acoustic features with visual semantics is inherently tricky,
especially under noisy conditions. Brain-guided (Chen et al. 2023; Sun et al. 2024) and
depth-guided (He et al. 2023; Xing et al. 2024) models further suffer from limited training
data or poor input reliability, degrading generation quality.
Trade-off Between Control and Realism: Highly constrained synthesis may hinder real­
ism. Over-conditioning—e.g., via overly rigid trajectories, bounding boxes, or depth con­
straints—can result in unnatural motion artifacts or visual inconsistencies, as observed in
motion- and pose-driven settings (Chen et al. 2024; Zhu et al. 2024).
3.5  Unconditional video generation
Unconditional video generation synthesizes videos without explicit conditioning (e.g., text
or motion cues) by autonomously learning temporal dynamics and visual patterns. Driven
by diffusion models, recent approaches follow two main architectures: UNet-based and
Transformer-based designs. In the following sections, we analyze these approaches’ charac­
teristics, pros and cons, and future research directions.
3.5.1  UNet-based video generation
In this part, we analyzed the characteristics of UNet-based video generation, and below are
its details.
•Spatial-Temporal Representation Learning: UNet-based models capture multi-scale
spatial-temporal features via encoder-decoder hierarchies. Hybrid Video Diffusion (Kim
et al. 2024), GD-VDM (Lapid et al. 2023) integrate 2D/3D representations or depth priors
to enhance realism and coherence.
•Latent Diffusion for Efficient Generation: Models like VPDinPL (Yu et al. 2023);
VIDM (He et al. 2022); LEO (Liang et al. 2023) operate in latent space to reduce compu­
tational cost and accelerate generation. VPDinPL uses factorized latent encoding for long
videos, while LEO disentangles motion and appearance to improve motion fidelity.
3.5.2  Transformer-based video generation
●
Temporal Dependency Modeling: Transformer-based models capture long-range mo­
tion via self-attention. VDT (Lu et al. 2023) decouples spatial-temporal attention with
1 3
Page 26 of 55
Video diffusion generation: comprehensive review and open problems
unified masking, while Redefining Temporal Modeling (Liu et al. 2024) introduces vec­
torized timestep scheduling to improve flexibility and temporal stability.
●
Tokenized and Discrete Representation Learning: VQ-based methods like VQGANTransformer (Ge et al. 2022) and Latte (Ma et al. 2024) tokenize video into discrete
units for autoregressive prediction. Latte enhances efficiency with spatial-temporal de­
composition, enabling scalable and controllable generation.
3.5.3  Analysis of the advantages and disadvantages
This section summarizes the advantages and disadvantages of diffusion-based uncondi­
tional video generation methods. Below, we explain the details of these advantages and
disadvantages.
•Advantages:
Effective Spatialâ€“Temporal Representation Learning: UNet-based models such as
VIDM (He et al. 2022) and LEO (Liang et al. 2023) leverage hierarchical convolution and
latent-space modeling to generate high-resolution, temporally consistent videos while main­
taining efficiency. Flow-based motion modules further improve motion realism and scene
coherence.
Long-Range Temporal Dependency Modeling: Transformer-based methods like VDT (Lu
et al. 2023); RTM-VQGAN-Trans (Liu et al. 2024); and Latte (Ma et al. 2024) utilize selfattention to capture long-range dependencies, supporting better motion continuity over
extended frames and enhancing complex temporal structure modeling.
Flexible Conditioning and Token-Level Control: Transformers allow fine-grained control
over sequence elements and enable seamless integration of text, structure, or modality infor­
mation (Ge et al. 2022), which is difficult to achieve in CNN-based models.
High-Fidelity and Scalable Synthesis: By leveraging discrete latent representations (e.g.,
VQ tokens), transformer-based models improve semantic alignment and visual quality
while offering different video lengths and resolutions scalability.
•Disadvantages:
Limited Long-Term Temporal Modeling in CNNs: UNet architectures often lack global
receptive fields, making it difficult to capture long-term dependencies compared to selfattention-based models.
High Computational Overhead in Transformers: Transformer-based video generation
introduces heavy memory and time consumption, especially when handling high-resolution
or long-duration clips (Lu et al. 2023; Ma et al. 2024).
Slow Inference and Optimization Instability: Sequential attention and autoregressive
mechanisms can significantly slow down inference compared to convolutional pipelines,
and long sequence training may suffer from instability (Liu et al. 2024; Ma et al. 2024).
Architecture Rigidity in UNet Models: UNet-based pipelines offer less architectural flex­
ibility for cross-modal tasks, and their reliance on latent compression may lead to loss of
fine spatial details in long-term or complex scenarios.
3.6  Video completion
Video completion refers to generating or restoring missing, corrupted, or future frames in
a video sequence. It includes video inpainting, super-resolution, denoising, frame interpo­
1 3
Page 27 of 55
W. Ma et al.
lation, and predictive synthesis. These techniques are crucial in low-level restoration and
high-level understanding of temporal dynamics, contributing to more robust and control­
lable video generation pipelines.
3.6.1  Enhancement and restoration
This task aims to improve the perceptual quality of degraded videos through diffusion-based
techniques, focusing on super-resolution, denoising, inpainting, and temporal consistency.
●
Multimodal-Guided Restoration: Methods like Language-Driven Video Inpaint­
ing (Wu et al. 2024) and AVID (Zhang et al. 2023) incorporate language or action cues
to guide semantically-aware restoration, extending beyond visual-only enhancement.
●
Diffusion for Super-Resolution and Interpolation: Inflation with Diffusion  (Yuan
et al. 2024) and LDMVFI (Danier et al. 2023) apply latent diffusion for high-quality up­
scaling and frame interpolation, improving perceptual smoothness and detail recovery.
●
Lightweight and High-Fidelity Upscaling: Upscale-A-Video (Zhou et al. 2023) com­
bines flow-guided propagation and text prompts for controllable, high-resolution video
enhancement with temporal consistency.
●
User-Controllable Restoration: CaDM  (Zhou et  al. 2022) and Look Ma, No
Hands!  (Chang et al. 2023) enable codec-aware and egocentric video restoration, intro­
ducing user or environment-driven control in restoration pipelines.
3.6.2  Video prediction
Video prediction focuses on forecasting future frames from a historical context, with appli­
cations in action anticipation, video completion, and autonomous driving. Diffusion-based

## Method

ditioning, latent priors, and autoregressive modeling.
●
Future Frame Generation with Long-Term Consistency: Models like STDiff (Ye
and Bilodeau 2024) and MCVD (Voleti et al. 2022) employ stochastic motion modeling
and masked training to improve continuity. AVID (Zhang et al. 2023) uses mid-frame
attention to enable consistent text-guided inpainting across variable-length sequences.
●
Latent Diffusion for Predictive Motion Modeling: LG-CVD (Yang et al. 2023) and
RaMViD (Höppe et al. 2022) apply latent-space diffusion with context-aware modules
for efficient, scalable prediction without relying on heavy 3D convolution.
●
Mask-Based and Flexible Conditioning: MaskViT  (Gupta et  al. 2022) introduces
masked modeling with temporal refinement for high-resolution prediction. Seer (Gu
et al. 2023) adapts T2I models using spatiotemporal attention and decomposed text
guidance.
●
Multimodal or Instructional Control: Control-A-Video (Chen et al. 2024) combines
text prompts and structural maps (e.g., edge, depth) with reward optimization to en­
hance alignment and controllability in future frame synthesis.
1 3
Page 28 of 55
Video diffusion generation: comprehensive review and open problems
3.6.3  Analysis of the advantages and disadvantages
This section summarizes the advantages and disadvantages of diffusion-based video com­
pletion methods. Below, we explain the details of these advantages and disadvantages.
•Advantages:
Semantically-Aware Restoration and Enhancement: Methods such as Language-Driven
Inpainting (Wu et al. 2024) and AVID (Zhang et al. 2023) utilize text or action cues for
guided restoration, improving contextual accuracy and user alignment.
High-Quality Temporal Recovery: Diffusion-based techniques like LDMVFI  (Danier
et al. 2023) and Inflation with Diffusion (Yuan et al. 2024) produce superior spatial and
temporal fidelity over traditional interpolation or super-resolution methods.
Lightweight and Scalable Design: Approaches such as Upscale-A-Video (Zhou et al.
2023) and CaDM (Zhou et al. 2022) adopt modular architectures suitable for deployment in
practical scenarios with controllable resolution and robustness.
Long-Term Prediction with Flexible Control: Models like STDiff  (Ye and Bilodeau
2024), MCVD (Voleti et al. 2022), and MaskViT (Gupta et al. 2022) support temporally sta­
ble forecasting with masked inputs. In contrast, Control-A-Video (Chen et al. 2024) lever­
ages multimodal prompts (e.g., depth, edge, or text) to condition future predictions toward
downstream task requirements.
•Disadvantages:
Temporal Instability in Dynamic Scenes: Despite progress, handling occlusion, fast
motion, and long-term temporal consistency remain a challenge, often leading to drift or
degradation (Voleti et al. 2022).
High Inference Cost: Most models require iterative denoising steps, introducing latency
that hinders real-time applications (Ye and Bilodeau 2024).
Domain and Input Sensitivity: Performance may degrade across unseen conditions or
misaligned prompts, especially in multimodal or controllable pipelines ((Chen et al. 2024),
(Chang et al. 2023)).
Training Complexity and Generalization: Instruction-guided or hybrid models (e.g.,
Seer (Gu et al. 2023), Look Ma (Chang et al. 2023)) may suffer from instability and limited
transferability without extensive domain adaptation.
4  Datasets and metrics
This section provides an overview of the commonly used datasets and evaluation metrics for
video generation tasks, specifically focusing on video generation based on diffusion models.
4.1  Common datasets for video generation
The development of video generation models is closely tied to the availability of high-qual­
ity datasets. These datasets can be categorized into two main types: caption-level datasets,
which provide video-text pairs to support tasks like text-to-video generation, and categorylevel datasets, which group videos by predefined action or semantic categories and are
commonly used for unconditional or class-conditional generation. Below, we describe rep­
resentative datasets from both categories.
1 3
Page 29 of 55
W. Ma et al.
4.1.1  Caption-level datasets
Caption-level datasets consist of video clips paired with descriptive textual captions, mak­
ing them essential for text-to-video generation, captioning, and multimodal retrieval tasks.
We summarize major caption-level datasets in Table  2, covering early benchmarks
such as MSR-VTT (Xu et al. 2016), large-scale resources like HowTo100M (Miech et al.
2019) and WebVid-10 M (Bain et al. 2021), and recent instruction-based datasets such as
Señorita-2 M (Zi et al. 2025) and VideoUFO (Wang and Yang 2025). These datasets vary in
Table 2  Comparison of caption-level datasets for diffusion-based video generation
Dataset
Year
Clips
Resolution
Domain
Source
MSR-VTT (Xu et al.
2016)
10K
240P
General
Manual
HowTo100M (Miech
et al. 2019)
136 M
240P–720P
Instructional
ASR (Miech
et al. 2019)
WebVid-10 M (Bain
et al. 2021)
10.7M
360P
Open-domain
Alt-text
HD-VILA (Zellers 2022) 2022
103 M
720P
Open-domain
ASR
HD-VG-130 M (Wang
et al. 2025)
130 M
720P
Open-domain
Generated
InternVid (Wang et al.
2024)
234 M
720P
Open-domain
Generated
CelebV-Text (Yu et al.
2023)
70K
480P
Face-centric
Generated
Youku-mPLUG (Xu
et al. 2023)
10 M
720P
Chinese video
Generated
Panda-70 M (Chen et al.
2024)
70.8M
720P
Open-domain
Generated
ChronoMagic-Pro (Yuan
et al. 2024)
460K
720P
Time-lapse
Manual
OpenVid-1 M (Nan et al.
2025)
1 M
720P
General
Generated
Koala-36 M (Wang et al.
2024)
36 M
512P
Open-domain
Refined +
Gen
LVD-2 M (Xiong et al.
2024)
2 M
512P
Long video
Manual
MovieBench (Wu et al.
2025)
1K movies
1080P
Movie-level
Manual +
Struct
VIVID-10 M (Hu et al.
2024)
10 M
512P+
Local editing
Instructionbased
VideoBooth (Jiang et al.
2023)
48.7K
(train) / 650
(test)
–
Image+Text-conditioned
Filtered
from Web­
Vid-10 M
CustomVideo (Wang
et al. 2024)
68 pairs / 63
subjects
–
Multi-subject identity
Manual +
Segmented
OpenHumanVid (Li
et al. 2025)
5 M
720P
Human-centric
Manual +
Refined
Señorita-2 M (Zi et al.
2025)
2 M
720P
Video editing
Expertannotated
VideoUFO (Wang and
Yang 2025)
1 M
720P
User-focused
Instructionbased
1 3
Page 30 of 55
Video diffusion generation: comprehensive review and open problems
supervision quality, domain coverage, and data source, supporting diverse generation tasks
from open-domain synthesis to controllable editing.
4.1.2  Category-level datasets
As summarized in Table 3, category-level datasets span various domains, including human
actions (e.g., UCF-101 (Soomro et al. 2012); Kinetics-400 (Kay et al. 2017); robotic tasks
(e.g., BAIR (Ebert and et al. 2017); BridgeData (Walke et al. 2024), and autonomous driv­
ing (e.g., RDS (Liang and et al. 2022); Cityscapes (Cordts and et al. 2016). These datasets
support the training and evaluation of video generation models across prediction, segmenta­
tion, and motion synthesis scenarios.
4.2  Metrics and benchmark for diffusion-based video generation
As summarized in Table  4, evaluation metrics for diffusion-based video generation can
be broadly categorized into image-level, video-level, and increasingly, specialized mul­
timodal metrics. Image-level metrics such as FID (Heusel et al. 2017), PSNR (Hore and
Ziou 2010), SSIM (Wang et al. 2004), and CLIPSim (Radford et al. 2021) assess the visual
quality and text alignment of individual frames.
Video-level metrics such as FVD (Unterthiner et al. 2019), KVD (Ryan et al. 2023), and
Video IS (Wu et al. 2016) extend this evaluation to temporal aspects. Additional indicators
like Frame Consistency (Wu et al. 2022), Motion Consistency (Liu et al. 2023; Tian et al.
2021), and Diversity Score (Saito et al. 2017) further evaluate frame smoothness, motion
realism, and output diversity.
Recently, multimodal and perception-driven metrics have gained attention, including
VideoCLIPSim (Fang et al. 2023) for video-text alignment, AV-Align (Haji-Ali et al. 2024;
Mao et al. 2024) for rhythm and semantic synchronization, and BenchUFO (Wang and Yang
Table 3  Comparison of category-level datasets for diffusion-based video generation
Dataset
Year
Categories
Clips
Resolution
Domain
UCF-101 (Soomro et al. 2012)
101
13K
320×240
Human Actions
Cityscapes (Cordts and et al. 2016)
30
3K
256×256
Urban Driving
Moving MNIST (Srivastava and et al.
2015)
10
10K
64×64
Digits
(Synthetic)
BAIR (Ebert and et al. 2017)
2
45K
64×64
Robot Arm
DAVIS (Perazzi and et al. 2016)
–
1280×720
Object
Segmentation
Kinetics-400 (Kay et al. 2017)
400
260K
256×256
Human Actions
Sky Time-Lapse (Xiong et al. 2018)
1
38K
256×256
Nature / Sky
Something-Something V2 (Goyal et al.
2017)
174
220K
256×256
Human Actions
Epic-Kitchen (Damen and et al. 2018)
149
90K
1920×1080
Egocentric
Cooking
TaiChi-HD (Siarohin and et al. 2019)
1
3K
256×256
Human Motion
BridgeData (Walke et al. 2024)
10
7K
256×256
Robot Tasks
RDS (VideoLDM) (Liang and et al.
2022)
2
683K
512×1024
Autonomous
Driving
1 3
Page 31 of 55
W. Ma et al.
2025) for LLM-based assessment. These complement traditional metrics by incorporating
human perception and multi-condition controllability.
Overall, a combination of frame-level accuracy, temporal smoothness, multimodal align­
ment, and diversity is essential for robust evaluation. Developing unified, scalable, and taskspecific benchmarks remains a key direction for future research.
5  Performance comparison
This section presents a comprehensive comparison of recent text-to-video generation
models evaluated on two widely used benchmarks: UCF-101 (Soomro et al. 2012) and
MSR-VTT (Xu et al. 2016). The comparison is based on key quantitative metrics, includ­
ing Fréchet Video Distance (FVD) (Unterthiner et al. 2019), Inception Score (IS) (Wu et al.
2016), Fréchet Inception Distance (FID) (Heusel et al. 2017), and CLIP Similarity (CLIP­
Sim) (Radford et al. 2021), which jointly reflect the visual quality, motion coherence, and
semantic consistency of generated videos.
The results in Table 5 are based on the pre-trained weights provided by the official
repositories of each method or on the models trained using their released code. The bestperforming results for each indicator are highlighted in bold within the table. In the method
column of Table 5, the method with ∗ is the zero-shot method. At the same time, we also
presented some visualizations from the original paper, as shown in Fig. 6, Fig. 7 and Fig. 8.
We hope to use these visualizations to give readers a more intuitive understanding of this
field. Figure 7 and 8 present visualizations from three leading open-source SOTA methods:
SVD (Blattmann et al. 2023), CogVideoX (Yang et al. 2024), and Huanyuanvideo (Kong
et al. 2024), these results illustrate the strengths of current SOTA models in semantic fidel­
ity and temporal continuity, each exhibiting distinctive visual characteristics. The following
presents our experimental analysis.
Table 4  Summary of evaluation metrics for diffusion-based video generation
Metric Type
Metric
Key Property
Image-level
FID (Heusel et al. 2017)
Visual realism (distribution distance between real
and generated frames)
PSNR (Hore and Ziou 2010)
Pixel-level reconstruction accuracy
SSIM (Wang et al. 2004)
Structural similarity and visual coherence
CLIPSim (Radford et al. 2021)
Frame-text semantic alignment using CLIP
Video-level
FVD (Unterthiner et al. 2019)
Temporal consistency and perceptual realism
KVD (Ryan et al. 2023)
KL divergence-based distribution similarity
Video IS (Wu et al. 2016)
Frame-level realism and intra-video diversity
Frame Consistency (Wu et al.
2022)
Smoothness and coherence across adjacent frames
VideoCLIPSim (Fang et al. 2023)
Video-caption alignment using VideoCLIP
Specialized
Motion Consistency (Liu et al.
2023)
Smooth and plausible motion transition
AV-Align (Haji-Ali et al. 2024)
Audio-video semantic or rhythmic synchronization
BenchUFO (Wang and Yang 2025)
LLM-based consistency and controllability

## Evaluation

1 3
Page 32 of 55
Video diffusion generation: comprehensive review and open problems

## Method

Year
Data
Res.
UCF-101
MSR-VTT
FID(↓)
FVD(↓)
IS(↑)
FID(↓)
FVD(↓)
CLIPSim(↑)
TATS (Ge et al. 2022)
–
256×256
–
79.28
–
–
–
MMVG∗ (Fu et al. 2023)
–
128×128
–
58.3
60.6
–
0.2385
NUWA (Wu et al. 2022)
–
256×256
–
–
–
–
–
0.2402
LVDM∗ (He et al. 2022)
2 M
256×256
–
641.8
–
–
0.2381
Magic-Video∗ (Zhou et al. 2022)
10 M
256×256
145.00
699.00
–
–
–
Make-A-Video∗ (Singer et al. 2022)
273
256×256
–
367.23
33.00
13.17
–
0.3049
ED-T2V∗ (Liu et al. 2023)
10 M
256×256
–
–
–
–
–
0.2763
InternVid∗ (Wang et al. 2024)
28 M
256×256
60.25
616.51
21.04
–
–
0.2951
Video-LDM∗ (Blattmann et al. 2023)
10 M
256×256
–
550.61
33.45
–
–
0.2929
Video-Composer∗ (Wang et al. 2023)
10 M
256×256
–
–
–
–
0.2932
Latent-shift∗ (An et al. 2023)
10 M
256×256
–
–
–
15.23
–
0.2773
Video-Fusion∗ (Luo et al. 2023)
10 M
256×256
75.77
639.90
17.49
–
0.2795
Make-Your-Video∗ (Xing et al. 2024)
10 M
256×256
–
330.49
–
–
–
–
PYoCo∗ (Ge et al. 2023)
22.5M
256×256
–
355.19
47.76
9.73
–
–
CoDi∗ (Tang et al. 2023)
512×512
–
–
–
–
–
0.2890
NExT-GPT∗ (Wu et al. 2024)
320×576
–
–
–
13.04
–
0.3085
Dysen-VDM∗ (Fei et al. 2024)
10 M
256×256
–
325.42
35.57
12.64
–
0.3204
VideoFactory∗ (Wang et al. 2025)
256×256
–
410.00
–
–
–
0.3005
ModelScope∗ (Wang et al. 2023)
10 M
256×256
–
410.00
–
11.09
0.2930
VideoGen∗ (Li et al. 2023)
10 M
256×256
–
554.00
71.61
–
–
0.3127
Animate-A-Story∗ (He et al. 2023)
10 M
256×256
–
515.15
–
–
–
–
VidRD∗ (Gu et al. 2023)
5.3M
256×256
–
363.19
39.37
–
–
–
CogVideo (Chinese)∗ (Hong et al. 2022)
–
480×480
–
751.34
23.55
–
–
0.2614
CogVideo (English)∗ (Hong et al. 2022)
–
480×480
–
701.59
25.27
–
–
0.2631
LAVIE∗ (Wang et al. 2024)
10 M+25 M
320×512
–
526.30
–
–
–
0.2949
VideoDirGPT∗ (Lin et al. 2023)
10 M
256×256
–
–
–
12.22
0.2860
Show-1∗ (Zhang et al. 2024)
10 M
320×576
–
394.46
35.42
13.08
0.3072
Table 5  Performance comparison of text-to-video generation methods on UCF-101 and MSR-VTT datasets
1 3
Page 33 of 55
W. Ma et al.

## Method

Year
Data
Res.
UCF-101
MSR-VTT
FID(↓)
FVD(↓)
IS(↑)
FID(↓)
FVD(↓)
CLIPSim(↑)
Dynamicrafter∗ (Xing et al. 2024)
10 M
256×256
–
429.23
–
–
–
EMU-Video∗ (Girdhar et al. 2024)
10 M
256×256
–
606.20
42.70
–
–
–
SVD∗ (Blattmann et al. 2023)
577 M
256×256
–
242.02
–
–
–
–
W.A.L.T∗ (Gupta et al. 2024)
89 M
128×128
–
258.1
35.1
–
244.7
–
CMD∗ (Yu et al. 2024)
10 M
512×1024
–
504.00
–
–
–
0.2894
ModelScopeT2∗(Wang et al. 2023)
32×32
–
–
–
11.9
0.2930
Lumiere∗ (Bar-Tal et al. 2024)
10 M
320×576
–
332.49
37.54
–
–
–
RF (Long et al. 2024)
320×512
–
–
–
10.8
0.2859
ART•V∗ (Weng et al. 2024)
10 M
320×320
–
315.69
50.34
–
0.2859
AnimateDiff (Liu et al. 2023)
10 M
254×254
–
499.3
–
–
0.2880
MicroCinema∗ (Wang et al. 2024)
10 M
256×256
–
342.86
37.46
–
0.2967
Vlogger∗ (Zhuang et al. 2024)
10K
320×512
–
292.43
–
–
–
0.2908
Make Pixels Dance∗ (Zeng et al. 2024)
10 M
256×256
49.36
242.82
42.10
–
0.3125
SimDA∗ (Xing et al. 2024)
10 M
256×256
–
–
–
–
0.2945
Snap Video∗ (Menapace et al. 2024)
10 M
288×288
39.0
260.1
38.89
–
110.4
0.2793
MoVideo∗ (Liang et al. 2024)
–
256×256
–
313.41
34.13
12.71
–
0.3213
MagDiff∗ (Zhao et al. 2024b)
5.3M+76K
256×256
–
339.62
48.57
–
–
HARIVO (Kwon et al. 2024)
–
256×256
–
–
–
–
787.87
0.2948
VersVideo-L∗ (Xiang et al. 2023)
–
256×256
–
–
72.9
–
–
Table 5  (continued)
1 3
Page 34 of 55
Video diffusion generation: comprehensive review and open problems
5.1  Comparative analysis on UCF-101 and MSR-VIT
UCF-101 is widely adopted to evaluate motion realism and dynamic consistency in gener­
ated videos. As observed in Table 5, recent methods trained on large-scale datasets tend to
perform better in terms of Fréchet Video Distance (FVD) and Inception Score (IS). Notably,
Snap Video (Menapace et al. 2024) achieves the best FID of 39.00 and a low FVD of 260.1,
along with an IS of 38.89, showing its strong capability in generating temporally coherent
and visually rich videos.
PixelDance (Zeng et al. 2024) also demonstrates excellent motion quality with an FVD
of 242.82 and IS of 42.10. MoVideo (Liang et al. 2024) balances both metrics well, reaching
313.41 (FVD) and 34.13 (IS). SVD (Blattmann et al. 2023) reports the best FVD (242.02)
among all, reflecting the benefit of training on large-scale datasets (577 M samples).
Fig. 6  Comparison between VDM (Ho et al. 2022) (top), Make-A-Video (Singer et al. 2022) (middle),
and CogVideo (Hong et al. 2022) (bottom) for the prompt “An orange cat jumped up and pounced on the
fish in the water”. Representative frames are shown from our implementation of the models, using official
codebases and pre-trained weights
1 3
Page 35 of 55
W. Ma et al.
Older methods such as LVDM (He et al. 2022) and Magic-Video (Zhou et al. 2022)
exhibit relatively higher FVDs (641.8 and 699.0, respectively), indicating the significant
improvement over time brought by architectural advances and training scale.
MSR-VTT is the primary benchmark for evaluating text-video semantic alignment, with
CLIPSim as the core metric. As seen in Table 5, MoVideo (Liang et al. 2024) leads with
a CLIPSim of 0.3213, followed closely by Dysen-VDM (Fei et al. 2024) (0.3204), Pixel­
Fig. 7  A comparison of different SOTA diffusion video generation models using pre-trained weights for
multi-frame visualization. From top to bottom: SVD (Blattmann et al. 2023), CogVideoX (Yang et al.
2024), and Huanyuanvideo (Kong et al. 2024)
1 3
Page 36 of 55
Video diffusion generation: comprehensive review and open problems
Dance (Zeng et al. 2024) (0.3125), and VideoGen (Li et al. 2023) (0.3127), all demonstrat­
ing robust multimodal alignment.
NExT-GPT (Wu et al. 2024) and Show-1 (Zhang et al. 2024) achieve CLIPSim scores
over 0.30 while also maintaining low FVDs. These models leverage large-scale videolanguage pretraining and diffusion-transformer architectures to effectively align textual
prompts with visual content.
In contrast, models like CogVideo (Hong et  al. 2022) (English version: 0.2631) and
NUWA (Wu et  al. 2022) (0.2402) show lower CLIPSim scores, reflecting earlier-stage

## Method

Fig. 8  Same to Fig. 7
1 3
Page 37 of 55
W. Ma et al.
5.2  Analysis of SOTA model performance
Recent SOTA models in diffusion-based video generation demonstrate substantial improve­
ments in both visual fidelity and semantic alignment. In terms of model architecture, Snap
Video adopts a multi-stage diffusion process that decouples motion modeling from frame
synthesis, effectively mitigating temporal error accumulation. In its global local feature
extraction mechanism, global features maintain scene consistency, while local features
focus on optimizing dynamic details. This explicitly modular architecture contributes sig­
nificantly to the model’s superior motion smoothness.
PixelDance achieves its performance gains through an innovative local attention mecha­
nism that explicitly constrains fine-grained motion correlations between adjacent frames.
This allows the model to better capture subtle motion dynamics. Additionally, its multi-scale
context fusion facilitates temporal dependency modeling across different time scales, sup­
porting strong temporal consistency in long video sequences.
The impact of training data size on model performance is particularly significant. Taking
SVD as an example, its 577 million sample training set provides the model with rich spatio­
temporal distribution priors, which enables the model to infer more reasonable time transi­
tions when generating long videos. In contrast, models trained on smaller scale data, such
as VideoGen, often require a compromise between text alignment and perceptual quality.
In terms of cross modal understanding, MoVideo achieves strong semantic alignment
through a large-scale text-video pretraining strategy using a cross-modal Transformer archi­
tecture. This design enables accurate interpretation of spatiotemporal concepts described in
text, which are then transformed into coherent and semantically rich visual content.
The current evaluation system has several important limitations: firstly, different indica­
tors focus on different aspects, with FVD placing more emphasis on motion quality and IS
leaning towards static image quality, which may lead to conflicts in model optimization
objectives. Secondly, the difference in output resolution (ranging from 128 × 128 to 512 ×
1024) directly affects the evaluation of perceptual quality, but this factor is often overlooked
in existing benchmark tests. Finally, some methods (such as Animate-A-Story) lack com­
plete evaluation results, further complicating direct comparisons across models.
These performance variations reflect differing design priorities among research teams:
some (e.g., SVD) emphasize scalability, while others (e.g., PixelDance) prioritize precise
modeling of motion dynamics. This diversity highlights the complexity of video generation
and underscores the need for unified and standardized evaluation criteria.
5.3  Summary
In summary, Table 5 reflects the rapid advancement of diffusion-based text-to-video models,
with clear improvements in motion smoothness, image fidelity, and semantic alignment.
The top-performing models such as Snap Video, MoVideo, and PixelDance showcase the
potential of large-scale diffusion learning combined with advanced architectural innova­
tions. Future benchmarking should focus on unified metric reporting, resolution normaliza­
tion, and task-specific evaluation to ensure fairer comparisons across the diverse landscape
of video generation models.
1 3
Page 38 of 55
Video diffusion generation: comprehensive review and open problems
6  Solved and unsolved challenges
6.1  Overview of achievements
In recent years, diffusion-based video generation has made remarkable progress, driving
both theoretical innovation and practical application. Key achievements include:
●
Enhanced temporal coherence: Multi-stage refinement networks and dynamic tempo­
ral alignment modules have substantially improved frame-to-frame continuity, reducing
flickering and inconsistency in generated videos.
●
Improved semantic fidelity: Integration of multimodal conditions such as text, pose,
audio, and depth maps has enabled models to generate videos that align closely with
user-specified prompts. Approaches leveraging cross-attention and latent conditioning,
exemplified by Snap Video(Menapace et al. 2024), PixelDance(Zeng et al. 2024), and
MoVideo(Liang et al. 2024), have demonstrated fine-grained semantic control.
●
Efficiency gains: Latent diffusion models (e.g., LDM(Rombach et al. 2022)) and adap­
tive sampling schedules have reduced inference time and computational load, making
high-quality generation more practical.
●
Advanced architectures: The adoption of diffusion-transformer hybrids and temporal
attention mechanisms has improved both global scene understanding and local motion
consistency, supporting complex tasks such as story-driven generation and dynamic
scene synthesis.
●
New evaluation metrics: While FVD(Unterthiner et al. 2019) and IS(Wu et al. 2016)
remain foundational, the field now incorporates metrics like CLIPSim(Radford et al.
2021) to address previously overlooked dimensions, particularly the semantic fidelity of
generated content to input prompts.
6.2  Key unsolved challenges
Despite the progress, the field faces several unsolved challenges:
●
Temporal consistency in long videos: Existing methods often exhibit drift or incoher­
ence in long sequences, requiring explicit memory or hierarchical modeling.
●
Cross-modal integration limitations: Ensuring consistent alignment across diverse
modalities (text, audio, pose) is challenging, especially for complex prompts.
●
Graph Diffusion Models: Current diffusion models underutilize graph structures,
which could improve scene coherence and structural reasoning.
●
Inference efficiency: High computational costs remain a bottleneck for practical de­
ployment, particularly for high-resolution or real-time applications.
●

## Evaluation

benchmarking, calling for standardized protocols.
These unresolved issues highlight the need for further research into temporal modeling,
efficient architectures, cross-modal fusion, and comprehensive evaluation strategies. A more
detailed discussion of these challenges, along with corresponding future research directions,
is provided in SectionÂ 7.
1 3
Page 39 of 55
W. Ma et al.
7  Future research directions and open problems
This section synthesizes key trends and emerging opportunities in diffusion-based video
generation. We summarize unresolved issues, promising future directions, and emerging
technologies that may drive the next stage of research.
7.1  Enhancing temporal coherence and efficiency
Ensuring temporal stability remains one of the most persistent challenges in video gen­
eration. While short videos can achieve frame-level coherence through simple spatial con­
straints, long-form synthesis often suffers from temporal drift and motion inconsistency.
Future research should focus on memory-augmented architectures, recurrent latent dynam­
ics, and hierarchical generation strategies that explicitly capture long-range dependencies.
Techniques such as temporal recycling, latent interpolation, and causal conditioning can be
employed to maintain context continuity in multi-second or minute-long videos. In particu­
lar, incorporating memory mechanisms (e.g., recurrent latent states) and structured priors
(e.g., scene graphs) can significantly improve long-range temporal reasoning and visual
consistency.
The growing complexity of diffusion models also presents challenges for inference
speed, scalability, and resource efficiency. While multi-stage and cascaded frameworks
(e.g., Show-1 (Zhang et al. 2024), FlexiFilm (Ouyang et al. 2024)) offer enhanced qual­
ity, they come at the cost of computationally intensive sampling. Future directions include
designing lightweight backbones (e.g., sparse transformers, hybrid UNet, ViT), adaptive
sampling schedules, and plug-in modules (e.g., adapters, dynamic denoising paths) to bal­
ance quality with speed. Furthermore, model distillation techniques offer a promising way
to reduce the inference burden by transferring knowledge from large diffusion models into
compact, efficient variants suitable for real-time or edge deployment.
7.2  Advancing cross-modal integration and graph-based reasoning
Recent methods have demonstrated the effectiveness of multimodal guidance (e.g., text,
audio, pose, depth, brain activity), but maintaining semantic consistency across these diverse
inputs remains challenging. Future research should explore unified embedding spaces, hier­
archical conditioning, and token-level cross-modal fusion for better integration. Applica­
tions such as sound-guided motion (e.g., lip-sync or dance) and layout-driven synthesis can
benefit from stronger cross-modal alignment.
Graph-based diffusion models present a promising yet underexplored direction. By mod­
eling scene structures and temporal relationships as graphs, these approaches can enhance
scene coherence, multi-object interactions, and complex event synthesis. Integrating graph
structures into diffusion frameworks could significantly improve structural reasoning and
control in long, dynamic sequences.
Specifically, graph diffusion models can represent relationships between entities such
as objects, motions, or semantic regions, enabling more fine-grained control and interpret­
ability. Unlike traditional token-based methods, they allow explicit modeling of spatiotem­
poral dependencies and interactions, thus improving temporal consistency in long videos.
Leveraging graph neural networks (GNNs) within diffusion frameworks can also facilitate
1 3
Page 40 of 55
Video diffusion generation: comprehensive review and open problems
structured learning of complex scenes, supporting scenarios with intricate motions, multiobject dynamics, and enhanced scene coherence.
7.3  Improving generalization and control flexibility
Diffusion models trained on fixed domains often struggle with generalization to open-domain
scenarios or unseen combinations of prompts. Future work should focus on data-efficient
pretraining, unsupervised learning, and multi-domain adaptation strategies. Few-shot or
zero-shot models leveraging vision-language foundation models (VLFMs) offer potential
for improving generalization while minimizing retraining requirements.
Strong conditioning signals, such as fixed images or depth maps, can lead to overfitting
or suppression of motion diversity. Adaptive conditioning strength modulation, semantic fil­
tering of control inputs, and multi-scale conditioning refinement are essential for maintain­
ing control precision while preserving diversity, particularly for tasks like image-to-video,
depth-driven editing, and audio-visual synthesis.
7.4  Towards unified frameworks and human-centered interaction
Currently, video generation tasks are often handled in isolation, with separate models opti­
mized for specific tasks. A promising direction is to develop unified frameworks that sup­
port flexible task switching and modular component reuse, such as multi-head transformers,
hierarchical decoders, and routing networks. These can enable comprehensive applications
like instruction-based video editing or scene-aware generation with multi-resolution outputs.
Human-interactive, real-time generation systems are increasingly needed for practical
deployment. Future research should focus on intuitive interfaces, such as sketching, dragbased motion cues, and mixed-modality prompts, alongside progressive refinement and
conditional feedback mechanisms. Low-latency pipelines with explainable intermediate
states will be crucial for creative and educational applications.
7.5  Ethical considerations and broad applications
The rise of diffusion-based video generation brings ethical concerns about misinformation,
privacy, and bias. Future research must focus on developing safety filters, bias mitigation
techniques, and transparent generation pipelines. Standardized evaluation protocols assess­
ing visual quality, temporal coherence, semantic alignment, and realism are needed for fair
comparison and trustworthy deployment.
Applications of diffusion-based video generation are expanding across industries, includ­
ing lifelike character animation, virtual avatars, film effects, immersive VR/AR simulations,
dynamic medical video synthesis, and personalized media creation. Further potential lies in
educational technology, environmental monitoring, and creative content generation, demon­
strating the broad societal impact of this technology.
Overall, future research on diffusion-based video generation must continue to address
several key challenges, including improving generation efficiency, reducing computational
costs, enhancing long-term temporal stability, and developing unified evaluation metrics.
Successfully overcoming these barriers will further boost the applicability of diffusion mod­
1 3
Page 41 of 55
W. Ma et al.
els in a wide range of real-world scenarios, such as film production, autonomous driving,
innovative healthcare, digital humans, and immersive media.
8  Conclusions
In summary, diffusion-based video generation has made remarkable strides in both academic
research and practical applications. These models have demonstrated superior capabili­
ties in generating high-fidelity, temporally coherent, and semantically controllable videos,
often outperforming traditional generative approaches such as GANs(Dhariwal and Nichol
2021) and autoregressive models. Key advances include the incorporation of sophisticated
architectures (e.g., UNet(Çiçek et al. 2016), Transformers(Yan et al. 2021)), adaptive sam­
pling strategies, and effective multimodal conditioning (e.g., text, pose, audio), which have
enabled the generation of videos with enhanced realism and control.
This review has highlighted the strengths and limitations of state-of-the-art diffusionbased video generation methods, offering a systematic analysis of their design principles,

## Evaluation

state-of-the-art models achieve impressive results in both perceptual quality and semantic
alignment, challenges remain in terms of temporal consistency over long sequences, gener­
alization to diverse domains, and computational efficiency.
Looking ahead, we observe several key trends and promising research directions. Future
efforts should focus on improving long-term temporal modeling, enabling more efficient
and scalable architectures, and advancing cross-modal integration for complex and control­
lable video synthesis. At the same time, architectures incorporating memory mechanisms
(e.g., recurrent latent states) or structured priors (e.g., scene graphs) could unlock longduration generation, while distillation techniques may enable real-time synthesis. Crucially,
the field must adopt rigorous evaluation standards—separating resolution-dependent effects
from true algorithmic progress through multi-scale benchmarks. Furthermore, standardized
benchmarking protocols, perceptual metrics, and fair evaluation practices are essential for
meaningful comparisons and trustworthy deployment of these models.
Overall, we believe that diffusion-based video generation is poised to revolutionize the
field of generative visual media. This review provides a comprehensive foundation for
future research, and we hope it inspires further exploration and innovation in this dynamic
and impactful area.
Author contributions  Wenping Ma, Xiaoting Yang and Licheng Jiao conceived and designed the study.
Xiaoting Yang finish the methodology design and manuscript writing. Wenping Ma and Licheng Jiao con­
tributed to the guidance paper and result analysis. Lingling Li, Xu Liu, and Fang Liu provided technical sup­
port during the experimental process, conducted experimental validation and data analysis, and contributed to
the manuscript revision. Puhua Chen, Yuting Yang, Mengru Ma, Long Sun, Ruohan Zhang, and Xueli Geng
assisted in data collection and preprocessing. Yuwei Guo, Shuyuan Yang, and Zhixi Feng provided helpful

## Discussion

the manuscript.
Data availability  The experimental datasets supporting the results of this study are as follows, all of which
are downloadable public datasets that can be used and downloaded from the corresponding website below:
(1)UCF-101: https://www.crcv.ucf.edu/data/UCF101.php (2) MSR-VTT: ​h​t​t​p​s​:​/​/​p​a​p​e​r​s​w​i​t​h​c​o​d​e​.​c​o​m​/​d​a​t​a​s​
e​t​/​m​s​r​-​v​t​t​
1 3
Page 42 of 55
Video diffusion generation: comprehensive review and open problems
Declarations
Conflict of interest  The authors declare no Conflict of interest.
Open Access   This article is licensed under a Creative Commons Attribution-NonCommercialNoDerivatives 4.0 International License, which permits any non-commercial use, sharing, distribution and
reproduction in any medium or format, as long as you give appropriate credit to the original author(s) and the
source, provide a link to the Creative Commons licence, and indicate if you modified the licensed material.
You do not have permission under this licence to share adapted material derived from this article or parts of it.
The images or other third party material in this article are included in the article’s Creative Commons licence,
unless indicated otherwise in a credit line to the material. If material is not included in the article’s Creative
Commons licence and your intended use is not permitted by statutory regulation or exceeds the permitted use,
you will need to obtain permission directly from the copyright holder. To view a copy of this licence, visit ​h​
t​t​p​:​/​/​c​r​e​a​t​i​v​e​c​o​m​m​o​n​s​.​o​r​g​/​l​i​c​e​n​s​e​s​/​b​y​-​n​c​-​n​d​/​4​.​0​/.

## References

Akkerman R, Feng H, Black MJ, et al (2024) Interdyn: controllable interactive dynamics with video diffusion
models. arXiv preprint arXiv:2412.11785
Alayrac JB, Donahue J, Luc P et al (2022) Flamingo: a visual language model for few-shot learning. Adv
Neural Inf Process Syst 35:23716–23736
An J, Zhang S, Yang H, et al (2023) Latent-shift: Latent diffusion with temporal shift for efficient text-tovideo generation. arXiv preprint arXiv:2304.08477
Arkhipkin V, Shaheen Z, Vasilev V, et al (2023) Fusionframes: efficient architectural aspects for text-to-video
generation pipeline. arXiv preprint arXiv:2311.13073
Bain M, Nagrani A, Varol G, et al (2021) Frozen in time: A joint video and image encoder for end-to-end
retrieval. In: ICCV
Bai J, Xia M, Fu X, et al (2025) Recammaster: Camera-controlled generative rendering from a single video.
arXiv preprint arXiv:2503.11647
Bai J, Xia M, Wang X, et  al (2024) Syncammaster: synchronizing multi-camera video generation from
diverse viewpoints. arXiv preprint arXiv:2412.07760
Bandyopadhyay H, Song YZ (2024) Flipsketch: Flipping static drawings to text-guided sketch animations.
arXiv preprint arXiv:2411.10818
Bar-Tal O, Chefer H, Tov O, et al (2024) Lumiere: A space-time diffusion model for video generation. In:
SIGGRAPH Asia 2024 Conference Papers, pp 1–11
Blattmann A, Dockhorn T, Kulal S, et al (2023) Stable video diffusion: Scaling latent video diffusion models
to large datasets. arXiv preprint arXiv:2311.15127
Bu J, Ling P, Zhang P, et al (2024) Broadway: Boost your text-to-video generation model in a training-free
way. arXiv preprint arXiv:2410.06241
Cai S, Ceylan D, Gadelha M, et al (2024) Generative rendering: Controllable 4d-guided video generation
with 2d diffusion models. In: Proceedings of the IEEE/CVF conference on computer vision and pattern
recognition, pp 7611–7620
Cai M, Cun X, Li X, et al (2024) Ditctrl: Exploring attention control in multi-modal diffusion transformer for
tuning-free multi-prompt longer video generation. arXiv:2412.18597
Cao Y, Li S, Liu Y, et al (2023) A comprehensive survey of AI-Generated Content (AIGC): A history of gen­
erative ai from gan to chatgpt. arXiv preprint arXiv:2303.04226
Cao Y, Min X, Gao Y, et al (2025) Agav-rater: Adapting large multimodal model for ai-generated audiovisual quality assessment. arXiv preprint arXiv:2501.18314
Cao M, Mou C, Yuan Z, et al (2024) Consistent human image and video generation with spatially conditioned
diffusion. arXiv preprint arXiv:2412.14531
Chang M, Prakash A, Gupta S (2023) Look ma, no hands! agent-environment factorization of egocentric
videos. In: Advances in Neural Information Processing Systems (NeurIPS)
Chang D, Shi Y, Gao Q, et al (2023) Magicdance: Realistic human dance video generation with motions &
facial expressions transfer. CoRR
Chefer H, Zada S, Paiss R et al (2024) Still-moving: customized video generation without customized video
data. ACM Trans Grap (TOG) 43(6):1–11
1 3
Page 43 of 55
W. Ma et al.
Chen TS, Siarohin A, Menapace W, et al (2024) Panda-70m: Captioning 70m videos with multiple crossmodality teachers. arXiv:2402.19479
Chen Z, Qing J, Zhou JH (2023) Cinematic mindscapes: high-quality video reconstruction from brain activ­
ity. Adv Neural Inf Process Syst 36:24841–24858
Chen H, Xiang Q, Hu J et al (2025) Comprehensive exploration of diffusion models in image generation: a
survey. Artif Intell Rev 58(4):99
Chen D, Hu J, Wei X, et al (2024) Fine-gained zero-shot video sampling. arXiv preprint arXiv:2407.21475
Chen W, Ji Y, Wu J, et al (2024) Control-a-video: Controllable text-to-video diffusion models with motion
prior and reward feedback learning. arXiv:2305.13840
Chen W, Ji Y, Wu J, et al (2024) Control-a-video: Controllable text-to-video diffusion models with motion
prior and reward feedback learning. arXiv:2305.13840
Chen X, Liu Z, Chen M, et al (2024) Livephoto: Real image animation with text-guided motion control. In:
European Conference on Computer Vision, Springer, Cham. pp 475–491
Chen J, Long F, An J, et al (2025) Ouroboros-diffusion: Exploring consistent content generation in tuningfree long video diffusion. arXiv preprint arXiv:2501.09019
Chen C, Shu J, Chen L, et al (2024) Motion-zero: Zero-shot moving object control framework for diffusionbased video generation. arXiv preprint arXiv:2401.10150
Chen X, Wang X, Changpinyo S, et al (2022) Pali: A jointly-scaled multilingual language-image model.
arXiv preprint arXiv:2209.06794
Chen Z, Wang Y, Wang F, et al (2024) V3d: Video diffusion models are effective 3d generators. arXiv preprint
arXiv:2403.06738
Chen M, Wu C, Wang W, et al (2023) Dragnuwa: Fine-grained control in video generation by integrating text,
image, and trajectory. arXiv preprint arXiv:2308.07926
Chen S, Xu M, Ren J, et al (2024) Gentron: Diffusion transformers for image and video generation. In: Pro­
ceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition, pp 6441–6451
Cho J, Puspitasari FD, Zheng S, et al (2024) Sora as an agi world model? a complete survey on text-to-video
generation. arXiv preprint arXiv:2403.05131
Chu M, Xie Y, Mayer J et al (2020) Learning temporal coherence via self-supervision for gan-based video
generation. ACM Trans Graphics (TOG) 39(4):75. https://doi.org/10.1145/3386569.3392457
Çiçek Ö, Abdulkadir A, Lienkamp SS, et al (2016) 3d u-net: learning dense volumetric segmentation from
sparse annotation. In: Medical Image Computing and Computer-Assisted Intervention–MICCAI 2016:
19th International Conference, Athens, Greece, October 17-21, 2016, Proceedings, Part II 19, Springer,
pp 424–432
Cordts M, et al. (2016) The cityscapes dataset for semantic urban scene understanding. In: CVPR
Croitoru FA, Hondru V, Ionescu RT et al (2023) Diffusion models in vision: a survey. IEEE Trans Pattern
Anal Mach Intell 45(9):10850–10869. https://doi.org/10.1109/TPAMI.2023.3261988
Dai Z, Zhang Z, Yao Y, et al (2023) Animateanything: Fine-grained open domain image animation with
motion guidance. arXiv preprint arXiv:2311.12886
Damen D, et al. (2018) Scaling egocentric vision: The epic-kitchens dataset. ECCV
Danier D, Zhang F, Bull D (2023) Ldmvfi: Video frame interpolation with latent diffusion models. arXiv
preprint arXiv:2303.09508
Dhariwal P, Nichol A (2021) Diffusion models beat gans on image synthesis. In: Advances in Neural Informa­
tion Processing Systems, pp 8780–8794
Duan Z, You L, Wang C et al (2024) Diffsynth: latent in-iteration deflickering for realistic video synthesis.
Joint European conference on machine learning and knowledge discovery in databases. Springer, Cham,
pp 332–347
Ebert F, et al. (2017) Self-supervised visual planning with temporal skip connections. In: CoRL
Epstein D, Jabri A, Poole B et al (2023) Diffusion self-guidance for controllable image generation. In: Oh
A, Naumann T, Globerson A et al (eds) Advances in Neural Information Processing Systems, vol 36.
Curran Associates Inc, New York, pp 16222–16239
Fang Y, Xie Y, Liu Z, et al (2023) Video-chatgpt: Towards detailed video understanding via large vision and
language models. arXiv preprint arXiv:2306.05424
Fei H, Wu S, Ji W, et al (2024) Dysen-vdm: Empowering dynamics-aware text-to-video diffusion with llms.
In: Proceedings of the IEEE/CVF conference on computer vision and pattern recognition, pp 7641–7653
Feng W, Liu C, Liu S, et al (2025) Blobgen-vid: Compositional text-to-video generation with blob video
representations. arXiv preprint arXiv:2501.07647
Feng M, Liu J, Yu K, et al (2023) Dreamoving: A human video generation framework based on diffusion
models. arXiv preprint arXiv:2312.05107
Feng J, Ma A, Wang J, et al (2024) Fancyvideo: Towards dynamic and consistent video generation via crossframe textual guidance. arXiv preprint arXiv:2408.08189
1 3
Page 44 of 55
Video diffusion generation: comprehensive review and open problems
Feng W, Wang X, Chen H, et al (2024) Multi-sentence video grounding for long video generation. arXiv
preprint arXiv:2407.13219
Finn C, Abbeel P, Levine S (2017) Model-agnostic meta-learning for fast adaptation of deep networks. In:
International conference on machine learning, PMLR, pp 1126–1135
Fu TJ, Yu L, Zhang N, et al (2023) Tell me what happened: Unifying text-guided video completion via mul­
timodal masked video generation. In: Proceedings of the IEEE/CVF Conference on Computer Vision
and Pattern Recognition, pp 10681–10692
Fuest M, Hu VT, Ommer B (2025) Maskflow: Discrete flows for flexible and efficient long video generation.
arXiv preprint arXiv:2502.11234
Fu X, Liu X, Wang X, et al (2024a) Generative inbetweening. arXiv preprint arXiv:2412.07759
Fu X, Liu X, Wang X, et al (2024b) 3dtrajmaster: Mastering 3d trajectory for multi-entity motion in video
generation. arXiv preprint arXiv:2412.07759
Gao K, Shi J, Zhang H, et al (2024) Vid-gpt: Introducing gpt-style autoregressive generation in video diffu­
sion models. arXiv preprint arXiv:2406.10981
Ge S, Hayes T, Yang H, et al (2022) Long video generation with time-agnostic vqgan and time-sensitive
transformer. In: European Conference on Computer Vision, Springer, pp 102–118
Ge S, Nah S, Liu G, et al (2023) Preserve your own correlation: a noise prior for video diffusion models. In:
Proceedings of the IEEE/CVF International Conference on Computer Vision, pp 22930–22941
Geng D, Herrmann C, Hur J, et al (2024) Motion prompting: Controlling video generation with motion tra­
jectories. arXiv preprint arXiv:2412.02700
Girdhar R, Singh M, Brown A, et al (2024) Factorizing text-to-video generation by explicit image condition­
ing. In: European Conference on Computer Vision, Springer, pp 205–224
Gong L, Zhu Y, Li W, et al (2024) Atomovideo: High fidelity image-to-video generation. arXiv preprint
arXiv:2403.01800
Goyal R, Kahou SE, Michalski V, et al (2017) The “something something” video database for learning and
evaluating visual common sense. arXiv:1706.04261
Guo Y, Yang C, Rao A, et al (2023) Animatediff: Animate your personalized text-to-image diffusion models
without specific tuning. arXiv preprint arXiv:2307.04725
Guo Y, Yang C, Rao A, et al (2023) Sparsectrl: Adding sparse controls to text-to-video diffusion models.
arXiv:2311.16933
Guo J, Zhang D, Liu X, et al (2024) Liveportrait: Efficient portrait animation with stitching and retargeting
control. arXiv preprint arXiv:2407.03168
Guo X, Zheng M, Hou L, et al (2024) I2v-adapter: A general image-to-video adapter for diffusion models. In:
ACM SIGGRAPH 2024 Conference Papers, pp 1–12
Gupta A, Tian S, Zhang Y, et  al (2022) Maskvit: Masked visual pre-training for video prediction.
arXiv:2206.11894
Gupta A, Yu L, Sohn K, et al (2024) Photorealistic video generation with diffusion models. In: European
Conference on Computer Vision, Springer, pp 393–411
Gu J, Wang S, Zhao H, et al (2023) Reuse and diffuse: Iterative denoising for text-to-video generation. arXiv
preprint arXiv:2309.03549
Gu X, Wen C, Ye W, et al (2023) Seer: Language instructed video prediction with latent diffusion models.
arXiv preprint arXiv:2303.14897
Haji-Ali M, Menapace W, Siarohin A, et al (2024) Av-link: Temporally-aligned diffusion features for crossmodal audio-video generation. arXiv preprint arXiv:2412.15191
Han S, Xi Z (2020) Dynamic scene semantics slam based on semantic segmentation. IEEE Access
8:43563–43570
Harvey W, Naderiparizi S, Masrani V, et  al (2022) Flexible diffusion modeling of long videos.
arXiv:2205.11495
He B, Liao L, Wang W, et al (2022) Vidm: Video implicit diffusion models. arXiv preprint arXiv:2212.00235
He X, Liu Q, Qian S, et al (2024) Id-animator: Zero-shot identity-preserving human video generation. arXiv
preprint arXiv:2404.15275
Henschel R, Khachatryan L, Hayrapetyan D, et al (2024) Streamingt2v: Consistent, dynamic, and extendable
long video generation from text. arXiv preprint arXiv:2403.14773
Heusel M, Ramsauer H, Unterthiner T, et al (2017) Gans trained by a two time-scale update rule converge to
a local nash equilibrium. In: NeurIPS
He Y, Xia M, Chen H, et al (2023) Animate-a-story: Storytelling with retrieval-augmented video generation.
arXiv preprint arXiv:2307.06940
He Y, Yang T, Zhang Y, et al (2022) Latent video diffusion models for high-fidelity video generation with
arbitrary lengths. arXiv preprint arXiv:2211.13221
1 3
Page 45 of 55
W. Ma et al.
Ho J, Jain A, Abbeel P (2020) Denoising diffusion probabilistic models. In: Larochelle H, Ranzato M, Had­
sell R et al (eds) Advances in Neural Information Processing Systems, vol 33. Curran Associates Inc,
New York, pp 6840–6851
Ho J, Salimans T, Gritsenko A et al (2022) Video diffusion models. In: Koyejo S, Mohamed S, Agarwal A et
al (eds) Advances in Neural Information Processing Systems, vol 35. Curran Associates Inc, New York,
pp 8633–8646
Ho J, Chan W, Saharia C, et al (2022) Imagen video: High definition video generation with diffusion models.
arXiv preprint arXiv:2210.02303
Hong W, Ding M, Zheng W, et al (2022) Cogvideo: Large-scale pretraining for text-to-video generation via
transformers. arXiv preprint arXiv:2205.15868
Hong S, Kemelmacher-Shlizerman I, Curless B, et al (2025) Musicinfuser: Making video diffusion listen and
dance. arXiv preprint arXiv:2503.14505
Höppe T, Mehrjou A, Bauer S, et  al (2022) Diffusion models for video prediction and infilling.
arXiv:2206.07696
Hore A, Ziou D (2010) Image quality metrics: Psnr vs. ssim. 2010 20th International Conference on Pattern
Recognition pp 2366–2369
Houlsby N, Giurgiu A, Jastrzebski S, et al (2019) Parameter-efficient transfer learning for nlp. In: Interna­
tional conference on machine learning, PMLR, pp 2790–2799
Hou C, Wei G, Zeng Y, et  al (2024) Training-free camera control for video generation. arXiv preprint
arXiv:2406.10126
Hu EJ, Shen Y, Wallis P et al (2022) Lora: low-rank adaptation of large language models. ICLR 1(2):3
Huang HP, Su YC, Sun D, et al (2023) Fine-grained controllable video generation via object appearance and
context. arXiv:2312.02919
Huang Y, Zheng W, Gao Y, et al (2024) Owl-1: Omni world model for consistent long video generation. arXiv
preprint arXiv:2412.09600
Hu Y, Chen Z, Luo C (2023) Lamd: Latent motion diffusion for video generation. arXiv preprint
arXiv:2304.11603
Hu L, Gao X, Zhang P, et al (2024) Animate anyone: consistent and controllable image-to-video synthesis for
character animation. arXiv:2311.17117
Hu J, Zhong T, Wang X, et al (2024) Vivid-10m: a dataset and baseline for versatile and interactive video
local editing. arXiv:2411.15260
Jain Y, Nasery A, Vineet V, et al (2024) Peekaboo: interactive video generation via masked-diffusion. In:
Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition (CVPR), pp
8079–8088
Jeong Y, Ryoo W, Lee S, et al (2023) The power of sound (tpos): audio reactive video generation with stable
diffusion. In: Proceedings of the IEEE/CVF international conference on computer vision, pp 7822–7832
Jiang J, Hong G, Zhou L, et al (2024) Dive: Dit-based video generation with enhanced control. arXiv preprint
arXiv:2409.01595
Jiang Y, Wu T, Yang S, et al (2023) Videobooth: diffusion-based video generation with image prompts.
arXiv:2312.00777
Jiang Y, Wu T, Yang S, et al (2024) Videobooth: diffusion-based video generation with image prompts. In:
Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition, pp 6689–6700
Jiang Y, Yang S, Koh TL, et al (2023) Text2performer: text-driven human video generation. In: Proceedings
of the IEEE/CVF International Conference on Computer Vision, pp 22747–22757
Kandala H, Gao J, Yang J (2024) Pix2gif: Motion-guided diffusion for gif generation. In: European Confer­
ence on Computer Vision, Springer, pp 35–51
Karras J, Holynski A, Wang TC, et al (2023) Dreampose: Fashion image-to-video synthesis via stable diffu­
sion. In: 2023 IEEE/CVF International conference on computer vision (ICCV), IEEE, pp 22623–22633
Kay W, Carreira J, Simonyan K, et al (2017) The kinetics human action video dataset. arXiv:1705.06950
Khachatryan L, Movsisyan A, Tadevosyan V, et al (2023) Text2video-zero: Text-to-image diffusion models
are zero-shot video generators. arXiv preprint arXiv:2303.13439
Kim J, Kang J, Choi J, et al (2024) Fifo-diffusion: generating infinite videos from text without training.
arXiv:2405.11473
Kim K, Lee H, Park J, et al (2024) Hybrid video diffusion models with 2d triplane and 3d wavelet representa­
tion. arXiv preprint arXiv:2402.13729
Kong W, Tian Q, Zhang Z, et al (2024) Hunyuanvideo: a systematic framework for large video generative
models. arXiv preprint arXiv:2412.03603
Kwon M, Oh SW, Zhou Y, et al (2024) Harivo: harnessing text-to-image models for video generation. In:
European Conference on Computer Vision, Springer, pp 19–36
Lapid A, Achituve I, Bracha L, et al (2023) Gd-vdm: generated depth for better diffusion-based video genera­
tion. arXiv preprint arXiv:2306.11173
1 3
Page 46 of 55
Video diffusion generation: comprehensive review and open problems
Lee S, Kong C, Jeon D, et al (2023) Aadiff: audio-aligned video synthesis with text-to-image diffusion.
arXiv:2305.04001
Lee T, Kwon S, Kim T (2024) Grid diffusion models for text-to-video generation. In: Proceedings of the
IEEE/CVF Conference on Computer Vision and Pattern Recognition, pp 8734–8743
Lester B, Al-Rfou R, Constant N (2021) The power of scale for parameter-efficient prompt tuning.
arXiv:2104.08691
Liang J, et al. (2022) Make your video: High-resolution text-to-video generation with latent diffusion models.
CVPR
Liang J, Fan Y, Zhang K et al (2024) Movideo: motion-aware video generation with diffusion model. Euro­
pean conference on computer vision. Springer, Cham, pp 56–74
Liang Z, Zhang Y, Liu Y, et al (2023) Leo: Generative latent image animator for human video synthesis. arXiv
preprint arXiv:2305.03989
Li W, Cao Y, Su X, et al (2024) Decoupled video generation with chain of training-free diffusion model
experts. https://arxiv.org/abs/2408.13423, arXiv:2408.13423
Li X, Chu W, Wu Y, et al (2023) Videogen: a reference-guided latent diffusion approach for high definition
text-to-video generation. arXiv preprint arXiv:2309.00398
Li W, Gong L, Zhu Y, et al (2024) Tuning-free noise rectification for high fidelity image-to-video generation.
arXiv preprint arXiv:2403.02827
Li C, Huang D, Lu Z, et al (2024) A survey on long video generation: challenges, methods, and prospects.
arXiv preprint arXiv:2403.16407
Li Z, Hu S, Liu S, et al (2024) Arlon: Boosting diffusion transformers with autoregressive models for long
video generation. arXiv preprint arXiv:2410.20502
Li Z, Lin B, Ye Y, et al (2024) Wf-vae: enhancing video vae by wavelet-driven energy flow for latent video
diffusion model. arXiv preprint arXiv:2411.17459
Li J, Li D, Savarese S, et al (2023) Blip-2: Bootstrapping language-image pre-training with frozen image
encoders and large language models. In: International conference on machine learning, PMLR, pp
19730–19742
Li J, Li D, Xiong C, et al (2022) Blip: Bootstrapping language-image pre-training for unified vision-lan­
guage understanding and generation. In: International conference on machine learning, PMLR, pp
12888–12900
Ling P, Bu J, Zhang P, et al (2024) Motionclone: training-free motion cloning for controllable video genera­
tion. arXiv:2406.05338
Lin H, Zala A, Cho J, et al (2023) Videodirectorgpt: Consistent multi-scene video generation via llm-guided
planning. arXiv preprint arXiv:2309.15091
Li Z, Tucker R, Snavely N, et al (2024) Generative image dynamics. In: Proceedings of the IEEE/CVF con­
ference on computer vision and pattern recognition, pp 24142–24153
Liu Y, Cun X, Liu X, et al (2024) Evalcrafter: benchmarking and evaluating large video generation models. In:
Proceedings of the IEEE/CVF conference on computer vision and pattern recognition, pp 22139–22149
Liu B, Liu X, Dai A, et al (2023) Dual-stream diffusion net for text-to-video generation. arXiv preprint
arXiv:2308.08316
Liu C, Li R, Zhang K, et al (2024) Stablev2v: stablizing shape consistency in video-to-video editing. arXiv
preprint arXiv:2411.11045
Liu Y, Ren Y, Cun X, et al (2024) Redefining temporal modeling in video diffusion: the vectorized timestep

## Approach

Liu S, Ren Z, Gupta S, et al (2024) Physgen: rigid-body physics-grounded image-to-video generation. In:
European Conference on Computer Vision, Springer, pp 360–378
Liu F, Sun W, Wang H, et al (2024) Reconx: Reconstruct any scene from sparse views with video diffusion
model. arXiv preprint arXiv:2408.16767
Liu X, Su K, Shlizerman E (2024) Tell what you hear from what you see–video to audio generation through
text. arXiv preprint arXiv:2411.05679
Liu J, Wang W, Liu W, et al (2023) Ed-t2v: An efficient training framework for diffusion-based text-to-video
generation. In: 2023 International Joint Conference on Neural Networks (IJCNN), IEEE, pp 1–8, URL ​
h​t​t​p​s​:​/​/​i​e​e​e​x​p​l​o​r​e​.​i​e​e​e​.​o​r​g​/​a​b​s​t​r​a​c​t​/​d​o​c​u​m​e​n​t​/​1​0​1​9​1​5​6​5
Liu H, Yang X, Zhou N, et al (2023) Animatediff: Animate your personalized text-to-image diffusion models
without specific tuning. arXiv preprint arXiv:2307.04725
Liu H, Yan W, Zaharia M, et al (2025) World model on million-length video and language with blockwise
ringattention. arXiv:2402.08268
Li Y, Wang X, Zhang Z, et al (2024) Image conductor: Precision control for interactive video synthesis. arXiv
preprint arXiv:2406.15339
Li H, Xu M, Zhan Y, et al (2025) Openhumanvid: A large-scale high-quality dataset for enhancing humancentric video generation. arXiv:2412.00115
1 3
Page 47 of 55
W. Ma et al.
Li X, Zhang Y, Ye X (2024) Drivingdiffusion: Layout-guided multi-view driving scenarios video generation
with latent diffusion model. In: European Conference on Computer Vision, Springer, pp 469–485
Li W, Zhao S, Mou C, et al (2024) Omnidrag: Enabling motion control for omnidirectional image-to-video
generation. arXiv preprint arXiv:2412.09623
Long F, Qiu Z, Yao T, et al (2024) Videostudio: Generating consistent-content and multi-scene videos. In:
European Conference on Computer Vision, Springer, pp 468–485
Lu Y, Liang Y, Zhu L, et al (2024) Freelong: Training-free long video generation with spectralblend temporal
attention. arXiv:2407.19918
Luo Z, Chen D, Zhang Y, et al (2023) Videofusion: Decomposed diffusion models for high-quality video
generation. arXiv preprint arXiv:2303.08320
Lu H, Yang G, Fei N, et al (2023) Vdt: General-purpose video diffusion transformers via mask modeling.
arXiv preprint arXiv:2305.13311
Lu Y, Zhu L, Fan H, et al (2023) Flowzero: Zero-shot text-to-video synthesis with llm-driven dynamic scene
syntax. arXiv preprint arXiv:2311.15813
Lv J, Huang Y, Yan M, et al (2024) Gpt4motion: Scripting physical motions in text-to-video generation via
blender-oriented gpt planning. In: Proceedings of the IEEE/CVF conference on computer vision and
pattern recognition, pp 1430–1440
Ma WDK, Lewis JP, Kleijn WB (2024) Trailblazer: Trajectory control for diffusion-based video generation.
In: SIGGRAPH Asia 2024 Conference Papers, pp 1–11
Ma Y, Chen J, Di D, et al (2025) Tuning-free long video generation via global-local collaborative diffusion.
arXiv preprint arXiv:2501.05484
Ma Y, He Y, Cun X, et al (2024) Follow your pose: Pose-guided text-to-video generation using pose-free
videos. In: Proceedings of the AAAI Conference on Artificial Intelligence, pp 4117–4125
Ma Y, He Y, Wang H, et al (2024) Follow-your-click: Open-domain regional image animation via short
prompts. arXiv preprint arXiv:2403.08268
Mao Y, Shen X, Zhang J, et al (2024) Tavgbench: Benchmarking text to audible-video generation. In: Pro­
ceedings of the 32nd ACM International Conference on Multimedia, pp 6607–6616
Materzynska J, Sivic J, Shechtman E, et al (2023) Customizing motion in text-to-video diffusion models.
arXiv preprint arXiv:2312.04966
Ma X, Wang Y, Jia G, et al (2024) Cinemo: Consistent and controllable image animation with motion diffu­
sion models. arXiv preprint arXiv:2407.15642
Ma X, Wang Y, Jia G, et al (2024) Latte: Latent diffusion transformer for video generation. arXiv preprint
arXiv:2401.03048
Ma Z, Zhou D, Yeh CH, et al (2024) Magic-me: Identity-specific video customized diffusion. arXiv:2402.09368
Menapace W, Siarohin A, Skorokhodov I, et al (2024) Snap video: Scaled spatiotemporal transformers for
text-to-video synthesis. In: Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern
Recognition, pp 7038–7048
Miech A, Zhukov D, Alayrac JB, et al (2019) Howto100m: Learning a text-video embedding by watching
hundred million narrated video clips. In: ICCV
Moon G, Shiraotri T, Saito S (2024) Expressive whole-body 3d gaussian avatar. In: European Conference on
Computer Vision (ECCV), https://mks0601.github.io/ExAvatar/
Namekata K, Bahmani S, Wu Z, et al (2025) Sg-i2v: Self-guided trajectory control in image-to-video genera­
tion. arXiv:2411.04989
Nan K, Xie R, Zhou P, et al (2025) Openvid-1m: A large-scale high-quality dataset for text-to-video genera­
tion. arXiv:2407.02371
Ni H, Egger B, Lohit S, et al (2024) Ti2v-zero: Zero-shot image conditioning for text-to-video diffusion
models. In: Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition,
pp 9015–9025
Ni H, Shi C, Li K, et al (2023) Conditional image-to-video generation with latent flow diffusion models. In:
Proceedings of the IEEE/CVF conference on computer vision and pattern recognition, pp 18444–18455
Niu M, Cun X, Wang X et al (2024) Mofa-video: controllable image animation via generative motion field
adaptions in frozen image-to-video diffusion model. European conference on computer vision. Springer,
Cham, pp 111–128
Oh G, Jeong J, Kim S et al (2024) Mevg: multi-event video generation with text-to-video models. European
Conference on computer vision. Springer, Cham, pp 401–418
Ouyang Y, Yuan J, Zhao H, et al (2024) Flexifilm: Long video generation with flexible conditions. arXiv
preprint arXiv:2404.18620
Pan B, Xu Z, Huang CHP, et  al (2024) Actanywhere: Subject-aware video background generation.
arXiv:2401.10822
Peng B, Chen X, Wang Y, et al (2024) Conditionvideo: training-free condition-guided video generation. In:
Proceedings of the AAAI Conference on Artificial Intelligence, pp 4459–4467
1 3
Page 48 of 55
Video diffusion generation: comprehensive review and open problems
Peng B, Wang J, Zhang Y, et al (2025) Controlnext: Powerful and efficient control for image and video gen­
eration. arXiv:2408.06070
Perazzi F, et al. (2016) A benchmark dataset and evaluation methodology for video object segmentation. In:
CVPR
Pradhyumna P, Shreya G, et al (2021) Graph Neural Network (GNN) in image and video understanding using
deep learning for computer vision applications. In: 2021 Second International Conference on Electron­
ics and Sustainable Communication Systems (ICESC), IEEE, pp 1183–1189, ​h​t​t​p​s​:​/​/​d​o​i​.​o​r​g​/​1​0​.​1​1​0​9​/​I​
C​E​S​C​5​1​4​2​2​.​2​0​2​1​.​9​5​3​2​6​3​1
Qing Z, Zhang S, Wang J, et al (2024) Hierarchical spatio-temporal decoupling for text-to-video genera­
tion. In: Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition, pp
6635–6645
Qin B, Ye W, Yu Q, et al (2023) Dancing avatar: Pose and text-guided human motion videos synthesis with
image diffusion model. https://arxiv.org/abs/2308.07749, arXiv:2308.07749
Qiu H, Chen Z, Wang Z, et al (2024) Freetraj: Tuning-free trajectory control in video diffusion models. arXiv
preprint arXiv:2406.16863
Qiu H, Xia M, Zhang Y, et al (2023) Freenoise: Tuning-free longer video diffusion via noise rescheduling.
arXiv preprint arXiv:2310.15169arXiv:2310.15169
Qu Q, Shen Y, Chen X, et al (2024) E2hqv: High-quality video generation from event camera via theoryinspired model-aided deep learning. In: Proceedings of the AAAI Conference on Artificial Intelligence,
pp 4632–4640
Radford A, Kim JW, Hallacy C, et al (2021) Learning transferable visual models from natural language
supervision. In: ICML
Ren W, Yang H, Zhang G, et al (2024) Consisti2v: Enhancing visual consistency for image-to-video genera­
tion. arXiv preprint arXiv:2402.04324
Rings F (2024) Stableanimator: High-quality identity-preserving human image animation. arXiv preprint
arXiv:2411.17697
Rombach R, Blattmann A, Lorenz D, et al (2022) High-resolution image synthesis with latent diffusion
models. In: Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition,
pp 10684–10695
Ruan L, Ma Y, Yang H, et al (2023) Mm-diffusion: Learning multi-modal diffusion models for joint audio
and video generation. In: Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern
Recognition, pp 10219–10228
Ruan L, Ma Y, Yang H, et al (2023) Mm-diffusion: Learning multi-modal diffusion models for joint audio
and video generation. In: Proceedings of the IEEE/CVF conference on computer vision and pattern
recognition, pp 10219–10228
Ryan P, Bandurski J, Bals J, et al (2023) Evaluating text-to-video generation with kernel video distance. In:
CVPR
Saharia C, Chan W, Saxena S et al (2022) Photorealistic text-to-image diffusion models with deep language
understanding. Adv Neural Inf Process Syst 35:36479–36494
Saito M, Matsumoto E, Saito S (2017) Tgan: Temporal generative adversarial nets with singular value clip­
ping. In: ICCV
Shen C, Gan Y, Chen C, et al (2024) Decouple content and motion for conditional image-to-video generation.
In: Proceedings of the AAAI conference on artificial intelligence, pp 4757–4765
Shen L, Li X, Sun H, et al (2023) Make-it-4d: Synthesizing a consistent long-term dynamic scene video from
a single image. In: Proceedings of the 31st ACM international conference on multimedia, pp 8167–8175
Shi F, Gu J, Xu H, et al (2024) Bivdiff: A training-free framework for general-purpose video synthesis via
bridging image and video diffusion models. In: Proceedings of the IEEE/CVF Conference on Computer
Vision and Pattern Recognition, pp 7393–7402
Shi X, Huang Z, Wang FY, et al (2024) Motion-i2v: Consistent and controllable image-to-video generation
with explicit motion modeling. arXiv preprint arXiv:2401.15977
Siarohin A, et al. (2019) First order motion model for image animation. In: NeurIPS
Singer U, Polyak A, Hayes T, et al (2022) Make-a-video: Text-to-video generation without text-video data.
arXiv preprint arXiv:2209.14792
Skorokhodov I, Menapace W, Siarohin A, et al (2024) Hierarchical patch diffusion models for high-resolution
video generation. In: Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Rec­
ognition, pp 7569–7579
Song W, Ma W, Zhang M et al (2024) Lightweight diffusion models: a survey. Artif Intell Rev 57(6):161.
https://doi.org/10.1007/s10462-024-10800-8
Song K, Hou T, He Z, et  al (2024) Directorllm for human-centric video generation. arXiv preprint
arXiv:2412.14484https://arxiv.org/abs/2412.14484
1 3
Page 49 of 55
W. Ma et al.
Song J, Meng C, Ermon S (2020b) Denoising diffusion implicit models. In: International Conference on
Learning Representations, https://doi.org/10.48550/arXiv.2010.02502
Song Y, Sohl-Dickstein J, Kingma DP, et al (2020a) Score-based generative modeling through stochastic dif­
ferential equations. In: Advances in Neural Information Processing Systems, pp 12438–12450, ​h​t​t​p​s​:​/​/​
d​o​i​.​o​r​g​/​1​0​.​4​8​5​5​0​/​a​r​X​i​v​.​2​0​1​1​.​1​3​4​5​6​
Soomro K, Zamir AR, Shah M (2012) Ucf101: A dataset of 101 human actions classes from videos in the
wild. arXiv preprint arXiv:1212.0402
Srivastava N, et al. (2015) Unsupervised learning of video representations using lstms. In: ICML
Su S, Liu J, Gao L, et al (2024) F3-pruning: A training-free and generalized pruning strategy towards faster
and finer text-to-video synthesis. In: Proceedings of the AAAI Conference on Artificial Intelligence, pp
4961–4969
Sun J, Li M, Chen Z, et al (2024) Neurocine: Decoding vivid video sequences from human brain activties.
arXiv preprint arXiv:2402.01590
Tang Z, Yang Z, Zhu C et al (2023) Any-to-any generation via composable diffusion. Adv Neural Inf Process
Syst 36:16083–16099
Tan Z, Yang X, Liu S, et  al (2024) Video-infinity: Distributed long video generation. arXiv preprint
arXiv:2406.16260
Tian L, Wang Q, Zhang B et al (2024) Emo: emote portrait alive generating expressive portrait videos
with audio2video diffusion model under weak conditions. European conference on computer vision.
Springer, Cham, pp 244–260
Tian S, Xu J, Tang H, et al (2021) Aesthetic-driven audiovisual generation with adversarial training. In: ACM
MM
Unterthiner T, van Steenkiste S, Esser P, et al (2019) Fvd: A new metric for video generation. arXiv preprint
arXiv:1812.01717
Voleti V, Jolicoeur-Martineau A, Pal C (2022) Mcvd - masked conditional video diffusion for prediction,
generation, and interpolation. In: Koyejo S, Mohamed S, Agarwal A et al (eds) Advances in Neural
Information Processing Systems, vol 35. Curran Associates Inc, New York, pp 23371–23385
Voleti V, Jolicoeur-Martineau A, Pal C (2022) Mcvd: Masked conditional video diffusion for prediction,
generation, and interpolation. arXiv:2205.09853
Voulodimos A, Doulamis N, Doulamis A et al (2018) Deep learning for computer vision: a brief review.
Comput Intell Neurosci 1:7068349
Walke H, Black K, Lee A, et al (2024) Bridgedata v2: A dataset for robot learning at scale. arXiv:2308.12952
Wang FY, Chen W, Song G, et al (2023) Gen-l-video: Multi-text to long video generation via temporal codenoising. arXiv preprint arXiv:2305.18264
Wang FY, Huang Z, Bian W, et al (2024) Animatelcm: computation-efficient personalized style video genera­
tion without personalized video data. arXiv:2402.00769
Wang Z, Bovik AC, Sheikh HR et al (2004) Image quality assessment: from error visibility to structural
similarity. IEEE Trans Image Process 13(4):600–612
Wang Y, Bao J, Weng W, et al (2024) Microcinema: a divide-and-conquer approach for text-to-video genera­
tion. In: Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition, pp
8414–8424
Wang L, Boddeti V, Lim S (2024) Action reimagined: Text-to-pose video editing for dynamic human actions.
arXiv preprint arXiv:2403.07198
Wang Y, Chen X, Ma X, et al (2023) Lavie: High-quality video generation with cascaded latent diffusion
models. arXiv preprint arXiv:2309.15103
Wang Y, Chen X, Ma X et al (2024) Lavie: high-quality video generation with cascaded latent diffusion
models. Int J Comput Vision 10:1–20
Wang C, Gu J, Hu P, et al (2024a) Easycontrol: Transfer controlnet to video diffusion for controllable genera­
tion and interpolation. arXiv preprint arXiv:2408.13005
Wang C, Gu J, Hu P, et al (2025) Dreamvideo: high-fidelity image-to-video generation with image retention
and text guidance. In: ICASSP 2025-2025 IEEE International Conference on Acoustics, Speech and
Signal Processing (ICASSP), IEEE, pp 1–5
Wang Y, He Y, Li Y, et al (2024) Internvid: A large-scale video-text dataset for multimodal understanding and
generation. arXiv:2307.06942
Wang Z, Lan Y, Zhou S, et al (2024) Objctrl-2.5 d: training-free object control with camera poses. arXiv
preprint arXiv:2412.07721
Wang X, Li X, Chen Z (2024) Cono: Consistency noise injection for tuning-free long video diffusion. arXiv
preprint arXiv:2406.05082
Wang T, Li L, Lin K, et al (2024) Disco: disentangled control for realistic human dance generation. In:
Proceedings of the IEEE/CVF conference on computer vision and pattern recognition, pp 9326–9336
1 3
Page 50 of 55
Video diffusion generation: comprehensive review and open problems
Wang W, Liu J, Lin Z, et  al (2024) Magicvideo-v2: Multi-stage high-aesthetic video generation.
arXiv:2401.04468
Wang Z, Li Y, Zeng Y, et al (2024) Humanvid: Demystifying training data for camera-controllable human
image animation. In: The Thirty-eighth Conference on Neural Information Processing Systems Datasets
and Benchmarks Track
Wang Z, Li A, Zhu L, et al (2024) Customvideo: Customizing text-to-video generation with multiple sub­
jects. arXiv:2401.09962
Wang H, Ouyang H, Wang Q, et al (2024) Levitor: 3d trajectory oriented image-to-video synthesis. arXiv
preprint arXiv:2412.15214
Wang Q, Shi Y, Ou J, et al (2024) Koala-36m: A large-scale video dataset improving consistency between
fine-grained conditions and video content. arXiv:2410.08260
Wang Z, Wang L, Zhao Z, et al (2024) Gpt4video: A unified multimodal large language model for lnstructionfollowed understanding and safety-aware generation. arXiv:2311.16511
Wang W, Wang Q, Zheng K, et  al (2024b) Framer: Interactive frame interpolation. arXiv preprint
arXiv:2410.18978
Wang W, Yang Y (2025) Videoufo: A million-scale user-focused dataset for text-to-video generation.
arXiv:2503.01739
Wang W, Yang H, Tuo Z, et al (2025) Swap attention in spatiotemporal diffusions for text-to-video genera­
tion. International Journal of Computer Vision pp 1–19
Wang J, Yuan H, Chen D, et  al (2023) Modelscope text-to-video technical report. arXiv preprint
arXiv:2308.06571
Wang Z, Yuan Z, Wang X, et al (2024) Motionctrl: A unified and flexible motion controller for video genera­
tion. In: ACM SIGGRAPH 2024 Conference Papers, pp 1–11
Wang X, Yuan H, Zhang S, et al (2023) Videocomposer: Compositional video synthesis with motion control­
lability. arXiv:2306.02018
Wang X, Zhang S, Yuan H, et al (2024) A recipe for scaling up text-to-video generation with text-free vid­
eos. In: Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition, pp
6572–6582
Wang J, Zhang Y, Zou J, et al (2024) Boximator: Generating rich and controllable motions for video synthe­
sis. arXiv preprint arXiv:2402.01566
Wang C, Zheng Z, Yu T, et al (2024) Diffperformer: Iterative learning of consistent latent guidance for
diffusion-based human video generation. In: Proceedings of the IEEE/CVF Conference on Computer
Vision and Pattern Recognition, pp 6169–6179
Wang X, Zhu Z, Huang G, et al (2024) Worlddreamer: Towards general world models for video generation
via predicting masked tokens. arXiv:2401.09985
Weng W, Feng R, Wang Y, et al (2024) Art-v: Auto-regressive text-to-video generation with diffusion mod­
els. In: Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition, pp
7395–7405
Wen Y, Zhao Y, Liu Y, et al (2023) Panacea: panoramic and controllable video generation for autonomous
driving. arXiv:2311.16813
Wu JZ, Ge Y, Wang X, et al (2023) Tune-a-video: One-shot tuning of image diffusion models for text-tovideo generation. In: Proceedings of the IEEE/CVF international conference on computer vision, pp
7623–7633
Wu S, Fei H, Qu L, et al (2024) Next-gpt: Any-to-any multimodal llm. In: Forty-first International Confer­
ence on Machine Learning
Wu J, Gan W, Chen Z, et al (2023) AI-Generated Content (AIGC): A survey. arXiv preprint arXiv:2304.066
32arXiv:2304.06632
Wu C, Liang J, Hu X, et al (2022) Nuwa-infinity: Autoregressive over autoregressive generation for infinite
visual synthesis. arXiv preprint arXiv:2207.09814
Wu B, Lim J, Zhang H, et al (2016) Deep multiple instance learning for video classification and anomaly
detection. In: BMVC
Wu J, Li X, Si C, et al (2024) Towards language-driven video inpainting via multimodal large language
models. arXiv preprint arXiv:2401.10226
Wu W, Liu M, Zhu Z, et al (2025) Moviebench: a hierarchical movie level dataset for long video generation.
arXiv:2411.15262
Wu Z, Siarohin A, Menapace W, et al (2025) Mind the time: temporally-controlled multi-event video genera­
tion. arXiv:2412.05263
Wu T, Si C, Jiang Y et al (2024) Freeinit: bridging initialization gap in video diffusion models. European
conference on computer vision. Springer, Cham, pp 378–394
Wu W, Yang W, Bao H, et al (2022) Nuwa: Visual synthesis with neural visual world architectures. In: ICLR
1 3
Page 51 of 55
W. Ma et al.
Xia T, Chen X, Xu S (2024) Unictrl: Improving the spatiotemporal consistency of text-to-video diffusion
models via training-free unified attention control. arXiv:2403.02332
Xiang J, Huang R, Zhang J, et al (2023) Versvideo: Leveraging enhanced temporal diffusion models for ver­
satile video generation. In: The twelfth international conference on learning representations
Xie Y, Xu H, Song G, et al (2024) X-portrait: Expressive portrait animation with hierarchical motion atten­
tion. In: ACM SIGGRAPH 2024 Conference Papers, pp 1–11
Xing Z, Feng Q, Chen H et al (2024) A survey on video diffusion models. ACM Comput Surv 57(2):1–42.
https://doi.org/10.1145/3696415
Xing Z, Dai Q, Hu H, et al (2024) Simda: Simple diffusion adapter for efficient video generation. In: Proceed­
ings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition, pp 7827–7839
Xing Z, Dai Q, Weng Z, et al (2024) Aid: Adapting image2video diffusion models for instruction-guided
video prediction. arXiv preprint arXiv:2406.06465
Xing Z, Dai Q, Zhang Z, et al (2023) Vidiff: Translating videos via multi-modal instructions with diffusion
models. arXiv preprint arXiv:2311.18837
Xing Y, He Y, Tian Z, et al (2024) Seeing and hearing: Open-domain visual-audio generation with diffusion
latent aligners. In: Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recogni­
tion, pp 7151–7161
Xing J, Xia M, Liu Y, et al (2024) Make-your-video: Customized video generation using textual and struc­
tural guidance. IEEE transactions on visualization and computer graphics
Xing J, Xia M, Zhang Y et al (2024) Dynamicrafter: animating open-domain images with video diffusion
priors. European conference on computer vision. Springer, Cham, pp 399–417
Xiong W, Luo W, Ma L, et al (2018) Learning to generate time-lapse videos using multi-stage dynamic gen­
erative adversarial networks. In: Proceedings of the IEEE Conference on Computer Vision and Pattern
Recognition, pp 2364–2373
Xiong T, Wang Y, Zhou D, et al (2024) Lvd-2m: A long-take video dataset with temporally dense captions.
arXiv:2410.10816
Xuanyuan M, Wang Y, Guo H, et al (2024) Context-aware talking face video generation. arXiv preprint
arXiv:2402.18092
Xu M, Du H, Niyato D, et al (2024) Unleashing the power of edge-cloud generative ai in mobile networks: a
survey of AIGC services. IEEE Communications Surveys & Tutorials arXiv:2303.16129
Xu M, Li H, Su Q, et al (2024) Hallo: Hierarchical audio-driven visual synthesis for portrait image animation.
arXiv preprint arXiv:2406.08801
Xu J, Mei T, Yao T, et al (2016) Msr-vtt: A large video description dataset for bridging video and language.
In: CVPR
Xu Z, Wei K, Yang X, et al (2024a) Do you guys want to dance: Zero-shot compositional human dance gen­
eration with multiple persons. arXiv preprint arXiv:2401.13363
Xu H, Ye Q, Wu X, et al (2023) Youku-mplug: a 10 million large-scale chinese video-language dataset for
pre-training and benchmarks. arXiv:2306.04362
Xu Z, Zhang J, Liew JH, et al (2024b) Magicanimate: temporally consistent human image animation using
diffusion model. In: Proceedings of the IEEE/CVF Conference on computer vision and pattern recogni­
tion, pp 1481–1490
Yan X, Cai Y, Wang Q, et al (2024) Long video diffusion generation with segmented cross-attention and
content-rich video data curation. arXiv preprint arXiv:2412.01316
Yang L, Zhang Z, Song Y et al (2023) Diffusion models: a comprehensive survey of methods and applica­
tions. ACM Comput Surv 56(4):1–39 arXiv:2209.00796
Yang M, Du Y, Dai B, et  al (2023) Probabilistic adaptation of text-to-video models. arXiv preprint
arXiv:2306.01872
Yang R, Gamper H, Braun S (2024) Cmmd: Contrastive multi-modal diffusion for video-audio conditional
modeling. arXiv:2312.05412
Yang X, He C, Ma J, et al (2023) Motion-guided latent diffusion for temporally consistent real-world video
super-resolution. In: Proceedings of the IEEE/CVF conference on computer vision and pattern recogni­
tion (CVPR)
Yang S, Hou L, Huang H, et al (2024) Direct-a-video: Customized video generation with user-directed cam­
era movement and object motion. In: ACM SIGGRAPH 2024 Conference Papers, pp 1–12
Yang Y, Jiao L, Liu X, et  al (2022) Transformers meet visual learning understanding: a comprehensive
review. arXiv preprint arXiv:2203.12944
Yang S, Li H, Wu J, et al (2024) Megactor: Unlocking flexible mixed-modal control in portrait animation
with diffusion transformer. arXiv preprint arXiv:2408.14975
Yang Q, Mao B, Wang Z, et al (2024) Draw an audio: Leveraging multi-instruction for video-to-audio syn­
thesis. arXiv preprint arXiv:2409.06135
1 3
Page 52 of 55
Video diffusion generation: comprehensive review and open problems
Yang T, Shi Y, Huang Y, et al (2024) Factorized-dreamer: training a high-quality video generator with limited
and low-quality data. arXiv preprint arXiv:2408.10119
Yang R, Srivastava P, Mandt S (2022) Diffusion probabilistic modeling for video generation. arXiv:2203.09481
Yang Z, Teng J, Zheng W, et al (2024) Cogvideox: Text-to-video diffusion models with an expert transformer.
arXiv preprint arXiv:2408.06072
Yang S, Zhang L, Liu Y, et al (2023) Video diffusion models with local-global context guidance. arXiv pre­
print arXiv:2306.02562
Yan W, Zhang Y, Abbeel P, et al (2021) Videogpt: Video generation using vq-vae and transformers. arXiv
preprint arXiv:2104.10157
Yan D, Zhang W, Zhang L, et al (2024) Animated stickers: Bringing stickers to life with video diffusion.
arXiv preprint arXiv:2402.06088
Yariv G, Gat I, Benaim S, et al (2023) Diverse and aligned audio-to-video generation via text-to-video model
adaptation. arXiv:2309.16429
Ye X, Bilodeau GA (2024) Stdiff: Spatio-temporal diffusion for continuous stochastic video prediction. In:
Proceedings of the AAAI Conference on Artificial Intelligence, pp 6666–6674
Yin S, Wu C, Liang J, et al (2023) Dragnuwa: Fine-grained control in video generation by integrating text,
image, and trajectory. arXiv:2308.08089
Yin S, Wu C, Yang H, et al (2023) Nuwa-xl: Diffusion over diffusion for extremely long video generation.
arXiv preprint arXiv:2303.12346
Yin S, Wu C, Yang H, et al (2023) Nuwa-xl: Diffusion over diffusion for extremely long video generation. In:
Proceedings of the 61st Annual Meeting of the Association for Computational Linguistics (Volume 1:
Long Papers), Association for Computational Linguistics, pp 1309–1320, ​h​t​t​p​s​:​/​/​d​o​i​.​o​r​g​/​1​0​.​1​8​6​5​3​/​v​1​/​2​
0​2​3​.​a​c​l​-​l​o​n​g​.​7​3​, URL https://aclanthology.org/2023.acl-long.73/
Yuan X, Baek J, Xu K, et al (2024) Inflation with diffusion: Efficient temporal adaptation for text-to-video
super-resolution. In: Proceedings of the IEEE/CVF winter conference on applications of computer
vision (WACV)
Yuan S, Huang J, He X, et al (2024) Identity-preserving text-to-video generation by frequency decomposi­
tion. arXiv preprint arXiv:2411.17440
Yuan S, Huang J, Xu Y, et al (2024) Chronomagic-bench: a benchmark for metamorphic evaluation of textto-time-lapse video generation. arXiv:2406.18522
Yuan Z, Liu Y, Cao Y, et al (2024) Mora: enabling generalist video generation via a multi-agent framework.
arXiv preprint arXiv:2403.13248
Yu S, Nie W, Huang DA, et  al (2024) Efficient video diffusion models via content-frame motion-latent
decomposition. In: International conference on learning representations, ​h​t​t​p​s​:​/​/​o​p​e​n​r​e​v​i​e​w​.​n​e​t​/​f​o​r​u​m​
?​i​d​=​d​Q​V​t​T​d​s​v​Z​H​
Yu S, Sohn K, Kim S, et al (2023) Video probabilistic diffusion models in projected latent space. In: Proceed­
ings of the IEEE/CVF conference on computer vision and pattern recognition, pp 18456–18466
Yu J, Zhu H, Jiang L, et al (2023) Celebv-text: A large-scale facial text-video dataset. arXiv:2303.14717
Zaken EB, Ravfogel S, Goldberg Y (2021) Bitfit: simple parameter-efficient fine-tuning for transformerbased masked language-models. arXiv preprint arXiv:2106.10199
Zellers R (2022) Advancing high-resolution video-language representation with large-scale video transcrip­
tions. In: CVPR
Zeng Y, Wei G, Zheng J, et al (2024) Make pixels dance: High-dynamic video generation. In: Proceedings of
the IEEE/CVF conference on computer vision and pattern recognition, pp 8850–8860
Zhang DJ, Li D, Le H, et al (2024) Moonshot: towards controllable video generation and editing with multi­
modal conditions. arXiv:2401.01827
Zhang DJ, Paiss R, Zada S, et al (2024) Recapture: generative video camera controls for user-provided videos
using masked video fine-tuning. arXiv preprint arXiv:2411.05003
Zhang DJ, Wu JZ, Liu JW et al (2024) Show-1: marrying pixel and latent diffusion models for text-to-video
generation. Int J Comput Vision 10:1–15
Zhang R, Chen Y, Liu Y, et al (2024) Tvg: A training-free transition video generation method with diffusion
models. arXiv:2408.13413
Zhang Y, Gu J, Wang LW, et al (2024) Mimicmotion: High-quality human motion video generation with
confidence-aware pose guidance. arXiv preprint arXiv:2406.19680
Zhang Y, Kang Y, Zhang Z, et al (2024) Interactivevideo: User-centric controllable video generation with
synergistic multimodal instructions. arXiv preprint arXiv:2402.03040
Zhang Z, Liao J, Li M, et al (2024) Tora: Trajectory-oriented diffusion transformer for video generation.
arXiv preprint arXiv:2407.21705
Zhang S, Wang J, Zhang Y, et al (2023) I2vgen-xl: High-quality image-to-video synthesis via cascaded diffu­
sion models. arXiv preprint arXiv:2311.04145
1 3
Page 53 of 55
W. Ma et al.
Zhang Y, Wei Y, Lin X, et al (2024) Videoelevator: Elevating video generation quality with versatile text-toimage diffusion models. https://arxiv.org/abs/2403.05438, arXiv:2403.05438
Zhang Z, Wu B, Wang X, et al (2023) Avid: Any-length video inpainting with diffusion model. arXiv preprint
arXiv:2312.03816
Zhang H, Wu Z, Xing Z, et al (2023) Adadiff: Adaptive step selection for fast diffusion. arXiv preprint
arXiv:2311.14768
Zhang C, Zhang C, Zheng S, et al (2023) A survey on audio diffusion models: Text to speech synthesis and
enhancement in generative ai. arXiv preprint arXiv:2303.13336
Zhao L, Feng L, Ge D, et al (2025) Uniform: A unified diffusion transformer for audio-video generation.
arXiv preprint arXiv:2502.03897
Zhao R, Gu Y, Wu JZ, et al (2024a) Motiondirector: motion customization of text-to-video diffusion models.
In: European Conference on Computer Vision, Springer, pp 273–290
Zhao H, Lu T, Gu J, et al (2024b) Magdiff: Multi-alignment diffusion for high-fidelity video generation and
editing. In: European Conference on Computer Vision, Springer, pp 205–221
Zhao M, Zhu H, Xiang C, et al (2024) Identifying and solving conditional image leakage in image-to-video
diffusion model. arXiv preprint arXiv:2406.15735
Zheng G, Li T, Jiang R, et al (2024) Cami2v: Camera-controlled image-to-video diffusion model. arXiv
preprint arXiv:2410.15957
Zhou Q, Li R, Guo S, et al (2022) Cadm: Codec-aware diffusion modeling for neural-enhanced video stream­
ing. arXiv preprint arXiv:2211.08428
Zhou D, Wang W, Yan H, et al (2022) Magicvideo: Efficient video generation with latent diffusion models.
arXiv preprint arXiv:2211.11018
Zhou S, Yang P, Wang J, et al (2023) Upscale-a-video: Temporal-consistent diffusion model for real-world
video super-resolution. arXiv preprint arXiv:2312.06640
Zhuang S, Li K, Chen X, et al (2024) Vlogger: Make your dream a vlog. In: Proceedings of the IEEE/CVF
Conference on Computer Vision and Pattern Recognition, pp 8806–8817
Zhu S, Chen JL, Dai Z, et al (2024) Champ: Controllable and consistent human image animation with 3d
parametric guidance. In: European Conference on Computer Vision, Springer, pp 145–162
Zhu J, Yang H, He H, et al (2023) Moviefactory: Automatic movie creation from text using large generative
models for language and images. In: Proceedings of the 31st ACM International Conference on Multi­
media, pp 9313–9319
Zi B, Ruan P, Chen M, et al (2025) Señorita-2m: A high-quality instruction-based dataset for general video
editing by video specialists. arXiv:2502.06734
Publisher's Note  Springer Nature remains neutral with regard to jurisdictional claims in published maps and
institutional affiliations.
Authors and Affiliations
Wenping Ma1 · Xiaoting Yang1 · Licheng Jiao1 · Lingling Li1 · Xu Liu1 · Fang Liu1 ·
Puhua Chen1 · Yuting Yang1 · Mengru Ma1 · Long Sun1 · Ruohan Zhang1 · Xueli Geng1 ·
Yuwei Guo1 · Shuyuan Yang1 · Zhixi Feng1
Licheng Jiao
lchjiao@mail.xidian.edu.cn
Wenping Ma
wpma@mail.xidian.edu.cn
Xiaoting Yang
18200100246@stu.xidian.edu.cn
Lingling Li
llli@xidian.edu.cn
Xu Liu
xuliu@xidian.edu.cn
1 3
Page 54 of 55
Video diffusion generation: comprehensive review and open problems
Fang Liu
f63liu@163.com
Puhua Chen
phchen@xidian.edu.cn
Yuting Yang
yangyuting@xidian.edu.cn
Mengru Ma
mengrumalearn@163.com
Long Sun
longsun@xidian.edu.cn
Ruohan Zhang
zhangruohan@xidian.edu.cn
Xueli Geng
gengxueli@xidian.edu.cn
Yuwei Guo
ywguo@xidian.edu.cn
Shuyuan Yang
syyang@xidian.edu.cn
Zhixi Feng
zxfeng@xidian.edu.cn
Key Laboratory of Intelligent Perception and Image Understanding of Ministry of Education,
Xidian University, Xi’an 710071, Shaanxi, China
1 3
Page 55 of 55
