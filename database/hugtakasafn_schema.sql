--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: plpgsql_call_handler(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION plpgsql_call_handler() RETURNS opaque
    LANGUAGE c
    AS '$libdir/plpgsql', 'plpgsql_call_handler';


ALTER FUNCTION public.plpgsql_call_handler() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: hugtakagripill_hugtok; Type: TABLE; Schema: public; Owner: hugtakasafn; Tablespace:
--

CREATE TABLE hugtakagripill_hugtok (
    id integer NOT NULL,
    dags timestamp with time zone DEFAULT now(),
    enska text,
    islenska text,
    daemi_enska text,
    daemi_islenska text,
    rit text,
    skjal_nr text,
    samheiti text,
    svid text,
    uppruni_skjals text,
    heimild text,
    athugasemd text,
    adalord text,
    ordflokkur text,
    kyn text,
    onnur_malfraedi text,
    skammstofun text,
    skilgreining text,
    nafn_ordtaka text,
    gilding text,
    enska_skammstofun text,
    islenska_annar_rith text,
    enska_annar_rith text,
    da_no_sae text,
    de text,
    fr text,
    la text,
    hidden boolean DEFAULT false
);


ALTER TABLE public.hugtakagripill_hugtok OWNER TO hugtakasafn;

--
-- Name: hugtakagripill_hugtok_id; Type: SEQUENCE; Schema: public; Owner: hugtakasafn
--

CREATE SEQUENCE hugtakagripill_hugtok_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hugtakagripill_hugtok_id OWNER TO hugtakasafn;

--
-- Name: hugtakagripill_por; Type: TABLE; Schema: public; Owner: hugtakasafn; Tablespace:
--

CREATE TABLE hugtakagripill_por (
    nr integer NOT NULL,
    skrarheiti text NOT NULL,
    enska text,
    islenska text,
    processed boolean
);


ALTER TABLE public.hugtakagripill_por OWNER TO hugtakasafn;

--
-- Name: hugtakagripill_skjol; Type: TABLE; Schema: public; Owner: hugtakasafn; Tablespace:
--

CREATE TABLE hugtakagripill_skjol (
    skrarheiti text NOT NULL,
    flokkun text,
    rit text,
    bls text,
    dags date,
    processed boolean
);


ALTER TABLE public.hugtakagripill_skjol OWNER TO hugtakasafn;

--
-- Name: hugtakagripill_tillogur_stakord; Type: TABLE; Schema: public; Owner: hugtakasafn; Tablespace:
--

CREATE TABLE hugtakagripill_tillogur_stakord (
    par_nr integer,
    par_skrarheiti text,
    ord text,
    idx_start integer,
    idx_end integer
);


ALTER TABLE public.hugtakagripill_tillogur_stakord OWNER TO hugtakasafn;

--
-- Name: hugtakasafn; Type: TABLE; Schema: public; Owner: hugtakasafn; Tablespace:
--

CREATE TABLE hugtakasafn (
    entrynumber integer NOT NULL,
    lang_is text,
    lang_en text,
    lang_danosae text,
    lang_fr text,
    lang_de text,
    lang_la text,
    is_samh text,
    is_svid text,
    is_daemi text,
    is_skilgr text,
    is_rit text,
    is_efnisfl text,
    is_adalord text,
    is_adalord_ordfl text,
    is_adalord_kyn text,
    is_onnurmalfr text,
    en_ordfl text,
    en_skst text,
    en_annar_rith text,
    is_skst text,
    is_annar_rith text,
    is_heimild text,
    is_aths text,
    is_skjalnr text,
    en_daemi text,
    en_samh text,
    en_skilgr text,
    en_aths text,
    en_rit text,
    db_nr integer
);


ALTER TABLE public.hugtakasafn OWNER TO hugtakasafn;

--
-- Name: hugtakasafn_svid; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW hugtakasafn_svid AS
    SELECT hugtakasafn.is_svid, count(hugtakasafn.is_svid) AS fjoldi FROM hugtakasafn GROUP BY hugtakasafn.is_svid;


ALTER TABLE public.hugtakasafn_svid OWNER TO postgres;

--
-- Name: hugtakasafn_updated; Type: TABLE; Schema: public; Owner: hugtakasafn; Tablespace:
--

CREATE TABLE hugtakasafn_updated (
    updated date,
    entry_count integer
);


ALTER TABLE public.hugtakasafn_updated OWNER TO hugtakasafn;

--
-- Name: stopplisti; Type: TABLE; Schema: public; Owner: hugtakasafn; Tablespace:
--

CREATE TABLE stopplisti (
    enska text
);


ALTER TABLE public.stopplisti OWNER TO hugtakasafn;

--
-- Name: temp; Type: TABLE; Schema: public; Owner: hugtakasafn; Tablespace:
--

CREATE TABLE temp (
    t text
);


ALTER TABLE public.temp OWNER TO hugtakasafn;

--
-- Name: entrynumber_pk; Type: CONSTRAINT; Schema: public; Owner: hugtakasafn; Tablespace:
--

ALTER TABLE ONLY hugtakasafn
    ADD CONSTRAINT entrynumber_pk PRIMARY KEY (entrynumber);


--
-- Name: hugtakagripill_skjol_skrarheiti; Type: CONSTRAINT; Schema: public; Owner: hugtakasafn; Tablespace:
--

ALTER TABLE ONLY hugtakagripill_skjol
    ADD CONSTRAINT hugtakagripill_skjol_skrarheiti PRIMARY KEY (skrarheiti);


--
-- Name: id_pk; Type: CONSTRAINT; Schema: public; Owner: hugtakasafn; Tablespace:
--

ALTER TABLE ONLY hugtakagripill_hugtok
    ADD CONSTRAINT id_pk PRIMARY KEY (id);


--
-- Name: nr_skrarheiti; Type: CONSTRAINT; Schema: public; Owner: hugtakasafn; Tablespace:
--

ALTER TABLE ONLY hugtakagripill_por
    ADD CONSTRAINT nr_skrarheiti PRIMARY KEY (nr, skrarheiti);


--
-- Name: hugtakagripill_hidden_idx; Type: INDEX; Schema: public; Owner: hugtakasafn; Tablespace:
--

CREATE INDEX hugtakagripill_hidden_idx ON hugtakagripill_hugtok USING btree (hidden);


--
-- Name: hugtakagripill_hugtok_enska_idx; Type: INDEX; Schema: public; Owner: hugtakasafn; Tablespace:
--

CREATE INDEX hugtakagripill_hugtok_enska_idx ON hugtakagripill_hugtok USING btree (enska);


--
-- Name: hugtakagripill_hugtok_islenska_idx; Type: INDEX; Schema: public; Owner: hugtakasafn; Tablespace:
--

CREATE INDEX hugtakagripill_hugtok_islenska_idx ON hugtakagripill_hugtok USING btree (islenska);


--
-- Name: hugtakasafn_lang_en_index; Type: INDEX; Schema: public; Owner: hugtakasafn; Tablespace:
--

CREATE INDEX hugtakasafn_lang_en_index ON hugtakasafn USING btree (lang_en);


--
-- Name: stopplisti_enska_idx; Type: INDEX; Schema: public; Owner: hugtakasafn; Tablespace:
--

CREATE INDEX stopplisti_enska_idx ON stopplisti USING btree (enska);


--
-- Name: hugtakagripill_por_skrarheiti_f; Type: FK CONSTRAINT; Schema: public; Owner: hugtakasafn
--

ALTER TABLE ONLY hugtakagripill_por
    ADD CONSTRAINT hugtakagripill_por_skrarheiti_f FOREIGN KEY (skrarheiti) REFERENCES hugtakagripill_skjol(skrarheiti) ON DELETE CASCADE;


--
-- Name: nr_skrarheiti_fk; Type: FK CONSTRAINT; Schema: public; Owner: hugtakasafn
--

ALTER TABLE ONLY hugtakagripill_tillogur_stakord
    ADD CONSTRAINT nr_skrarheiti_fk FOREIGN KEY (par_nr, par_skrarheiti) REFERENCES hugtakagripill_por(nr, skrarheiti) ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--
