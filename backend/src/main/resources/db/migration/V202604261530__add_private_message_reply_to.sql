DO $$
BEGIN
    IF to_regclass('public.private_message') IS NOT NULL THEN
        ALTER TABLE public.private_message
            ADD COLUMN IF NOT EXISTS reply_to BIGINT NULL;

        CREATE INDEX IF NOT EXISTS idx_pm_reply_to
            ON public.private_message(reply_to);

        EXECUTE 'COMMENT ON COLUMN public.private_message.reply_to IS ''回复的消息ID''';
    END IF;
END $$;
