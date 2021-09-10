-- Drop tables
DROP TABLE IF EXISTS public.asset_item;
DROP TABLE IF EXISTS public.asset;
DROP TABLE IF EXISTS public.issuer;
DROP TABLE IF EXISTS public.owner;
DROP SEQUENCE IF EXISTS public.asset_asset_id_seq;
DROP SEQUENCE IF EXISTS public.asset_item_asset_id_seq;
DROP SEQUENCE IF EXISTS public.asset_item_asset_item_id_seq;

-- Table: public.owner
CREATE TABLE IF NOT EXISTS public.owner
(
    owner_id uuid NOT NULL,
    CONSTRAINT owner_pkey PRIMARY KEY (owner_id)
)

TABLESPACE pg_default;

-- Table: public.issuer
CREATE TABLE IF NOT EXISTS public.issuer
(
    issuer_id uuid NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    website text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT issuer_pkey PRIMARY KEY (issuer_id)
)

TABLESPACE pg_default;

-- Table: public.asset

CREATE SEQUENCE IF NOT EXISTS public.asset_asset_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE TABLE IF NOT EXISTS public.asset
(
    issuer_id uuid NOT NULL,
    asset_id integer NOT NULL DEFAULT nextval('asset_asset_id_seq'::regclass),
    name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT asset_pkey PRIMARY KEY (issuer_id, asset_id),
    CONSTRAINT asset_issuer_id_fkey FOREIGN KEY (issuer_id)
        REFERENCES public.issuer (issuer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

-- Table: public.asset_item
CREATE SEQUENCE public.asset_item_asset_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE SEQUENCE public.asset_item_asset_item_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE IF NOT EXISTS public.asset_item
(
    issuer_id uuid NOT NULL,
    asset_id integer NOT NULL DEFAULT nextval('asset_item_asset_id_seq'::regclass),
    asset_item_id bigint NOT NULL DEFAULT nextval('asset_item_asset_item_id_seq'::regclass),
    owner_id uuid NOT NULL,
    serial_number text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT asset_item_pkey PRIMARY KEY (issuer_id, asset_id, asset_item_id),
    CONSTRAINT asset_item_issuer_id_fkey FOREIGN KEY (issuer_id)
        REFERENCES public.issuer (issuer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT asset_item_asset_id_fkey FOREIGN KEY (issuer_id, asset_id)
        REFERENCES public.asset (issuer_id, asset_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT asset_item_owner_id_fkey FOREIGN KEY (owner_id)
        REFERENCES public.owner (owner_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

CREATE INDEX fki_asset_item_issuer_id_fkey
    ON public.asset_item USING btree
    (issuer_id ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX fki_asset_item_asset_id_fkey
    ON public.asset_item USING btree
    (issuer_id ASC NULLS LAST, asset_id ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX fki_asset_item_owner_id_fkey
    ON public.asset_item USING btree
    (owner_id ASC NULLS LAST)
    TABLESPACE pg_default;
