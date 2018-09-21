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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: agency_profile; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE agency_profile (
    id integer NOT NULL,
    profile_id integer NOT NULL,
    agency_id integer NOT NULL
);


ALTER TABLE public.agency_profile OWNER TO ozp_user;

--
-- Name: agency_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE agency_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agency_profile_id_seq OWNER TO ozp_user;

--
-- Name: agency_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE agency_profile_id_seq OWNED BY agency_profile.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO ozp_user;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO ozp_user;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO ozp_user;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO ozp_user;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO ozp_user;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO ozp_user;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO ozp_user;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO ozp_user;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO ozp_user;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO ozp_user;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO ozp_user;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO ozp_user;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: category_listing; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE category_listing (
    id integer NOT NULL,
    listing_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.category_listing OWNER TO ozp_user;

--
-- Name: category_listing_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE category_listing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_listing_id_seq OWNER TO ozp_user;

--
-- Name: category_listing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE category_listing_id_seq OWNED BY category_listing.id;


--
-- Name: contact_listing; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE contact_listing (
    id integer NOT NULL,
    listing_id integer NOT NULL,
    contact_id integer NOT NULL
);


ALTER TABLE public.contact_listing OWNER TO ozp_user;

--
-- Name: contact_listing_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE contact_listing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contact_listing_id_seq OWNER TO ozp_user;

--
-- Name: contact_listing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE contact_listing_id_seq OWNED BY contact_listing.id;


--
-- Name: corsheaders_corsmodel; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE corsheaders_corsmodel (
    id integer NOT NULL,
    cors character varying(255) NOT NULL
);


ALTER TABLE public.corsheaders_corsmodel OWNER TO ozp_user;

--
-- Name: corsheaders_corsmodel_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE corsheaders_corsmodel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.corsheaders_corsmodel_id_seq OWNER TO ozp_user;

--
-- Name: corsheaders_corsmodel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE corsheaders_corsmodel_id_seq OWNED BY corsheaders_corsmodel.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO ozp_user;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO ozp_user;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO ozp_user;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO ozp_user;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO ozp_user;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO ozp_user;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO ozp_user;

--
-- Name: intent_listing; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE intent_listing (
    id integer NOT NULL,
    listing_id integer NOT NULL,
    intent_id integer NOT NULL
);


ALTER TABLE public.intent_listing OWNER TO ozp_user;

--
-- Name: intent_listing_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE intent_listing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.intent_listing_id_seq OWNER TO ozp_user;

--
-- Name: intent_listing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE intent_listing_id_seq OWNED BY intent_listing.id;


--
-- Name: listing_activity_change_detail; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE listing_activity_change_detail (
    id integer NOT NULL,
    listingactivity_id integer NOT NULL,
    changedetail_id integer NOT NULL
);


ALTER TABLE public.listing_activity_change_detail OWNER TO ozp_user;

--
-- Name: listing_activity_change_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE listing_activity_change_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.listing_activity_change_detail_id_seq OWNER TO ozp_user;

--
-- Name: listing_activity_change_detail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE listing_activity_change_detail_id_seq OWNED BY listing_activity_change_detail.id;


--
-- Name: notification_profile; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE notification_profile (
    id integer NOT NULL,
    notification_id integer NOT NULL,
    profile_id integer NOT NULL
);


ALTER TABLE public.notification_profile OWNER TO ozp_user;

--
-- Name: notification_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE notification_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notification_profile_id_seq OWNER TO ozp_user;

--
-- Name: notification_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE notification_profile_id_seq OWNED BY notification_profile.id;


--
-- Name: ozpcenter_agency; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_agency (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    short_name character varying(32) NOT NULL,
    icon_id integer
);


ALTER TABLE public.ozpcenter_agency OWNER TO ozp_user;

--
-- Name: ozpcenter_agency_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_agency_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_agency_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_agency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_agency_id_seq OWNED BY ozpcenter_agency.id;


--
-- Name: ozpcenter_applicationlibraryentry; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_applicationlibraryentry (
    id integer NOT NULL,
    folder character varying(255),
    listing_id integer NOT NULL,
    owner_id integer NOT NULL,
    "position" integer NOT NULL,
    CONSTRAINT ozpcenter_applicationlibraryentry_position_check CHECK (("position" >= 0))
);


ALTER TABLE public.ozpcenter_applicationlibraryentry OWNER TO ozp_user;

--
-- Name: ozpcenter_applicationlibraryentry_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_applicationlibraryentry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_applicationlibraryentry_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_applicationlibraryentry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_applicationlibraryentry_id_seq OWNED BY ozpcenter_applicationlibraryentry.id;


--
-- Name: ozpcenter_category; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_category (
    id integer NOT NULL,
    title character varying(50) NOT NULL,
    description character varying(255)
);


ALTER TABLE public.ozpcenter_category OWNER TO ozp_user;

--
-- Name: ozpcenter_category_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_category_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_category_id_seq OWNED BY ozpcenter_category.id;


--
-- Name: ozpcenter_changedetail; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_changedetail (
    id integer NOT NULL,
    field_name character varying(255) NOT NULL,
    old_value character varying(4000),
    new_value character varying(4000)
);


ALTER TABLE public.ozpcenter_changedetail OWNER TO ozp_user;

--
-- Name: ozpcenter_changedetail_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_changedetail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_changedetail_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_changedetail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_changedetail_id_seq OWNED BY ozpcenter_changedetail.id;


--
-- Name: ozpcenter_contact; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_contact (
    id integer NOT NULL,
    secure_phone character varying(50),
    unsecure_phone character varying(50),
    email character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    organization character varying(100),
    contact_type_id integer NOT NULL
);


ALTER TABLE public.ozpcenter_contact OWNER TO ozp_user;

--
-- Name: ozpcenter_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_contact_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_contact_id_seq OWNED BY ozpcenter_contact.id;


--
-- Name: ozpcenter_contacttype; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_contacttype (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    required boolean NOT NULL
);


ALTER TABLE public.ozpcenter_contacttype OWNER TO ozp_user;

--
-- Name: ozpcenter_contacttype_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_contacttype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_contacttype_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_contacttype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_contacttype_id_seq OWNED BY ozpcenter_contacttype.id;


--
-- Name: ozpcenter_docurl; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_docurl (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    url character varying(2083) NOT NULL,
    listing_id integer NOT NULL
);


ALTER TABLE public.ozpcenter_docurl OWNER TO ozp_user;

--
-- Name: ozpcenter_docurl_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_docurl_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_docurl_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_docurl_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_docurl_id_seq OWNED BY ozpcenter_docurl.id;


--
-- Name: ozpcenter_image; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_image (
    id integer NOT NULL,
    uuid character varying(36) NOT NULL,
    security_marking character varying(1024) NOT NULL,
    file_extension character varying(16) NOT NULL,
    image_type_id integer NOT NULL
);


ALTER TABLE public.ozpcenter_image OWNER TO ozp_user;

--
-- Name: ozpcenter_image_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_image_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_image_id_seq OWNED BY ozpcenter_image.id;


--
-- Name: ozpcenter_imagetype; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_imagetype (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    max_size_bytes integer NOT NULL,
    max_width integer NOT NULL,
    max_height integer NOT NULL,
    min_width integer NOT NULL,
    min_height integer NOT NULL
);


ALTER TABLE public.ozpcenter_imagetype OWNER TO ozp_user;

--
-- Name: ozpcenter_imagetype_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_imagetype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_imagetype_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_imagetype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_imagetype_id_seq OWNED BY ozpcenter_imagetype.id;


--
-- Name: ozpcenter_intent; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_intent (
    id integer NOT NULL,
    action character varying(64) NOT NULL,
    media_type character varying(129) NOT NULL,
    label character varying(255) NOT NULL,
    icon_id integer NOT NULL
);


ALTER TABLE public.ozpcenter_intent OWNER TO ozp_user;

--
-- Name: ozpcenter_intent_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_intent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_intent_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_intent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_intent_id_seq OWNED BY ozpcenter_intent.id;


--
-- Name: ozpcenter_listing; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_listing (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    approved_date timestamp with time zone,
    edited_date timestamp with time zone NOT NULL,
    description character varying(8192),
    launch_url character varying(2083),
    version_name character varying(255),
    unique_name character varying(255),
    what_is_new character varying(255),
    description_short character varying(150),
    usage_requirements character varying(1000),
    approval_status character varying(255) NOT NULL,
    is_enabled boolean NOT NULL,
    is_featured boolean NOT NULL,
    avg_rate double precision NOT NULL,
    total_votes integer NOT NULL,
    total_rate5 integer NOT NULL,
    total_rate4 integer NOT NULL,
    total_rate3 integer NOT NULL,
    total_rate2 integer NOT NULL,
    total_rate1 integer NOT NULL,
    total_reviews integer NOT NULL,
    iframe_compatible boolean NOT NULL,
    security_marking character varying(1024),
    is_private boolean NOT NULL,
    agency_id integer NOT NULL,
    banner_icon_id integer,
    current_rejection_id integer,
    large_banner_icon_id integer,
    large_icon_id integer,
    last_activity_id integer,
    listing_type_id integer,
    required_listings_id integer,
    small_icon_id integer,
    is_deleted boolean NOT NULL,
    total_review_responses integer NOT NULL,
    system_requirements character varying(1000),
    feedback_score integer NOT NULL
);


ALTER TABLE public.ozpcenter_listing OWNER TO ozp_user;

--
-- Name: ozpcenter_listing_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_listing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_listing_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_listing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_listing_id_seq OWNED BY ozpcenter_listing.id;


--
-- Name: ozpcenter_listingactivity; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_listingactivity (
    id integer NOT NULL,
    action character varying(128) NOT NULL,
    activity_date timestamp with time zone NOT NULL,
    description character varying(2000),
    author_id integer NOT NULL,
    listing_id integer NOT NULL
);


ALTER TABLE public.ozpcenter_listingactivity OWNER TO ozp_user;

--
-- Name: ozpcenter_listingactivity_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_listingactivity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_listingactivity_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_listingactivity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_listingactivity_id_seq OWNED BY ozpcenter_listingactivity.id;


--
-- Name: ozpcenter_listingtype; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_listingtype (
    id integer NOT NULL,
    title character varying(50) NOT NULL,
    description character varying(255) NOT NULL
);


ALTER TABLE public.ozpcenter_listingtype OWNER TO ozp_user;

--
-- Name: ozpcenter_listingtype_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_listingtype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_listingtype_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_listingtype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_listingtype_id_seq OWNED BY ozpcenter_listingtype.id;


--
-- Name: ozpcenter_notification; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_notification (
    id integer NOT NULL,
    created_date timestamp with time zone NOT NULL,
    message character varying(4096) NOT NULL,
    expires_date timestamp with time zone NOT NULL,
    author_id integer NOT NULL,
    listing_id integer,
    agency_id integer,
    peer character varying(4096),
    group_target character varying(24) NOT NULL,
    notification_type character varying(24) NOT NULL,
    entity_id integer,
    notification_subtype character varying(36)
);


ALTER TABLE public.ozpcenter_notification OWNER TO ozp_user;

--
-- Name: ozpcenter_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_notification_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_notification_id_seq OWNED BY ozpcenter_notification.id;


--
-- Name: ozpcenter_notificationmailbox; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_notificationmailbox (
    id integer NOT NULL,
    target_profile_id integer NOT NULL,
    notification_id integer NOT NULL,
    emailed_status boolean NOT NULL,
    read_status boolean NOT NULL,
    acknowledged_status boolean NOT NULL
);


ALTER TABLE public.ozpcenter_notificationmailbox OWNER TO ozp_user;

--
-- Name: ozpcenter_notificationmailbox_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_notificationmailbox_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_notificationmailbox_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_notificationmailbox_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_notificationmailbox_id_seq OWNED BY ozpcenter_notificationmailbox.id;


--
-- Name: ozpcenter_profile; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_profile (
    id integer NOT NULL,
    display_name character varying(255) NOT NULL,
    bio character varying(1000) NOT NULL,
    dn character varying(1000) NOT NULL,
    issuer_dn character varying(1000),
    auth_expires timestamp with time zone NOT NULL,
    access_control character varying(16384) NOT NULL,
    user_id integer,
    center_tour_flag boolean NOT NULL,
    hud_tour_flag boolean NOT NULL,
    webtop_tour_flag boolean NOT NULL,
    email_notification_flag boolean NOT NULL,
    listing_notification_flag boolean NOT NULL,
    subscription_notification_flag boolean NOT NULL,
    leaving_ozp_warning_flag boolean NOT NULL
);


ALTER TABLE public.ozpcenter_profile OWNER TO ozp_user;

--
-- Name: ozpcenter_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_profile_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_profile_id_seq OWNED BY ozpcenter_profile.id;


--
-- Name: ozpcenter_recommendationfeedback; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_recommendationfeedback (
    id integer NOT NULL,
    feedback integer NOT NULL,
    target_listing_id integer NOT NULL,
    target_profile_id integer NOT NULL
);


ALTER TABLE public.ozpcenter_recommendationfeedback OWNER TO ozp_user;

--
-- Name: ozpcenter_recommendationfeedback_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_recommendationfeedback_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_recommendationfeedback_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_recommendationfeedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_recommendationfeedback_id_seq OWNED BY ozpcenter_recommendationfeedback.id;


--
-- Name: ozpcenter_recommendationsentry; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_recommendationsentry (
    id integer NOT NULL,
    target_profile_id integer NOT NULL,
    recommendation_data bytea NOT NULL
);


ALTER TABLE public.ozpcenter_recommendationsentry OWNER TO ozp_user;

--
-- Name: ozpcenter_recommendationsentry_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_recommendationsentry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_recommendationsentry_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_recommendationsentry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_recommendationsentry_id_seq OWNED BY ozpcenter_recommendationsentry.id;


--
-- Name: ozpcenter_review; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_review (
    id integer NOT NULL,
    text character varying(4000),
    rate integer NOT NULL,
    edited_date timestamp with time zone NOT NULL,
    author_id integer NOT NULL,
    listing_id integer NOT NULL,
    review_parent_id integer,
    created_date timestamp with time zone NOT NULL
);


ALTER TABLE public.ozpcenter_review OWNER TO ozp_user;

--
-- Name: ozpcenter_review_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_review_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_review_id_seq OWNED BY ozpcenter_review.id;


--
-- Name: ozpcenter_screenshot; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_screenshot (
    id integer NOT NULL,
    large_image_id integer NOT NULL,
    listing_id integer NOT NULL,
    small_image_id integer NOT NULL,
    description character varying(160),
    "order" integer
);


ALTER TABLE public.ozpcenter_screenshot OWNER TO ozp_user;

--
-- Name: ozpcenter_screenshot_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_screenshot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_screenshot_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_screenshot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_screenshot_id_seq OWNED BY ozpcenter_screenshot.id;


--
-- Name: ozpcenter_subscription; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_subscription (
    id integer NOT NULL,
    entity_type character varying(12) NOT NULL,
    entity_id integer NOT NULL,
    target_profile_id integer NOT NULL
);


ALTER TABLE public.ozpcenter_subscription OWNER TO ozp_user;

--
-- Name: ozpcenter_subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_subscription_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_subscription_id_seq OWNED BY ozpcenter_subscription.id;


--
-- Name: ozpcenter_tag; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpcenter_tag (
    id integer NOT NULL,
    name character varying(30) NOT NULL
);


ALTER TABLE public.ozpcenter_tag OWNER TO ozp_user;

--
-- Name: ozpcenter_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpcenter_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpcenter_tag_id_seq OWNER TO ozp_user;

--
-- Name: ozpcenter_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpcenter_tag_id_seq OWNED BY ozpcenter_tag.id;


--
-- Name: ozpiwc_dataresource; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE ozpiwc_dataresource (
    id integer NOT NULL,
    key character varying(1024) NOT NULL,
    entity character varying(1048576),
    content_type character varying(1024),
    username character varying(128) NOT NULL,
    pattern character varying(1024),
    permissions character varying(1024),
    version character varying(1024)
);


ALTER TABLE public.ozpiwc_dataresource OWNER TO ozp_user;

--
-- Name: ozpiwc_dataresource_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE ozpiwc_dataresource_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ozpiwc_dataresource_id_seq OWNER TO ozp_user;

--
-- Name: ozpiwc_dataresource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE ozpiwc_dataresource_id_seq OWNED BY ozpiwc_dataresource.id;


--
-- Name: profile_listing; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE profile_listing (
    id integer NOT NULL,
    listing_id integer NOT NULL,
    profile_id integer NOT NULL
);


ALTER TABLE public.profile_listing OWNER TO ozp_user;

--
-- Name: profile_listing_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE profile_listing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profile_listing_id_seq OWNER TO ozp_user;

--
-- Name: profile_listing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE profile_listing_id_seq OWNED BY profile_listing.id;


--
-- Name: stewarded_agency_profile; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE stewarded_agency_profile (
    id integer NOT NULL,
    profile_id integer NOT NULL,
    agency_id integer NOT NULL
);


ALTER TABLE public.stewarded_agency_profile OWNER TO ozp_user;

--
-- Name: stewarded_agency_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE stewarded_agency_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stewarded_agency_profile_id_seq OWNER TO ozp_user;

--
-- Name: stewarded_agency_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE stewarded_agency_profile_id_seq OWNED BY stewarded_agency_profile.id;


--
-- Name: tag_listing; Type: TABLE; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE TABLE tag_listing (
    id integer NOT NULL,
    listing_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.tag_listing OWNER TO ozp_user;

--
-- Name: tag_listing_id_seq; Type: SEQUENCE; Schema: public; Owner: ozp_user
--

CREATE SEQUENCE tag_listing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_listing_id_seq OWNER TO ozp_user;

--
-- Name: tag_listing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ozp_user
--

ALTER SEQUENCE tag_listing_id_seq OWNED BY tag_listing.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY agency_profile ALTER COLUMN id SET DEFAULT nextval('agency_profile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY category_listing ALTER COLUMN id SET DEFAULT nextval('category_listing_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY contact_listing ALTER COLUMN id SET DEFAULT nextval('contact_listing_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY corsheaders_corsmodel ALTER COLUMN id SET DEFAULT nextval('corsheaders_corsmodel_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY intent_listing ALTER COLUMN id SET DEFAULT nextval('intent_listing_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY listing_activity_change_detail ALTER COLUMN id SET DEFAULT nextval('listing_activity_change_detail_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY notification_profile ALTER COLUMN id SET DEFAULT nextval('notification_profile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_agency ALTER COLUMN id SET DEFAULT nextval('ozpcenter_agency_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_applicationlibraryentry ALTER COLUMN id SET DEFAULT nextval('ozpcenter_applicationlibraryentry_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_category ALTER COLUMN id SET DEFAULT nextval('ozpcenter_category_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_changedetail ALTER COLUMN id SET DEFAULT nextval('ozpcenter_changedetail_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_contact ALTER COLUMN id SET DEFAULT nextval('ozpcenter_contact_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_contacttype ALTER COLUMN id SET DEFAULT nextval('ozpcenter_contacttype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_docurl ALTER COLUMN id SET DEFAULT nextval('ozpcenter_docurl_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_image ALTER COLUMN id SET DEFAULT nextval('ozpcenter_image_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_imagetype ALTER COLUMN id SET DEFAULT nextval('ozpcenter_imagetype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_intent ALTER COLUMN id SET DEFAULT nextval('ozpcenter_intent_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_listing ALTER COLUMN id SET DEFAULT nextval('ozpcenter_listing_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_listingactivity ALTER COLUMN id SET DEFAULT nextval('ozpcenter_listingactivity_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_listingtype ALTER COLUMN id SET DEFAULT nextval('ozpcenter_listingtype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_notification ALTER COLUMN id SET DEFAULT nextval('ozpcenter_notification_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_notificationmailbox ALTER COLUMN id SET DEFAULT nextval('ozpcenter_notificationmailbox_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_profile ALTER COLUMN id SET DEFAULT nextval('ozpcenter_profile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_recommendationfeedback ALTER COLUMN id SET DEFAULT nextval('ozpcenter_recommendationfeedback_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_recommendationsentry ALTER COLUMN id SET DEFAULT nextval('ozpcenter_recommendationsentry_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_review ALTER COLUMN id SET DEFAULT nextval('ozpcenter_review_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_screenshot ALTER COLUMN id SET DEFAULT nextval('ozpcenter_screenshot_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_subscription ALTER COLUMN id SET DEFAULT nextval('ozpcenter_subscription_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_tag ALTER COLUMN id SET DEFAULT nextval('ozpcenter_tag_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpiwc_dataresource ALTER COLUMN id SET DEFAULT nextval('ozpiwc_dataresource_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY profile_listing ALTER COLUMN id SET DEFAULT nextval('profile_listing_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY stewarded_agency_profile ALTER COLUMN id SET DEFAULT nextval('stewarded_agency_profile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY tag_listing ALTER COLUMN id SET DEFAULT nextval('tag_listing_id_seq'::regclass);


--
-- Data for Name: agency_profile; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY agency_profile (id, profile_id, agency_id) FROM stdin;
281	1	2
282	2	1
283	3	4
284	4	3
285	5	1
286	6	1
287	7	2
288	8	3
289	9	3
290	10	3
291	11	3
292	12	3
293	13	1
294	14	1
295	15	4
296	16	4
297	17	2
298	18	2
299	19	2
300	19	3
301	20	2
302	20	3
303	21	1
304	21	2
305	21	3
306	22	1
307	22	2
308	22	3
\.


--
-- Name: agency_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('agency_profile_id_seq', 308, true);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY auth_group (id, name) FROM stdin;
1	USER
2	ORG_STEWARD
3	APPS_MALL_STEWARD
4	BETA_USER
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('auth_group_id_seq', 4, true);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add content type	2	add_contenttype
5	Can change content type	2	change_contenttype
6	Can delete content type	2	delete_contenttype
7	Can add permission	3	add_permission
8	Can change permission	3	change_permission
9	Can delete permission	3	delete_permission
10	Can add group	5	add_group
11	Can change group	5	change_group
12	Can delete group	5	delete_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can add session	6	add_session
17	Can change session	6	change_session
18	Can delete session	6	delete_session
19	Can add image type	7	add_imagetype
20	Can change image type	7	change_imagetype
21	Can delete image type	7	delete_imagetype
22	Can add image	9	add_image
23	Can change image	9	change_image
24	Can delete image	9	delete_image
25	Can add tag	24	add_tag
26	Can change tag	24	change_tag
27	Can delete tag	24	delete_tag
28	Can add agency	12	add_agency
29	Can change agency	12	change_agency
30	Can delete agency	12	delete_agency
31	Can add application library entry	21	add_applicationlibraryentry
32	Can change application library entry	21	change_applicationlibraryentry
33	Can delete application library entry	21	delete_applicationlibraryentry
34	Can add category	16	add_category
35	Can change category	16	change_category
36	Can delete category	16	delete_category
37	Can add change detail	10	add_changedetail
38	Can change change detail	10	change_changedetail
39	Can delete change detail	10	delete_changedetail
40	Can add contact	13	add_contact
41	Can change contact	13	change_contact
42	Can delete contact	13	delete_contact
43	Can add contact type	17	add_contacttype
44	Can change contact type	17	change_contacttype
45	Can delete contact type	17	delete_contacttype
46	Can add doc url	20	add_docurl
47	Can change doc url	20	change_docurl
48	Can delete doc url	20	delete_docurl
49	Can add intent	8	add_intent
50	Can change intent	8	change_intent
51	Can delete intent	8	delete_intent
52	Can add review	22	add_review
53	Can change review	22	change_review
54	Can delete review	22	delete_review
55	Can add profile	28	add_profile
56	Can change profile	28	change_profile
57	Can delete profile	28	delete_profile
58	Can add listing	23	add_listing
59	Can change listing	23	change_listing
60	Can delete listing	23	delete_listing
61	Can add recommendations entry	25	add_recommendationsentry
62	Can change recommendations entry	25	change_recommendationsentry
63	Can delete recommendations entry	25	delete_recommendationsentry
64	Can add recommendation feedback	19	add_recommendationfeedback
65	Can change recommendation feedback	19	change_recommendationfeedback
66	Can delete recommendation feedback	19	delete_recommendationfeedback
67	Can add listing activity	18	add_listingactivity
68	Can change listing activity	18	change_listingactivity
69	Can delete listing activity	18	delete_listingactivity
70	Can add screenshot	26	add_screenshot
71	Can change screenshot	26	change_screenshot
72	Can delete screenshot	26	delete_screenshot
73	Can add listing type	11	add_listingtype
74	Can change listing type	11	change_listingtype
75	Can delete listing type	11	delete_listingtype
76	Can add notification	15	add_notification
77	Can change notification	15	change_notification
78	Can delete notification	15	delete_notification
79	Can add notification mail box	14	add_notificationmailbox
80	Can change notification mail box	14	change_notificationmailbox
81	Can delete notification mail box	14	delete_notificationmailbox
82	Can add subscription	27	add_subscription
83	Can change subscription	27	change_subscription
84	Can delete subscription	27	delete_subscription
85	Can add data resource	29	add_dataresource
86	Can change data resource	29	change_dataresource
87	Can delete data resource	29	delete_dataresource
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('auth_permission_id_seq', 87, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$36000$37ltcXSG9Gf3$hz/w5CORWW9SEXN1qJdATuBzJEn22l4RqHm+S+wvBnE=	\N	t	bigbrother			bigbrother@oceania.gov	t	t	2017-11-09 10:31:32.962087-05
2	pbkdf2_sha256$36000$WARVmSTOIrh2$Gt0nPrSYU7pibUxRbb9yudcGgIUtOEWxiyoYwHflyfw=	\N	t	bigbrother2			bigbrother2@oceania.gov	t	t	2017-11-09 10:31:33.006415-05
3	pbkdf2_sha256$36000$xBBiTynMLDNa$vWu2L/dymBVXv/I98G8yfKolGLVnoTUoRZ50aC1cN9c=	\N	t	khaleesi			khaleesi@dragonborn.gov	t	t	2017-11-09 10:31:33.046105-05
4	pbkdf2_sha256$36000$1w8TUK0rDLLb$KW6/9DH9oy/ZOvc2Sq13qf0t71tIcqKDdSDjWoQAeE4=	\N	t	bettafish			bettafish@oceania.gov	t	t	2017-11-09 10:31:33.084952-05
5	pbkdf2_sha256$36000$K6TeP2Lm4A8n$XGBphdmZ56hK2sprPZ+8M+Xs3u4e7NFqXft880PdVRU=	\N	t	wsmith			wsmith@oceania.gov	t	t	2017-11-09 10:31:33.145367-05
6	pbkdf2_sha256$36000$QuDmirtkyvSq$iUHDuaC1956NKHDviwnFsfin+R2wJ/RR+IsZtw9BR0k=	\N	t	julia			julia@oceania.gov	t	t	2017-11-09 10:31:33.187217-05
7	pbkdf2_sha256$36000$Lj6vyPLXHmrn$Edsixgu/LfJmuQ+rCDEFGHejetbVgR7dsV/Tdix4PPI=	\N	t	obrien			obrien@oceania.gov	t	t	2017-11-09 10:31:33.232005-05
8	pbkdf2_sha256$36000$iwqI2MJ2aYkq$BhNcIUocLLQmSiIJXgJMlq2JFW1wLBhCNakkfiG9KzI=	\N	t	david			david@oceania.gov	t	t	2017-11-09 10:31:33.277044-05
9	pbkdf2_sha256$36000$EopWl9yTD5K2$ZW6xnkevgobxKgpTsOtlJuvP9g/UbVDSt02aAOADOzQ=	\N	f	aaronson			aaronson@airstripone.com	f	t	2017-11-09 10:31:33.319176-05
10	pbkdf2_sha256$36000$w7vlReaCm7hV$iBEjRDhLTd9cGXXLGuMj5KAsUcS7paS11hvo7LxqZrI=	\N	f	pmurt			pmurt@airstripone.com	f	t	2017-11-09 10:31:33.358121-05
11	pbkdf2_sha256$36000$hW2t1IyPw6H6$CPU8vOXBJVwhQF5zYlBQQocUfFZ/M0n3qEvHr5Ufm2M=	\N	f	hodor			hodor@hodor.com	f	t	2017-11-09 10:31:33.397565-05
12	pbkdf2_sha256$36000$epLBMesngiWU$5wmL1LwnK8lS8O+rNV6GvA4I33yTQp/53zjgBK6hNtw=	\N	f	betaraybill			betaraybill@oceania.gov	f	t	2017-11-09 10:31:33.436913-05
13	pbkdf2_sha256$36000$igGZDiRc5eUg$eaVWKx2JKjmmhEUz/bPrGAYHE+aj9Jxs4ZR5aCSyxos=	\N	f	jones			jones@airstripone.com	f	t	2017-11-09 10:31:33.478953-05
14	pbkdf2_sha256$36000$QmsNynCsqUih$4krJo4niVfHaji7vtBkXNaWydyhoz3A3YhtBBI+W3xA=	\N	f	tammy			tammy@airstripone.com	f	t	2017-11-09 10:31:33.518557-05
15	pbkdf2_sha256$36000$AMfD2NN3F1cB$mlYFE2xT+fTPhmqJ7gXPQ1gi5+od7RdUBAFNjX32SHs=	\N	f	rutherford			rutherford@airstripone.com	f	t	2017-11-09 10:31:33.557622-05
16	pbkdf2_sha256$36000$jnQWfevSvTyy$ck8UKrC8EK9Ys7sNlHzkbJjd/yvco3SPlSGz8FQEirU=	\N	f	noah			noah@airstripone.com	f	t	2017-11-09 10:31:33.596833-05
17	pbkdf2_sha256$36000$wvi9h0xMt0KF$68Zh9/WYSZwBxe99eBRzeIw4hWn7urN2juZhvYZ/dEU=	\N	f	syme			syme@airstripone.com	f	t	2017-11-09 10:31:33.636159-05
18	pbkdf2_sha256$36000$DIOk5pvQKHmt$SMScMA+5T1WOSNv805QXrmB1ucEvJCqDsT8RzDOQTE8=	\N	f	abe			abe@airstripone.com	f	t	2017-11-09 10:31:33.675053-05
19	pbkdf2_sha256$36000$mqrTt10e2UXZ$GuISbjgSiNqLvj/pYze4485sxO38HJ6JntGH1nRz7Zo=	\N	f	tparsons			tparsons@airstripone.com	f	t	2017-11-09 10:31:33.714491-05
20	pbkdf2_sha256$36000$YNFFn1DcQQYC$iT61QKp0+w08bvhQrH0MzrIZEQHyKAd/zefuHNonGsQ=	\N	f	jsnow			jsnow@forthewatch.com	f	t	2017-11-09 10:31:33.756432-05
21	pbkdf2_sha256$36000$t8RMLrMgdgH0$7NMS8eA99EGHq99/TPnMrGEBTflhAeoKjaaw44rYd5E=	\N	f	charrington			charrington@airstripone.com	f	t	2017-11-09 10:31:33.798816-05
22	pbkdf2_sha256$36000$sMIb9ROtbrvG$8UiFtO845SQGa56LGvYaXDrW5lW6Wmlx2Ennj5lWFys=	\N	f	johnson			johnson@airstripone.com	f	t	2017-11-09 10:31:33.842365-05
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
241	1	3
242	2	3
243	3	3
244	4	3
245	4	4
246	5	2
247	6	2
248	7	2
249	8	2
250	9	1
251	10	1
252	11	1
253	12	1
254	12	4
255	13	1
256	14	1
257	15	1
258	16	1
259	17	1
260	18	1
261	19	1
262	20	1
263	21	1
264	22	1
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 264, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('auth_user_id_seq', 22, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: category_listing; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY category_listing (id, listing_id, category_id) FROM stdin;
2662	1	10
2663	2	4
2664	2	12
2665	3	4
2666	4	5
2667	5	5
2668	5	9
2669	5	15
2670	6	7
2671	6	16
2672	7	3
2673	7	7
2674	8	5
2675	8	16
2676	9	6
2677	10	14
2678	11	6
2679	12	4
2680	13	8
2681	13	9
2682	13	14
2683	14	4
2684	15	5
2685	16	7
2686	16	16
2687	17	3
2688	17	12
2689	17	15
2690	18	10
2691	19	7
2692	19	16
2693	20	12
2694	20	15
2695	21	8
2696	21	12
2697	22	15
2698	23	8
2699	23	13
2700	24	5
2701	24	6
2702	24	9
2703	25	5
2704	26	3
2705	27	3
2706	28	4
2707	28	11
2708	28	15
2709	29	4
2710	29	12
2711	30	5
2712	30	15
2713	31	9
2714	32	4
2715	33	8
2716	34	5
2717	35	8
2718	36	9
2719	37	6
2720	37	9
2721	38	5
2722	38	15
2723	39	15
2724	40	3
2725	41	7
2726	41	16
2727	42	7
2728	42	16
2729	43	2
2730	43	3
2731	43	8
2732	43	12
2733	43	14
2734	43	15
2735	43	16
2736	44	7
2737	45	5
2738	46	2
2739	47	6
2740	48	15
2741	49	10
2742	50	10
2743	51	6
2744	52	15
2745	53	14
2746	54	6
2747	55	8
2748	56	4
2749	57	2
2750	57	5
2751	58	5
2752	58	15
2753	59	12
2754	59	15
2755	60	4
2756	60	12
2757	61	12
2758	61	15
2759	62	6
2760	63	3
2761	64	5
2762	65	7
2763	66	5
2764	66	8
2765	66	15
2766	67	16
2767	68	9
2768	69	9
2769	70	6
2770	71	5
2771	71	15
2772	72	6
2773	73	2
2774	74	3
2775	74	4
2776	74	12
2777	75	4
2778	75	12
2779	76	6
2780	77	7
2781	77	16
2782	78	6
2783	79	2
2784	80	9
2785	81	7
2786	81	16
2787	82	5
2788	82	15
2789	83	3
2790	84	5
2791	84	8
2792	85	6
2793	85	15
2794	86	4
2795	86	12
2796	87	5
2797	88	6
2798	89	5
2799	90	6
2800	91	5
2801	92	2
2802	92	5
2803	93	16
2804	94	5
2805	95	5
2806	95	15
2807	96	5
2808	96	15
2809	97	5
2810	97	15
2811	98	6
2812	99	9
2813	99	12
2814	99	15
2815	100	7
2816	100	16
2817	101	9
2818	102	12
2819	102	15
2820	103	6
2821	104	6
2822	105	6
2823	106	12
2824	107	6
2825	108	5
2826	108	15
2827	109	6
2828	110	5
2829	111	8
2830	112	5
2831	112	11
2832	113	6
2833	114	6
2834	115	5
2835	115	6
2836	116	12
2837	116	15
2838	117	4
2839	117	12
2840	117	15
2841	118	8
2842	119	4
2843	120	4
2844	120	11
2845	121	5
2846	122	5
2847	122	6
2848	122	11
2849	123	15
2850	124	5
2851	125	5
2852	126	6
2853	127	10
2854	128	15
2855	129	6
2856	130	3
2857	130	8
2858	130	11
2859	131	5
2860	132	5
2861	133	3
2862	133	12
2863	134	12
2864	135	7
2865	135	16
2866	136	7
2867	137	12
2868	137	15
2869	138	15
2870	139	4
2871	139	10
2872	139	12
2873	140	15
2874	141	6
2875	142	14
2876	143	5
2877	144	11
2878	145	7
2879	146	12
2880	146	14
2881	146	15
2882	147	7
2883	148	3
2884	148	6
2885	149	10
2886	150	2
2887	150	4
2888	150	15
2889	151	15
2890	152	5
2891	152	15
2892	153	3
2893	153	4
2894	153	14
2895	154	16
2896	155	16
2897	156	10
2898	157	5
2899	158	15
2900	159	6
2901	160	6
2902	161	2
2903	162	15
2904	163	6
2905	163	10
2906	164	15
2907	165	5
2908	166	4
2909	166	6
2910	166	10
2911	167	14
2912	168	10
2913	169	16
2914	170	12
2915	170	13
2916	171	4
2917	171	9
2918	171	15
2919	172	5
2920	173	7
2921	174	6
2922	175	10
2923	176	6
2924	177	5
2925	178	8
2926	179	6
2927	179	8
2928	180	5
2929	181	4
2930	182	6
2931	182	8
2932	183	6
2933	184	5
2934	184	6
2935	185	4
2936	186	5
2937	187	7
2938	187	16
2939	188	4
\.


--
-- Name: category_listing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('category_listing_id_seq', 2939, true);


--
-- Data for Name: contact_listing; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY contact_listing (id, listing_id, contact_id) FROM stdin;
502	2	26
503	2	8
504	8	1
505	22	25
506	23	8
507	26	30
508	26	21
509	26	12
510	27	12
511	30	17
512	32	17
513	37	7
514	38	17
515	43	9
516	47	3
517	55	11
518	58	17
519	66	17
520	68	2
521	68	29
522	68	22
523	69	24
524	69	6
525	69	18
526	74	28
527	74	21
528	74	12
529	82	17
530	87	3
531	91	3
532	95	17
533	96	17
534	97	17
535	108	3
536	121	3
537	122	3
538	132	25
539	141	31
540	148	20
541	148	32
542	148	4
543	148	23
544	148	13
545	152	17
546	163	15
547	168	27
548	168	10
549	168	19
550	172	3
551	180	3
552	181	3
553	186	3
\.


--
-- Name: contact_listing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('contact_listing_id_seq', 553, true);


--
-- Data for Name: corsheaders_corsmodel; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY corsheaders_corsmodel (id, cors) FROM stdin;
\.


--
-- Name: corsheaders_corsmodel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('corsheaders_corsmodel_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 1, false);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	contenttypes	contenttype
3	auth	permission
4	auth	user
5	auth	group
6	sessions	session
7	ozpcenter	imagetype
8	ozpcenter	intent
9	ozpcenter	image
10	ozpcenter	changedetail
11	ozpcenter	listingtype
12	ozpcenter	agency
13	ozpcenter	contact
14	ozpcenter	notificationmailbox
15	ozpcenter	notification
16	ozpcenter	category
17	ozpcenter	contacttype
18	ozpcenter	listingactivity
19	ozpcenter	recommendationfeedback
20	ozpcenter	docurl
21	ozpcenter	applicationlibraryentry
22	ozpcenter	review
23	ozpcenter	listing
24	ozpcenter	tag
25	ozpcenter	recommendationsentry
26	ozpcenter	screenshot
27	ozpcenter	subscription
28	ozpcenter	profile
29	ozpiwc	dataresource
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('django_content_type_id_seq', 29, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2017-09-19 13:24:57.963841-04
2	auth	0001_initial	2017-09-19 13:24:58.117409-04
3	admin	0001_initial	2017-09-19 13:24:58.176315-04
4	contenttypes	0002_remove_content_type_name	2017-09-19 13:24:58.247468-04
5	auth	0002_alter_permission_name_max_length	2017-09-19 13:24:58.270618-04
6	auth	0003_alter_user_email_max_length	2017-09-19 13:24:58.292833-04
7	auth	0004_alter_user_username_opts	2017-09-19 13:24:58.311647-04
8	auth	0005_alter_user_last_login_null	2017-09-19 13:24:58.334576-04
9	auth	0006_require_contenttypes_0002	2017-09-19 13:24:58.338339-04
10	ozpcenter	0001_initial	2017-09-19 13:25:00.241083-04
11	ozpcenter	0002_auto_20160310_1929	2017-09-19 13:25:00.558469-04
12	ozpcenter	0003_listing_is_deleted	2017-09-19 13:25:00.710399-04
13	ozpcenter	0004_auto_20160511_1653	2017-09-19 13:25:00.869346-04
14	ozpcenter	0005_notification_agency	2017-09-19 13:25:00.935022-04
15	ozpcenter	0006_notification__peer	2017-09-19 13:25:00.992468-04
16	ozpcenter	0007_auto_20160928_1858	2017-09-19 13:25:01.047661-04
17	ozpcenter	0008_auto_20160928_1904	2017-09-19 13:25:01.118737-04
18	ozpcenter	0009_applicationlibraryentry_position	2017-09-19 13:25:01.20577-04
19	ozpcenter	0010_auto_20170109_2128	2017-09-19 13:25:01.446019-04
20	ozpcenter	0011_recommendationsentry	2017-09-19 13:25:01.527136-04
21	ozpcenter	0012_auto_20170322_1309	2017-09-19 13:25:01.776036-04
22	ozpcenter	0013_notification_fill_migrate	2017-09-19 13:25:01.786775-04
23	ozpcenter	0014_notificationmailbox	2017-09-19 13:25:01.879343-04
24	ozpcenter	0015_notification_script	2017-09-19 13:25:01.887105-04
25	ozpcenter	0016_subscription	2017-09-19 13:25:01.97813-04
26	ozpcenter	0017_recommendationsentry_recommendation_data	2017-09-19 13:25:02.249217-04
27	ozpcenter	0018_screenshot_description	2017-09-19 13:25:02.32167-04
28	ozpcenter	0019_auto_20170417_2045	2017-09-19 13:25:02.380431-04
29	ozpcenter	0020_beta_group_script	2017-09-19 13:25:02.39192-04
30	ozpcenter	0021_screenshot_order	2017-09-19 13:25:02.46895-04
31	ozpcenter	0022_profile_email_notification_flag	2017-09-19 13:25:02.551063-04
32	ozpcenter	0023_auto_20170629_1323	2017-09-19 13:25:02.9152-04
33	ozpcenter	0024_auto_20170829_1944	2017-09-19 13:25:03.098218-04
34	ozpcenter	0025_listing_total_review_responses	2017-09-19 13:25:03.262684-04
35	ozpcenter	0026_auto_20170912_1524	2017-09-19 13:25:03.549174-04
36	ozpiwc	0001_initial	2017-09-19 13:25:03.607034-04
37	sessions	0001_initial	2017-09-19 13:25:03.643905-04
38	ozpcenter	0027_auto_20170919_1341	2017-09-27 12:35:04.702266-04
39	ozpcenter	0028_profile_leaving_ozp_warning_flag	2017-09-27 12:35:04.828703-04
40	ozpcenter	0029_auto_20170921_1342	2017-09-27 12:35:04.911325-04
41	ozpcenter	0030_recommendationfeedback	2017-09-27 12:35:04.997945-04
42	admin	0002_logentry_remove_auto_add	2017-10-18 15:08:34.692145-04
43	auth	0007_alter_validators_add_error_messages	2017-10-18 15:08:34.710188-04
44	auth	0008_alter_user_username_max_length	2017-10-18 15:08:34.743034-04
45	ozpcenter	0031_notification_notification_subtype	2017-10-18 15:08:34.814346-04
46	ozpcenter	0032_listing_feedback_score	2017-10-18 15:08:34.930798-04
47	ozpcenter	0033_auto_20171027_1948	2017-11-08 17:31:47.59887-05
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('django_migrations_id_seq', 47, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: intent_listing; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY intent_listing (id, listing_id, intent_id) FROM stdin;
\.


--
-- Name: intent_listing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('intent_listing_id_seq', 1, false);


--
-- Data for Name: listing_activity_change_detail; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY listing_activity_change_detail (id, listingactivity_id, changedetail_id) FROM stdin;
\.


--
-- Name: listing_activity_change_detail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('listing_activity_change_detail_id_seq', 5, true);


--
-- Data for Name: notification_profile; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY notification_profile (id, notification_id, profile_id) FROM stdin;
\.


--
-- Name: notification_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('notification_profile_id_seq', 1, false);


--
-- Data for Name: ozpcenter_agency; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_agency (id, title, short_name, icon_id) FROM stdin;
1	Ministry of Truth	Minitrue	2
2	Ministry of Peace	Minipax	3
3	Ministry of Love	Miniluv	4
4	Ministry of Plenty	Miniplen	5
5	Test	Test	6
6	Test 1	Test 1	7
7	Test 2	Test2	8
8	Test 3	Test 3	9
9	Test 4	Test 4	10
\.


--
-- Name: ozpcenter_agency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_agency_id_seq', 9, true);


--
-- Data for Name: ozpcenter_applicationlibraryentry; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_applicationlibraryentry (id, folder, listing_id, owner_id, "position") FROM stdin;
1	Instruments	1	1	10
2	old	2	5	0
3	\N	2	11	0
4	\N	9	15	0
5	planets	9	5	8
6	\N	10	4	0
7	\N	10	5	4
8	\N	14	13	0
9	\N	18	4	1
10	Beverages	21	4	5
11	old	23	5	1
12	\N	23	1	15
13	\N	29	1	18
14	\N	30	11	0
15	\N	30	1	20
16	\N	44	5	2
17	\N	47	3	0
18	Instruments	49	1	9
19	Instruments	50	1	12
20	\N	59	1	19
21	\N	63	5	3
22	\N	68	3	0
23	\N	69	3	0
24	\N	70	3	0
25	Beverages	72	4	6
26	\N	73	1	16
27	Funny	76	4	3
28	heros	77	5	5
29	heros	81	5	6
30	\N	82	11	0
31	\N	87	13	0
32	Animals	87	1	4
33	\N	90	13	0
34	Weather	93	1	1
35	Animals	94	1	5
36	\N	96	11	0
37	Funny	101	4	2
38	heros	101	5	7
39	Games	103	4	8
40	Animals	108	1	6
41	Games	115	4	7
42	\N	116	15	0
43	Animals	122	1	7
44	Instruments	127	1	13
45	planets	147	5	9
46	\N	148	4	4
47	Weather	154	1	2
48	Instruments	156	1	11
49	\N	158	1	17
50	Weather	169	1	0
51	Instruments	175	1	14
52	Animals	180	1	8
53	\N	186	3	0
54	Animals	186	1	3
\.


--
-- Name: ozpcenter_applicationlibraryentry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_applicationlibraryentry_id_seq', 54, true);


--
-- Data for Name: ozpcenter_category; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_category (id, title, description) FROM stdin;
1	Accessories	Accessories Description
2	Books and Reference	Things made of paper
3	Business	For making money
4	Communication	Moving info between people and things
5	Education	Educational in nature
6	Entertainment	For fun
7	Finance	For managing money
8	Health and Fitness	Be healthy, be fit
9	Media and Video	Videos and media stuff
10	Music and Audio	Using your ears
11	News	What's happening where
12	Productivity	Do more in less time
13	Shopping	For spending your money
14	Sports	Score more points than your opponent
15	Tools	Tools and Utilities
16	Weather	Get the temperature
\.


--
-- Name: ozpcenter_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_category_id_seq', 16, true);


--
-- Data for Name: ozpcenter_changedetail; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_changedetail (id, field_name, old_value, new_value) FROM stdin;
\.


--
-- Name: ozpcenter_changedetail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_changedetail_id_seq', 1, false);


--
-- Data for Name: ozpcenter_contact; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_contact (id, secure_phone, unsecure_phone, email, name, organization, contact_type_id) FROM stdin;
1	741-774-7414	\N	a@b.com	A B	\N	1
2	741-774-7414	965-8569	cersei@gmail.com	Cersei	Default	1
3	741-774-7414	666-555-5555	gsmith@science.com	Dr. George Smith	Organization for animal heath	1
4	741-774-7414	666-7774	riderhard@mine.net	HOF	HOG2	1
5	741-774-7414	555-1212	smokinaces@mine.net	Joe Dirt	Smokin Aces	1
6	741-774-7414	854-8569	johnsnow@gmail.com	John Snow	Default	1
7	741-774-7414	784-1548	silentbob@clerks.com	Kevin Smith	Default	1
8	741-774-7414	321-123-7894	osha@stark.com	Osha	House Stark	1
9	741-774-7414	555-555-5555	r@s.com	P Scale	\N	1
10	741-774-7414	784-1548	scott@stp.com	Scott	Default	1
11	741-774-7414	\N	Tyler@fc.com	Tyler	\N	1
12	741-774-7414	555-555-5555	w@s.com	W Smith	Default	1
13	741-774-7414	202-5555	willieg@mustride.net	Willie G	\N	1
14	741-774-7414	784-1548	no@gmail.com	someguy	someplace	1
15	741-774-7414	123-456-7890	chris@sound.com	Chris	Default	2
16	741-774-7414	555-1212	riderdie@mustride.net	Frank Beans	Ride r' Die	2
17	741-774-7414	123-456-7890	rbaratheon@baratheon.com	Robert Baratheon	House Baratheon	2
18	741-774-7414	652-5236	sansa@gmail.com	Sansa	Default	2
19	741-774-7414	784-1548	scott@vr.com	Scott	Default	2
20	741-774-7414	666-1111	goodtogo@my.net	Slippery Wen Wet	HOG	2
21	741-774-7414	555-555-5555	t@t.com	Tammy	Default	2
22	741-774-7414	632-5236	tyrion@gmail.com	Tyrion Lannister	Default	2
23	741-774-7414	555-1212	willie.g@hog.net	willie g	HOG	2
24	741-774-7414	856-9632	arya@gmail.com	Arya	Default	3
25	741-774-7414	\N	bowsers@castle.com	Bowser	\N	3
26	741-774-7414	222-324-3846	brienne@stark.com	Brienne Tarth	House Stark	3
27	741-774-7414	784-1548	chester@lp.com	Chester	Default	3
28	741-774-7414	555-555-5555	d@d.com	Donald Duck	\N	3
29	741-774-7414	523-5547	jamie@gmail.com	Jamie Lannister	Default	3
30	741-774-7414	555-555-5555	m@m.com	M Smith	Default	3
31	741-774-7414	\N	mario@plumbersinc.com	Mario	\N	3
32	741-774-7414	555-6666	mustride@aka.net	Must Ride	HOG	3
33	741-774-7414	555-1212	HOG@miniture.net	Willie G	HOG	3
\.


--
-- Name: ozpcenter_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_contact_id_seq', 33, true);


--
-- Data for Name: ozpcenter_contacttype; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_contacttype (id, name, required) FROM stdin;
1	Civilian	f
2	Government	f
3	Military	f
\.


--
-- Name: ozpcenter_contacttype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_contacttype_id_seq', 3, true);


--
-- Data for Name: ozpcenter_docurl; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_docurl (id, name, url, listing_id) FROM stdin;
1	guide	http://www.google.com/guide	2
2	wiki	http://www.google.com/wiki	2
3	https://en.wikipedia.org/wiki/Smoking_(cooking)	https://en.wikipedia.org/wiki/Spice_rub	11
4	https://en.wikipedia.org/wiki/Worm_charming	https://en.wikipedia.org/wiki/Soft_plastic_bait	15
5	https://en.wikipedia.org/wiki/List_of_whisky_brands#Bourbon	https://en.wikipedia.org/wiki/Moonshine	21
6	Wiki	https://en.wikipedia.org/wiki/Fiat_525	54
7	https://en.wikipedia.org/wiki/Finnish_Museum_of_Horology	https://en.wikipedia.org/wiki/Striking_clock	63
8	https://en.wikipedia.org/wiki/Corn_whiskey	https://en.wikipedia.org/wiki/Moonshine_in_popular_culture	109
9	Wiki	https://en.wikipedia.org/wiki/Buff-faced_pygmy_parrot	121
10	https://en.wikipedia.org/wiki/Golf_club	https://en.wikipedia.org/wiki/Super_Swing_Golf	160
\.


--
-- Name: ozpcenter_docurl_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_docurl_id_seq', 10, true);


--
-- Data for Name: ozpcenter_image; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_image (id, uuid, security_marking, file_extension, image_type_id) FROM stdin;
1	0b5e33ed-fe78-4f67-bc60-8f511bd0fe05	UNCLASSIFIED	png	3
2	c3ca23ee-c232-4dc0-b8f6-fee40691ffce	UNCLASSIFIED	jpg	1
3	62dbd9bb-bd1d-43c7-997d-2b21a3a90979	UNCLASSIFIED	png	1
4	5ed07b4f-f9e0-4409-9dd7-de765e2f5b7a	UNCLASSIFIED	jpeg	1
5	4f88865c-0c8b-4755-8e4c-8a30f4d03571	UNCLASSIFIED	png	1
6	f10fe522-c17b-4ef8-9f20-ccabb89a406e	UNCLASSIFIED	png	1
7	fc71983a-1c0a-49b1-9987-5b763f7e4ffd	UNCLASSIFIED	png	1
8	1bd78eda-b72b-40d1-ab15-bfa14cc634c8	UNCLASSIFIED	png	1
9	ccd27006-f916-4475-8c09-31d3647c499f	UNCLASSIFIED	png	1
10	9f5e43b8-e6ec-4421-8f25-25b41f119639	UNCLASSIFIED	png	1
11	a84e5fce-2c9b-4c53-97ae-084e3a20aa41	UNCLASSIFIED	jpeg	7
12	7057783b-c461-4cf5-8c47-4acb2466eb94	UNCLASSIFIED	jpeg	5
13	ad4f7126-adf9-4d8c-882e-27023e6c2978	UNCLASSIFIED	jpeg	2
14	864fdbeb-3814-4afb-84e6-802e838675fc	UNCLASSIFIED	jpeg	4
15	ab5cf1e1-4fdc-4197-a3d6-656d6cce6939	UNCLASSIFIED	png	7
16	4c1e354c-dfc6-4a6a-a796-1edf934e1496	UNCLASSIFIED	png	5
17	bf98e701-9fdc-40f0-a2d9-b429848093cc	UNCLASSIFIED	png	2
18	9ce16879-abb5-4011-9768-f33e44cc7cf1	UNCLASSIFIED	png	4
19	435cadc0-d89f-42ae-a8b7-955f25f631eb	UNCLASSIFIED	jpeg	7
20	475eaf95-2e01-4692-92ab-5b20eaf5e3d9	UNCLASSIFIED	jpeg	5
21	c9c1dfd8-b576-42e8-958d-b1949bf924cc	UNCLASSIFIED	jpeg	2
22	86ead58c-9d4e-4030-913e-1764e72ec7eb	UNCLASSIFIED	jpeg	4
23	2d7a4467-99a3-4f0b-91ea-9f9e792e7fc2	UNCLASSIFIED	jpeg	7
24	586d787b-b0d9-42a2-a0c7-ebb01579b6e7	UNCLASSIFIED	jpeg	5
25	de0a46cd-c406-419e-94f1-22d120c3ce46	UNCLASSIFIED	jpeg	2
26	7dc5c0f9-2c0d-4b3f-a9b5-444ca0e3296a	UNCLASSIFIED	jpeg	4
27	3c2d8a1a-5d98-4ef4-8b45-d5f449025be0	UNCLASSIFIED	jpeg	7
28	7be6e5a4-47c6-49af-947b-7f0fc3695c6f	UNCLASSIFIED	jpeg	5
29	64143723-d22a-411b-b227-95370c3c211a	UNCLASSIFIED	jpeg	2
30	76f78f10-c27e-48e3-8a37-464daa91a68c	UNCLASSIFIED	jpeg	4
31	57827dbd-3257-44c3-8607-b43aea45b5fd	UNCLASSIFIED	png	7
32	8e89a8d7-4a4c-46e9-a747-44900ef052af	UNCLASSIFIED	png	5
33	54a9aad8-3e30-4adc-a6f8-022ce4b00446	UNCLASSIFIED	png	2
34	7b90786e-39da-4003-8957-b22b33ab5c3e	UNCLASSIFIED	png	4
35	b2c10810-9d4b-4f76-bc08-f5b602824d06	UNCLASSIFIED	png	7
36	318aa4a0-6e92-40ee-ab79-21756c49e3aa	UNCLASSIFIED	png	5
37	b6e01be9-dbeb-4bef-a8a4-0e7cd9b45b2e	UNCLASSIFIED	png	2
38	a84c8a2a-fb3f-4deb-a335-747931ada01e	UNCLASSIFIED	png	4
39	917f5749-8783-4a36-b429-e99c1ad2c1b8	UNCLASSIFIED	png	7
40	8a78bb43-12a1-4e2c-b658-eb54a8564598	UNCLASSIFIED	png	5
41	f3b8a0ed-34bc-4d80-a5da-67ff3f6e38e2	UNCLASSIFIED	png	2
42	043dc71d-a6a8-4ccd-bcbb-5b517af48b34	UNCLASSIFIED	png	4
43	3bd79df5-03c2-4de9-945a-27983cfe7c87	UNCLASSIFIED	jpeg	7
44	76fa26fc-4d03-4dc7-bd71-a24b75eab473	UNCLASSIFIED	jpeg	5
45	3a059dfa-b8cf-41da-965f-dc9e6d32c2f2	UNCLASSIFIED	jpeg	2
46	2ed0a3f5-62bd-458d-ac9e-ea2dbda7d601	UNCLASSIFIED	jpeg	4
47	fc065cec-8470-4164-abd7-aa21378294bf	UNCLASSIFIED	png	7
48	cacde2ad-261b-4b4d-80c0-6f797de116be	UNCLASSIFIED	png	5
49	f7d6f793-7a83-4a1e-866c-d822070c7edb	UNCLASSIFIED	png	2
50	dd9c4a31-361f-41af-91b9-e428ec34b41d	UNCLASSIFIED	png	4
51	bc9f8286-6531-439a-944c-a1e22e367f7a	UNCLASSIFIED	jpeg	7
52	44e0f3ac-6f93-4649-90a3-50ddee0d2da4	UNCLASSIFIED	jpeg	5
53	258a8fe3-3b5e-4a59-b9fc-b94c3238d479	UNCLASSIFIED	jpeg	2
54	f9cda18c-724f-4ab4-ac0a-691c7e379e6e	UNCLASSIFIED	jpeg	4
55	07f62ea7-92ee-459a-a0df-3cd5809297ec	UNCLASSIFIED	jpeg	7
56	c0433d65-18f8-437c-8e00-92d9306a2537	UNCLASSIFIED	jpeg	5
57	35119ed0-9bb7-4d68-8eb3-8ff233e5f2c9	UNCLASSIFIED	jpeg	2
58	02684cd0-2070-4160-ad5b-a2cb9ca1a2e4	UNCLASSIFIED	jpeg	4
59	d9cf799a-5125-41da-bdf8-79ee2f58fab8	UNCLASSIFIED	jpeg	7
60	ed40a4e0-c779-4dcc-9d75-0279ee78e783	UNCLASSIFIED	jpeg	5
61	206c53a3-c035-40af-8e29-d0f83587977b	UNCLASSIFIED	jpeg	2
62	34b7e434-bc90-4ad3-b100-eb08ddfb248f	UNCLASSIFIED	jpeg	4
63	68f7b172-f8e2-46e0-b936-8360d875f503	UNCLASSIFIED	jpeg	7
64	c657bc5e-77af-442a-a296-e69e7c545bbf	UNCLASSIFIED	jpeg	5
65	18f52e8b-2d85-44e4-bd74-3922905374cc	UNCLASSIFIED	jpeg	2
66	62a876ac-cb09-4076-bab3-7755cbb2fdcc	UNCLASSIFIED	jpeg	4
67	acd17c0d-80f1-4ab7-8e8f-ec09786a3383	UNCLASSIFIED	png	7
68	f9a484ac-270b-4856-b71c-6f648a0a8f8f	UNCLASSIFIED	png	5
69	7f3091e9-4d9e-47d2-b54d-684e405ae8db	UNCLASSIFIED	png	2
70	a3e8d011-9f6f-4c84-a6bb-6a1a3791b169	UNCLASSIFIED	png	4
71	1bcb15ba-ef01-4e6c-931c-05e153b4cf74	UNCLASSIFIED	jpeg	7
72	717952c7-d671-4e35-99a2-8b1a39deae57	UNCLASSIFIED	jpeg	5
73	3c314f68-5069-4017-bb86-f8f623bf1370	UNCLASSIFIED	jpeg	2
74	7e4e8074-3be2-4f58-ab6d-5d013f3f8379	UNCLASSIFIED	jpeg	4
75	2afe2bde-64ce-42b4-9711-67283f10dbc3	UNCLASSIFIED	jpeg	7
76	cec15b59-5639-49d2-824a-6c634ed36de1	UNCLASSIFIED	jpeg	5
77	316a1a8a-94c0-4edd-9f08-fdc47bf53918	UNCLASSIFIED	jpeg	2
78	ea642a69-3fff-40a2-9ade-bdcaf95de036	UNCLASSIFIED	jpeg	4
79	a4bb71dc-8e32-4669-9cd2-60e4bd3f836a	UNCLASSIFIED	jpeg	7
80	700f07f8-90de-442e-b5ef-a56396fc0ed4	UNCLASSIFIED	jpeg	5
81	ea2f7889-110a-4087-9707-a18ae49ff211	UNCLASSIFIED	jpeg	2
82	5d920319-2fcf-4cd7-921d-f6b737cd2b20	UNCLASSIFIED	jpeg	4
83	e19787ce-6183-4152-9fc3-5bb57b4b0f52	UNCLASSIFIED	jpeg	7
84	6f2cde3f-4632-495f-88ac-8b781ded5f13	UNCLASSIFIED	jpeg	5
85	7ae3451c-b27d-429a-b96c-c48a9a486155	UNCLASSIFIED	jpeg	2
86	b2efa68a-2d72-4a73-8678-2071bec4a52e	UNCLASSIFIED	jpeg	4
87	6bd63726-cec9-4a14-95e0-9d1fd9318c97	UNCLASSIFIED	jpeg	7
88	bb441a42-6b51-4cee-9aea-2657b9573b04	UNCLASSIFIED	jpeg	5
89	262b2e36-5424-412f-ac52-ad14c9feb849	UNCLASSIFIED	jpeg	2
90	3f0a6cc8-fbfd-4f5c-8bef-18847a096b92	UNCLASSIFIED	jpeg	4
91	7b97fa80-6c8c-408a-9761-da35005c0687	UNCLASSIFIED	jpeg	7
92	0038ba97-50ef-4741-9563-b35ed7d35e26	UNCLASSIFIED	jpeg	5
93	24c081d9-482b-40a9-9a0b-c648262b0b75	UNCLASSIFIED	jpeg	2
94	c571ac1f-d802-4f66-8780-c6d2c2498a9d	UNCLASSIFIED	jpeg	4
95	20aea72b-0d40-4f0e-9e0b-6bb8de80f3aa	UNCLASSIFIED	png	7
96	f4006d0f-8f7b-4086-ae43-b08501bfac4e	UNCLASSIFIED	png	5
97	013ee18d-703e-4f2a-bbbf-725fa5d90888	UNCLASSIFIED	png	2
98	4f974b7f-75f8-45c4-a3a1-a4d858fd40df	UNCLASSIFIED	png	4
99	1feabc14-1cb3-453b-918d-a274235a6454	UNCLASSIFIED	png	7
100	25a62d5b-f828-423e-a1b1-81550f54cdb0	UNCLASSIFIED	png	5
101	a3914870-5d8a-4f88-9ed3-c5f873afad7c	UNCLASSIFIED	png	2
102	adfe5622-7d95-4fa1-b03c-0825f698e9f1	UNCLASSIFIED	png	4
103	95c3bde7-6222-464b-8077-4e529b58795d	UNCLASSIFIED	jpeg	7
104	9e102bd3-8bec-43b7-876a-0bcea30d0280	UNCLASSIFIED	jpeg	5
105	d2994e5e-a774-43a0-8c18-9f3efa43225e	UNCLASSIFIED	png	2
106	7cc5bbf9-03a1-41ea-85ce-e92519604e07	UNCLASSIFIED	jpeg	4
107	3bd421d6-89c1-4371-aca9-fe4362a20057	UNCLASSIFIED	jpeg	7
108	6b0a79cd-6d7e-43fe-b402-cbe6654ccda3	UNCLASSIFIED	jpeg	5
109	899d9da4-ae7f-41eb-aab8-e78dede21c16	UNCLASSIFIED	jpeg	2
110	bebc7500-fe15-4bdf-ad06-764fd52f024c	UNCLASSIFIED	jpeg	4
111	2007d643-da86-4612-b7f1-713d52a24b46	UNCLASSIFIED	png	7
112	3ef91d53-1835-4fe8-b5bd-4c71ada8a472	UNCLASSIFIED	png	5
113	44d5a1d5-1d29-47c1-9565-3c460963f3c7	UNCLASSIFIED	png	2
114	4a6d0a35-5086-4f40-b454-e77305c7770e	UNCLASSIFIED	png	4
115	506a4c09-7ac6-4b90-92a8-36ea8ee964ae	UNCLASSIFIED	png	7
116	daad28a5-f1b0-4f4d-a357-e6e61c699c1d	UNCLASSIFIED	png	5
117	ea26b6aa-d450-478f-b235-20587d90a272	UNCLASSIFIED	png	2
118	9ed1fc0e-23be-4519-896b-00d5a7a03b30	UNCLASSIFIED	png	4
119	c4ef326c-66b1-4fa7-b57d-d71b90aaf7ee	UNCLASSIFIED	jpeg	7
120	eb8c0295-fb8b-4610-ac38-8cd2881855d7	UNCLASSIFIED	jpeg	5
121	12d59c54-0203-465f-be9a-03574518c5a2	UNCLASSIFIED	jpeg	2
122	c8a0507d-8676-41a3-9949-8c107b5c18bb	UNCLASSIFIED	jpeg	4
123	d8280df6-4f06-4063-ba01-c0dd5fd75d66	UNCLASSIFIED	jpeg	7
124	4b641f18-0e84-4e81-a7e0-50859843b853	UNCLASSIFIED	jpeg	5
125	f5cf22e9-a1ee-4ceb-bfbe-7a86c7106dca	UNCLASSIFIED	jpeg	2
126	ceb00c8a-c9bf-48ab-87b4-a3b658baaa2b	UNCLASSIFIED	jpeg	4
127	8f33e8ac-f1d3-48b3-83da-e73386f72cc2	UNCLASSIFIED	png	7
128	667e2953-cb11-4ff8-8318-5ffd7f9a0a7e	UNCLASSIFIED	png	5
129	10198905-32f2-4e2b-b8ef-8bab80e806d0	UNCLASSIFIED	png	2
130	0ddcad60-93d7-4d9b-a89c-69435b931d02	UNCLASSIFIED	png	4
131	5bd76698-db84-48fb-ba74-5fa6a1ff5b14	UNCLASSIFIED	jpeg	7
132	8c3d311d-539b-4810-90fe-9ef1cabd27f3	UNCLASSIFIED	jpeg	5
133	90b27149-0c0d-4191-bae9-7dbd1bd2c7d8	UNCLASSIFIED	jpeg	2
134	89fa7607-912d-4bff-8c4f-69b729f8d26e	UNCLASSIFIED	jpeg	4
135	560db2a2-33ed-41f8-8839-c8b28fba7218	UNCLASSIFIED	png	7
136	ea64da81-1d02-4b88-9a36-55fd1b9f8733	UNCLASSIFIED	png	5
137	996081b2-7e58-499b-9b9d-676dd6d0e987	UNCLASSIFIED	png	2
138	e7eb97cf-afe9-47f1-85b9-fa27c24b76d0	UNCLASSIFIED	png	4
139	c643f021-97d1-4d20-b283-16a76bb08ee4	UNCLASSIFIED	jpeg	7
140	8e26aedf-8798-4516-a390-62603302bece	UNCLASSIFIED	jpeg	5
141	e98f6f56-13ee-45b3-a237-b979219c7e62	UNCLASSIFIED	jpeg	2
142	9362015b-1c63-43b8-bbea-8b9d485a3041	UNCLASSIFIED	jpeg	4
143	829d01c5-93df-4638-9fe6-3eee5c7000da	UNCLASSIFIED	jpeg	7
144	fb36ab4b-9df2-4a77-9702-973929aa8b12	UNCLASSIFIED	jpeg	5
145	86ba92cd-aa8e-4d4f-a9f3-f3d1f50b71b2	UNCLASSIFIED	jpeg	2
146	f4e09e54-aeea-47c9-b58b-713f8c939d09	UNCLASSIFIED	jpeg	4
147	9cf1557f-4cc9-4199-9694-0388e30e5576	UNCLASSIFIED	jpeg	7
148	d880d774-ed22-4d97-acb1-66d60edeba85	UNCLASSIFIED	jpeg	5
149	8c48a5d8-ac2b-4351-8e95-acd3d1ce185d	UNCLASSIFIED	jpeg	2
150	8edcad2d-6ce7-4dfe-bf7b-ded7d6227315	UNCLASSIFIED	jpeg	4
151	42cb3a5f-ba1d-4a36-9759-779d1e50184b	UNCLASSIFIED	jpeg	7
152	018bc86e-d07d-4e56-8c3e-0863db5eb180	UNCLASSIFIED	jpeg	5
153	d5f857d9-b094-4a94-aba6-194bdaadd620	UNCLASSIFIED	jpeg	2
154	6d1bd684-cce1-4192-9c52-074fd45d97c0	UNCLASSIFIED	jpeg	4
155	9093f975-03ee-4d65-8b6d-1c1ff727d90b	UNCLASSIFIED	jpeg	7
156	c8a252b3-acdb-4ae2-9eb0-9958bd6d5ad1	UNCLASSIFIED	jpeg	5
157	7523b476-e06e-4153-a99e-35700038674d	UNCLASSIFIED	jpeg	2
158	0e31e397-d39e-4486-bc06-a9bfb7fa904a	UNCLASSIFIED	jpeg	4
159	90c442fc-b363-447d-bd61-caf15f67eefb	UNCLASSIFIED	png	7
160	342a1bc3-fb1d-4858-b054-e51185ec3ce3	UNCLASSIFIED	png	5
161	a4a0eeb6-9b05-4061-905e-97ea32def31c	UNCLASSIFIED	png	2
162	c4da51e2-ca00-4a50-9fb9-7b653037d527	UNCLASSIFIED	png	4
163	c7665a6b-2278-4338-ad78-4877729f6046	UNCLASSIFIED	png	7
164	e283203e-e634-4037-947d-5c8f66706ab1	UNCLASSIFIED	png	5
165	cbc8f4da-3107-47e5-bebf-3343ac545f06	UNCLASSIFIED	png	2
166	9ceb00e7-debb-4010-9ac7-f6afa56aa913	UNCLASSIFIED	png	4
167	be5c927f-de31-483a-a4d4-7c926b826057	UNCLASSIFIED	jpeg	7
168	64b27c88-1760-4dcd-b8af-2f5c10b3c924	UNCLASSIFIED	jpeg	5
169	82677434-9b41-4b30-a785-342803d12387	UNCLASSIFIED	jpeg	2
170	316cc45c-1286-44d0-aa94-895e9ba6d1d9	UNCLASSIFIED	jpeg	4
171	8890c817-4de5-41b2-865b-3e0a38b075c2	UNCLASSIFIED	jpeg	7
172	b932c603-f201-4e34-844f-22aca2d6f553	UNCLASSIFIED	jpeg	5
173	77b867da-c69d-4592-bef7-ad893e35f3c6	UNCLASSIFIED	jpeg	2
174	25ccf72d-ec43-44e6-a727-45479a4ab772	UNCLASSIFIED	jpeg	4
175	4ea1ad71-b162-4447-ab4f-b288afff601f	UNCLASSIFIED	png	7
176	8592065f-dd84-4e5f-8cd5-061940e932ee	UNCLASSIFIED	png	5
177	b6b8c609-9fec-4697-b6c6-56626ea88212	UNCLASSIFIED	png	2
178	422bcaf3-d707-41e5-afb9-c4d122f7b9a8	UNCLASSIFIED	png	4
179	aee69dc3-6b99-4cab-91d3-31a5ca3f6225	UNCLASSIFIED	png	7
180	3b92d6d6-2534-4d61-9043-26975053c8b1	UNCLASSIFIED	png	5
181	c949caef-6921-44ed-aea2-29b58f611d93	UNCLASSIFIED	png	2
182	5e4ea714-fd7a-4c72-ae9b-f4ea14bbcfdf	UNCLASSIFIED	png	4
183	59f2d028-c91a-43c2-b5cd-b207926816a0	UNCLASSIFIED	png	7
184	e2319cd2-1f9d-4276-9a2d-be1dca271e16	UNCLASSIFIED	png	5
185	3c535e1c-3a84-4018-a03b-de664d0e317f	UNCLASSIFIED	jpeg	2
186	da33793d-a033-4f71-ae2d-51524bc6aced	UNCLASSIFIED	jpeg	4
187	febe4b57-559c-41e5-aef3-5fc75409b76e	UNCLASSIFIED	jpeg	7
188	2f80a7a0-5911-4dab-8449-38a49a25c4bf	UNCLASSIFIED	jpeg	5
189	aaf3d890-63e2-4d40-ba98-a945a527c95c	UNCLASSIFIED	jpeg	2
190	e17ffb93-da70-495d-97ed-ea7c645bb902	UNCLASSIFIED	jpeg	4
191	24cc3d23-abe2-4f46-9f71-5a433713d567	UNCLASSIFIED	jpeg	7
192	683d5cf2-7777-413e-be0c-ca63842066a7	UNCLASSIFIED	jpeg	5
193	67be55cd-dbca-40db-badb-5422d315d133	UNCLASSIFIED	jpeg	2
194	b183a66d-0227-4772-8f52-8ab237fc5229	UNCLASSIFIED	jpeg	4
195	baa83c95-434c-42d0-a804-756b5b07b3c7	UNCLASSIFIED	png	7
196	0abc7dd9-52f7-427b-9713-aaad1d35f15a	UNCLASSIFIED	png	5
197	32c2c3a6-d2fe-4734-804b-1ccf562767fa	UNCLASSIFIED	jpeg	2
198	8b1c372c-c203-474d-8f7b-ea9492b1a26f	UNCLASSIFIED	jpeg	4
199	f4de2ab4-1abe-4771-ab6b-71ed434ba9e8	UNCLASSIFIED	png	7
200	1aebd773-dca3-4197-a036-cb13b4609d1e	UNCLASSIFIED	png	5
201	b8dc7234-0baf-46b0-a22b-1f5a079a02d6	UNCLASSIFIED	png	2
202	fd5c2711-53c9-4e30-ab17-5c22b8c44dee	UNCLASSIFIED	png	4
203	f80a25b1-dc30-4b67-9095-acf9dd561077	UNCLASSIFIED	jpeg	7
204	8b842965-33dd-415c-af65-c4140f529bba	UNCLASSIFIED	jpeg	5
205	e9263be8-dca5-4d44-845e-95165d8451b3	UNCLASSIFIED	jpeg	2
206	14b0fdf5-2891-44f5-8eda-c0dfd88311cf	UNCLASSIFIED	jpeg	4
207	9fc80e6c-010d-4a52-9ede-a8db84875df4	UNCLASSIFIED	jpeg	7
208	e67d7b73-cc5a-445a-a85b-961128b333dc	UNCLASSIFIED	jpeg	5
209	effd2420-975f-4408-a8f6-a308866bb71b	UNCLASSIFIED	jpeg	2
210	10f92bf9-38ce-4188-848e-d2c2bd985224	UNCLASSIFIED	jpeg	4
211	2bce267e-db5c-48f3-a47c-5e727e355f59	UNCLASSIFIED	jpeg	7
212	3d888adf-edc3-47e1-bc8c-2e3fbf018e64	UNCLASSIFIED	jpeg	5
213	defd05e1-cfa5-4267-b223-8dc30a804b79	UNCLASSIFIED	jpeg	2
214	9c4418d6-eeb5-4f91-84d2-5fadbb952324	UNCLASSIFIED	jpeg	4
215	ef21e20e-67ef-4556-9419-7721661ca718	UNCLASSIFIED	jpeg	7
216	6e09e158-1574-47b4-9f38-dbb81e938369	UNCLASSIFIED	jpeg	5
217	637d1031-d147-47d2-b831-f07b8cbe44e8	UNCLASSIFIED	jpeg	2
218	a8ba163e-64e9-4b00-a36a-d29b7ecea059	UNCLASSIFIED	jpeg	4
219	698991dc-f3e9-441b-a2b3-9030ea8837aa	UNCLASSIFIED	png	7
220	3a186d92-97db-4e76-bdbb-9e6ee9d03a32	UNCLASSIFIED	png	5
221	bb4a14b3-3a19-4cf0-a620-65958bef9e70	UNCLASSIFIED	png	2
222	4b5a1bf4-521c-4eab-88c2-a7462a7699cf	UNCLASSIFIED	png	4
223	320242af-6d95-4b9d-9686-c3a9e4d30e3a	UNCLASSIFIED	jpeg	7
224	d89bf80c-b587-40a3-82ff-d0a25a8ffbbb	UNCLASSIFIED	jpeg	5
225	001e552a-290b-4831-bdd5-4b1510390ab1	UNCLASSIFIED	jpeg	2
226	a4e42e2a-4115-4ecf-b723-1d2f1787fd08	UNCLASSIFIED	jpeg	4
227	50988f1d-7d0d-48e6-bb14-347ec8c95b78	UNCLASSIFIED	jpeg	7
228	1d6bbae2-1b4e-4130-95c9-234674dacd04	UNCLASSIFIED	jpeg	5
229	898aa0ee-1479-43ef-a97a-791352d0874f	UNCLASSIFIED	jpeg	2
230	41f4c61d-36dc-4bfe-93a3-3629d8ef06d9	UNCLASSIFIED	jpeg	4
231	d623b0bb-0ac9-4733-8ce6-be8f8631777a	UNCLASSIFIED	jpeg	7
232	7da54295-9c86-432e-af8e-97da8b57a79a	UNCLASSIFIED	jpeg	5
233	013d8f47-ad4b-4aab-b3e3-52bc2cda4825	UNCLASSIFIED	jpeg	2
234	eb8a11fd-73d3-4001-a415-bd141c82c27b	UNCLASSIFIED	jpeg	4
235	fdee5127-45b2-4d6e-91a1-bce78335a762	UNCLASSIFIED	jpeg	7
236	7cf70d8d-c09c-4d76-90dc-d21de82c1989	UNCLASSIFIED	jpeg	5
237	bc839e58-736c-4c98-bd50-7d40c7d5e99b	UNCLASSIFIED	jpeg	2
238	27312fd2-3903-4000-b2f9-555b62dfca76	UNCLASSIFIED	jpeg	4
239	1d75c377-682f-4339-b0c8-ed1c8539fa51	UNCLASSIFIED	png	7
240	17e528dc-63b4-4623-b372-9dbdcd31a186	UNCLASSIFIED	png	5
241	8cfd5091-2ea1-43c4-9636-64b07f592ca7	UNCLASSIFIED	png	2
242	b69571cf-1e41-430d-9d88-721a4ffcc97d	UNCLASSIFIED	png	4
243	27ad7811-4aee-40df-a74b-e38b8cab2c02	UNCLASSIFIED	jpeg	7
244	7a1e8beb-cd65-4f78-8fe8-52650c92e2ad	UNCLASSIFIED	jpeg	5
245	9328facd-6ec3-4294-a5ec-9d9f6d53e957	UNCLASSIFIED	png	2
246	f163b086-a232-4476-8f16-b848032b0ec8	UNCLASSIFIED	jpeg	4
247	cdcdc5c6-8e70-4a7f-9bcd-2eb6feef6808	UNCLASSIFIED	jpeg	7
248	b0ae0a19-f87a-4f49-93ca-ad909b15c74c	UNCLASSIFIED	jpeg	5
249	53cdfdf2-c88f-4cc1-a02a-b1e52a2b04fc	UNCLASSIFIED	jpeg	2
250	144e9abe-6844-4b3b-97e3-000784d81ce8	UNCLASSIFIED	jpeg	4
251	be1f0c2f-4194-4fe4-84f9-9f20f0f3877a	UNCLASSIFIED	jpeg	7
252	5945faf7-8336-499a-9565-eb5655a044e7	UNCLASSIFIED	jpeg	5
253	a5ce1c1c-2ec0-4521-8d0c-0604fd1bfe26	UNCLASSIFIED	jpeg	2
254	ac55abc7-ae3a-4953-b33d-c1e6786b057e	UNCLASSIFIED	jpeg	4
255	9547406b-33e1-4978-9235-ac40934b4703	UNCLASSIFIED	jpeg	7
256	096685d4-f2b4-49d9-84b1-1cc53fb3f20d	UNCLASSIFIED	jpeg	5
257	edf896d7-cb2f-454d-8708-c2be292b0a83	UNCLASSIFIED	jpeg	2
258	8ef33f2c-6835-42f8-8ecf-459177d824e6	UNCLASSIFIED	jpeg	4
259	421b2a47-1a02-4ca6-94aa-96af99973b0b	UNCLASSIFIED	jpeg	7
260	56db4bfa-29ac-4e49-ae30-065af17d182a	UNCLASSIFIED	jpeg	5
261	0e71db23-f7aa-417a-a0f9-7eb62ca8cf7d	UNCLASSIFIED	jpeg	2
262	0f30c1c1-9e3a-454b-8f0d-8abfbfe1833e	UNCLASSIFIED	jpeg	4
263	bd147b8c-6818-4404-9cca-636abbf5dedd	UNCLASSIFIED	jpeg	7
264	0a826302-338d-4772-b4b4-72f06fd855ad	UNCLASSIFIED	jpeg	5
265	61125d80-62b2-4528-9887-722c638c4a7b	UNCLASSIFIED//FOR OFFICIAL USE ONLY	jpeg	2
266	26c8cd8b-5415-49a9-8906-410ef6f4ce66	UNCLASSIFIED//FOR OFFICIAL USE ONLY	jpeg	4
267	8b0b7277-f34b-4019-b347-a10f0709b46e	UNCLASSIFIED	jpeg	7
268	defcc664-07d2-4d0b-84cd-e76f42cec1c6	UNCLASSIFIED	jpeg	5
269	4f88927b-cac4-40cf-894a-4311935ca59b	UNCLASSIFIED	jpeg	2
270	535bb9bc-2d20-4d29-b9e0-a29d7d1ab11a	UNCLASSIFIED//FOR OFFICIAL USE ONLY	jpeg	4
271	0f3f06b2-41d3-4532-8b6f-d4dac30655fe	UNCLASSIFIED	png	7
272	9d98d146-fe87-4fd6-bf46-12f00c43c43f	UNCLASSIFIED	png	5
273	8858a2a6-84ef-4e77-b3c4-e2d296a0a8da	UNCLASSIFIED	png	2
274	72e01d3a-2189-47a1-9fb8-20aa8e5a7c77	UNCLASSIFIED	png	4
275	e4220bb7-7d42-43b2-9d29-f30a4fad1f7c	UNCLASSIFIED	jpeg	7
276	09ab40a3-63be-4de8-a295-19d88bd36498	UNCLASSIFIED	jpeg	5
277	dbe57296-79b7-419b-be94-991383642244	UNCLASSIFIED	jpeg	2
278	c97136cb-11b7-48b8-b628-0d95513f828e	UNCLASSIFIED	jpeg	4
279	26299988-8bd4-4590-9f9c-9a7968fd8980	UNCLASSIFIED	jpeg	7
280	4d2ae4de-64c3-4f43-8fee-05fae8313c3b	UNCLASSIFIED	jpeg	5
281	0ba423cd-af3b-460d-afff-3a0c843812a8	UNCLASSIFIED	jpeg	2
282	762c2d30-19ef-4cdb-ace1-ce91b4e0a95d	UNCLASSIFIED	jpeg	4
283	bc6dc7d6-254e-4b27-aed2-7ed80b4a3fa8	UNCLASSIFIED	jpeg	7
284	4480f448-0edc-4924-81ef-cdf3cc0e4783	UNCLASSIFIED	jpeg	5
285	36ee84b2-cee1-4439-82c4-2d0a0563b02e	UNCLASSIFIED	jpeg	2
286	524cf746-4edc-4e84-92db-767a4ac38375	UNCLASSIFIED	jpeg	4
287	4a8058ed-90e5-4e28-ada8-f10c20227c3d	UNCLASSIFIED	png	7
288	25f217b3-69b7-425a-a9e5-00a083f6cdf0	UNCLASSIFIED	png	5
289	e28093a4-2af8-419d-8ab9-b24b331d085c	UNCLASSIFIED	jpeg	2
290	962ae6b9-7444-49dc-a8f6-0cbd8b804b64	UNCLASSIFIED	jpeg	4
291	1b49d54d-ee6d-41ec-a753-48e7477fb1f7	UNCLASSIFIED	jpeg	7
292	d8afd7a3-261c-4d5e-9e19-b96153614050	UNCLASSIFIED	jpeg	5
293	226f7190-2421-48f0-9e0c-4c159e72cbd7	UNCLASSIFIED	jpeg	2
294	2343ca9c-7e47-45e6-b95e-dd69535421f9	UNCLASSIFIED	jpeg	4
295	21ca8b33-bef6-4e61-9af9-a67812f135f7	UNCLASSIFIED	jpeg	7
296	cd56c03e-def0-4ab4-99f6-2eeba34ca0e1	UNCLASSIFIED	jpeg	5
297	dab89712-842e-4345-8dbd-2656646a111a	UNCLASSIFIED	jpeg	2
298	935435b4-5d23-4035-99a1-22e04be3272f	UNCLASSIFIED	jpeg	4
299	861c3d69-a478-4fc5-a574-43e58540df5d	UNCLASSIFIED	png	7
300	1031c0ce-17bf-4b8a-9d0b-46264ed22228	UNCLASSIFIED	png	5
301	bd10ddb8-c4fb-45d7-bca7-eddf2c42658d	UNCLASSIFIED	png	2
302	187fefbd-4a60-46f8-94bf-dbd34ea06f48	UNCLASSIFIED	png	4
303	dcdd0bef-70ad-4f8a-abd8-e350d0cd7123	UNCLASSIFIED	png	7
304	49247196-24c1-414a-b0ae-da0f8f8cd99e	UNCLASSIFIED	png	5
305	cc53fa45-3d3d-4a43-a30f-ff982112cc63	UNCLASSIFIED	png	2
306	39a8b4b2-ba7b-4dad-a0b2-61581ed0b62e	UNCLASSIFIED	png	4
307	4964eee9-0b08-4edb-8beb-d67b27a143e1	UNCLASSIFIED	jpeg	7
308	b15402fb-21bd-4f38-8d51-abb5743ad926	UNCLASSIFIED	jpeg	5
309	8e586b41-0ebe-4a17-afb4-c70f608b1f95	UNCLASSIFIED	jpeg	2
310	b2a2fbf4-b80b-4ab8-b796-ca79690e9de4	UNCLASSIFIED	jpeg	4
311	70eeb7d1-3395-4b63-ad44-c7befd92d26c	UNCLASSIFIED	jpeg	7
312	df662670-bcb0-415b-b5b4-e5f17459a7eb	UNCLASSIFIED	jpeg	5
313	aea63991-8c03-4a8f-b4c9-759065ee343f	UNCLASSIFIED	jpeg	2
314	f2f90664-0381-4d82-82cd-651b771e93b8	UNCLASSIFIED	jpeg	4
315	f154836f-eef3-4808-977c-b07452adbe21	UNCLASSIFIED	jpeg	7
316	7946032c-04d3-41c0-9a30-6ad1a8861f4a	UNCLASSIFIED	jpeg	5
317	ba261837-85ee-42c8-9e9e-315c10892441	UNCLASSIFIED	jpeg	2
318	adb31f35-b7ae-46f8-a59c-2c372cda51dd	UNCLASSIFIED	jpeg	4
319	e8b1cc22-69fc-468c-a16b-64b5362544b7	UNCLASSIFIED	jpeg	7
320	2f91757f-ec28-4672-8093-2d7bc5bcd8b1	UNCLASSIFIED	jpeg	5
321	8f7136d2-cbca-4c18-9e63-2075ea2f2bf5	UNCLASSIFIED	jpeg	2
322	0f04a005-a1b1-41ff-b77e-18fc60483515	UNCLASSIFIED	jpeg	4
323	9aa03f4f-d05b-41b0-b92c-00cb0f59d6f6	UNCLASSIFIED	jpeg	7
324	4157d011-0165-4772-9edd-32cc5e36f33b	UNCLASSIFIED	jpeg	5
325	e4927242-9391-4e48-81e1-68e34938921a	UNCLASSIFIED	jpeg	2
326	a2525327-714c-4cb8-8924-c0323fd3c94d	UNCLASSIFIED	jpeg	4
327	5f017b7a-0614-4976-91b3-52e7ef99e05f	UNCLASSIFIED	jpeg	7
328	061055cc-18e0-4723-acb9-33c337388c77	UNCLASSIFIED	jpeg	5
329	b263e4d4-b67e-461e-9989-f4a127facdd9	UNCLASSIFIED	jpeg	2
330	21cf0b8f-bfbc-4548-ae1c-2cc579f46a15	UNCLASSIFIED	jpeg	4
331	7f19bdc7-7d62-4bcf-a1aa-136e237e83b1	UNCLASSIFIED	png	7
332	81c33234-1411-403f-bcab-8a1cc42101f6	UNCLASSIFIED	png	5
333	18980d9a-a536-4784-8515-fa58317c844b	UNCLASSIFIED	png	2
334	617dd4e1-c4e0-43f4-974e-075fac19855a	UNCLASSIFIED	png	4
335	547221dd-a554-4caa-b0fc-4e5afe60acd4	UNCLASSIFIED	png	7
336	3ba7c68a-a000-4898-8f4a-5f4c8b64f269	UNCLASSIFIED	png	5
337	0810ffa6-7bd8-4031-86e4-8dc098ebb1f8	UNCLASSIFIED	png	2
338	febb8174-66c7-42bc-9ae7-ccbb232a1696	UNCLASSIFIED	png	4
339	70d9f16f-5f93-4aa0-87e4-aac581c04497	UNCLASSIFIED	jpeg	7
340	4c25aac9-b578-460e-bd4b-7bf7358081fd	UNCLASSIFIED	jpeg	5
341	6fb26d5b-fa96-4f91-886e-f1e0406412ee	UNCLASSIFIED	jpeg	2
342	6e795476-054c-410f-ae57-c7309a623ab9	UNCLASSIFIED	jpeg	4
343	56f5cbbe-f4bd-4a29-b8fc-2400d9bb0869	UNCLASSIFIED	jpeg	7
344	8154a1de-a259-4ba8-bcd3-9f10aaff07c2	UNCLASSIFIED	jpeg	5
345	b7f60563-9f4c-48b2-8dcc-ac355dc4302a	UNCLASSIFIED	jpeg	2
346	dd582ec7-273d-4488-a513-9ca1e0541e30	UNCLASSIFIED	jpeg	4
347	a5647df6-264f-439b-b35a-cd1a0866ffd6	UNCLASSIFIED	png	7
348	8d47d040-75d8-4746-ada1-3030916bae03	UNCLASSIFIED	png	5
349	4a503d1d-6b07-49a3-98ce-1016505279e2	UNCLASSIFIED	png	2
350	89aa7dbd-e58b-4c30-9882-219b0488a0bb	UNCLASSIFIED	png	4
351	c8525fcd-179e-4594-970c-b09372621b50	UNCLASSIFIED	jpeg	7
352	50cbb167-a761-43d2-a0c2-04af359bb3f6	UNCLASSIFIED	jpeg	5
353	92870056-03e8-4260-a508-ed8173b6e66c	UNCLASSIFIED	jpeg	2
354	b178a7b3-7069-4daf-9070-022c1000aadd	UNCLASSIFIED	jpeg	4
355	65194839-3982-4658-a598-fc0d1254421d	UNCLASSIFIED	jpeg	7
356	577d4820-8fd3-406a-a229-8be26865429d	UNCLASSIFIED	jpeg	5
357	77bace91-d208-4e51-9a19-37c500f5e421	UNCLASSIFIED//FOR OFFICIAL USE ONLY	jpeg	2
358	042083cf-e6af-46fe-a845-1e4660b413ed	UNCLASSIFIED	jpeg	4
359	55964732-55fe-4f7c-b46f-f5f213a06e28	UNCLASSIFIED	jpeg	7
360	1192f7a8-93f8-4342-b4a3-c234bb72a08b	UNCLASSIFIED	jpeg	5
361	c3e86ed1-47ea-4d1a-bea0-2462abd3335d	UNCLASSIFIED	jpeg	2
362	4c62b1c4-1050-43c8-913c-74ffc196751c	UNCLASSIFIED	jpeg	4
363	26c48cfb-e386-48b3-b180-3bebb49f82ec	UNCLASSIFIED	jpeg	7
364	bfa1747d-1563-43cf-931d-06ead03a8f2d	UNCLASSIFIED	jpeg	5
365	842be9f0-fc54-441b-bc52-9c5dcdb9492b	UNCLASSIFIED	jpeg	2
366	cb7aa1dd-01b3-4d4e-a7cc-f5f15b774aa4	UNCLASSIFIED	jpeg	4
367	5892ed46-56c4-4076-b2de-98406fff5016	UNCLASSIFIED	jpeg	7
368	085794aa-311a-45f9-9441-f094c50eaaad	UNCLASSIFIED	jpeg	5
369	f65a3baf-260f-4682-a71d-ca2b47b80f24	UNCLASSIFIED	jpeg	2
370	25912f25-dbcc-4ac3-a064-e4a72e3a76d6	UNCLASSIFIED	jpeg	4
371	3b32b326-730a-4c50-b003-9cac7577a00f	UNCLASSIFIED	jpeg	7
372	b8932cbe-cc88-4d90-99b3-22449c0e9651	UNCLASSIFIED	jpeg	5
373	fa6000a4-f92d-4674-b478-290e7d7ee6e6	UNCLASSIFIED//FOR OFFICIAL USE ONLY	jpeg	2
374	611b0065-76bf-4654-8952-2b1b1bc17a91	UNCLASSIFIED//FOR OFFICIAL USE ONLY	jpeg	4
375	e38f061a-d0da-4d0e-afcf-cef825dba9dc	UNCLASSIFIED	png	7
376	e413a501-192b-49dd-ba53-f86aae09e4c4	UNCLASSIFIED	png	5
377	8becaaee-546b-4a01-8062-dee1bc9efecd	UNCLASSIFIED	png	2
378	b4dcd186-dae8-4fdb-bd7e-e6a8c951b1f1	UNCLASSIFIED	png	4
379	88d6d877-b615-4feb-a606-f4e3685d665d	UNCLASSIFIED	jpeg	7
380	28ad2055-ad7d-436f-8498-f1cb6686e75b	UNCLASSIFIED	jpeg	5
381	a0d58d69-47ee-456c-a0bc-b38087bc65f2	UNCLASSIFIED	jpeg	2
382	c14a77a5-3a2b-47d6-980c-21d9b67c7357	UNCLASSIFIED	jpeg	4
383	f6098119-fe7a-49d4-a320-2572a32e8215	UNCLASSIFIED	jpeg	7
384	ba292476-f0c5-48bb-a414-a6e59cda5c28	UNCLASSIFIED	jpeg	5
385	1bb7da78-144e-47b7-841e-a9030ea68588	UNCLASSIFIED	jpeg	2
386	b0e8ca3c-6ecd-4403-84f7-41c47ba4ad50	UNCLASSIFIED	jpeg	4
387	25cedbff-4d60-4d57-bcc9-1c22c5f1966a	UNCLASSIFIED	png	7
388	0337e837-3f42-4aa0-a6d0-5f6ead57984b	UNCLASSIFIED	png	5
389	cb323577-fd62-4a13-aace-d90d1447775c	UNCLASSIFIED	png	2
390	c10fa2d9-566d-45d4-aa35-21cc46bde2ae	UNCLASSIFIED	png	4
391	f56577d7-cef8-4bbb-a6e5-35c4b3db35f9	UNCLASSIFIED	png	7
392	c914bf82-174f-44e5-91f2-9aeca7c0f30a	UNCLASSIFIED	png	5
393	378dd5ac-d53e-469f-929d-ac6093553f5a	UNCLASSIFIED	png	2
394	3a73aae3-07b0-4ae4-a4df-bb1df11b978d	UNCLASSIFIED	png	4
395	0ac2046a-4c12-44f3-a88b-e50f51142674	UNCLASSIFIED	png	7
396	84b8703d-7f9b-4f5a-8be6-5f453bdb1888	UNCLASSIFIED	png	5
397	cf19d1ac-c9d9-472a-a673-4ce0a8003db9	UNCLASSIFIED	png	2
398	05391088-55c8-4a3c-b3ad-1758d873fd71	UNCLASSIFIED	png	4
399	91c9508e-2bfc-498d-b3b4-841d356e5797	UNCLASSIFIED	png	7
400	8b67e1fa-8579-4d53-be3c-3c1636a17179	UNCLASSIFIED	png	5
401	ae9c158b-e156-464d-a8b2-61910efa4bdc	UNCLASSIFIED	png	2
402	e32dbfea-2380-4af1-a31f-124598336938	UNCLASSIFIED	png	4
403	4e865739-2d92-4341-8113-8838c6b2a266	UNCLASSIFIED	jpeg	7
404	4ac980cf-4dc3-447d-836b-0913ce75c5f1	UNCLASSIFIED	jpeg	5
405	54773e2a-032b-4bfc-8b12-455c1deb44e5	UNCLASSIFIED	jpeg	2
406	41eb5ca2-67ed-40b6-9f7b-96fdbf301da4	UNCLASSIFIED	jpeg	4
407	dd8db971-c3c4-406a-a459-6d778ae8ca5a	UNCLASSIFIED	png	7
408	8e28ea9a-1258-4f5c-b33a-3b34b2811e07	UNCLASSIFIED	png	5
409	86dd882f-499f-4251-98ed-5dfd5b021414	UNCLASSIFIED	png	2
410	27c8f436-53a1-4a90-bf32-c37d71e72452	UNCLASSIFIED	png	4
411	f71460fd-123b-4de0-9cfe-116bb203fb90	UNCLASSIFIED	jpeg	7
412	a930883c-5876-4714-97f3-54a47a4c6c45	UNCLASSIFIED	jpeg	5
413	0b9f65ee-400e-4536-9440-6f23ce45da30	UNCLASSIFIED	jpeg	2
414	9cb09d4d-1901-4c27-8726-b1f3a1f1e7ec	UNCLASSIFIED	jpeg	4
415	f94419fb-8730-4bc4-93bd-d51c0040a43f	UNCLASSIFIED	jpeg	7
416	18cb7040-fc9a-4424-be34-8979cc8d54fd	UNCLASSIFIED	jpeg	5
417	adfae998-1a0d-4a09-9479-b8949f496981	UNCLASSIFIED	png	2
418	c71daf92-030b-44a7-99dd-529605f27384	UNCLASSIFIED	jpeg	4
419	62939dbc-1c09-44aa-a212-44938b5f5cd3	UNCLASSIFIED	png	7
420	1db819d1-b5d8-4e7e-a887-973252bd3f2a	UNCLASSIFIED	png	5
421	b0af3a93-24f5-4a2e-85bd-bac47da4ef9c	UNCLASSIFIED	png	2
422	3c1a8780-7eb0-459d-a127-f6072e72094d	UNCLASSIFIED	gif	4
423	a9c5ab3c-2d7e-4e11-b54b-bc37f661ec89	UNCLASSIFIED	png	7
424	a58fc399-628f-4d81-9ca3-fd4eee411f43	UNCLASSIFIED	png	5
425	2c9f34d3-419e-4085-bc7c-1dc12d3aff7f	UNCLASSIFIED	png	2
426	320626ea-9635-495d-ab47-c79a695f9be9	UNCLASSIFIED	png	4
427	225de060-3c5f-4140-b177-28e5b9cde3a2	UNCLASSIFIED	jpeg	7
428	30c92006-c5cd-435f-ae5c-26c066efb91c	UNCLASSIFIED	jpeg	5
429	f5799298-077a-4a2a-895d-9e9fbfca47f4	UNCLASSIFIED	jpeg	2
430	18d3606f-8fdc-4ef1-942b-11b310f4ec62	UNCLASSIFIED	jpeg	4
431	a34514a5-c55f-404d-8e58-1f446f411126	UNCLASSIFIED	png	7
432	100b1dff-f5ed-468b-958b-af115304fd51	UNCLASSIFIED	png	5
433	9b02af43-4d20-4e3d-977d-cb2de15d5fd5	UNCLASSIFIED	png	2
434	83040b70-d2cf-4d53-936a-f81e5013ddee	UNCLASSIFIED	png	4
435	4bcfcf82-29b7-4dd5-b076-06d636085d70	UNCLASSIFIED	jpeg	7
436	f8f18b02-be8d-4d95-bddb-8ad54b047c26	UNCLASSIFIED	jpeg	5
437	f83a1c94-21f4-4264-a2e3-da6c21b5180f	UNCLASSIFIED	jpeg	2
438	357a74ab-2053-40a9-9e10-e8370012fec8	UNCLASSIFIED	jpeg	4
439	5a5d5912-13dd-4258-88b7-e406119f0dee	UNCLASSIFIED	jpeg	7
440	c1770457-e35b-4427-a7eb-07a966ce9a91	UNCLASSIFIED	jpeg	5
441	fb38a18b-2376-4802-82ff-ac1d122fb817	UNCLASSIFIED	jpeg	2
442	e54ffaa9-6437-4bdf-b24a-5ea4224059b0	UNCLASSIFIED	jpeg	4
443	757884cb-9f4c-499c-93ff-5c118841a0c2	UNCLASSIFIED	jpeg	7
444	f07becf8-d42a-4989-9354-1b31a998c20a	UNCLASSIFIED	jpeg	5
445	86746873-af08-4fac-84ef-dd558143d049	UNCLASSIFIED	jpeg	2
446	61cba560-1116-4a5b-94c6-664a5e257f84	UNCLASSIFIED	jpeg	4
447	0c218815-060b-4b7b-91cd-11fc2709433e	UNCLASSIFIED	png	7
448	e6bc5d1b-5ccc-4553-8383-986a22eb51a0	UNCLASSIFIED	png	5
449	5da6fa49-df3a-4242-bf92-95eb02b3b639	UNCLASSIFIED	png	2
450	16621f1b-7ab0-4c3a-87b1-25692df53f2b	UNCLASSIFIED	png	4
451	e4c5e1d6-8179-4d89-8c16-0600e3c9120b	UNCLASSIFIED	jpeg	7
452	8ff262f2-5dbe-44b6-b524-74a39619c88b	UNCLASSIFIED	jpeg	5
453	132285cc-102c-4059-8ebc-32aebcb4492e	UNCLASSIFIED	jpeg	2
454	badf49fe-cab6-4064-9710-bc3b179c5791	UNCLASSIFIED	jpeg	4
455	516c96c0-c030-4837-9586-1696f1136528	UNCLASSIFIED	png	7
456	56f4f566-0fc5-4bb0-b2a9-4e5784c8e1fb	UNCLASSIFIED	png	5
457	1c775892-5570-464c-acb1-0e93a49b7c3a	UNCLASSIFIED	png	2
458	3b2cf0d7-3f53-4d66-9e67-d81a24ae91b5	UNCLASSIFIED	png	4
459	cac95e2a-b04b-400b-9f01-4873d2dff165	UNCLASSIFIED	gif	7
460	eda0456d-7d9e-4c74-8e86-5d72570b2ced	UNCLASSIFIED	gif	5
461	abe7e665-9d4c-48ba-85d9-3912fc31d41c	UNCLASSIFIED	gif	2
462	87c858bf-08ed-4975-8a06-943f220d6d50	UNCLASSIFIED	gif	4
463	d330ce08-fd7e-4be6-8cba-eeec4e29a225	UNCLASSIFIED	jpeg	7
464	4cf3abe7-b785-4d15-9703-7466bce688bb	UNCLASSIFIED	jpeg	5
465	c1457154-dfc8-4512-9904-7324a5342f79	UNCLASSIFIED	jpeg	2
466	ea8b4197-12da-420b-b7f4-194ca92e5ea0	UNCLASSIFIED	jpeg	4
467	22263cf1-efd7-44d6-ab0f-48e2d7d53da8	UNCLASSIFIED	jpeg	7
468	e35bd6bd-f288-463d-b314-13b62d9b5b17	UNCLASSIFIED	jpeg	5
469	74f00f35-71b1-49ff-aac6-72f4aeba8707	UNCLASSIFIED	jpeg	2
470	48dfc8a3-7e5a-4aac-84a5-e1badb8094c4	UNCLASSIFIED	jpeg	4
471	a0717c33-39db-4081-9e7d-aa366caa6b68	UNCLASSIFIED	jpeg	7
472	e96a292b-a3a2-4738-87f1-3cef715c54d9	UNCLASSIFIED	jpeg	5
473	328b0217-1c83-402e-8673-ab9931605b69	UNCLASSIFIED	jpeg	2
474	0f11c1ab-4cff-4040-a673-d463bfe94dcd	UNCLASSIFIED	jpeg	4
475	8a1feefe-7dbc-4d32-999a-c31d72a99012	UNCLASSIFIED	jpeg	7
476	60dd9255-9846-43ec-9625-da3cf150fdbc	UNCLASSIFIED	jpeg	5
477	760b6526-0b18-46e0-94a0-b8500c30d5a0	UNCLASSIFIED	jpeg	2
478	65fcd6df-6eaf-4fcc-b597-e4bdf77f7a2b	UNCLASSIFIED	jpeg	4
479	20550d7b-bd3b-4438-9d88-208b14b030d7	UNCLASSIFIED	jpeg	7
480	ba9aa457-dfb6-41a3-b45d-b416d9cfd134	UNCLASSIFIED	jpeg	5
481	1bd1f529-f3ed-490b-97f9-beea65485165	UNCLASSIFIED	jpeg	2
482	5c340df3-3139-467b-b857-3380d5a9b66c	UNCLASSIFIED	jpeg	4
483	8fb3c77e-a158-48e0-9812-9aa01d59aaeb	UNCLASSIFIED	jpeg	7
484	7cbbea26-3bac-4e01-9254-0152b59c3326	UNCLASSIFIED	jpeg	5
485	db5d7b88-dd12-40c6-8f74-2b0f081aedfa	UNCLASSIFIED	jpeg	2
486	00962187-a2a0-458c-a04c-26b9f577a522	UNCLASSIFIED	jpeg	4
487	037bab11-4050-498b-b548-82e980cc59f4	UNCLASSIFIED	jpeg	7
488	b5843385-2a8b-47da-a629-144afd83fb3e	UNCLASSIFIED	jpeg	5
489	68ceada4-149c-4705-a274-4fdb8e8d8e4b	UNCLASSIFIED	jpeg	2
490	70969e3f-6ef3-47f3-b5c1-8d056c4ff82f	UNCLASSIFIED	jpeg	4
491	d5bb0d29-b44f-490c-8118-ca86224ef1e0	UNCLASSIFIED	jpeg	7
492	c6e90780-f29c-471c-a846-e495aacb03c2	UNCLASSIFIED	jpeg	5
493	2eec1363-72af-4f4d-b80b-f91570ecdadd	UNCLASSIFIED	jpeg	2
494	b2b18e72-baa5-4d7e-a291-16ba265a377c	UNCLASSIFIED	jpeg	4
495	5ae282df-66ea-4810-b93c-03252ed4cd29	UNCLASSIFIED	jpeg	7
496	2c4b5b2d-478e-4d77-9b77-506b262bbccc	UNCLASSIFIED	jpeg	5
497	2159fc74-d43b-40cf-afec-ed4d26ebf63d	UNCLASSIFIED	jpeg	2
498	96138ff2-3a0e-4cc3-a01d-50fc60bee26d	UNCLASSIFIED	jpeg	4
499	e2f064ed-f6d4-4b6d-8971-d1d3d23f6383	UNCLASSIFIED	jpeg	7
500	c2f58dae-e73c-49c0-9e27-273f3e3c80ef	UNCLASSIFIED	jpeg	5
501	c10e1a9c-4b7b-4a2c-b93b-cc2c8001a53e	UNCLASSIFIED	jpeg	2
502	99c051fa-2e8e-4e7c-ba0b-f22d9a328311	UNCLASSIFIED	jpeg	4
503	0ac9ef84-0d71-4944-9904-62236de61b8a	UNCLASSIFIED	png	7
504	12dc766e-1c55-4b36-9fae-d8ec49b33fce	UNCLASSIFIED	png	5
505	dc631b71-6d0b-4179-bbea-c016dd6f42a2	UNCLASSIFIED	png	2
506	fc9fb9f7-4f98-4e30-b1f2-86492ff78c2d	UNCLASSIFIED	png	4
507	4825bca3-f23e-4a03-801f-492bf3b6dbe8	UNCLASSIFIED	png	7
508	8f90607c-817a-49d0-a29d-cd472c584c96	UNCLASSIFIED	png	5
509	1ef9f686-635f-4cef-8ab8-1948bdc56400	UNCLASSIFIED	png	2
510	80a61e87-bcbc-4213-86d0-38ae22e8ef80	UNCLASSIFIED	png	4
511	bbe3f49a-0543-4bdc-a169-43857b2954f0	UNCLASSIFIED	png	7
512	bf87c91c-7c79-48b9-9cae-db35ba875ac1	UNCLASSIFIED	png	5
513	924fc388-b312-475d-9e5b-6a7b9c7f566f	UNCLASSIFIED	png	2
514	fae71e2f-08e2-4f0c-945e-a65743bfd278	UNCLASSIFIED	png	4
515	36ed219a-a940-468c-b5bf-84a7a1b5f3d0	UNCLASSIFIED	jpeg	7
516	39494c9e-0f9b-4805-a925-5b603c774075	UNCLASSIFIED	jpeg	5
517	e837b11c-bd16-4230-8db5-f1e7439abedc	UNCLASSIFIED	jpeg	2
518	676e72ae-3722-4291-94ac-333f6ec8820b	UNCLASSIFIED	jpeg	4
519	2e47ed75-e91a-4b1b-b65c-f01f962c5caa	UNCLASSIFIED	jpeg	7
520	1fe26198-a9e4-4944-90fb-3737e02def02	UNCLASSIFIED	jpeg	5
521	4fa07d66-61f7-44f3-8bbb-5f445931996a	UNCLASSIFIED	jpeg	2
522	89296474-af30-4ad5-9283-c10228b5b14b	UNCLASSIFIED	jpeg	4
523	b8c58c35-bcbb-4c24-a6e8-93d31867df24	UNCLASSIFIED	png	7
524	bba64113-0d21-4fcb-9899-203542bd478a	UNCLASSIFIED	png	5
525	27ac0d60-5b36-40b1-bbe3-640de94c2966	UNCLASSIFIED	jpeg	2
526	fe518dfc-f6ef-460b-97b4-ae51af705a56	UNCLASSIFIED	jpeg	4
527	e64cc3ca-664f-454e-a441-1ae7a2b954d5	UNCLASSIFIED	jpeg	7
528	988852a7-b827-46a8-a1e4-e8128e85d647	UNCLASSIFIED	jpeg	5
529	6d70abfc-b7eb-4169-ad32-a852e0d7f4f9	UNCLASSIFIED	jpeg	2
530	0b86ff46-c918-4d42-b0d4-724ee3976c3f	UNCLASSIFIED	jpeg	4
531	f89ac732-79ef-4b11-8eb0-32df913fba4f	UNCLASSIFIED	jpeg	7
532	9259e95b-419d-41d5-8a8c-4f70b8de9a59	UNCLASSIFIED	jpeg	5
533	1289f889-7cb9-4178-9a74-9157ac6061fa	UNCLASSIFIED	jpeg	2
534	ca04f12d-3c33-4cf9-b61b-6a24770802bf	UNCLASSIFIED	jpeg	4
535	e962094d-a967-4cac-bfe4-ff5d61ebb59d	UNCLASSIFIED	jpeg	7
536	4b6d9ae8-b243-4175-b63a-a6cd73ecfa49	UNCLASSIFIED	jpeg	5
537	fa27940b-bc61-46e2-8639-4df4fb5a26cd	UNCLASSIFIED	jpeg	2
538	4b745849-ca04-4ba5-a285-cc8b1e3e0b69	UNCLASSIFIED	jpeg	4
539	d7546614-cd95-4d08-8258-046cc288a70d	UNCLASSIFIED	png	7
540	4bd611da-8e39-4072-a316-992f10a04dce	UNCLASSIFIED	png	5
541	269d547f-d231-4a94-9f7c-6b41d519b3ac	UNCLASSIFIED	png	2
542	ad953dd5-ccec-4213-82bd-db1321f64bf1	UNCLASSIFIED	png	4
543	457407e6-1cb0-4b99-acaf-a23ad3c6770c	UNCLASSIFIED	jpeg	7
544	67b73a3d-b586-41b0-9df0-ff62c7d12d92	UNCLASSIFIED	jpeg	5
545	7676aea7-b50c-43bd-a4c6-0d09f297240e	UNCLASSIFIED	jpeg	2
546	99f23a49-5a7f-4e98-b8dd-716162732923	UNCLASSIFIED	jpeg	4
547	22047cf5-0199-4090-b054-82ef01601754	UNCLASSIFIED	jpeg	7
548	34180865-ab7f-47ee-892b-800be7f2d4c6	UNCLASSIFIED	jpeg	5
549	cd590da8-d00c-4790-a175-6d6b69d83a38	UNCLASSIFIED	jpeg	2
550	9072e81d-c81e-4001-bb05-75859f3bf0d6	UNCLASSIFIED	jpeg	4
551	2593c39a-68c1-4b4c-aae1-5729c4e54732	UNCLASSIFIED	jpeg	7
552	6cbf2948-a7d8-4756-a186-5f2b8c95cd3f	UNCLASSIFIED	jpeg	5
553	7bfd906d-26cd-4b15-ba83-043101f55bda	UNCLASSIFIED	jpeg	2
554	cb93582b-3111-4a35-83ff-1175b74cb332	UNCLASSIFIED	jpeg	4
555	5c7d6fe5-13be-4f2b-ba1b-819ea565eca1	UNCLASSIFIED	png	7
556	15dd6f95-6ae7-40c8-972c-4496d40db19d	UNCLASSIFIED	png	5
557	2c490142-6942-4477-9f92-f337337d1068	UNCLASSIFIED	png	2
558	9afb77ae-eda8-4550-9e0e-9a04806bf07c	UNCLASSIFIED	png	4
559	729e43a6-ad0b-4522-aa3f-6a4c06e1314b	UNCLASSIFIED	png	7
560	76bdb5ba-3448-40a7-871b-2e3c8246a49e	UNCLASSIFIED	png	5
561	d9db8ebb-236b-4079-bfff-f43c807559f6	UNCLASSIFIED	png	2
562	898972f7-222c-4c65-b9bf-f4a1badc927a	UNCLASSIFIED	png	4
563	3cb1e7cb-77c1-4e85-bc5d-f24ff6bcaca5	UNCLASSIFIED	jpeg	7
564	562ec16a-7afa-4de9-9c87-638a55767b0e	UNCLASSIFIED	jpeg	5
565	c5e908fd-b4e8-4112-8d89-b5db62db5665	UNCLASSIFIED	jpeg	2
566	0275efd0-3497-441c-a73d-65aa8c6257cf	UNCLASSIFIED	jpeg	4
567	35109787-8534-47ca-a8f2-07cc217a58b3	UNCLASSIFIED	png	7
568	bb506d75-eba3-43b6-bf34-ffa7df32879d	UNCLASSIFIED	png	5
569	f0e8e5da-0357-4b06-a875-04501c2a0189	UNCLASSIFIED	png	2
570	d47f29ea-ee8b-432d-a316-dbcd7bee773f	UNCLASSIFIED	png	4
571	9022cdea-a2b3-4316-8a1c-61b97f814521	UNCLASSIFIED	jpeg	7
572	77eabb3c-6347-4f24-bb36-71435ae93796	UNCLASSIFIED	jpeg	5
573	303b33cb-ba91-42a6-9745-a5ce54733215	UNCLASSIFIED	jpeg	2
574	f7c1ed7b-625e-4700-8ce9-25f7345f5b9d	UNCLASSIFIED	jpeg	4
575	db51b6c0-0bc1-45b8-bebb-52fb8dd7fff3	UNCLASSIFIED	jpeg	7
576	1d7b2bf1-71c0-4be3-9e48-fa84de09dfef	UNCLASSIFIED	jpeg	5
577	b3cd4ca0-3187-44be-8e13-dcd2ec44a231	UNCLASSIFIED	jpeg	2
578	bb05da4e-41cf-4ce4-8af5-85e4ca2490a8	UNCLASSIFIED	jpeg	4
579	1e2e5114-bc1f-457e-bbb1-2d38680ead4f	UNCLASSIFIED	jpeg	7
580	440b73ef-32ad-4351-974f-23f97d06d5bd	UNCLASSIFIED	jpeg	5
581	d56154db-a65c-4808-928b-39c9e8ad10b1	UNCLASSIFIED	jpeg	2
582	244fdf57-798d-425a-843b-efb367c5d50a	UNCLASSIFIED	jpeg	4
583	aac94d1e-b6bd-4b36-8e9c-b6242d94bc06	UNCLASSIFIED	jpeg	7
584	269d0280-1c2a-480d-9194-87fe7691b125	UNCLASSIFIED	jpeg	5
585	719a4bdc-cda8-4177-973e-7d62bb0ad77d	UNCLASSIFIED	jpeg	2
586	fca46946-8bb2-4c14-bdd5-8bde0a6f8f1d	UNCLASSIFIED	jpeg	4
587	a94ccbb5-35d7-47a7-a161-dbf4a7ef4167	UNCLASSIFIED	png	7
588	7482dadd-bf5f-4ea2-bba4-5e2f53cf0647	UNCLASSIFIED	png	5
589	efc19853-427b-4b25-9991-8a652c5dcbca	UNCLASSIFIED	jpeg	2
590	af4f6c34-eb83-4543-9715-0c2ddafe4eb1	UNCLASSIFIED	jpeg	4
591	f517721c-b2ad-48f2-8dd7-8b8779275077	UNCLASSIFIED	jpeg	7
592	4a98fdd0-e018-4bc2-b3c0-c3a04f6c5728	UNCLASSIFIED	jpeg	5
593	c0af0c8c-fc96-42bd-9e5f-04b8a9d19eca	UNCLASSIFIED	jpeg	2
594	5e0478c1-988e-453d-b72c-022af2d3c32d	UNCLASSIFIED	jpeg	4
595	69e520b8-d91f-4ff6-abe9-8c5370c94001	UNCLASSIFIED	jpeg	7
596	36bbda34-28dc-432b-bf54-1386b6d8ed1e	UNCLASSIFIED	jpeg	5
597	4e24aee8-6d68-4ae9-b75f-d317064da761	UNCLASSIFIED	jpeg	2
598	770ab66f-385b-4459-aa50-96b2275f0c5f	UNCLASSIFIED	jpeg	4
599	824b58a4-5469-4759-9fe2-da13f182ef14	UNCLASSIFIED	jpeg	7
600	30de89c3-c897-4268-b826-c526983f7752	UNCLASSIFIED	jpeg	5
601	1607420c-18e5-4e3c-acba-c48bf723a968	UNCLASSIFIED	png	2
602	abe4a39d-26cc-48fc-820e-6d40b56b95d1	UNCLASSIFIED	jpeg	4
603	a163ede3-cf21-48c8-969e-93c7f7118280	UNCLASSIFIED	jpeg	7
604	d829fee2-58dc-4391-a4cc-6362ba2caa70	UNCLASSIFIED	jpeg	5
605	ab0b7b34-d0f3-4985-92e6-00ac780f7fcc	UNCLASSIFIED	jpeg	2
606	44b02024-c1af-4fd0-ad65-0962f4e121d9	UNCLASSIFIED	jpeg	4
607	08d614cc-dfd9-46c5-a400-7ebc0cdda0e0	UNCLASSIFIED	jpeg	7
608	87e3426b-e162-4d0b-b389-41a455f78ff6	UNCLASSIFIED	jpeg	5
609	26cecfe0-35d9-48f3-a5d7-e4519a21eaa5	UNCLASSIFIED	jpeg	2
610	7e42c16a-edcc-4590-a971-08320119bed4	UNCLASSIFIED	jpeg	4
611	1a219001-04d3-4f59-a3cb-d7a14d823f58	UNCLASSIFIED	jpeg	7
612	bf794d47-1fac-4d13-8e4d-566ba84171b2	UNCLASSIFIED	jpeg	5
613	80fbb847-e086-4cdf-90a3-3e6076f7d55c	UNCLASSIFIED	jpeg	2
614	d7ebe725-34af-48b2-a41f-129084b9b808	UNCLASSIFIED	jpeg	4
615	fb23a3c4-1cea-4ea0-b033-b79ab4524742	UNCLASSIFIED	png	7
616	e96cbe6a-32be-4897-a1bb-58fc82394be9	UNCLASSIFIED	png	5
617	1540932e-b95d-4c1f-8d5f-de6e0be70318	UNCLASSIFIED	png	2
618	4dfe9d40-7315-4fdd-942b-fc731e55ec1f	UNCLASSIFIED	png	4
619	01985ea8-3946-417b-8fcc-14485147852d	UNCLASSIFIED	jpeg	7
620	4485ebb6-41b3-4b0f-9ff1-1dbfa3884040	UNCLASSIFIED	jpeg	5
621	d63219c4-103d-47c6-a7fc-02390df1a4a5	UNCLASSIFIED	jpeg	2
622	e2f284e9-5395-47fa-8bb4-48529f720362	UNCLASSIFIED	jpeg	4
623	670f0f1c-2471-4214-83ec-45a91065eb8d	UNCLASSIFIED	jpeg	7
624	5b43c21c-522e-46a2-b721-b626575a50a3	UNCLASSIFIED	jpeg	5
625	281dc273-5698-4b23-81aa-9b3915c5bccb	UNCLASSIFIED	jpeg	2
626	6ef56957-b6d3-4a62-9906-247be76ab003	UNCLASSIFIED	jpeg	4
627	1a85e5e1-1fd4-47be-85a4-6cd634ac2d68	UNCLASSIFIED	jpeg	7
628	2f89689a-23e6-48ba-b516-41240d9f14ec	UNCLASSIFIED	jpeg	5
629	33200723-4824-4f66-b02b-42817bebd286	UNCLASSIFIED	jpeg	2
630	3743fbe9-2f68-404f-b77e-d5e30ff79643	UNCLASSIFIED	jpeg	4
631	b4f222d2-2b06-430f-a4e4-7a57d9216b17	UNCLASSIFIED	jpeg	7
632	75d7570d-f5ca-4fe1-9080-fb7516af5979	UNCLASSIFIED	jpeg	5
633	062176bb-c58d-4d21-b215-9d316fa46c1d	UNCLASSIFIED	jpeg	2
634	746289bb-94be-4dcd-834b-6d0aa4c54f41	UNCLASSIFIED	jpeg	4
635	6256242e-a4a6-43f3-aab7-f20a84910f72	UNCLASSIFIED	jpeg	7
636	287859ed-d2e4-4d7e-9ee4-328c7912ba6e	UNCLASSIFIED	jpeg	5
637	b6ab539e-e04e-4e09-b7ff-03d1360c106f	UNCLASSIFIED	jpeg	2
638	a53f1bbf-4ff5-4272-8532-80d6cdba3a3c	UNCLASSIFIED	jpeg	4
639	7c6fc3eb-0598-4474-bf89-7bbd1dcbd0ab	UNCLASSIFIED	jpeg	7
640	cf3cfd86-aa61-463d-9e83-c90fd992d277	UNCLASSIFIED	jpeg	5
641	5d88a2b7-c158-474a-b4f2-cec14ee5b536	UNCLASSIFIED	jpeg	2
642	ec758dd3-8b50-4f64-b022-f002f911e0d5	UNCLASSIFIED	jpeg	4
643	d35e8da5-3a25-4eb9-ac1d-4bc0952ecea4	UNCLASSIFIED	jpeg	7
644	70c833cd-4b04-4157-9cc2-c729f8abfd91	UNCLASSIFIED	jpeg	5
645	62a5f132-3e20-4f06-8978-7003d82ef28f	UNCLASSIFIED	jpeg	2
646	7c8f8a56-9489-406a-aa41-56191f6c8e8d	UNCLASSIFIED	jpeg	4
647	af7f10c9-9617-49b3-93c1-9bbf82c51e92	UNCLASSIFIED	png	7
648	ec76d063-4437-43c9-8956-789a7a1b7258	UNCLASSIFIED	jpeg	5
649	2b2d6425-1058-4dbe-8d40-c4e7b15d608b	UNCLASSIFIED	jpeg	2
650	1c9ebc05-9a20-4b58-b6c6-ac9b1a06d23a	UNCLASSIFIED	jpeg	4
651	e5d30403-ad94-4b77-a199-00591d056ec4	UNCLASSIFIED	jpeg	7
652	1f035f2e-c9bc-4362-8053-2e94f2735291	UNCLASSIFIED	jpeg	5
653	2570c246-ce43-427f-bd5a-e868fe201edf	UNCLASSIFIED	jpeg	2
654	9abd7458-877c-4e13-91fe-6ea2575be704	UNCLASSIFIED	jpeg	4
655	0e265179-ecbf-4da8-8453-ab43cdbfd073	UNCLASSIFIED	jpeg	7
656	7cc35982-8e77-4bc6-ac90-6f3f3d21693b	UNCLASSIFIED	jpeg	5
657	eefb7e36-3cc5-4c29-8451-25a53cd95520	UNCLASSIFIED	jpeg	2
658	8fcc002b-e96b-4d1c-8ef3-d8df5e7304fe	UNCLASSIFIED	jpeg	4
659	85c37795-828e-411d-a2de-c1b04e938cea	UNCLASSIFIED	jpeg	7
660	cc7ee1e6-7a7e-48e4-a429-46b8b42a4339	UNCLASSIFIED	jpeg	5
661	6dee1f2b-456e-4467-8445-6ff47f61802c	UNCLASSIFIED	jpeg	2
662	2c0b60eb-e07a-4011-b609-1206c322cfad	UNCLASSIFIED	jpeg	4
663	594cbfe3-a960-440f-b7dc-8decfebd0be5	UNCLASSIFIED	png	7
664	6a81ce08-6e9e-41cf-811a-33ef6cd6292b	UNCLASSIFIED	png	5
665	78ca1bdd-ee40-481f-bdd4-aa9156179202	UNCLASSIFIED	png	2
666	57b63baa-6c93-4331-bee1-b8cb0e754e03	UNCLASSIFIED	png	4
667	265cc294-49c4-4a96-b8f2-136d36372b09	UNCLASSIFIED	jpeg	7
668	194ff0b5-4806-4c3f-859e-8fa9bade8c77	UNCLASSIFIED	jpeg	5
669	e3c70cd4-55ae-4cc9-8258-d15bc8925380	UNCLASSIFIED	jpeg	2
670	ebdf1517-929f-4111-98f3-51c8e0837c14	UNCLASSIFIED//FOR OFFICIAL USE ONLY	jpeg	4
671	7ef55c6e-7360-41bc-9833-a259a2487d0e	UNCLASSIFIED	jpeg	7
672	21062566-c361-439b-ab9a-9d74764cbcc2	UNCLASSIFIED	jpeg	5
673	bc594151-9697-4421-94ce-4496835f665a	UNCLASSIFIED	jpeg	2
674	34597309-dbc3-424c-b5c4-14854b74dcaf	UNCLASSIFIED	jpeg	4
675	df5a3e69-35e0-4598-aab9-0c108957b17c	UNCLASSIFIED	jpeg	7
676	3b17c1cf-fd5e-46e1-8045-beb4f8c99af8	UNCLASSIFIED	jpeg	5
677	9ac48ecf-0f10-463b-be3b-2e951a5b5544	UNCLASSIFIED	jpeg	2
678	61418711-215a-48de-b89f-83a7f1f0d3b2	UNCLASSIFIED	jpeg	4
679	0f8cec13-70a0-4f11-b7af-94c088969548	UNCLASSIFIED	jpeg	7
680	0dc6182e-0737-41e6-a918-c93a4a298b59	UNCLASSIFIED	jpeg	5
681	0677416c-e968-441c-9a23-020cf1ac0507	UNCLASSIFIED	jpeg	2
682	f1971766-64c1-4f63-8557-8028cae99c8d	UNCLASSIFIED	jpeg	4
683	5b9fa197-f549-497d-9300-0757cfd86419	UNCLASSIFIED	jpeg	7
684	99094238-e83f-4a6c-8c14-990252c7b699	UNCLASSIFIED	jpeg	5
685	00ea06da-92e2-40f4-add1-a5cf8179f9a9	UNCLASSIFIED	jpeg	2
686	8526287a-9c8d-476a-968d-471e2314597a	UNCLASSIFIED	jpeg	4
687	2bb1c247-b398-43c5-ba61-0b673722a5d4	UNCLASSIFIED	png	7
688	c3622b78-5c87-4ce9-915d-c13ed60e8fd9	UNCLASSIFIED	png	5
689	c11c793b-769f-40ed-b1ab-f74a162d52bd	UNCLASSIFIED	png	2
690	fa86413f-b93c-4005-b431-7a08f1e8c1d9	UNCLASSIFIED	png	4
691	abc7b810-7f30-44f4-96b4-5bf986c32e42	UNCLASSIFIED	jpeg	7
692	76411e6c-0417-47f0-baff-1a4ca1d2f818	UNCLASSIFIED	jpeg	5
693	4cd70a7c-09b9-4034-ba17-0944698e3aaa	UNCLASSIFIED	jpeg	2
694	09921957-7319-4706-ba4a-55316650922f	UNCLASSIFIED	jpeg	4
695	325d2e5a-7947-4f0e-a2fe-39cec9614311	UNCLASSIFIED	jpeg	7
696	c0d07d04-ee32-4c3d-88de-e40bbafcbc41	UNCLASSIFIED	jpeg	5
697	4092de92-eeec-4dc3-b592-2f63e0a44dc1	UNCLASSIFIED	jpeg	2
698	0fb83481-a9b4-4dad-9015-fd2bde8743ab	UNCLASSIFIED	jpeg	4
699	fd4f3c56-9951-4a8f-943f-a2a3dc5b5254	UNCLASSIFIED	jpeg	7
700	1630ec81-0853-4504-b189-1f729cae5f2f	UNCLASSIFIED	jpeg	5
701	7a7380b5-726d-4bef-b7e5-fd95cb9cb3ca	UNCLASSIFIED	jpeg	2
702	372afa72-3885-421e-a5ef-5dc6367133d8	UNCLASSIFIED	jpeg	4
703	d0fb58cb-2b9e-4ec8-ae1b-bb93e8b5ee61	UNCLASSIFIED	jpeg	7
704	7a134ca9-9279-42cf-b8e9-ae01f04b078a	UNCLASSIFIED	jpeg	5
705	4680f7fa-5dee-4f69-a9ac-51408f5b45fd	UNCLASSIFIED	jpeg	2
706	619c8fc1-2278-459f-a2a7-f6c2229c93b1	UNCLASSIFIED	jpeg	4
707	0964f8c0-5670-4160-8b80-45de27c8fd36	UNCLASSIFIED	jpeg	7
708	c5ee0829-57be-4e0f-a211-a3c6a9fcb88f	UNCLASSIFIED	jpeg	5
709	bd5e9623-3528-48bf-89a5-6a49cc5ef4b2	UNCLASSIFIED	jpeg	2
710	9b46df8a-58df-4051-97bd-5acbbb38b481	UNCLASSIFIED	jpeg	4
711	41214a8e-8913-452c-8398-d977453f1308	UNCLASSIFIED	png	7
712	7b0c2f58-7b47-4cd4-af16-a268b5dc5cd1	UNCLASSIFIED	png	5
713	25767c56-0023-43b9-b844-e9e84d08d8a7	UNCLASSIFIED	png	2
714	5b00690e-651b-494e-8c8f-8b9084d44dc6	UNCLASSIFIED	png	4
715	2e4cf043-9610-43d6-8630-6dc503dd7ca4	UNCLASSIFIED	jpeg	7
716	1ccbe729-a2c3-4c1b-ad4a-eb018bca1911	UNCLASSIFIED	jpeg	5
717	e521bff2-ffd7-4562-bb99-a998cf4c3c18	UNCLASSIFIED	jpeg	2
718	986af084-29d4-44c2-9fef-74dcffeb7ced	UNCLASSIFIED	jpeg	4
719	b98b25ed-2b25-418b-a7dc-0a011ebe9be0	UNCLASSIFIED	jpeg	7
720	4cac6461-d658-40df-895d-280c8509bf74	UNCLASSIFIED	jpeg	5
721	d6c6d539-d94f-4230-a035-bc6506c9a424	UNCLASSIFIED	jpeg	2
722	294fdfaf-e5f0-492c-85e8-801b994332f4	UNCLASSIFIED	jpeg	4
723	01d44784-e0ed-4efa-993d-b448a83f532a	UNCLASSIFIED	jpeg	7
724	9af01f16-7a17-4977-ad8a-e05a9b4f634c	UNCLASSIFIED	jpeg	5
725	a9cb3e4e-945f-495e-aff3-e06220873b54	UNCLASSIFIED	jpeg	2
726	4b2ce7b3-6c6a-4460-a7e0-0620dfac977c	UNCLASSIFIED	jpeg	4
727	c653cbb4-8158-46e7-b909-12c8185265b8	UNCLASSIFIED	jpeg	7
728	b94fb0b1-5d02-4fa4-9a03-e96914aec835	UNCLASSIFIED	jpeg	5
729	97e633ab-b29f-4570-8fdc-110f5695e141	UNCLASSIFIED	jpeg	2
730	cfab3ac7-0913-477c-bc50-04955b3b6e39	UNCLASSIFIED	jpeg	4
731	1e8cdbd0-c1e6-42c1-93e7-07f04d43c42b	UNCLASSIFIED	jpeg	7
732	4c2e7b35-e2ea-4c08-bd4c-18d0b22955dc	UNCLASSIFIED	jpeg	5
733	c86c6440-7aa8-4065-a1d6-68b5edbbacdf	UNCLASSIFIED	jpeg	2
734	a1573a15-f172-4911-80c7-2343487bfe73	UNCLASSIFIED	jpeg	4
735	af77be42-9f61-49e2-8ee3-61c70666113c	UNCLASSIFIED	png	7
736	11079666-48f3-41b3-9669-ff798debcb87	UNCLASSIFIED	png	5
737	e99f4ed4-67e8-4a40-bfb5-a31336a59ef1	UNCLASSIFIED	png	2
738	ea570cba-67dc-49f9-8864-2a522a3442f4	UNCLASSIFIED	png	4
739	0721fb7c-8656-41a4-a1a3-3b8116f6ed42	UNCLASSIFIED	png	7
740	9a017fec-a6ff-41e5-a545-b89f8501cf95	UNCLASSIFIED	png	5
741	ae2af892-3a92-4dba-a4c5-d88ff60c11ab	UNCLASSIFIED	png	2
742	a47d34cb-0757-4544-963a-54f3f4993852	UNCLASSIFIED	png	4
743	7abc2761-a786-4fba-8b39-e9c00bdc80b5	UNCLASSIFIED	png	7
744	1dbcbe2e-774e-452f-8c75-b515146648f0	UNCLASSIFIED	png	5
745	6598d06f-3bec-4ce2-8493-b1bbd2f3809d	UNCLASSIFIED	png	2
746	e1163848-1cf8-498f-9683-fe17600baad2	UNCLASSIFIED	png	4
747	d6869447-6693-4ed1-8385-57216573cd40	UNCLASSIFIED	jpeg	7
748	e29e01bd-0aa3-4a91-86d2-cd08f79ef9bc	UNCLASSIFIED	jpeg	5
749	94004f9f-47c8-4e6b-9439-2d7345b461fc	UNCLASSIFIED	jpeg	2
750	ea28febc-6f4a-45c5-950a-b652b3cd2ec6	UNCLASSIFIED	jpeg	4
751	b224e6c4-5d6e-47da-9c05-5269122ccbf3	UNCLASSIFIED	jpeg	7
752	0081bd03-95ca-41ca-92a4-96d5d3215596	UNCLASSIFIED	jpeg	5
753	0544e06c-3cba-43cc-aa95-d9c57b7d538d	UNCLASSIFIED	jpeg	2
754	d20b8134-4c66-44d7-a6a1-1f4fa0b10761	UNCLASSIFIED//FOR OFFICIAL USE ONLY	jpeg	4
755	97f2ae0c-04ec-4411-b9b0-c6f300d6b3c5	UNCLASSIFIED	jpeg	7
756	24ffbd3d-8550-4358-8d86-5a7879436950	UNCLASSIFIED	jpeg	5
757	8c440156-48b6-4c4b-8bc6-af7d594a4cfb	UNCLASSIFIED	jpeg	2
758	57c949c1-9815-4922-aac7-389640e867f9	UNCLASSIFIED	jpeg	4
759	9d2d9335-8956-49fe-832e-e7f5b1709893	UNCLASSIFIED	jpeg	7
760	8b5517fc-b467-4e4d-ac7d-51a65a7a3c2e	UNCLASSIFIED	jpeg	5
761	fc570faf-ddd8-4843-9012-381e8a157fec	UNCLASSIFIED	jpeg	2
762	2466bf19-4491-4755-a2bf-d47210e86c91	UNCLASSIFIED	jpeg	4
763	a26e1baa-af46-41e6-9123-c10f743e1428	UNCLASSIFIED	jpeg	8
764	19b6db9e-f0d4-41af-b5c2-ee7fb5415067	UNCLASSIFIED	jpeg	6
765	1c1d9846-a965-43b9-9da0-c2acd4633d27	UNCLASSIFIED	png	8
766	f817bdcf-8c8d-4065-8601-920f5074c471	UNCLASSIFIED	png	6
767	d213e2fa-ffb4-45d2-b05c-59aa76a3cfd6	UNCLASSIFIED	png	8
768	db79c1e8-dfd2-4366-9907-653de738ec4f	UNCLASSIFIED	png	6
769	17750324-1e53-4a1a-85f3-cf70a33a3588	UNCLASSIFIED	jpeg	8
770	12c97659-4089-4abf-b96d-7e64987afdbf	UNCLASSIFIED	jpeg	6
771	ba8fa7d7-a941-4570-b7a6-ef660d67ec63	UNCLASSIFIED	jpeg	8
772	c5700e98-627b-480f-ae0d-370659ee8ed8	UNCLASSIFIED	jpeg	6
773	3ef91211-2a5f-4ad1-b01f-30a41a309697	UNCLASSIFIED	jpeg	8
774	b03aa579-2c01-4aba-94f7-bc0c0020bbb6	UNCLASSIFIED	jpeg	6
775	980190fc-6d98-4db1-87c6-e420d329a012	UNCLASSIFIED	jpeg	8
776	9fe8986a-8453-4caf-81ec-781b7d5709f2	UNCLASSIFIED	jpeg	6
777	efe11a79-b3b4-45db-9b07-95914181f77a	UNCLASSIFIED	png	8
778	79fcd327-7254-453d-b55a-7a339ca8b56c	UNCLASSIFIED	png	6
779	11f549d4-5dab-43ec-91b5-9903608ea9f0	UNCLASSIFIED	png	8
780	8f38476a-85b6-4094-b66d-8a5043fd1921	UNCLASSIFIED	png	6
781	065ca7b5-060c-44c9-bd93-bd661b23bceb	UNCLASSIFIED	jpeg	8
782	51f7e744-1bef-4cbc-8fe6-827895a3b112	UNCLASSIFIED	jpeg	6
783	2cb64396-2e36-4553-a03e-275d7076a293	UNCLASSIFIED	png	8
784	1ba7102f-9aa8-4c0c-858e-e262266b3bec	UNCLASSIFIED	png	6
785	076f6c27-18ca-4214-bf68-12afad968641	UNCLASSIFIED	jpeg	8
786	193e5692-e452-42bf-966b-84dfa746ef2e	UNCLASSIFIED	jpeg	6
787	a7f6d09a-3578-413a-8585-1c71eb02a304	UNCLASSIFIED	jpeg	8
788	8892709d-189c-4417-aeab-3fbc5c15bba7	UNCLASSIFIED	jpeg	6
789	54251d6c-c0bf-474c-b7d0-004f78e5871a	UNCLASSIFIED	jpeg	8
790	7ad1d06c-c216-4a3e-93d7-233d529ea020	UNCLASSIFIED	jpeg	6
791	02e3f8f7-aa7f-4764-bff2-62d19bd1ef88	UNCLASSIFIED	jpeg	8
792	3aa46f18-f584-4549-b356-2cd36b748c9e	UNCLASSIFIED	jpeg	6
793	a1a550fa-8623-4007-a0eb-c1ad19fa3630	UNCLASSIFIED	jpeg	8
794	0c0141c9-b152-4a07-a7f0-d63bed1be25a	UNCLASSIFIED	jpeg	6
795	acfd3de1-a21b-4832-8daa-2b29b03dfb4e	UNCLASSIFIED	jpeg	8
796	f1898810-e947-4ca7-a6a2-6b4eab2669b6	UNCLASSIFIED	jpeg	6
797	0674badd-cef6-44ab-9271-d28b2de1c15c	UNCLASSIFIED	jpeg	8
798	ac2b78a7-3d4c-4694-9a5f-ca63392b637c	UNCLASSIFIED	jpeg	6
799	bd4382d1-1dc2-44f5-9cae-c3c33c67014e	UNCLASSIFIED	jpeg	8
800	c96a48e7-7842-48ff-a90d-87135468f917	UNCLASSIFIED	jpeg	6
801	d4b30db4-9ded-4d6c-8fac-595e097fb63c	UNCLASSIFIED	jpeg	8
802	4fd038a4-57f3-41c7-a135-fc7c2ce4f46c	UNCLASSIFIED	jpeg	6
803	70976727-d629-4f0e-9d20-fae4bcfcc29d	UNCLASSIFIED	png	8
804	5ef60c30-1790-421e-a2ee-d1f48dff3d93	UNCLASSIFIED	png	6
805	487f6286-27a3-4acd-b386-0b6d62895ecf	UNCLASSIFIED	jpeg	8
806	19b951ba-1018-40c8-a7ae-8edcb3f87035	UNCLASSIFIED	jpeg	6
807	fb77d5bd-0ad8-41c2-bed4-e4b259660522	UNCLASSIFIED	jpeg	8
808	63d26631-3a93-4df9-97cf-61a14e6e22fc	UNCLASSIFIED	jpeg	6
809	897386f4-13fc-41a2-90d3-e484ae8f0c89	UNCLASSIFIED	jpeg	8
810	aa55431f-50c6-4891-8c75-704c443bf158	UNCLASSIFIED	jpeg	6
811	3955c79e-6a72-4472-9b78-4f05ebaa0b17	UNCLASSIFIED	jpeg	8
812	ca48ddb6-3b04-4f2c-9b66-faaed66a8964	UNCLASSIFIED	jpeg	6
813	a98b568c-3a22-4720-915a-7da89fcecdc2	UNCLASSIFIED	png	8
814	922bff87-0b83-45ec-a6b4-f892221059b8	UNCLASSIFIED	png	6
815	dd12987c-ef2c-4c7b-bfc6-ca148eb88133	UNCLASSIFIED	png	8
816	1bc55681-8da0-49d3-a9eb-d87680861c41	UNCLASSIFIED	png	6
817	3d71db1f-6d0c-458a-ac29-e363a9f1b4ad	UNCLASSIFIED	jpeg	8
818	ef6981e9-6d64-4496-9fc3-2d23771685d2	UNCLASSIFIED	jpeg	6
819	f59d0495-7a9c-44c2-be15-6932e2411a93	UNCLASSIFIED	jpeg	8
820	dcdcd3d8-47c2-4d0d-b02a-c3550354a991	UNCLASSIFIED	jpeg	6
821	7891f2f4-1a6e-4855-9c19-f4f17f018819	UNCLASSIFIED	png	8
822	e6f7eb12-3c11-46da-8216-6e7e4cbc0cf0	UNCLASSIFIED	png	6
823	788eb1ad-aa34-4c63-bc38-0ad7f09b6fd7	UNCLASSIFIED	png	8
824	e7ab83ee-f220-4a16-ae7d-ca065f100ac7	UNCLASSIFIED	png	6
825	58b546d0-1e04-49b2-a13f-0bfd4cf8084b	UNCLASSIFIED	jpeg	8
826	1fc8ed4e-8d57-4b6a-95be-6ccda4e54ad2	UNCLASSIFIED	jpeg	6
827	5574bb57-3cda-42df-aaaa-83bd794d9660	UNCLASSIFIED	jpeg	8
828	83530eb5-3b64-4329-8233-a7a0c41fbaca	UNCLASSIFIED	jpeg	6
829	d4dd8a65-233a-4ac8-b48d-18086715e745	UNCLASSIFIED	png	8
830	41201c04-536d-45b2-81a3-d23031ce96cc	UNCLASSIFIED	png	6
831	a76db409-3f38-49b8-bdba-da0dc07c97e3	UNCLASSIFIED	jpeg	8
832	5bca4125-6923-4ddd-923e-4c33b5dbce31	UNCLASSIFIED	jpeg	6
833	c1d4897f-9d09-47f7-8048-b38e4fe7d850	UNCLASSIFIED	png	8
834	f7f5e29e-d580-4f37-8aca-246c14fb5475	UNCLASSIFIED	png	6
835	873eaac3-a50b-446e-9b93-bc0d3958e8dd	UNCLASSIFIED	jpeg	8
836	70bec9e1-e5f8-4bf5-986c-13fbc2984477	UNCLASSIFIED	jpeg	6
837	ca23fad8-d33f-430f-9f46-afeea4ee91ac	UNCLASSIFIED	jpeg	8
838	9d04da53-d7bf-43b5-acb0-3c9a53fe8c1c	UNCLASSIFIED	jpeg	6
839	607b2719-6c91-491f-bbba-f7af57e89fa0	UNCLASSIFIED	jpeg	8
840	2d82cbaf-7950-4222-94d3-2a032f902665	UNCLASSIFIED	jpeg	6
841	780feb19-be43-4212-8fab-4ea0fb8645a5	UNCLASSIFIED	jpeg	8
842	e0d41683-ef03-4dbd-82c3-7e6e929a762b	UNCLASSIFIED	jpeg	6
843	5425e224-a289-486e-b1d3-d08a7340fbb2	UNCLASSIFIED	jpeg	8
844	ab5bfa9f-f94c-463d-8bbf-9d1b08a0e315	UNCLASSIFIED	jpeg	6
845	8d24f279-be33-457b-ae66-e68734ba0794	UNCLASSIFIED	jpeg	8
846	d9fbd424-fe5d-4daa-830d-549bf07b6338	UNCLASSIFIED	jpeg	6
847	ade024bc-767e-45f6-8388-348a35625a2f	UNCLASSIFIED	jpeg	8
848	682d5f0b-31e3-4b66-8c90-cb9c4385c558	UNCLASSIFIED	jpeg	6
849	5d6b5b38-86f6-46a5-a943-a44463d1435e	UNCLASSIFIED	jpeg	8
850	1cc881f1-1792-44c9-b921-f6144fe2cfd8	UNCLASSIFIED	jpeg	6
851	9fc6834a-0dea-4be2-a247-b457c8fb0e6d	UNCLASSIFIED	jpeg	8
852	dd5df244-96ff-41a9-87b3-de59593c51cf	UNCLASSIFIED	jpeg	6
853	4c03eb80-b331-410e-a6dd-1fcf686c67ba	UNCLASSIFIED	png	8
854	76ab72cd-75c2-4b85-9000-3b2d8f3a8c34	UNCLASSIFIED	png	6
855	18fe2e5e-1027-4fcf-9988-6e9e69f63d8e	UNCLASSIFIED	png	8
856	b0a24842-c860-4ea9-a7cb-8c719657019a	UNCLASSIFIED	png	6
857	147ce15c-6b82-4e50-abd6-c8ab0b5f942d	UNCLASSIFIED	jpeg	8
858	a28984c3-a423-4552-8567-ee84ab308766	UNCLASSIFIED	jpeg	6
859	4256cdd0-4c64-473d-bd89-e92d6b030ac8	UNCLASSIFIED	jpeg	8
860	05c7430c-0d4f-4d06-bd0d-426f27f4b2ef	UNCLASSIFIED	jpeg	6
861	f7bb863b-f1ad-46b4-b9e0-7720d5b2666d	UNCLASSIFIED	jpeg	8
862	5e6bdec7-1870-425d-8e02-c25bba21289b	UNCLASSIFIED	jpeg	6
863	30afe81e-d4aa-4ec6-bdb5-79524c5ea9d4	UNCLASSIFIED	png	8
864	2c55ff68-a3d5-4028-8263-92c4c93aaa6c	UNCLASSIFIED	png	6
865	76f82b14-fcc0-4fea-9591-39047391d210	UNCLASSIFIED	png	8
866	68493cd9-fa17-42e7-8529-f3e3f2c4b0c4	UNCLASSIFIED	png	6
867	61545b06-1018-4ef3-adc3-834de6fac555	UNCLASSIFIED	jpeg	8
868	16bbe64e-04c3-4526-8adf-0edc170b5d35	UNCLASSIFIED	jpeg	6
869	c5c206a3-d7b7-4bc3-991a-9dc8119a51b1	UNCLASSIFIED	png	8
870	7c12cdb6-d942-46ab-84a9-75c51d30a116	UNCLASSIFIED	png	6
871	3a606d1d-291c-428d-8591-50ca704f7da0	UNCLASSIFIED	jpeg	8
872	5094e064-b3b2-4d3e-b2f2-6852905b335f	UNCLASSIFIED	jpeg	6
873	271840e9-c11c-4fbe-9297-ca5542b9bd0b	UNCLASSIFIED	jpeg	8
874	c3606baf-c3f2-4a7d-a96a-6beb9257ac09	UNCLASSIFIED	jpeg	6
875	9ce49385-46e8-4df3-bfa9-12c902037c58	UNCLASSIFIED	jpeg	8
876	58864b8c-680b-429f-84ed-bda703fb6eae	UNCLASSIFIED	jpeg	6
877	964682c1-2886-4d3a-b5fb-8ce39eb68dac	UNCLASSIFIED	jpeg	8
878	448c6a3e-28c7-4ace-8e25-e60dfc1270e1	UNCLASSIFIED	jpeg	6
879	07174836-a6be-4b3c-8710-671f527554d5	UNCLASSIFIED	jpeg	8
880	66d56948-3924-4b9c-a2fe-499e3f93c363	UNCLASSIFIED	jpeg	6
881	fc05f4c1-61ca-423f-94a9-e0d92956dfdf	UNCLASSIFIED	png	8
882	dfee7d6f-7db9-40b6-9c9c-e889c455b4a9	UNCLASSIFIED	png	6
883	6ac29732-c0e8-4c9a-ae7d-2ed4732ddc58	UNCLASSIFIED	jpeg	8
884	392fc9ef-ef83-4751-b47b-208f6e3bd35a	UNCLASSIFIED	jpeg	6
885	d79d1e53-5be7-42ee-b715-f7e19d8f4413	UNCLASSIFIED	jpeg	8
886	0ca15489-51b2-408c-ab62-3a758cc873cd	UNCLASSIFIED	jpeg	6
887	2bc98684-99c4-4e6a-9157-0d5acf2cf592	UNCLASSIFIED	jpeg	8
888	fe6f533c-3289-4182-a913-44fe4fd5c88b	UNCLASSIFIED	jpeg	6
889	97780fd5-f616-43c1-adef-e6bd1887e257	UNCLASSIFIED	jpeg	8
890	e89d06f3-f053-487f-adcf-ff99f87cea07	UNCLASSIFIED	jpeg	6
891	bb56baab-36d1-4b2e-8569-2f29d3b9e1d3	UNCLASSIFIED	jpeg	8
892	050c95ed-72d7-4414-b4cb-3a92d0d51683	UNCLASSIFIED	jpeg	6
893	399e259a-97cc-42e3-84a2-66206ff79ada	UNCLASSIFIED	jpeg	8
894	b14b864e-98f2-440f-b412-39f4ff6263b0	UNCLASSIFIED	jpeg	6
895	02d6558a-452e-495b-88c7-bb973bffb61b	UNCLASSIFIED	jpeg	8
896	54df5a59-c308-4805-be35-ff5031d77bd0	UNCLASSIFIED	jpeg	6
897	4457236e-5a1b-413f-b7e8-e654e9e0e6a1	UNCLASSIFIED	jpeg	8
898	3cd8db36-81b0-41cd-b02b-2276221d3c28	UNCLASSIFIED	jpeg	6
899	d7202d35-e37c-472c-a3d2-a8534141e38a	UNCLASSIFIED	jpeg	8
900	1e54cd11-7bee-43f0-84b2-6d5f222643c7	UNCLASSIFIED	jpeg	6
901	3d933353-d444-4324-8542-85b0dbe16348	UNCLASSIFIED	jpeg	8
902	00730af2-9c16-4ae4-afe4-5e47eeae15e1	UNCLASSIFIED	jpeg	6
903	4feab7fc-8f17-4a66-b24f-22e4279ac2e3	UNCLASSIFIED	jpeg	8
904	afdf61c3-9cb4-4055-9524-0d06eaa95ffb	UNCLASSIFIED	jpeg	6
905	18f36651-dcbf-413c-9894-2c3bfaa9861c	UNCLASSIFIED	jpeg	8
906	e05474a7-3fcd-4728-bf21-bc8fbe7a87e8	UNCLASSIFIED	jpeg	6
907	b8ed62cb-80e6-467e-96c5-64db11a49d26	UNCLASSIFIED	png	8
908	90d716cb-0bc4-4c94-8285-a45042ac4ea6	UNCLASSIFIED	png	6
909	898bb26f-aab3-4a1a-b326-f0e7e166cf3d	UNCLASSIFIED	png	8
910	a025867d-0727-41ee-8094-7d4d07bbb8f7	UNCLASSIFIED	jpeg	6
911	78493fc4-1fd5-412f-9d85-974e2bf170e9	UNCLASSIFIED	jpeg	8
912	c0bdcdcc-b4bd-424f-b0d0-3894d8c192f0	UNCLASSIFIED	jpeg	6
913	dfcca664-85a2-4a85-b03b-09df1908a76e	UNCLASSIFIED	jpeg	8
914	4ae46f4b-ebcc-40e0-be9d-c27496cc2ba6	UNCLASSIFIED	jpeg	6
915	8c53c0d6-2328-4d7d-a74d-96ad93b1a8f3	UNCLASSIFIED	jpeg	8
916	d15e845c-c3dd-4e94-8e3a-2642f258041e	UNCLASSIFIED	jpeg	6
917	b8392ec6-eec0-4ade-88eb-7d42ecbcc7ed	UNCLASSIFIED	jpeg	8
918	3d1a8827-60db-4dd2-82b5-69b9f5752cb6	UNCLASSIFIED	jpeg	6
919	fcc2b19c-af6d-4096-9ba1-13f45638c7be	UNCLASSIFIED	jpeg	8
920	0dd58941-18c6-44da-936a-d1e7f241e110	UNCLASSIFIED	jpeg	6
921	c651a012-585f-4c5f-a098-5d8749610d8f	UNCLASSIFIED	jpeg	8
922	03440bd1-4c4e-4687-b4fc-d0647a4bcbab	UNCLASSIFIED	jpeg	6
923	12b45be3-3b52-41fa-b59f-7a8be318615e	UNCLASSIFIED	png	8
924	e6304751-d41b-41a0-9ef9-673b1908ddac	UNCLASSIFIED	png	6
925	9d63cbc4-4338-4b56-8f23-8f176f79d7ef	UNCLASSIFIED	jpeg	8
926	f9947a4b-4649-4737-b643-d79aedf7c1a7	UNCLASSIFIED	jpeg	6
927	6d8c9dcd-b9bd-4271-a1fd-04af4ec55c90	UNCLASSIFIED	jpeg	8
928	7d6bfd37-5b34-4615-bade-af55ea333787	UNCLASSIFIED	jpeg	6
929	6a6bca58-05b5-477d-a75a-1a45c37f3a77	UNCLASSIFIED	jpeg	8
930	4dfc5e0b-1d6b-42ce-a82a-cca620fe6fd3	UNCLASSIFIED	jpeg	6
931	63269338-4525-455f-b02e-d6574531ef1c	UNCLASSIFIED	jpeg	8
932	2184b6af-70b2-4ea4-aedc-a9c340c2ca2c	UNCLASSIFIED	jpeg	6
933	adedb128-3e34-48b1-87c4-68cbe73dfd57	UNCLASSIFIED	jpeg	8
934	cf647107-b868-4261-8028-ac6b81a0531a	UNCLASSIFIED	jpeg	6
935	aaa18fc8-fd66-4500-ac1e-6b7241cc9e32	UNCLASSIFIED	jpeg	8
936	c78f1ee4-7e7b-437b-8f0f-e176a87d48d5	UNCLASSIFIED	jpeg	6
937	087bb026-8980-425b-99a1-844bd32f06e3	UNCLASSIFIED	jpeg	8
938	9417c9e9-3f7f-4219-81e4-3e5dc0cc7e30	UNCLASSIFIED	jpeg	6
939	af79432f-9867-4c70-b7c6-0aa22c84b6cc	UNCLASSIFIED	jpeg	8
940	464ef4b5-a270-430a-9d26-7b676fee26b8	UNCLASSIFIED	jpeg	6
941	700ef53e-fa1d-4185-9bcf-4b8cb586f790	UNCLASSIFIED	jpeg	8
942	81fecd90-603c-4b1e-97b9-9d50eff00bd0	UNCLASSIFIED	jpeg	6
943	9c25b990-3f8a-4920-b7b0-6b32822d385c	UNCLASSIFIED	jpeg	8
944	b60ed48e-c6a9-4519-b8af-da35a9c0358c	UNCLASSIFIED	jpeg	6
945	00c330d6-dab0-4e8e-a4f2-5d042ac7ea8b	UNCLASSIFIED	jpeg	8
946	70920ed4-5742-485b-9c3f-6a06a7d0bc36	UNCLASSIFIED	jpeg	6
947	4cccd7f1-1ce8-4be9-8c43-45d08af8749c	UNCLASSIFIED	jpeg	8
948	c254a00e-f767-4942-b575-03e4567bb08e	UNCLASSIFIED	jpeg	6
949	75df1528-7880-4eee-b08b-3b3c287336a0	UNCLASSIFIED	jpeg	8
950	56a787fa-dd71-4941-8caa-2628b345bebc	UNCLASSIFIED	jpeg	6
951	26cad1ee-fdde-474d-ad9b-360948b29e0e	UNCLASSIFIED	jpeg	8
952	dcfbdf49-1241-468f-aa33-411d14cb5548	UNCLASSIFIED//FOR OFFICIAL USE ONLY	jpeg	6
953	1745e346-3a67-45c1-bd19-13bb41900f21	UNCLASSIFIED	png	8
954	5ccffa7f-3e95-4964-8a8d-70797497e8e8	UNCLASSIFIED	png	6
955	54228414-e01a-4c0a-bea8-b7a79f7f2b02	UNCLASSIFIED	png	8
956	8e7f0fe1-536b-45c7-8bfc-ac5b7c434f64	UNCLASSIFIED	png	6
957	731db53d-8ff2-42d3-86e5-8f51e9d37f38	UNCLASSIFIED	png	8
958	ee0b959c-6ad4-47c3-b0de-f244593813dd	UNCLASSIFIED	png	6
959	81bcf02b-62bb-4e53-83b7-4c67f82e9f8f	UNCLASSIFIED	png	8
960	c4c9c7fc-270c-4445-864c-d60441edd54d	UNCLASSIFIED	png	6
961	7e4e148c-98d8-4720-b3b8-72e1ddea4735	UNCLASSIFIED	jpeg	8
962	5025141f-4960-40be-85fc-29f218238c69	UNCLASSIFIED	jpeg	6
963	480a545f-d500-4af3-a097-39246f82546b	UNCLASSIFIED	jpeg	8
964	48e450d4-839a-4ab7-b232-a1a67f39d431	UNCLASSIFIED	jpeg	6
965	c8f9d079-cb00-41cb-ae2f-85fcaa9edf06	UNCLASSIFIED	jpeg	8
966	fdb31ba8-afc0-4429-9fb9-2248f6b1cbc5	UNCLASSIFIED	jpeg	6
967	c8966c41-8746-4aa6-8c63-6c398242d7d5	UNCLASSIFIED	jpeg	8
968	b78ab8f2-73ec-4612-9582-d668d0b2b74a	UNCLASSIFIED	jpeg	6
969	adefeb3b-d289-42f1-87fe-5c2d5c50008d	UNCLASSIFIED	jpeg	8
970	93e4277e-c8d9-4222-b6e7-a90472f83308	UNCLASSIFIED	jpeg	6
971	71ae7225-8cf3-4168-a287-99861d8bdd9e	UNCLASSIFIED	jpeg	8
972	48fa7091-151c-4ea8-a1ed-4e917c3bed3e	UNCLASSIFIED	jpeg	6
973	53a30a3b-6f26-4a93-bfbe-9b78d253f7af	UNCLASSIFIED	jpeg	8
974	554ed768-d8c3-4517-9921-60445424e54b	UNCLASSIFIED	jpeg	6
975	407c1c76-31d0-4392-b70e-3ef30ee113fe	UNCLASSIFIED	jpeg	8
976	7e9c2cf4-b25e-4ac6-abcc-b6066bf44b4e	UNCLASSIFIED	jpeg	6
977	26476ad3-a3f6-4010-9b29-f0ca5f1e55d4	UNCLASSIFIED	jpeg	8
978	a55fe73c-25c7-4b67-9780-8a775b5a10d6	UNCLASSIFIED	jpeg	6
979	8eb31687-bd53-46d4-903e-4ebd3f74a7f4	UNCLASSIFIED	jpeg	8
980	e98bba90-d8e9-4f91-88b6-11ab15f3dc3c	UNCLASSIFIED	jpeg	6
981	58b42c7e-b07d-4778-948b-49da2a1031da	UNCLASSIFIED	png	8
982	1e419ff2-a3b6-453e-b87c-bfd3e2346f46	UNCLASSIFIED	png	6
983	7f9af0b6-77eb-4ec5-9848-d6550714c55b	UNCLASSIFIED	jpeg	8
984	b164ffed-8af7-44eb-bbab-9daefbbda37d	UNCLASSIFIED	jpeg	6
985	e448fbf9-be34-4f95-b191-1753b16ee8dd	UNCLASSIFIED	jpeg	8
986	3f140c25-e943-4788-86a2-403c80e2387f	UNCLASSIFIED	jpeg	6
987	a2907c36-b274-4fa4-8dcc-8e893deb4523	UNCLASSIFIED	png	8
988	a8f15400-2b48-4e15-b99d-1535225798fc	UNCLASSIFIED	png	6
989	6401e293-e4a3-40af-9834-bb28c6154dc6	UNCLASSIFIED	jpeg	8
990	533f2ae0-3821-48ba-b704-12012eed91a3	UNCLASSIFIED	jpeg	6
991	ec81b816-5f6d-48d1-a47f-2932a78072e0	UNCLASSIFIED	jpeg	8
992	b597fcec-4d12-4c7e-8473-c10595bf3ec7	UNCLASSIFIED	jpeg	6
993	9c2d8d01-8962-4dd3-84b2-41537121b99c	UNCLASSIFIED	jpeg	8
994	09ca65ed-2f15-4f66-ba73-e5109c357785	UNCLASSIFIED	jpeg	6
995	90cf5de0-59a0-4d78-b955-0e35aadb9d90	UNCLASSIFIED	jpeg	8
996	3b0a6e63-4f89-4787-8085-bfec2bdbc56e	UNCLASSIFIED	jpeg	6
997	7f48c6b2-d4fb-488d-bf9d-1fd228117189	UNCLASSIFIED	jpeg	8
998	e0c7cfec-d665-4af3-9def-2880545a7ab1	UNCLASSIFIED	jpeg	6
999	1851c6a6-8cc5-48c5-9739-d836e3f1c59f	UNCLASSIFIED	jpeg	8
1000	12ddadfd-774f-48dd-968c-9d43c11534de	UNCLASSIFIED	jpeg	6
1001	828709fa-01ff-4296-9b10-0b158ba930f0	UNCLASSIFIED	png	8
1002	58f21f9e-1d71-4a79-a1bf-c466abbe316e	UNCLASSIFIED	png	6
1003	ebc0e887-c784-4f6e-8bae-bf975d06d827	UNCLASSIFIED	png	8
1004	564474e7-808e-4e8c-9c36-19690f4bda27	UNCLASSIFIED	png	6
1005	180d32d8-b03b-43f4-9f06-55a7796ff6e1	UNCLASSIFIED	png	8
1006	5d0f24b7-e7da-4f39-b5e1-e1b4e1cf48f6	UNCLASSIFIED	png	6
1007	b1acda3d-5d32-4792-92fd-a25de61ea03f	UNCLASSIFIED	png	8
1008	981e5cc0-d80c-4eaa-b840-4f7d80efb01a	UNCLASSIFIED	png	6
1009	566317ff-88f1-43ea-bd6e-3dd5a2e73297	UNCLASSIFIED	jpeg	8
1010	cd1ec2e9-45bf-4b44-8d50-bf8fe5667f97	UNCLASSIFIED	jpeg	6
1011	dec56aeb-2a3d-4fa5-bdfc-f70a1b13fb29	UNCLASSIFIED	jpeg	8
1012	63ec31a9-a201-40fc-82f1-3e8d32d8fe92	UNCLASSIFIED	jpeg	6
1013	75bcf0c4-171b-445a-883c-bfcbf245ebb9	UNCLASSIFIED	png	8
1014	e1612f21-a2b2-4e54-a741-ce0adddb4aa6	UNCLASSIFIED	png	6
1015	f159769f-0777-4013-a93a-aad14b838bff	UNCLASSIFIED	png	8
1016	62d0864c-6a77-4dca-9ef7-0e99a187ab72	UNCLASSIFIED	png	6
1017	f8722b5f-8953-454e-9bf8-0df927328f1d	UNCLASSIFIED	png	8
1018	eba191a3-283c-4a82-80ad-f86f5f2581c8	UNCLASSIFIED	png	6
1019	6018d9d1-e15f-4475-8eb2-4c1cad1c25d0	UNCLASSIFIED	png	8
1020	27a41922-92c6-4d3c-9203-8d957dbff830	UNCLASSIFIED	png	6
1021	c084daa9-c91f-40b4-ad0f-9d74858c2214	UNCLASSIFIED	jpeg	8
1022	a07c0da3-4c48-4ea3-95fe-522e28124d7a	UNCLASSIFIED	jpeg	6
1023	c2692980-9789-4bb8-b306-751d1f72634e	UNCLASSIFIED	jpeg	8
1024	c91b9616-6c1d-4318-9806-31a9f00676ed	UNCLASSIFIED	jpeg	6
1025	4593c7ca-aa18-4395-b817-f9f148f0e322	UNCLASSIFIED	jpeg	8
1026	76aaef8b-12d1-4574-9e77-dd1e8e9afa14	UNCLASSIFIED	jpeg	6
1027	3b552529-eca9-47ea-9bc1-5cf0d261141c	UNCLASSIFIED	jpeg	8
1028	da6a949a-613a-45d9-8097-7495e192e6dd	UNCLASSIFIED	jpeg	6
1029	e4ecc22d-0561-4f50-ba71-46efb13fd971	UNCLASSIFIED	png	8
1030	30dca417-2a46-477a-8f25-1e10e1e3c6b8	UNCLASSIFIED	png	6
1031	bad88cf6-e2ad-4b98-8777-4af5c43faa23	UNCLASSIFIED	png	8
1032	0e37f989-5e5b-469b-b345-2e029a9ed528	UNCLASSIFIED	png	6
1033	acb35d81-9dbb-45f9-ac39-99264ab8bbc0	UNCLASSIFIED	jpeg	8
1034	d87e92a9-f84b-417f-b6d6-12e2c9c02d7b	UNCLASSIFIED	jpeg	6
1035	56918154-dc49-4022-82cf-9bf0de30a122	UNCLASSIFIED	jpeg	8
1036	66311506-503f-4a3c-b078-d99493dce0e7	UNCLASSIFIED	jpeg	6
1037	482a80b6-2bb1-4945-802d-f14af166e24a	UNCLASSIFIED	jpeg	8
1038	455deb56-9215-4bdf-b110-1d4c5e624a93	UNCLASSIFIED	jpeg	6
1039	7364ede9-1f21-4cd2-803a-155ec8afd33c	UNCLASSIFIED	jpeg	8
1040	04b525f1-5df7-4f1e-a319-d7341329a937	UNCLASSIFIED	jpeg	6
1041	d0300be6-ab43-45c2-bc8b-76ab792569b6	UNCLASSIFIED	jpeg	8
1042	d72f32d0-9ae3-4e1b-b9cc-e3e5989aa99f	UNCLASSIFIED	jpeg	6
1043	58b1ee20-140f-41fc-89c3-3af0de20c8b4	UNCLASSIFIED	jpeg	8
1044	fb8b7f7d-b429-4e7a-a268-4048f455d8b4	UNCLASSIFIED	jpeg	6
1045	2dcec8a5-6665-4982-9398-600926ede687	UNCLASSIFIED	jpeg	8
1046	8247f00c-2b23-46ca-b02e-59b95c2be7a9	UNCLASSIFIED	jpeg	6
1047	02df9788-d2fd-4420-bf4f-802ab9806097	UNCLASSIFIED	png	8
1048	6151d79a-a260-4ad3-acae-6c53397c50bb	UNCLASSIFIED	png	6
1049	33d22009-138c-447b-836e-5ad3e66fabb3	UNCLASSIFIED	jpeg	8
1050	de5d2afd-18ad-4ca3-8b7d-5530b3636a35	UNCLASSIFIED	jpeg	6
1051	eefac4d5-f2b6-485d-bc1e-0b638502334b	UNCLASSIFIED	png	8
1052	4e47d54d-7ab7-410a-bb6c-de6ff17ea5e6	UNCLASSIFIED	png	6
1053	2dce4b65-c4c4-4404-969e-07c32a7bbd4b	UNCLASSIFIED	jpeg	8
1054	b812070a-0179-4fbd-a046-0bf903fe21b3	UNCLASSIFIED	jpeg	6
1055	5f5b882e-d941-43cd-8c3a-b0da66dcc591	UNCLASSIFIED	jpeg	8
1056	72d653e0-0da5-4c42-a590-457d13adc864	UNCLASSIFIED	jpeg	6
1057	5cc03548-dc98-44b3-9253-8f1859207b64	UNCLASSIFIED//FOR OFFICIAL USE ONLY	jpeg	8
1058	d60e8ead-8206-4e3f-8e82-6564bf9f823a	UNCLASSIFIED//FOR OFFICIAL USE ONLY	jpeg	6
1059	ebef1bd3-d86a-4f24-97b1-cc6403907dcd	UNCLASSIFIED	jpeg	8
1060	d681d923-831a-4ce8-b7e8-bd93a4ca51ea	UNCLASSIFIED	jpeg	6
1061	10673f82-f40d-4563-9af1-f5bff14fc3de	UNCLASSIFIED	jpeg	8
1062	1a338b20-d146-4e53-909c-cd1eff295682	UNCLASSIFIED	jpeg	6
1063	4ce56fab-0c9e-4f71-8222-60d3c220a327	UNCLASSIFIED	jpeg	8
1064	aa70094a-4e74-43f1-95c5-2f6916ab6abe	UNCLASSIFIED	jpeg	6
1065	63d81ec4-3089-48a0-9f8e-9b8a5efaea9d	UNCLASSIFIED	jpeg	8
1066	9204c3be-826d-49eb-9d08-41d0d4475bbd	UNCLASSIFIED	jpeg	6
1067	4bebdab0-817f-44ea-871e-0051512851ee	UNCLASSIFIED	jpeg	8
1068	9a64eff3-f297-40c2-a440-90cd116318a9	UNCLASSIFIED	jpeg	6
1069	cee974c8-353f-409f-8d09-d94402ebe273	UNCLASSIFIED	jpeg	8
1070	be160594-c5a4-4a4f-a6dd-a1ad09b0db76	UNCLASSIFIED	jpeg	6
1071	859b5841-379f-4c54-8005-485c1ff9edac	UNCLASSIFIED	jpeg	8
1072	9f18c627-fa24-4cec-8c33-69f8300c9f77	UNCLASSIFIED	jpeg	6
1073	cca8829b-0e6e-491c-b69b-4a64f3184804	UNCLASSIFIED	jpeg	8
1074	0c964084-4a3b-4f5a-9a8c-d894141e4981	UNCLASSIFIED	jpeg	6
1075	ef53ffc9-76b0-4ede-a8ab-ce1c53f4f13b	UNCLASSIFIED	jpeg	8
1076	c26608f1-be44-4249-a515-d27a9b70f7af	UNCLASSIFIED	jpeg	6
1077	a4452f91-bec0-4e02-9975-71d67f43b3a8	UNCLASSIFIED	png	8
1078	91e674d5-116d-4531-8335-795ec2bb4809	UNCLASSIFIED	png	6
1079	a08241b8-b1ac-4ace-9c03-6e68e134b6e5	UNCLASSIFIED	png	8
1080	658d2e95-35e9-47b9-8dbb-07f381eb02d7	UNCLASSIFIED	png	6
1081	faf931b6-b7d1-4203-9087-f00f5870a4b7	UNCLASSIFIED	png	8
1082	baf4eaa0-a96c-496e-8da5-c3746d7bb6a3	UNCLASSIFIED	png	6
1083	c7d76af4-5516-40ba-bcc0-d2537c6a8fe8	UNCLASSIFIED	png	8
1084	9f78e84e-20bc-49b9-91bd-1a2de36c8b4c	UNCLASSIFIED	png	6
1085	97f732ac-0a6c-4e1a-8f60-c17cb38b6068	UNCLASSIFIED	jpeg	8
1086	aaf42e6d-a141-4f6f-82bd-58153ac3361f	UNCLASSIFIED	jpeg	6
1087	417fdc51-5b52-427b-9752-e3e7fe8a7bc6	UNCLASSIFIED	jpeg	8
1088	356e28ff-a5ca-48c1-9eab-20edb65c9212	UNCLASSIFIED	jpeg	6
1089	03e05cb7-1b06-43ea-bddc-7975f5f0bc43	UNCLASSIFIED	jpeg	8
1090	15045e81-5dcc-42cf-8bef-0107f08c3bb8	UNCLASSIFIED	jpeg	6
1091	0b9599c4-232c-42d8-bd5a-d72e562750f3	UNCLASSIFIED	jpeg	8
1092	ef908be3-e7fa-4d59-ab1d-037e2a8bc04e	UNCLASSIFIED	jpeg	6
1093	64b528d7-d554-443b-abba-c8dfe16362a1	UNCLASSIFIED	gif	8
1094	77aecb39-0dbb-4435-87e0-8bb4061bafd6	UNCLASSIFIED	gif	6
1095	8e3dbd0d-dd89-444a-838b-86534fdaadd8	UNCLASSIFIED	jpeg	8
1096	9832e31f-c18a-45ed-a88c-1cc41dc6e812	UNCLASSIFIED	jpeg	6
1097	9e67395c-ca7e-4028-9eaa-857c0b18bf95	UNCLASSIFIED	jpeg	8
1098	8ca4f756-3fff-47cd-b4ca-7dc9417a7c1a	UNCLASSIFIED	jpeg	6
1099	be86dbdc-15b2-4bf0-979e-e3a6c4974f6b	UNCLASSIFIED	png	8
1100	4ecf2b76-e307-45ce-921f-f526e74c9d7f	UNCLASSIFIED	png	6
1101	05e6fa93-fc6b-407b-abc1-f4f711fc6098	UNCLASSIFIED	png	8
1102	641f78ed-4be5-4488-bb4d-79b1a1531522	UNCLASSIFIED	png	6
1103	93df2d9b-80ca-43a0-a9a8-e992f94279d6	UNCLASSIFIED	png	8
1104	2ddb92fa-4670-4cb7-b44a-ff7d2858bfe6	UNCLASSIFIED	png	6
1105	e7a86887-4ca7-4bea-a634-5294430e0bd7	UNCLASSIFIED	jpeg	8
1106	2c8116f6-2904-45d3-b14a-8445e15c4f23	UNCLASSIFIED	jpeg	6
1107	6f52fe6c-8539-4c63-886d-e24bdd483ee1	UNCLASSIFIED	jpeg	8
1108	7c6bea53-18a2-4828-9c3e-8f2d88273450	UNCLASSIFIED	jpeg	6
1109	6459f5f6-6e36-4e4f-aad1-9e18c526e028	UNCLASSIFIED	jpeg	8
1110	60e14541-b115-4046-ad5c-ff616e6fa90b	UNCLASSIFIED	jpeg	6
1111	034a2349-6a3d-4a1a-a8a5-4fbeb021a051	UNCLASSIFIED	png	8
1112	df1c008d-8bf5-4062-9699-2df556e9604f	UNCLASSIFIED	png	6
1113	fd6dc686-cc80-4685-9d04-be6c5e968e0d	UNCLASSIFIED	png	8
1114	09804730-5310-40d8-90ed-a62b845ba630	UNCLASSIFIED	png	6
1115	a407c3bc-fb1f-403f-8853-ff473b15e5f0	UNCLASSIFIED	jpeg	8
1116	ec49a253-9b10-465c-b9fe-cf271d716ee1	UNCLASSIFIED	jpeg	6
1117	272f00bd-59dc-4db4-bc77-684bc06c0836	UNCLASSIFIED	png	8
1118	4e1f0cab-b800-4dd0-af25-940bc72a24b4	UNCLASSIFIED	png	6
1119	aa6692e6-f991-4eef-9564-17d39ecfc019	UNCLASSIFIED	jpeg	8
1120	c75540d1-e248-4f81-9121-a935ab6b6f3c	UNCLASSIFIED	jpeg	6
1121	cc4c347e-4dd9-4367-990a-bd7c9e13f5b8	UNCLASSIFIED	jpeg	8
1122	5382e5e7-8c1b-4019-8a09-babcf343cf1c	UNCLASSIFIED	jpeg	6
1123	70d7eed3-935d-4177-9712-0db49ae8b4ec	UNCLASSIFIED	jpeg	8
1124	ed23b7b7-3dfc-4bd4-94ba-f42d5238cca0	UNCLASSIFIED	jpeg	6
1125	19e59558-2527-46fe-b0fc-e21d3c86fe57	UNCLASSIFIED	jpeg	8
1126	9ee4de35-7ef9-4fc8-a65f-b2d01c9d8dea	UNCLASSIFIED	jpeg	6
1127	dffeb750-8aa1-4838-a513-2f202dc223ea	UNCLASSIFIED	jpeg	8
1128	34166a3d-e111-4c60-86c7-3e1f2d2904e4	UNCLASSIFIED	jpeg	6
1129	256b9d1a-cd5b-489e-8a4c-ece7c1080a01	UNCLASSIFIED	png	8
1130	4a92a886-afc3-4a90-bff9-b77ec19e8108	UNCLASSIFIED	png	6
1131	1941689b-864f-4ade-8c73-23d05cda4a8b	UNCLASSIFIED	jpeg	8
1132	ca6e0ef4-79be-4aeb-940d-42bbea46bb1a	UNCLASSIFIED	jpeg	6
1133	0a5a1a9f-ecc4-4a68-90f8-a4d8e31fe90c	UNCLASSIFIED	jpeg	8
1134	586b19a8-85d9-4e06-a641-9f894e3788fb	UNCLASSIFIED	jpeg	6
1135	47700e87-9793-4407-ab71-37bcc7a2a090	UNCLASSIFIED	jpeg	8
1136	34d0ee32-871c-4a79-9938-939992e532f5	UNCLASSIFIED	jpeg	6
1137	ff96c8ae-3604-43b4-87e7-5fcecfdd4354	UNCLASSIFIED	jpeg	8
1138	9c3d4475-a2b0-47d2-b492-140f5ce3a558	UNCLASSIFIED	jpeg	6
1139	06585fd5-e744-42f0-9275-5ac25f519ddc	UNCLASSIFIED	jpeg	8
1140	cc77cedf-1278-419a-9751-45bc7e94af02	UNCLASSIFIED	jpeg	6
1141	3a8b4089-8468-4e41-9e9d-62c33ed39509	UNCLASSIFIED	jpeg	8
1142	facda10e-cb8c-41f2-8ff2-898c9f3862ba	UNCLASSIFIED	jpeg	6
1143	62783894-6850-4a3e-ba75-4d3d6a8fb589	UNCLASSIFIED	jpeg	8
1144	4ee2ad15-2f21-4c39-9ee2-416343c4e6b1	UNCLASSIFIED	jpeg	6
1145	fc4c7739-58f9-49ed-987b-5a7a929e5c1d	UNCLASSIFIED	png	8
1146	b9325368-e379-42ba-ada4-aa8b7f20a52c	UNCLASSIFIED	png	6
1147	8f5dcd5e-bd10-4653-a6e8-3862ba23a54a	UNCLASSIFIED	jpeg	8
1148	30274ddd-512f-4a94-af37-91094f16d4fa	UNCLASSIFIED	jpeg	6
1149	02f62e21-97ed-42de-ae69-d91a99ac6474	UNCLASSIFIED	jpeg	8
1150	9e5b8a79-d7ea-488f-be3c-e4c3f2ee3ec0	UNCLASSIFIED	jpeg	6
1151	afe4cbea-6025-4deb-89fe-b03dee9f0057	UNCLASSIFIED	jpeg	8
1152	ce5e868e-2fda-4e74-85fa-4302b9593fbb	UNCLASSIFIED	jpeg	6
1153	0cf87681-e5e6-4062-837c-be2997129f51	UNCLASSIFIED	jpeg	8
1154	7193f1c4-8cda-40fe-b05b-746aa056f911	UNCLASSIFIED	jpeg	6
1155	07b09da8-0704-4050-bd17-1e7aa0ce2f95	UNCLASSIFIED	jpeg	8
1156	9948949f-c5d8-4be0-9259-8f091aee6296	UNCLASSIFIED	jpeg	6
1157	c9699abe-e08a-43bb-8b78-2e5b5c8ca20c	UNCLASSIFIED	jpeg	8
1158	5d34119c-b70b-4f85-b4c2-19b3f0c64e9a	UNCLASSIFIED	jpeg	6
1159	168d5bc8-040f-456c-a860-a7a1545206a0	UNCLASSIFIED	jpeg	8
1160	e47f98d0-3c79-462a-ac6d-3a2e9f16b5c0	UNCLASSIFIED	jpeg	6
1161	913099c0-ccb5-41b3-8412-f8f8c819caa4	UNCLASSIFIED	jpeg	8
1162	7b6ab94e-e959-40e5-ba50-a03aeaae671c	UNCLASSIFIED	jpeg	6
1163	d73f712a-fb89-4b1f-afc2-13af61fa974f	UNCLASSIFIED	jpeg	8
1164	6d8a04a8-a7fd-413b-b324-77b42d19c275	UNCLASSIFIED	jpeg	6
1165	ccf204f8-3e8f-4cfa-b8ef-90dc7e1a1a50	UNCLASSIFIED	jpeg	8
1166	2df59ebf-f896-412b-a41f-5b0ee48bc471	UNCLASSIFIED	png	6
1167	ed1ae17b-3f74-4f0d-862a-f22f44616485	UNCLASSIFIED	jpeg	8
1168	200830af-5994-4293-8350-1fe3a3e4e926	UNCLASSIFIED	jpeg	6
1169	2f4ff8fb-972c-4317-860e-627eff5828f4	UNCLASSIFIED	jpeg	8
1170	a6cce3ed-9847-4dea-af5e-b8428240910d	UNCLASSIFIED	jpeg	6
1171	8838a23d-cc54-4873-8ad0-4fb48684cbdf	UNCLASSIFIED	jpeg	8
1172	82701a5a-ee6d-4dba-b621-4cee826bd7fd	UNCLASSIFIED	jpeg	6
1173	2e774c22-6d3f-4b4d-8011-f85a57aee625	UNCLASSIFIED	jpeg	8
1174	4579f34e-8c5f-418e-91ed-c0b3607c800f	UNCLASSIFIED	jpeg	6
1175	81c4da63-ac96-4f70-830f-8430c0157d02	UNCLASSIFIED	png	8
1176	05457e6e-6f34-403d-b782-ce02a2244d44	UNCLASSIFIED	png	6
1177	e8ecf46d-5ea1-4d4f-a4a2-f74ef7b68dfc	UNCLASSIFIED	jpeg	8
1178	1f06f466-8cc6-445e-b305-d0beab5caea4	UNCLASSIFIED//FOR OFFICIAL USE ONLY	jpeg	6
1179	00b659a7-488d-4f3e-87f9-45180e4747bb	UNCLASSIFIED	jpeg	8
1180	b684a28e-ec17-45e6-bcad-9b55e4cc975c	UNCLASSIFIED	jpeg	6
1181	2895843b-9b0c-423d-abf3-99d475a94d65	UNCLASSIFIED//FOR OFFICIAL USE ONLY	jpeg	8
1182	448603ea-0fa6-40e3-b11f-b5ebac053015	UNCLASSIFIED//FOR OFFICIAL USE ONLY	jpeg	6
1183	9655348d-ffde-402f-95bb-d8045b449860	UNCLASSIFIED	jpeg	8
1184	bdac214b-0be9-4696-8fdd-3b02d5557686	UNCLASSIFIED	jpeg	6
1185	1e6c436f-9bc6-401f-94e4-9813bf1e214c	UNCLASSIFIED	jpeg	8
1186	aaa0aebe-264e-4c95-89fe-2f592d3c62f5	UNCLASSIFIED	jpeg	6
1187	6cebfd76-98ac-47dc-80f0-82fc308dde35	UNCLASSIFIED//FOR OFFICIAL USE ONLY	jpeg	8
1188	debfe00b-8069-4329-88d2-0e26c94d8e31	UNCLASSIFIED//FOR OFFICIAL USE ONLY	jpeg	6
1189	7203c4ef-976e-4584-9538-3a4abf143a67	UNCLASSIFIED	jpeg	8
1190	b650e92f-1562-4b62-97e3-b628e685f95b	UNCLASSIFIED	jpeg	6
1191	c0a0a942-5ac5-4575-8cc5-2b3ade129a47	UNCLASSIFIED	jpeg	8
1192	a7583488-95ff-4cc9-a3c1-b8d466bc4821	UNCLASSIFIED	jpeg	6
1193	acc65648-8de7-4ad5-927f-6bbc95afbbc9	UNCLASSIFIED	jpeg	8
1194	9701cc39-adcf-48db-8da4-4046738a1eff	UNCLASSIFIED	jpeg	6
1195	3942e6c7-32e8-4b29-a0a7-47abeb568877	UNCLASSIFIED	jpeg	8
1196	4100cf1d-a016-4ed1-a7de-92a92f706d06	UNCLASSIFIED	jpeg	6
1197	4f5b304e-e5eb-4e44-8236-b31b5590f789	UNCLASSIFIED	jpeg	8
1198	21c8ff21-08ba-40d9-91a9-66aadaddc22d	UNCLASSIFIED	jpeg	6
1199	31ddaf51-200f-4f6c-9525-27f1dae00887	UNCLASSIFIED	jpeg	8
1200	e384a525-98a0-457f-aa86-e08bc6a0cc5f	UNCLASSIFIED	jpeg	6
1201	db051c3a-7aaf-40bc-8ea6-d347deadaea8	UNCLASSIFIED	jpeg	8
1202	144e187e-f621-44e5-9edf-36d21ba64946	UNCLASSIFIED	jpeg	6
1203	5c7acf10-9ee0-4600-b235-c8d0f6d260de	UNCLASSIFIED	png	8
1204	d0e50eab-fc10-4ae3-928c-4128ee4b5a30	UNCLASSIFIED	png	6
1205	acafeb2b-6f7a-4616-85ae-614f61c5dff6	UNCLASSIFIED	png	8
1206	5fd1f457-8076-4055-9a43-e9cb98806ede	UNCLASSIFIED	png	6
1207	5decaab9-df1e-4237-8123-02857e7824d3	UNCLASSIFIED	jpeg	8
1208	48f0685b-4ca7-41a8-b817-133e1e58355b	UNCLASSIFIED	jpeg	6
1209	8816a188-fa89-43bc-822e-fc53bfd4622a	UNCLASSIFIED	jpeg	8
1210	4d1c1b07-fef6-49cd-8001-a2d68aa29e44	UNCLASSIFIED	jpeg	6
1211	6ab894f5-6c3d-4517-a757-3c928358dcd9	UNCLASSIFIED	jpeg	8
1212	3649cdf1-c384-45f8-85ad-2a54cdd83fdd	UNCLASSIFIED	jpeg	6
1213	a510d4d8-0030-4ac2-9211-e71523affc9a	UNCLASSIFIED	jpeg	8
1214	4791125d-9c05-418c-a1ae-2c76a59d8641	UNCLASSIFIED	jpeg	6
1215	d04c8fca-73f2-4bab-87a6-189be0947cc9	UNCLASSIFIED	jpeg	8
1216	d6d9e442-f020-4648-9968-059ee42616c0	UNCLASSIFIED	jpeg	6
1217	115f4227-320e-45e7-93df-a69ec16f8fd0	UNCLASSIFIED	jpeg	8
1218	85b51dce-2b8a-49d3-999a-e2e862d5ec04	UNCLASSIFIED	jpeg	6
1219	e812ccbe-e898-4b49-978c-19bf9fd519f1	UNCLASSIFIED	png	8
1220	00a6a5b8-2ae3-45ff-9351-1832790d50b7	UNCLASSIFIED	png	6
1221	9c5a76f9-5cc4-4f37-9dd1-a1a7a40d79c2	UNCLASSIFIED	png	8
1222	13cbe5e1-c5b2-4547-8d4b-da7003be9620	UNCLASSIFIED	png	6
1223	1fb8b456-1e9a-4c3b-af73-d07bf3eff0f9	UNCLASSIFIED	png	8
1224	366e04f5-8ce3-4974-9d6e-9047a3f1cce6	UNCLASSIFIED	png	6
1225	3bfc9839-e8cb-425c-b87c-0c789144d519	UNCLASSIFIED	jpeg	8
1226	d68ad401-fa3d-4da6-bc1e-362de0dd854f	UNCLASSIFIED	jpeg	6
1227	6d3e20db-c7a2-4838-b09b-cc5ec4f0e4b7	UNCLASSIFIED	jpeg	8
1228	030871e7-748d-4e96-9a20-c5b025b580e5	UNCLASSIFIED	jpeg	6
1229	010f95e3-cddf-4afd-a8ac-20a3751b1543	UNCLASSIFIED	jpeg	8
1230	3513b92d-8e06-4c11-b202-183a61dc91e8	UNCLASSIFIED	jpeg	6
1231	0074daf3-4000-436c-80be-e29ffb98cf3b	UNCLASSIFIED	jpeg	8
1232	781d85bc-d8e8-470e-b63a-33ce81e82965	UNCLASSIFIED	jpeg	6
1233	3ca538a6-ee87-4825-9e96-a34a14581503	UNCLASSIFIED	jpeg	8
1234	60e87b9d-c8c3-4409-9105-4b4832b4f5e3	UNCLASSIFIED	jpeg	6
1235	6553ab1f-e69a-417a-9ff8-075a6e4fd237	UNCLASSIFIED	jpeg	8
1236	2dd1cac3-fcd3-429e-8f8b-fdf99ceae7d7	UNCLASSIFIED	jpeg	6
\.


--
-- Name: ozpcenter_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_image_id_seq', 1236, true);


--
-- Data for Name: ozpcenter_imagetype; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_imagetype (id, name, max_size_bytes, max_width, max_height, min_width, min_height) FROM stdin;
1	agency_icon	2097152	2048	2048	16	16
2	banner_icon	2097152	2048	2048	16	16
3	intent_icon	2097152	2048	2048	16	16
4	large_banner_icon	2097152	2048	2048	16	16
5	large_icon	8192	2048	2048	16	16
6	large_screenshot	1048576	2048	2048	16	16
7	small_icon	4096	2048	2048	16	16
8	small_screenshot	1048576	2048	2048	16	16
\.


--
-- Name: ozpcenter_imagetype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_imagetype_id_seq', 8, true);


--
-- Data for Name: ozpcenter_intent; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_intent (id, action, media_type, label, icon_id) FROM stdin;
1	/application/json/view	vnd.ozp-intent-v1+json.json	view	1
2	/application/json/edit	vnd.ozp-intent-v1+json.json	edit	1
\.


--
-- Name: ozpcenter_intent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_intent_id_seq', 2, true);


--
-- Data for Name: ozpcenter_listing; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_listing (id, title, approved_date, edited_date, description, launch_url, version_name, unique_name, what_is_new, description_short, usage_requirements, approval_status, is_enabled, is_featured, avg_rate, total_votes, total_rate5, total_rate4, total_rate3, total_rate2, total_rate1, total_reviews, iframe_compatible, security_marking, is_private, agency_id, banner_icon_id, current_rejection_id, large_banner_icon_id, large_icon_id, last_activity_id, listing_type_id, required_listings_id, small_icon_id, is_deleted, total_review_responses, system_requirements, feedback_score) FROM stdin;
116	Navigation	2017-11-09 10:31:51.720223-05	2017-11-09 10:32:05.338223-05	From Wikipedia, the free encyclopedia\nThis article is about determination of position and direction on or above the surface of the earth. For other uses, see Navigation (disambiguation).\nTable of geography, hydrography, and navigation, from the 1728 Cyclopaedia\nNavigation is a field of study that focuses on the process of monitoring and controlling the movement of a craft or vehicle from one place to another. The field of navigation includes four general categories: land navigation, marine navigation, aeronautic navigation, and space navigation.\nIt is also the term of art used for the specialized knowledge used by navigators to perform navigation tasks. All navigational techniques involve locating the navigator's position compared to known locations or patterns.\nNavigation, in a broader sense, can refer to any skill or study that involves the determination of position and direction. In this sense, navigation includes orienteering and pedestrian navigation. For information about different navigation strategies that people use, visit human navigation.	https://en.wikipedia.org/wiki/Navigation	1.0	navigation	\N	Navigation is a field of study that focuses on the movement of a craft or vehicle	None	APPROVED	t	f	4.20000000000000018	5	3	1	0	1	0	5	t	UNCLASSIFIED	f	4	473	\N	474	472	462	3	\N	471	f	0	None	0
1	Acoustic Guitar	2017-11-09 10:31:40.031892-05	2017-11-09 10:32:01.463592-05	A guitar that produces sound acoustically by transmitting the vibration of the strings to the air as opposed to relying on electronic amplification. The sound waves from the strings of an acoustic guitar resonate through the guitar's body, creating sound.	https://en.wikipedia.org/wiki/Acoustic_guitar	10.0	acoustic_guitar	Introduction of Steel strings and increased the area of the guitar top	A guitar that produces sound acoustically by transmitting the vibration of the strings.	Knowledge of acoustic properties of guitar	APPROVED	t	f	3	3	1	0	1	0	1	3	f	UNCLASSIFIED	f	2	13	\N	14	12	4	3	\N	11	f	0	None	0
3	Albatron Technology	\N	2017-11-09 10:31:40.19066-05	Albatron Technology Co. Ltd. is a Taiwan-based company, whose current CEO is Jack Ko. The company is primarily known for having been a major manufacture of graphics cards and motherboards based on NVIDIA chipsets in the 2000s which were marketed under the brand Albatron.	https://en.wikipedia.org/wiki/Albatron_Technology	1	albatron_technology	\N	Albatron Technology Co. Ltd. is a Taiwan-based company, whose current CEO is Jack Ko.	None	PENDING	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	21	\N	22	20	10	2	\N	19	f	0	None	0
2	Air Mail	2017-11-09 10:31:40.165469-05	2017-11-09 10:32:01.638665-05	Sends mail via air	https://localhost:8443/demo_apps/centerSampleListings/airMail/index.html	1.0.0	ozp.test.air_mail	Nothing really new here	Sends airmail	None	APPROVED	t	t	3.20000000000000018	4	1	1	1	0	1	4	f	UNCLASSIFIED	f	1	17	\N	18	16	8	3	\N	15	f	0	None	0
4	Aliens	2017-11-09 10:31:40.242263-05	2017-11-09 10:32:01.754436-05	Extraterrestrial life, also called alien life (or, if it is a sentient or relatively complex individual, an "extraterrestrial" or "alien"), is life that does not originate from Earth. These hypothetical life forms may range from simple single-celled organisms to beings with civilizations far more advanced than humanity. Although many scientists expect extraterrestrial life to exist in some form, there is no evidence for its existence to date.	http://localhost.com	1	aliens	\N	E.T. phone home	None	APPROVED	t	f	3.29999999999999982	3	1	1	0	0	1	3	t	UNCLASSIFIED	f	6	25	\N	26	24	14	3	\N	23	f	0	None	0
5	Alingano Maisu	2017-11-09 10:31:40.308982-05	2017-11-09 10:31:40.308992-05	From Wikipedia, the free encyclopedia\nAlingano Maisu, also known simply as Maisu /ˈmaɪʃuː/, is a double-hulled voyaging canoe built in Kawaihae, Hawaii by members of Na Kalai Waʻa Moku o Hawaiʻi and ʻOhana Wa'a members from throughout the Pacific and abroad as a gift and tribute to Satawalese navigator Mau Piailug, who navigated the voyaging canoe Hōkūleʻa on her maiden voyage to Tahiti in 1976 and has since trained numerous native Hawaiians in the ancient art of wayfinding. The word maisu in the name of the canoe comes from the Satawalese word for breadfruit. In particular, the word refers to breadfruit that has been knocked down by storm winds and is therefore available for anyone to take. The name is said to symbolize the knowledge of navigation that is made freely available.\n\nThe concept for Alingano Maisu came about in 2001 when two Hawaiian voyaging groups, the Polynesian Voyaging Society and Na Kalai Waʻa Moku o Hawaiʻi, met with Piailug. The two hulls of the 56-foot (17 m) vessel were fabricated by the Friends of Hōkūleʻa and Hawaiʻiloa on Oʻahu and shipped to the Island of Hawaiʻi where Na Kalai Waʻa completed construction of the canoe. The Polynesian Voyaging Society provided much of the funding for the voyaging aspect of the project as well as an escort boat to help sail the canoe to Satawal.\n\nThe canoe is home-ported on the island of Yap under the command of Piailug's son, Sesario Sewralur.	https://en.wikipedia.org/wiki/Alingano_Maisu	1.0	alingano_maisu	\N	Alingano Maisu, also known simply as Maisu, is a double-hulled voyaging canoe built in Hawaii	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	29	\N	30	28	18	4	\N	27	f	0	None	0
6	Apocalypse	2017-11-09 10:31:40.35352-05	2017-11-09 10:32:01.789229-05	Apocalypse (En Sabah Nur) is a fictional supervillain appearing in comic books published by Marvel Comics. He is one of the world's first mutants, and was originally a principal villain for the original X-Factor team and now for the X-Men and related spinoff teams. Created by writer Louise Simonson and artist Jackson Guice, Apocalypse first appeared in X-Factor #5 (May 1986).\nSince his introduction, the character has appeared in a number of X-Men titles, including spin-offs and several limited series. Apocalypse has also been featured in various forms of media. In 2016, Oscar Isaac portrayed the villain in the film X-Men: Apocalypse. He is ranked #24 in IGN's 100 Greatest Comic Book Villains of All Time.	https://en.wikipedia.org/wiki/Apocalypse_(comics)	1	apocalypse	\N	Apocalypse is an ancient mutant born with a variety of superhuman abilities.	None	APPROVED	t	f	1	1	0	0	0	0	1	1	t	UNCLASSIFIED	f	2	33	\N	34	32	22	3	\N	31	f	0	None	0
7	Applied Ethics Inc.	2017-11-09 10:31:40.619487-05	2017-11-09 10:31:40.619496-05	Applied ethics is the branch of ethics concerned with the analysis of particular moral issues in private and public life. For example, the bioethics community is concerned with identifying the correct approach to moral issues in the life sciences, such as euthanasia, the allocation of scarce health resources, or the use of human embryos in research. Environmental ethics is concerned with ecological issues such as the responsibility of government and corporations to clean up pollution. Business ethics includes questions regarding the duties or duty of 'whistleblowers' to the general public or to their loyalty to their employers. Applied ethics is distinguished from normative ethics, which concerns standards for right and wrong behavior, and from meta-ethics, which concerns the nature of ethical properties, statements, attitudes, and judgments.	http://appliedethicsinc.com	2.5	applied_ethics_inc.	\N	Applied ethics is the branch of ethics concerned with the analysis of particular moral issues.	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	37	\N	38	36	26	3	\N	35	f	0	None	0
8	Astrology software	2017-11-09 10:31:40.692062-05	2017-11-09 10:32:01.823737-05	Astrology software is a type of computer programs designed to calculate horoscopes. Many of them also assemble interpretive text into narrative reports.\nAstro Computing Services (ACS) in San Diego, founded by Neil Michelsen in 1973, published a computer-generated astrological ephemeris in 1976, The American Ephemeris.\nWhen personal computers generally became available, astrologers and astrology hobbyists were able to purchase them and use astrological or astronomical calculation software or make such programs themselves. Astrologer and computer programmer Michael Erlewine was involved early in making astrological software for microcomputers available to the general public in the late 1970s. In 1978, Erlewine founded Matrix Software, and in 1980 he published a book with all the algorithms and data required for owners of microcomputers to make their own complete astrological programs. At first, astrology software was opposed by American astrologers who did not approve of computers in their field. However, acceptance grew as it became clear how more efficient and profitable such software could be.\nA few hundred fixed-purpose astrology computers were made, one of which was used by Nancy Reagan's astrologer beginning in about 1981	https://en.wikipedia.org/wiki/Astrology_software	1	astrology_software	\N	Astrology software is a type of computer programs designed to calculate horoscopes.	None	APPROVED	t	f	5	1	1	0	0	0	0	1	t	UNCLASSIFIED	f	8	41	\N	42	40	30	2	\N	39	f	0	None	0
10	Baltimore Ravens	2017-11-09 10:31:40.954138-05	2017-11-09 10:32:02.030942-05	The Baltimore Ravens are a professional American football team based in Baltimore, Maryland. The Ravens compete in the National Football League (NFL) as a member club of the American Football Conference (AFC) North division. The team plays its home games at M&T Bank Stadium and is headquartered in Owings Mills and is the best team in the NFL.\nThe Ravens were established in 1996, when Art Modell, who was then the owner of the Cleveland Browns, announced plans to relocate the franchise from Cleveland to Baltimore. As part of a settlement between the league and the city of Cleveland, Modell was required to leave the Browns' history and records in Cleveland for a replacement team and replacement personnel that would take control in 1999. In return, he was allowed to take his own personnel and team to Baltimore, where such personnel would then form an expansion team.	https://en.wikipedia.org/wiki/Baltimore_Ravens	2000	baltimore_ravens	\N	The Baltimore Ravens are a professional American football team based in Baltimore, Maryland	FOOTBALL	APPROVED	t	f	5	1	1	0	0	0	0	1	t	UNCLASSIFIED	f	3	49	\N	50	48	38	2	\N	47	f	0	None	0
11	Barbecue	2017-11-09 10:31:41.001119-05	2017-11-09 10:32:02.06455-05	Barbecuing encompasses four or five distinct types of cooking techniques. The original technique is cooking using smoke at low temperatures—usually around 240-280 °F or 115-145 °C—and significantly longer cooking times (several hours), known as smoking. Another technique, known as baking, used a masonry oven or baking oven that uses convection to cook meats and starches with moderate temperatures for an average cooking time of about an hour. Braising combines direct, dry heat charbroiling on a ribbed surface with a broth-filled pot for moist heat. Using this technique, cooking occurs at various speeds, starting fast, slowing down, then speeding up again, lasting for a few hours.\n\nGrilling is done over direct, dry heat, usually over a hot fire over 500 °F (260 °C) for a few minutes. Grilling may be done over wood, charcoal, gas, or electricity. The time difference between barbecuing and grilling is because of the temperature difference; at low temperatures used for barbecuing, meat takes several hours to reach the desired internal temperature.\nSmoking\nMain article: Smoking (cooking)\nChicken, pork and bacon-wrapped corn cooked in a barbecue smoker\n\nSmoking is the process of flavoring, cooking, and/or preserving food by exposing it to smoke from burning or smoldering material, most often wood. Meat and fish are the most common smoked foods, though cheeses, vegetables, nuts, and ingredients used to make beverages such as beer or smoked beer are also smoked.[full citation needed]\nRoasting\nSee also: Pit barbecue\n\nThe masonry oven is similar to a smoke pit; it allows for an open flame but cooks more quickly and uses convection to cook. Barbecue-baking can also be done in traditional stove-ovens. It can be used to cook meats, breads and other starches, casseroles, and desserts. It uses direct and indirect heat to surround the food with hot air to cook, and can be basted in much the same manner as grilled foods.\nBraising\n\nIt is possible to braise meats and vegetables in a pot on top of a grill. A gas or electric charbroil grill are the best choices for barbecue-braising, combining dry heat charbroil-grilling directly on a ribbed surface and braising in a broth-filled pot for moist heat. The pot is placed on top of the grill, covered, and allowed to simmer for a few hours. There are two advantages to barbecue-braising; it allows browning of the meat directly on the grill before the braising. It also allows for glazing of meat with sauce and finishing it directly over the fire after the braising. This effectively cooks the meat three times, which results in a soft, textured product that falls off the bone. The time needed for braising varies depending on whether a slow cooker or pressure cooker is used; it is generally slower than regular grilling or baking, but quicker than pit-smoking.[citation needed]	https://en.wikipedia.org/wiki/Barbecue	1	barbecue	Barbecue remains one of the most traditional foods in the United States.	Barbecuing is done slowly over low, indirect heat and the food is flavored by the smoking process.	Smoking\nSmoking is the process of flavoring, cooking, and/or preserving food by exposing it to smoke from burning or smoldering material, most often wood. Meat and fish are the most common smoked foods, though cheeses, vegetables, nuts, and ingredients used to make beverages such as beer or smoked beer are also smoked.[full citation needed]\nRoasting\nThe masonry oven is similar to a smoke pit; it allows for an open flame but cooks more quickly and uses convection to cook. Barbecue-baking can also be done in traditional stove-ovens. It can be used to cook meats, breads and other starches, casseroles, and desserts. It uses direct and indirect heat to surround the food with hot air to cook, and can be basted in much the same manner as grilled foods.	APPROVED	t	f	5	1	1	0	0	0	0	1	t	UNCLASSIFIED	f	1	53	\N	54	52	42	2	\N	51	f	0	None	0
17	BeiDou Navigation Satellite System	2017-11-09 10:31:41.375699-05	2017-11-09 10:32:02.373307-05	From Wikipedia, the free encyclopedia\n"BeiDou" redirects here. For other uses, see Beidou (disambiguation).\nBeiDoü Navigation Satellite System\nBeidou logo.png\nThe BeiDou system's logo\nCountry/ies of origin\tChina\nOperator(s)\tCNSA\nType\tMilitary, commercial\nStatus\tOperational (regionally)\nCoverage\tGlobal\nAccuracy\t10 m (public)\n0.1 m (encrypted)\nConstellation size\nTotal satellites\t35\nSatellites in orbit\t21\nFirst launch\t30 October 2000\nLast launch\t12 June 2016\nTotal launches\t27\nOrbital characteristics\nRegime(s)\tGEO, IGSO, MEO\nGeodesy\nAzimutalprojektion-schief kl-cropped.png\nFundamentals\nGeodesy Geodynamics Geomatics Cartography History\nConcepts\nGeographical distance Geoid Figure of the Earth Geodetic datum Geodesic Geographic coordinate system Horizontal position representation Latitude / Longitude Map projection Reference ellipsoid Satellite geodesy Spatial reference system\nTechnologies\nGlobal Navigation Satellite System (GNSS)\nGlobal Positioning System (GPS)\nGLONASS (Russian)\nBeiDou (BDS) (Chinese)\nGalileo (European)\nIndian Regional Navigation\nSatellite System (IRNSS) (India)\nQuasi-Zenith Satellite System (QZSS) (Japan)\nLegenda (satellite system)\nStandards (History)\nNGVD29\tSea Level Datum 1929\nOSGB36\tOrdnance Survey Great Britain 1936\nSK-42\tSystema Koordinat 1942 goda\nED50\tEuropean Datum 1950\nSAD69\tSouth American Datum 1969\nGRS 80\tGeodetic Reference System 1980\nNAD83\tNorth American Datum 1983\nWGS84\tWorld Geodetic System 1984\nNAVD88\tN. American Vertical Datum 1988\nETRS89\tEuropean Terrestrial Reference\nSystem 1989\nGCJ-02\tChinese encrypted datum 2002\nInternational Terrestrial Reference System\nSpatial Reference System Identifier (SRID)\nUniversal Transverse Mercator (UTM)\nv t e\nThe BeiDoü Navigation Satellite System (BDS, simplified Chinese: 北斗卫星导航系统; traditional Chinese: 北斗衛星導航系統; pinyin: Běidǒu wèixīng dǎoháng xìtǒng) is a Chinese satellite navigation system. It consists of two separate satellite constellations - a limited test system that has been operating since 2000, and a full-scale global navigation system that is currently under construction.\n\nThe first BeiDou system, officially called the BeiDou Satellite Navigation Experimental System (simplified Chinese: 北斗卫星导航试验系统; traditional Chinese: 北斗衛星導航試驗系統; pinyin: Běidǒu wèixīng dǎoháng shìyàn xìtǒng) and also known as BeiDou-1, consists of three satellites and offers limited coverage and applications. It has been offering navigation services, mainly for customers in China and neighboring regions, since 2000.\n\nThe second generation of the system, officially called the BeiDou Navigation Satellite System (BDS) and also known as COMPASS or BeiDou-2, will be a global satellite navigation system consisting of 35 satellites, and is under construction as of January 2015. It became operational in China in December 2011, with 10 satellites in use, and began offering services to customers in the Asia-Pacific region in December 2012. It is planned to begin serving global customers upon its completion in 2020.\n\nIn-mid 2015, China started the build-up of the third generation BeiDou system (BDS-3) in the global coverage constellation. The first BDS-3 satellite was launched 30 September 2015. As of March 2016, four BDS-3 in-orbit validation satellites have been launched.\n\nAccording to China Daily, fifteen years after the satellite system was launched, it is now generating a turnover of $31.5 billion per annum for major companies such as China Aerospace Science and Industry Corp, AutoNavi Holdings Ltd, and China North Industries Group Corp.\n\nBeidou has been described as a potential navigation satellite system to overtake GPS in global usage, and is expected to be more accurate than the GPS once it is fully completed.	https://en.wikipedia.org/wiki/BeiDou_Navigation_Satellite_System	1.0	beidou_navigation_satellite_system	\N	The BeiDoü Navigation Satellite System is a Chinese satellite navigation system	None	APPROVED	t	f	3.5	2	0	1	1	0	0	2	t	UNCLASSIFIED	f	4	77	\N	78	76	66	4	\N	75	f	0	None	0
12	Barsoom	2017-11-09 10:31:41.096001-05	2017-11-09 10:32:02.161825-05	Mars is the fourth planet from the Sun and the second-smallest planet in the Solar System, after Mercury. Named after the Roman god of war, it is often referred to as the "Red Planet" because the iron oxide prevalent on its surface gives it a reddish appearance. Mars is a terrestrial planet with a thin atmosphere, having surface features reminiscent both of the impact craters of the Moon and the valleys, deserts, and polar ice caps of Earth.\n\nThe rotational period and seasonal cycles of Mars are likewise similar to those of Earth, as is the tilt that produces the seasons. Mars is the site of Olympus Mons, the largest volcano and second-highest known mountain in the Solar System, and of Valles Marineris, one of the largest canyons in the Solar System. The smooth Borealis basin in the northern hemisphere covers 40% of the planet and may be a giant impact feature. Mars has two moons, Phobos and Deimos, which are small and irregularly shaped. These may be captured asteroids, similar to 5261 Eureka, a Mars trojan.\n\nThere are ongoing investigations assessing the past habitability potential of Mars, as well as the possibility of extant life. Future astrobiology missions are planned, including the Mars 2020 and ExoMars rovers. Liquid water cannot exist on the surface of Mars due to low atmospheric pressure, which is less than 1% of the Earth's, except at the lowest elevations for short periods. The two polar ice caps appear to be made largely of water. The volume of water ice in the south polar ice cap, if melted, would be sufficient to cover the entire planetary surface to a depth of 11 meters (36 ft). In November 2016, NASA reported finding a large amount of underground ice in the Utopia Planitia region of Mars. The volume of water detected has been estimated to be equivalent to the volume of water in Lake Superior.\n\nMars can easily be seen from Earth with the naked eye, as can its reddish coloring. Its apparent magnitude reaches −2.91, which is surpassed only by Jupiter, Venus, the Moon, and the Sun. Optical ground-based telescopes are typically limited to resolving features about 300 kilometers (190 mi) across when Earth and Mars are closest because of Earth's atmosphere.	https://en.wikipedia.org/wiki/Mars	1.0	barsoom	\N	Mars is the fourth planet from the Sun and the second-smallest planet in the Solar System.	Requires the internet.	APPROVED	t	f	4.29999999999999982	3	2	0	1	0	0	3	t	UNCLASSIFIED	f	3	57	\N	58	56	46	3	\N	55	f	0	None	0
13	Basketball	2017-11-09 10:31:41.141476-05	2017-11-09 10:32:02.223346-05	Basketball is a non-contact sport played on a rectangular court. While most often played as a team sport with five players on each side, three-on-three, two-on-two, and one-on-one competitions are also common. The objective is to shoot a ball through a hoop 18 inches (46 cm) in diameter and 10 feet (3.048 m) high that is mounted to a backboard at each end of the court. The game was invented in 1891 by Dr. James Naismith, who would be the first basketball coach of the Kansas Jayhawks, one of the most successful programs in the game's history.	http://localhost.com	23	basketball	\N	Possibly the best sport in the world	Must be tall	APPROVED	t	f	3.5	2	1	0	0	1	0	2	t	UNCLASSIFIED	f	3	61	\N	62	60	50	3	\N	59	f	0	None	0
14	Bass Fishing	2017-11-09 10:31:41.184252-05	2017-11-09 10:32:02.252434-05	Bass fishing is the activity of angling for the North American gamefish known colloquially as the black bass. There are numerous black bass species considered as gamefish in North America, including largemouth bass (Micropterus salmoides), smallmouth bass (Micropterus dolomieui), spotted bass or Kentucky bass (Micropterus punctulatus), and Guadalupe bass (order Perciformes).\nModern bass fishing has evolved into a multibillion-dollar industry. The sport has changed drastically since its beginnings in the late 19th century. From humble beginnings, the black bass has become the most specifically sought-after game fish in the United States. The sport has driven the development of all manner of fishing gear, including rods, reels, lines, lures, electronic depth and fish-finding instruments, drift boats, float tubes, also boats specified for bass fishing.	https://en.wikipedia.org/wiki/Bass_fishing	1	bass_fishing	The increasing popularity of the sport combined with "catch and release" practices have in some cases led to an overpopulation of bass.	The one that got away.	none	APPROVED	t	t	4	1	0	1	0	0	0	1	t	UNCLASSIFIED	f	1	65	\N	66	64	54	3	\N	63	f	0	None	0
23	Bread Basket	2017-11-09 10:31:41.845541-05	2017-11-09 10:32:02.581337-05	Carries delicious bread	https://localhost:8443/demo_apps/centerSampleListings/breadBasket/index.html	1.0.0	ozp.test.bread_basket	Nothing really new here	Carries bread	None	APPROVED	t	t	3.5	2	1	0	0	1	0	2	f	UNCLASSIFIED	t	1	101	\N	102	100	90	3	\N	99	f	0	None	0
15	Bass Lures	2017-11-09 10:31:41.232559-05	2017-11-09 10:31:41.232568-05	There are many types of fishing lures. In most cases they are manufactured to resemble prey for the fish, but they are sometimes engineered to appeal to a fishes' sense of territory, curiosity or aggression. Most lures are made to look like dying, injured, or fast moving fish. They include the following types:\n\n    A jig is a weighted hook with a lead head opposite the sharp tip. They usually have a minnow or crawfish or even a plastic worm on it to get the fish's attention. Deep water jigs used in saltwater fishing consist of a large metallic weight, which gives the impression of the body of the bait fish, which has a hook attached via a short length of kevlar usually to the top of the jig. Some jigs can be fished in water depths down to 300 metres.\n    Surface lures are also known as top water lures, poppers and stickbaits. They float and look like fish prey that is on top of the water. They can make a popping, burbling, or even a buzzing sound. It takes a long time to learn how to use this lure effectively\n    Spoon lures usually look like a spoon, with a wide rounded end and a narrower pointed end, similar n shape to a concave spearhead. They flash in the light while wobbling and darting due to their shape, which attracts fish.\n    LED lures have a built in led and battery to attract fish. They use a flashing or sometimes strobing pattern, using a combination of colors and leds.\n    Plugs are also known as crankbaits or minnows. These lures look like fish and they are run through the water where they can move in different ways because of instability due to the bib at the front under the head.\n    Artificial flies are designed to resemble all manner of fish prey and are used with a fly rod and reel in fly fishing.\n    Soft plastic baits are lures made of plastic or rubber designed to look like fish, crabs, squid, worms, lizards, frogs, leeches and other creatures.\n    Spinnerbait are pieces of wire that are bent at about a 60 degree angle with a hook at the bottom and a flashy spinner at the top.\n    Swimbait is a soft plastic bait/lure that resembles an actual bait fish. Some of these have a tail that makes the lure/bait look like it is swimming when drawn through the water.\n    Fish decoy is a type of lure that traditionally was carved to resemble a fish, frog, small rodent, or an insect that lures in fish so they can be speared. They are often used through the ice by fishermen and also by the Inuit people as part of their diet. The Mitchell Museum of the American Indian collection includes Native American fish decoys. William Jesse Ramey is considered a vintage master carver of fish decoys, and his work has been featured in museums.\n    Combined lures combine properties of several different types of lures.	https://en.wikipedia.org/wiki/Fishing_lure	1	bass_lures	A daisy chain is a teaser consisting of a "chain" of plastic lures run without hooks.	The fishing lure is either tied with a knot, or connected with a "swivel" onto the fishing line.	A fishing lure is a type of artificial fishing bait which is designed to attract a fish's attention. The lure uses movement, vibration, flash and color to bait fish. Many lures are equipped with one or more hooks that are used to catch fish when they strike the lure. Some lures are placed to attract fish so a spear can be impaled into the fish or so the fish can be captured by hand. Most lures are attached to the end of a fishing line and have various styles of hooks attached to the body and are designed to elicit a strike resulting in a hookset. Many lures are commercially made but some are hand made such as fishing flies. Hand tying fly lures to match the hatch is considered a challenge by many amateur entomologists.	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	69	\N	70	68	58	3	\N	67	f	0	None	0
16	Beast	2017-11-09 10:31:41.280089-05	2017-11-09 10:32:02.312736-05	Beast (Henry Philip "Hank" McCoy) is a fictional superhero appearing in American comic books published by Marvel Comics and is a founding member of the X-Men. Originally called "The Beast", the character was introduced as a mutant possessing ape-like superhuman physical strength and agility, oversize hands and feet, a genius-level intellect, and an otherwise normal appearance. Eventually being referred to simply as "Beast", Hank McCoy underwent progressive physiological transformations, permanently gaining animalistic physical characteristics. These include blue fur, both simian and feline facial features, pointed ears, fangs, and claws. Beast's physical strength and senses increased to even greater levels.\nDespite Hank McCoy's inhuman appearance, he is depicted as a brilliant, well-educated man in the arts and sciences, known for his witty sense of humor. He is a world authority on biochemistry and genetics, the X-Men's medical doctor, and the science and mathematics instructor at the Xavier Institute (the X-Men's headquarters and school for young mutants). He is also a mutant political activist, campaigning against society's bigotry and discrimination against mutants. While fighting his own bestial instincts and fears of social rejection, Beast dedicates his physical and mental gifts to the creation of a better world for man and mutant.\nOne of the original X-Men, Beast has appeared regularly in X-Men-related comics since his debut. He has also been a member of the Avengers and Defenders.\nThe character has also appeared in media adaptations, including animated TV series and feature films. In X2, Steve Bacic portrayed him in a very brief cameo in his human appearance, while in X-Men: The Last Stand he was played by Kelsey Grammer. Nicholas Hoult portrays a younger version of the character in X-Men: First Class. Both Hoult and Grammer reprise their roles in X-Men: Days of Future Past. Hoult also reprised the role in X-Men: Apocalypse.	https://en.wikipedia.org/wiki/Beast_(comics)	2	beast	\N	Smart punch kick person	None	APPROVED	t	f	4	2	1	0	1	0	0	2	t	UNCLASSIFIED	f	2	73	\N	74	72	62	4	\N	71	f	0	None	0
18	Bleach	2017-11-09 10:31:41.434108-05	2017-11-09 10:32:02.434834-05	Bleach is the debut studio album by the American rock band Nirvana, released on June 15, 1989 by Sub Pop. The main recording sessions took place at Reciprocal Recording in Seattle, Washington between December 1988 and January 1989. It was also their only album to feature drummer Chad Channing.	https://en.wikipedia.org/wiki/Bleach_%28Nirvana_album%29	1.989	bleach	\N	Bleach is the debut studio album by the American rock band Nirvana	Flannel	APPROVED	t	f	4.5	2	1	1	0	0	0	2	t	UNCLASSIFIED	f	1	81	\N	82	80	70	2	\N	79	f	0	None	0
30	Chart Course	2017-11-09 10:31:42.737679-05	2017-11-09 10:32:02.775447-05	Chart your course	https://localhost:8443/demo_apps/centerSampleListings/chartCourse/index.html	1.0.0	ozp.test.chartcourse	Nothing really new here	Chart your course	None	APPROVED	t	t	3.5	2	1	0	0	1	0	2	f	UNCLASSIFIED	f	1	129	\N	130	128	118	3	\N	127	f	0	None	0
19	Blink	2017-11-09 10:31:41.479294-05	2017-11-09 10:32:02.522781-05	In the primary Earth-616 continuity of the Marvel Universe, Blink was introduced in the "Phalanx Covenant" storyline, in which the extraterrestrially derived techno-organic beings called the Phalanx captured her and several other young mutants to assimilate their powers. This version of Blink was tense and panicky and frightened of her powers (having "woken up in a pool of blood" after her first use of them). Clarice could not properly control her powers, and apparently was unable to teleport anything in an intact form. Instead, any object or person caught in Blink's teleportation field, also known as a "blink wave", would be shredded. She eventually used her abilities to "cut up" Harvest, a Phalanx entity guarding her and her peers, but she was caught in her own teleportation field and apparently died in the process. Because of her sacrifice, the remaining captives were set free and became the X-Men junior team Generation X.	https://en.wikipedia.org/wiki/Blink_(comics)	1	blink	\N	teleports and stuff	None	APPROVED	t	f	3.70000000000000018	3	2	0	0	0	1	3	t	UNCLASSIFIED	f	2	85	\N	86	84	74	1	\N	83	f	0	None	0
20	Bombardier Transportation	2017-11-09 10:31:41.566719-05	2017-11-09 10:31:41.566728-05	From Wikipedia, the free encyclopedia\nBombardier Transportation is the rail equipment division of the Canadian firm Bombardier Inc. Bombardier Transportation is one of the world's largest companies in the rail vehicle and equipment manufacturing and servicing industry. The division is headquartered in Berlin, Germany, and has regional offices and major development facilities in Canada (Montreal and Toronto) and the United States (Plattsburgh, New York). Bombardier Transportation has many minor production and development facilities worldwide.\nBombardier Transportation produces a wide range of products including passenger rail vehicles, locomotives, bogies, propulsion and controls.\nLaurent Troger is the president and chief operating officer of Bombardier Transportation. In January 2011, the company had 34,900 employees, 25,400 of them in Europe, and 60 manufacturing locations around the world.	https://en.wikipedia.org/wiki/Bombardier_Transportation	2.4	bombardier_transportation	\N	Bombardier Transportation is the rail equipment division of the Canadian firm Bombardier Inc.	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	89	\N	90	88	78	4	\N	87	f	0	None	0
96	LocationLister	2017-11-09 10:31:50.041241-05	2017-11-09 10:32:04.358803-05	List locations	https://localhost:8443/demo_apps/locationLister/index.html	1.0.0	ozp.test.locationlister	Nothing really new here	List locations	None	APPROVED	t	t	4	1	0	1	0	0	0	1	f	UNCLASSIFIED	f	1	393	\N	394	392	382	3	\N	391	f	0	None	0
22	Bowser	2017-11-09 10:31:41.753592-05	2017-11-09 10:31:41.753613-05	Bowser (クッパ Kuppa, "Koopa") or King Koopa is a fictional character and the main antagonist of Nintendo's Mario franchise. In Japan, the character bears the title of Daimaō (大魔王 Great Demon King, lit.). In the United States, the character was first referred to as "Bowser, King of the Koopa" and "The sorcerer king" in the instruction manual. Bowser is the leader and likely the most powerful of the turtle-like Koopa race, and has been the archenemy of Mario ever since his first appearance, in the game Super Mario Bros.	https://en.wikipedia.org/wiki/Bowser_%28character%29	1	bowser	\N	Bowser or King Koopa is a fictional character and the main antagonist of Nintendo's Mario franchise.	Fireballs	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	97	\N	98	96	86	5	\N	95	f	0	None	0
21	Bourbon	2017-11-09 10:31:41.62835-05	2017-11-09 10:31:41.628359-05	Bourbon whiskey /bɜːrbən/ is a type of American whiskey: a barrel-aged distilled spirit made primarily from corn. The name is derived from the French Bourbon dynasty, although it is unclear precisely what inspired the whiskey's name (contenders include Bourbon County in Kentucky and Bourbon Street in New Orleans). Bourbon has been distilled since the 18th century. The use of the term "bourbon" for the whiskey has been traced to the 1820s, and the term began to be used consistently in Kentucky in the 1870s. While bourbon may be made anywhere in the United States, it is strongly associated with the American South, and with Kentucky in particular. As of 2014, the distillers' wholesale market revenue for bourbon sold within the U.S. is about $2.7 billion, and bourbon makes up about two-thirds of the $1.6 billion of U.S. exports of distilled spirits.	https://en.wikipedia.org/wiki/Bourbon_whiskey	1	bourbon	Bourbon is served in a variety of manners, including neat, diluted with water, over ice ("on the rocks"), with other beverages in simple mixed drinks, and into cocktails, including the Manhattan, the Old Fashioned, the whiskey sour, and the mint julep.	Bottled (like other whiskeys) at 80 proof or more (40% alcohol by volume)	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	93	\N	94	92	82	2	\N	91	f	0	None	0
24	Brisket	2017-11-09 10:31:41.917232-05	2017-11-09 10:31:41.917252-05	Brisket can be cooked many ways, including baking, boiling and roasting. Basting of the meat is often done during the cooking process. This normally tough cut of meat, due to the collagen fibers that make up the significant connective tissue in the cut, is tenderized when the collagen gelatinizes, resulting in more tender brisket. The fat cap, which is often left attached to the brisket, helps to keep the meat from drying during the prolonged cooking necessary to break down the connective tissue in the meat. Water is necessary for the conversion of collagen to gelatin, which is the hydrolysis product of collagen.\nPopular methods in the United States include rubbing with a spice rub or marinating the meat, then cooking slowly over indirect heat from charcoal or wood. This is a form of smoking the meat. A hardwood, such as oak, pecan, hickory, or mesquite, is sometimes added, alone or in combination with other hardwoods, to the main heat source. Sometimes, they make up all of the heat source, with chefs often prizing characteristics of certain woods. The smoke from these woods and from burnt dripping juices further enhances the flavor. The finished meat is a variety of barbecue. Smoked brisket done this way is popular in Texas barbecue. Once finished, pieces of brisket can be returned to the smoker to make burnt ends. Burnt ends are most popular in Kansas City-style barbecue, where they are traditionally served open-faced on white bread. The traditional New England boiled dinner features brisket as a main course option. Brisket is also cooked in a slow cooker as this also tenderizes the meat due to the slow cooking method, which is usually 8 hours for a 3lb brisket.	https://en.wikipedia.org/wiki/Brisket#Other_variations	1	brisket	Brisket is a cut of meat from the breast or lower chest of beef or veal. The beef brisket is one of the nine beef primal cuts, though the precise definition of the cut differs internationally.	The king of smoked meats.	none	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	105	\N	106	104	94	4	\N	103	f	0	None	0
25	Building	2017-11-09 10:31:42.011059-05	2017-11-09 10:32:02.639071-05	A building or edifice is a structure with a roof and walls standing more or less permanently in one place, such as a house or factory.	http://localhost.com	1	building	\N	Buildings come in a  variety of sizes, shape, and functions.	None	APPROVED	t	f	3	2	0	1	0	1	0	2	t	UNCLASSIFIED	f	7	109	\N	110	108	98	4	\N	107	f	0	None	0
26	Business Insurance Risk	2017-11-09 10:31:42.295114-05	2017-11-09 10:31:42.295124-05	Insurance is a means of protection from financial loss. It is a form of risk management primarily used to hedge against the risk of a contingent, uncertain loss.\nAn entity which provides insurance is known as an insurer, insurance company, or insurance carrier. A person or entity who buys insurance is known as an insured or policyholder. The insurance transaction involves the insured assuming a guaranteed and known relatively small loss in the form of payment to the insurer in exchange for the insurer's promise to compensate the insured in the event of a covered loss. The loss may or may not be financial, but it must be reducible to financial terms and must involve something in which the insured has an insurable interest established by ownership, possession, or pre-existing relationship.	http://www.i.com	1.0	business_insurance_risk	\N	Insurance is a means of protection from financial loss. It is a form of risk management.	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	113	\N	114	112	102	3	\N	111	f	0	None	0
27	Business Management System	2017-11-09 10:31:42.457949-05	2017-11-09 10:32:02.721951-05	Management (or managing) is the administration of an organization, whether it be a business, a not-for-profit organization, or government body. Management includes the activities of setting the strategy of an organization and coordinating the efforts of its employees or volunteers to accomplish its objectives through the application of available resources, such as financial, natural, technological, and human resources. The term "management" may also refer to the people who manage an organization.\nManagement is also an academic discipline, a social science whose objective is to study social organization and organizational leadership. Management is studied at colleges and universities; some important degrees in management are the Bachelor of Commerce (B.Com.) and Master of Business Administration (M.B.A.) and, for the public sector, the Master of Public Administration (MPA) degree. Individuals who aim at becoming management researchers or professors may complete the Doctor of Management (DM), the Doctor of Business Administration (DBA), or the PhD in Business Administration or Management.	http://businessmanagment.com	2.02	business_management_system	\N	Management (or managing) is the administration of an organization, whether it be a business.	None	APPROVED	t	f	3	3	0	1	1	1	0	3	t	UNCLASSIFIED	f	1	117	\N	118	116	106	2	\N	115	f	0	None	0
28	Cable ferry	2017-11-09 10:31:42.56789-05	2017-11-09 10:31:42.5679-05	From Wikipedia, the free encyclopedia\nThis article is about boats using a cable or chain to cross rivers. For boats using a chain to travel along a river, see Chain boat.\nA cable ferry (including the terms chain ferry, swing ferry, floating bridge, or punt) is a ferry that is guided (and in many cases propelled) across a river or large body of water by cables connected to both shores. Early cable ferries often used either rope or steel chains, with the latter resulting in the alternate name of chain ferry. Both of these were largely replaced by wire cable by the late 19th century.	https://en.wikipedia.org/wiki/Cable_ferry	1.1	cable_ferry	\N	A cable ferry is a ferry that is guided	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	121	\N	122	120	110	2	\N	119	f	0	None	0
29	Chain boat navigation	2017-11-09 10:31:42.652976-05	2017-11-09 10:31:42.653-05	Chain-boat navigation or chain-ship navigation is a little-known chapter in the history of shipping on European rivers. From around the middle of the 19th century, vessels called chain boats were used to haul strings of barges upstream by using a fixed chain lying on the bed of a river. The chain was raised from the riverbed to pass over the deck of the steamer, being hauled by a heavy winch powered by a steam engine. A variety of companies operated chain boat services on rivers such as the Elbe, Rhine, Neckar, Main, Saale, Havel, Spree and Saône as well as other rivers in Belgium and the Netherlands. Chain boats were also used in the United States.\n\nThe practice fell out of favour in the early 20th century when steamships with powerful engines and high boiler pressures - able to overcome the force of the river current - became commonplace	https://en.wikipedia.org/wiki/Chain_boat_navigation	1.0	chain_boat_navigation	\N	Chain-boat navigation or chain-ship navigation is a little-known chapter in the history	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	125	\N	126	124	114	5	\N	123	f	0	None	0
31	Chasing Amy	2017-11-09 10:31:42.778863-05	2017-11-09 10:32:02.80302-05	Chasing Amy is a 1997 American romantic comedy-drama film written and directed by Kevin Smith. The film is about a male comic artist who falls in love with a lesbian woman, to the displeasure of his best friend. It is the third film in Smith's View Askewniverse series.\nThe film was originally inspired by a brief scene from an early movie by a friend of Smith's. In Guinevere Turner's Go Fish, one of the lesbian characters imagines her friends passing judgment on her for "selling out" by sleeping with a man. Kevin Smith was dating star Joey Lauren Adams at the time he was writing the script, which was also partly inspired by her.\nThe film won two awards at the 1998 Independent Spirit Awards (Best Screenplay for Smith and Best Supporting Actor for Jason Lee).	https://en.wikipedia.org/wiki/Chasing_Amy	1997	chasing_amy	\N	Chasing Amy is a 1997 American romantic comedy-drama film written and directed by Kevin Smith.	None	APPROVED	t	f	4	1	0	1	0	0	0	1	t	UNCLASSIFIED	f	5	133	\N	134	132	122	1	\N	131	f	0	None	0
32	Chatter Box	2017-11-09 10:31:42.862115-05	2017-11-09 10:31:42.862126-05	Chat with people	https://localhost:8443/demo_apps/centerSampleListings/chatterBox/index.html	1.0.0	ozp.test.chatterbox	Nothing really new here	Chat in a box	None	APPROVED	t	t	0	0	0	0	0	0	0	0	f	UNCLASSIFIED	f	3	137	\N	138	136	126	3	\N	135	f	0	None	0
33	Cheese and Crackers	2017-11-09 10:31:43.034478-05	2017-11-09 10:31:43.034489-05	Cheese and crackers is a common dish consisting of crackers paired with various or multiple cheeses. The dish was consumed by sailors before refrigeration existed, has been described as one of the first fast foods in the United States, and increased in popularity circa the 1850s in the U.S. It is prepared using various types of cheeses, and is often paired with wine. Mass-produced cheese and crackers brands include Handi-Snacks, Ritz, Jatz and Lunchables.	https://en.wikipedia.org/wiki/Cheese_and_crackers	1	cheese_and_crackers	\N	Cheese and crackers is a common dish consisting of crackers paired with various or multiple cheeses.	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	141	\N	142	140	130	3	\N	139	f	0	None	0
34	Cheesecake	2017-11-09 10:31:43.101087-05	2017-11-09 10:31:43.101097-05	Cheesecake is a sweet dessert consisting of one or more layers. The main, and thickest layer, consists of a mixture of soft, fresh cheese (typically cream cheese or ricotta), eggs, and sugar; if there is a bottom layer it often consists of a crust or base made from crushed cookies (or digestive biscuits), graham crackers, pastry, or sponge cake. It may be baked or unbaked (usually refrigerated). Cheesecake is usually sweetened with sugar and may be flavored or topped with fruit, whipped cream, nuts, cookies, fruit sauce, or chocolate syrup. Cheesecake can be prepared in many flavors, such as strawberry, pumpkin, key lime, chocolate, Oreo, chestnut, or toffee.	https://en.wikipedia.org/wiki/Cheesecake	1	cheesecake	Good eats.	Cheesecakes can be broadly categorized into two basic types: baked and unbaked.	none	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	145	\N	146	144	134	5	\N	143	f	0	None	0
35	Chicken and Waffles	2017-11-09 10:31:43.29518-05	2017-11-09 10:31:43.29519-05	Chicken and waffles refers to either of two American dishes - one from soul food, the other Pennsylvania Dutch - that combine chicken with waffles. It is served in certain specialty restaurants in the United States	https://en.wikipedia.org/wiki/Chicken_and_waffles	1	chicken_and_waffles	\N	Chicken and waffles	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	149	\N	150	148	138	5	\N	147	f	0	None	0
36	Clerks	2017-11-09 10:31:43.339227-05	2017-11-09 10:32:02.830226-05	Clerks is a 1994 American independent black comedy film written, directed, and co-produced by Kevin Smith. Starring Brian O'Halloran as Dante Hicks and Jeff Anderson as Randal Graves, it presents a day in the lives of two store clerks and their acquaintances. Shot entirely in black-and-white, Clerks is the first of Smith's View Askewniverse films, and introduces several recurring characters, notably Jay and Silent Bob, the latter played by Smith himself. The structure of the movie contains nine scene breaks, signifying the nine rings of hell as in Dante Alighieri's Divine Comedy, from which the main character, Dante, gets his name.	https://en.wikipedia.org/wiki/Clerks	1	clerks	\N	Clerks is a 1994 American independent black comedy film.	None	APPROVED	t	f	3	1	0	0	1	0	0	1	t	UNCLASSIFIED	f	3	153	\N	154	152	142	2	\N	151	f	0	None	0
37	Clerks II	2017-11-09 10:31:43.388731-05	2017-11-09 10:32:02.857895-05	Clerks II is a 2006 American comedy film written and directed by Kevin Smith, the sequel to his 1994 film Clerks, and his sixth feature film to be set in the View Askewniverse. The film stars Brian O'Halloran, Jeff Anderson, Rosario Dawson, Trevor Fehrman, Jennifer Schwalbach Smith, Jason Mewes, and Smith, and picks up with the original characters from Clerks: Dante Hicks, Randal Graves and Jay and Silent Bob ten years after the events of the first film. Unlike the first film, which was shot in black-and-white, this film was shot in color.	https://en.wikipedia.org/wiki/Clerks_II	2	clerks_ii	\N	Clerks II is a 2006 American comedy film written and directed by Kevin Smith.	Color TV	APPROVED	t	f	3	1	0	0	1	0	0	1	t	UNCLASSIFIED	f	3	157	\N	158	156	146	2	\N	155	f	0	None	0
38	Clipboard	2017-11-09 10:31:43.472879-05	2017-11-09 10:31:43.47289-05	Clip stuff on a board	https://localhost:8443/demo_apps/centerSampleListings/clipboard/index.html	1.0.0	ozp.test.clipboard	Nothing really new here	Its a clipboard	None	APPROVED	t	t	0	0	0	0	0	0	0	0	f	UNCLASSIFIED	f	1	161	\N	162	160	150	3	\N	159	f	0	None	0
39	Clippy	2017-11-09 10:31:43.539267-05	2017-11-09 10:31:43.539277-05	The Office Assistant was an intelligent user interface for Microsoft Office that assisted users by way of an interactive animated character, which interfaced with the Office help content. It was included in Microsoft Office for Windows (versions 97 to 2003), in Microsoft Publisher (versions 98 to 2003), and Microsoft Office for Mac (versions 98 to 2004).\nThe default assistant in the English Windows version was named Clippit (commonly nicknamed Clippy), after a paperclip. The character was designed by Kevan J. Atteberry. Clippit was the default and by far the most notable Assistant (partly because in many cases the setup CD was required to install the other assistants), which also led to it being called simply the Microsoft Paperclip. The original Clippit in Office 97 was given a new look in Office 2000.	https://en.wikipedia.org/wiki/Office_Assistant	1	clippy	\N	The Office Assistant was an intelligent user interface for Microsoft Office	Office	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	165	\N	166	164	154	5	\N	163	f	0	None	0
152	Skybox	2017-11-09 10:31:56.828817-05	2017-11-09 10:31:56.828826-05	Sky Overlord	https://localhost:8443/demo_apps/Skybox/index.html	1.0.0	ozp.test.skybox	It's a box in the sky	Sky Overlord	None	APPROVED	t	t	0	0	0	0	0	0	0	0	f	UNCLASSIFIED	f	3	617	\N	618	616	606	3	\N	615	f	0	None	0
40	Compound bow	2017-11-09 10:31:43.587866-05	2017-11-09 10:31:43.587877-05	In modern archery, a compound bow is a bow that uses a levering system, usually of cables and pulleys, to bend the limbs.\nThe pulley/cam system grants the user a mechanical advantage, and so the limbs of a compound bow are much stiffer than those of a recurve bow or longbow. This rigidity makes the compound bow more energy-efficient than other bows, as less energy is dissipated in limb movement. The higher-rigidity, higher-technology construction also improves accuracy by reducing the bow's sensitivity to changes in temperature and humidity.\nThe pulley/cam system also confers a benefit called "let-off". As the string is drawn back, the pulleys rotate. The pulleys are eccentric rather than round, and so their effective radius changes as they rotate. The pulleys feature two cam tracks. An inner cam track which connects mechanically to the limbs or opposite cam and an outer cam track which the bowstring runs through. As the bow is drawn the ratio of bowstring pay-out and bowstring take-up relative to limb-weight and leverage of the cams changes. By manipulation of the shapes of these cam tracks, different draw-stroke profiles can be created. A compound bow can be soft-drawing with a slow build-up to peak weight and a gradual let-off with a long "valley" at the end. It can also be hard-drawing with a very fast build-up to peak draw-weight, a long plateau where weight is maintained, and a quick let-off with a short valley. The let-off itself is the result of the cam profiles having passed center and approaching a condition very similar to a cam-lock. In fact some compound bows, if the draw-stops or draw-length modules are removed, will self-lock at full draw and require professional equipment to unlock safely.	https://en.wikipedia.org/wiki/Compound_bow	1	compound_bow	The function of the cam systems (known as the 'eccentrics') is to maximize the energy storage throughout the draw cycle and provide let-off at the end of the cycle (less holding weight at full draw).	The compound bow was first developed in 1966; the compound bow is the dominant form of bow.	none	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	169	\N	170	168	158	5	\N	167	f	0	None	0
41	Cyclops	2017-11-09 10:31:43.637471-05	2017-11-09 10:32:02.912442-05	Cyclops (Scott Summers) is a fictional superhero appearing in American comic books published by Marvel Comics and is a founding member of the X-Men. Created by writer Stan Lee and artist Jack Kirby, the character first appeared in the comic book The X-Men #1 (September 1963).\n\nCyclops is a member of a subspecies of humans known as mutants, who are born with superhuman abilities. Cyclops can emit powerful beams of energy from his eyes. He cannot control the beams without the aid of special eyewear which he must wear at all times. He is typically considered the first of the X-Men, a team of mutant heroes who fight for peace and equality between mutants and humans, and one of the team's primary leaders.\n\nCyclops is most often portrayed as the archetypal hero of traditional American popular culture—the opposite of the tough, anti-authority antiheroes that emerged in American popular culture after the Vietnam War (e.g., Wolverine, his X-Men teammate).\n\nOne of Marvel's most prominent characters, Cyclops was rated #1 on IGN.com's list of Top 25 X-Men from the past forty years in 2006, and the 39th in their 2011 list of Top 100 Comic Book Heroes. In 2008, Wizard Magazine also ranked Cyclops the 106th in their list of the 200 Greatest Comic Book Characters of All Time. In a 2011 poll, readers of Comic Book Resources voted Cyclops as 9th in the ranking of 2011 Top Marvel Characters.\n\nJames Marsden has portrayed Cyclops in the first three and the seventh X-Men films, while in the 2009 prequel film, X-Men Origins: Wolverine, he is portrayed as a teenager by actor Tim Pocock. In 2016's X-Men: Apocalypse, he is portrayed by Tye Sheridan.	https://en.wikipedia.org/wiki/Cyclops_(comics)	1	cyclops	\N	Kind of a tool.	None	APPROVED	t	f	3	2	1	0	0	0	1	2	t	UNCLASSIFIED//FOR OFFICIAL USE ONLY	f	2	173	\N	174	172	162	1	\N	171	f	0	None	0
42	Deadpool	2017-11-09 10:31:43.710176-05	2017-11-09 10:32:02.967778-05	Deadpool (Wade Winston Wilson) is a fictional antihero appearing in American comic books published by Marvel Comics. Created by artist/writer Rob Liefeld and writer Fabian Nicieza, the character first appeared in The New Mutants #98 (cover-dated February 1991). Initially Deadpool was depicted as a supervillain when he made his first appearance in The New Mutants and later in issues of X-Force, but later evolved into his more recognizable antiheroic persona. Deadpool, whose real name is Wade Wilson, is a disfigured and mentally unstable mercenary with the superhuman ability of an accelerated healing factor and physical prowess. The character is known as the "Merc with a Mouth" because of his talkative nature and tendency to break the fourth wall, which is used by writers for humorous effect and running gags.\nThe character's popularity has seen him feature in numerous other media. In the 2004 series Cable & Deadpool, he refers to his own scarred appearance as "Ryan Reynolds crossed with a Shar Pei". Reynolds himself would eventually portray the character in the 2009 film X-Men Origins: Wolverine and reprised the role in the 2016 film Deadpool.	https://en.wikipedia.org/wiki/Deadpool	1	deadpool	\N	makes dead people	None	APPROVED	t	f	3.5	2	1	0	0	1	0	2	t	UNCLASSIFIED	f	2	177	\N	178	176	166	4	\N	175	f	0	None	0
43	Desktop Virtualization	2017-11-09 10:31:44.046599-05	2017-11-09 10:31:44.04661-05	Desktop virtualization is software technology that separates the desktop environment and associated application software from the physical client device that is used to access it.\nDesktop virtualization can be used in conjunction with application virtualization and user profile management systems, now termed "user virtualization," to provide a comprehensive desktop environment management system. In this mode, all the components of the desktop are virtualized, which allows for a highly flexible and much more secure desktop delivery model. In addition, this approach supports a more complete desktop disaster recovery strategy as all components are essentially saved in the data center and backed up through traditional redundant maintenance systems. If a user's device or hardware is lost, the restore is straightforward and simple, because the components will be present at login from another device. In addition, because no data is saved to the user's device, if that device is lost, there is much less chance that any critical data can be retrieved and compromised.	http://dv.com	2.01	desktop_virtualization	\N	Desktop virtualization is software technology that separates the desktop environment.	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	181	\N	182	180	170	2	\N	179	f	0	None	0
44	Diamond	2017-11-09 10:31:44.311549-05	2017-11-09 10:31:44.31156-05	Diamond ( /ˈdaɪəmənd/ or /ˈdaɪmənd/) is a metastable allotrope of carbon, where the carbon atoms are arranged in a variation of the face-centered cubic crystal structure called a diamond lattice. Diamond is less stable than graphite, but the conversion rate from diamond to graphite is negligible at standard conditions. Diamond is renowned as a material with superlative physical qualities, most of which originate from the strong covalent bonding between its atoms. In particular, diamond has the highest hardness and thermal conductivity of any bulk material. Those properties determine the major industrial application of diamond in cutting and polishing tools and the scientific applications in diamond knives and diamond anvil cells.\n\nBecause of its extremely rigid lattice, it can be contaminated by very few types of impurities, such as boron and nitrogen. Small amounts of defects or impurities (about one per million of lattice atoms) color diamond blue (boron), yellow (nitrogen), brown (lattice defects), green (radiation exposure), purple, pink, orange or red. Diamond also has relatively high optical dispersion (ability to disperse light of different colors).\n\nMost natural diamonds are formed at high temperature and pressure at depths of 140 to 190 kilometers (87 to 118 mi) in the Earth's mantle. Carbon-containing minerals provide the carbon source, and the growth occurs over periods from 1 billion to 3.3 billion years (25% to 75% of the age of the Earth). Diamonds are brought close to the Earth's surface through deep volcanic eruptions by magma, which cools into igneous rocks known as kimberlites and lamproites. Diamonds can also be produced synthetically in a HPHT method which approximately simulates the conditions in the Earth's mantle. An alternative, and completely different growth technique is chemical vapor deposition (CVD). Several non-diamond materials, which include cubic zirconia and silicon carbide and are often called diamond simulants, resemble diamond in appearance and many properties. Special gemological techniques have been developed to distinguish natural diamonds, synthetic diamonds, and diamond simulants. The word is from the ancient Greek ἀδάμας - adámas "unbreakable".	https://en.wikipedia.org/wiki/Diamond	2	diamond	\N	An overpriced gemstone whose price is inflated by the De Beers cartel	Must spend x amount of your salary to show your love	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	185	\N	186	184	174	5	\N	183	f	0	None	0
45	Dinosaur	2017-11-09 10:31:44.435294-05	2017-11-09 10:32:03.051448-05	Dinosaurs are a diverse group of reptiles of the clade Dinosauria that first appeared during the Triassic period. Although the exact origin and timing of the evolution of dinosaurs is the subject of active research, the current scientific consensus places their origin between 231 and 243 million years ago.	http://localhost.com	1	dinosaur	\N	They were dangerous creatures.	Windows 95	APPROVED	t	f	3.29999999999999982	3	1	1	0	0	1	3	t	UNCLASSIFIED	f	5	189	\N	190	188	178	1	\N	187	f	0	None	0
97	LocationViewer	2017-11-09 10:31:50.117869-05	2017-11-09 10:31:50.117878-05	View locations	https://localhost:8443/demo_apps/locationViewer/index.html	1.0.0	ozp.test.locationviewer	Nothing really new here	View locations	None	APPROVED	t	t	0	0	0	0	0	0	0	0	f	UNCLASSIFIED	f	1	397	\N	398	396	386	3	\N	395	f	0	None	0
46	Double Heroides	2017-11-09 10:31:44.488697-05	2017-11-09 10:31:44.488707-05	The Double Heroides are a set of six epistolary poems allegedly composed by Ovid in Latin elegiac couplets, following the fifteen poems of his Heroides, and numbered 16 to 21 in modern scholarly editions. These six poems present three separate exchanges of paired epistles: one each from a heroic lover from Greek or Roman mythology to his absent beloved, and one from the heroine in return. Ovid's authorship is uncertain.	https://en.wikipedia.org/wiki/Double_Heroides	6	double_heroides	\N	The Double Heroides are a set of six epistolary poems	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	193	\N	194	192	182	3	\N	191	f	0	None	0
47	Dragons	2017-11-09 10:31:44.661571-05	2017-11-09 10:32:03.078754-05	A dragon is a legendary creature, typically scaled or fire-spewing and with serpentine, reptilian or avian traits, that features in the myths of many cultures around world. The two most well-known cultural traditions of dragon are\n\nThe European dragon, derived from European folk traditions and ultimately related to Balkans and Western Asian mythologies. Most are depicted as reptilian creatures with animal-level intelligence, and are uniquely six-limbed (four legs and a separate set of wings).\nThe Chinese dragon, with counterparts in Japan (namely the Japanese dragon), Korea and other East Asian and South Asian countries. Most are depicted as serpentine creatures with above-average intelligence, and are quadrupeds (four legs and wingless).\nThe two traditions may have evolved separately, but have influenced each other to a certain extent, particularly with the cross-cultural contact of recent centuries. The English word dragon and Latin word draco derives from Greek δράκων (drákōn), "dragon, serpent of huge size, water-snake".	https://en.wikipedia.org/wiki/Dragon	5	dragons	New illustrations of dragons	The fantastical lizard-like creature, often having wings or ability to fly	None	APPROVED	t	f	5	1	1	0	0	0	0	1	t	UNCLASSIFIED	f	4	197	\N	198	196	186	1	\N	195	f	0	None	0
48	E-ZPass	2017-11-09 10:31:44.776626-05	2017-11-09 10:31:44.776634-05	E‑ZPass is an electronic toll collection system used on most tolled roads, bridges, and tunnels in the midwestern and northeastern United States, as far south as North Carolina and as far west as Illinois. The E-ZPass Interagency Group (IAG) consists of 38 member agencies in operation within 16 states, which use the same technology and allow travelers to use the same transponder on toll roads throughout the network. Since its creation in 1987, various independent systems that use the same technology have been folded into the E-ZPass system, including the I-Pass in Illinois and the NC Quick Pass in North Carolina.	https://en.wikipedia.org/wiki/E-ZPass	1987	e-zpass	\N	E‑ZPass is an electronic toll collection system.	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	201	\N	202	200	190	2	\N	199	f	0	None	0
49	Electric Guitar	2017-11-09 10:31:44.836712-05	2017-11-09 10:31:44.83672-05	Is a fretted stringed instrument with a neck and body that uses a pickup to convert the vibration of its strings into electrical signals. The vibration occurs when a guitarist strums, plucks or fingerpicks the strings	https://en.wikipedia.org/wiki/Electric_guitar	1.05	electric_guitar	Construction vary greatly in the shape of the body and the configuration of the neck, bridge, and pickup	Guitar that uses a pickup to convert the vibration of its strings into electrical signals	Magnetic pickup that uses the principle of direct electromagnetic induction	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	2	205	\N	206	204	194	3	\N	203	f	0	None	0
50	Electric Piano	2017-11-09 10:31:44.92695-05	2017-11-09 10:31:44.926962-05	Electric musical instrument which produces sounds when a performer presses the keys of the piano-style musical keyboard. Pressing keys causes mechanical hammers to strike metal strings, metal reeds or wire tines, leading to vibrations which are converted into electrical signals by magnetic pickups, which are then connected to an instrument amplifier and loudspeaker to make a sound loud enough for the performer and audience to hear. Unlike a synthesizer, the electric piano is not an electronic instrument	https://en.wikipedia.org/wiki/Electric_piano	8.0.9	electric_piano	Digital electronic stage pianos that provide an emulated electric piano sound	Electric musical instrument which produces sounds when a performer presses the keys of the keyboard	Electricity and motivation to play piano	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	2	209	\N	210	208	198	3	\N	207	f	0	None	0
51	English Bitter	\N	2017-11-09 10:31:45.040844-05	Bitter is a British style of pale ale that varies in colour from gold to dark amber, and in strength from 3% to 7% alcohol by volume.	https://en.wikipedia.org/wiki/Bitter_%28beer%29	3	english_bitter	\N	Bitter is a British style of pale ale that varies in colour from gold to dark amber.	None	PENDING	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	213	\N	214	212	200	5	\N	211	f	0	None	0
52	Eraser	2017-11-09 10:31:45.133512-05	2017-11-09 10:31:45.133522-05	An eraser, (also called a rubber outside America, from the material first used) is an article of stationery that is used for removing writing from paper. Erasers have a rubbery consistency and come in a variety of shapes, sizes and colours. Some pencils have an eraser on one end. Less expensive erasers are made from synthetic rubber and synthetic soy-based gum, but more expensive or specialized erasers are vinyl, plastic, or gum-like materials.\nErasers were initially made for pencil markings, but more abrasive ink erasers were later introduced. The term is also used for things that remove writing from chalkboards and whiteboards.	https://en.wikipedia.org/wiki/Eraser	1	eraser	\N	An eraser is an article of stationery that is used for removing writing from paper.	Pencil	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	217	\N	218	216	204	5	\N	215	f	0	None	0
53	Excitebike	2017-11-09 10:31:45.178748-05	2017-11-09 10:31:45.178758-05	Excitebike (エキサイトバイク Ekisaitobaiku) is a motocross racing video game franchise made by Nintendo. It debuted as a game for the Famicom in Japan in 1984 and as a launch title for the NES in 1985. It is the first game of the Excite series, succeeded by its direct sequel Excitebike 64, its spiritual successors Excite Truck and Excitebots: Trick Racing, and the WiiWare title Excitebike: World Rally. 3D Classics: Excitebike, a 3D remake of the original game, was free for a limited time to promote the launch of the Nintendo eShop in June 2011.	https://en.wikipedia.org/wiki/Excitebike	1	excitebike	\N	Excitebike (エキサイトバイク Ekisaitobaiku) is a motocross racing video game.	NES	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	221	\N	222	220	208	2	\N	219	f	0	None	0
54	Fiat 525	2017-11-09 10:31:45.296092-05	2017-11-09 10:31:45.296125-05	The Fiat 525 is a passenger car produced by Italian automobile manufacturer Fiat between 1928 and 1931. The 525 was a larger successor to the Fiat 512. The 525 was modified a year after it began production and renamed the 525N. A sport variant, the 525SS, had a more powerful engine and a shorter chassis.\nFiat produced 4,400 525's.	https://en.wikipedia.org/wiki/Fiat_525	525	fiat_525	\N	The Fiat 525 is a passenger car produced by Italian automobile manufacturer Fiat.	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	t	6	225	\N	226	224	212	2	\N	223	f	0	None	0
100	Magneto	2017-11-09 10:31:50.3241-05	2017-11-09 10:32:04.478881-05	Magneto is a fictional character appearing in American comic books published by Marvel Comics, commonly in association with the X-Men. Created by writer Stan Lee and artist Jack Kirby, the character first appears in The X-Men #1 (cover-dated Sept. 1963) as the archenemy of the X-Men.\nThe character is a powerful mutant, one of a fictional subspecies of humanity born with superhuman abilities, who has the ability to generate and control magnetic fields. Magneto regards mutants as evolutionarily superior to humans and rejects the possibility of peaceful human-mutant coexistence; he aims to conquer the world to enable mutants (whom he refers to as "homo superior") to replace humans as the dominant species. Writers have since fleshed out his origins and motivations, revealing him to be a Holocaust survivor whose extreme methods and cynical philosophy derive from his determination to protect mutantkind from suffering a similar fate at the hands of a world that fears and persecutes mutants. He is a friend of Professor X, the leader of the X-Men, but their different philosophies cause a rift in their friendship at times. Magneto's role in comics has varied from supervillain to antihero to superhero, having served as an occasional ally and even a member of the X-Men at times.\nHis character's early history has been compared with the civil rights leader Malcolm X and Jewish Defense League founder Meir Kahane. Magneto opposes the pacifist attitude of Professor X and pushes for a more aggressive approach to achieving civil rights. In 2011, IGN ranked Magneto as the greatest comic book villain of all time.\nSir Ian McKellen portrayed Magneto in four films of the X-Men film series, while Michael Fassbender portrayed a younger version of the character in three films.	https://en.wikipedia.org/wiki/Magneto_(comics)	1	magneto	\N	Controls metal, also they keep trying to make him good for some reason.	None	APPROVED	t	f	2	2	0	0	1	0	1	2	t	UNCLASSIFIED	f	2	409	\N	410	408	398	3	\N	407	f	0	None	0
55	Fight Club	2017-11-09 10:31:45.356398-05	2017-11-09 10:32:03.106273-05	Fight Club is a 1999 American film based on the 1996 novel of the same name by Chuck Palahniuk. The film was directed by David Fincher, and stars Brad Pitt, Edward Norton and Helena Bonham Carter. Norton plays the unnamed protagonist, referred to as the narrator, who is discontented with his white-collar job. He forms a "fight club" with soap maker Tyler Durden, played by Pitt, and they are joined by men who also want to fight recreationally. The narrator becomes embroiled in a relationship with Durden and a dissolute woman, Marla Singer, played by Bonham Carter.\nPalahniuk's novel was optioned by 20th Century Fox producer Laura Ziskin, who hired Jim Uhls to write the film adaptation. Fincher was one of four directors the producers considered, and was selected because of his enthusiasm for the film. Fincher developed the script with Uhls and sought screenwriting advice from the cast and others in the film industry. The director and the cast compared the film to Rebel Without a Cause (1955) and The Graduate (1967). They said its theme was the conflict between a generation of young people and the value system of advertising. The director copied the homoerotic overtones from Palahniuk's novel to make audiences uncomfortable and keep them from anticipating the twist ending.	https://en.wikipedia.org/wiki/Fight_Club	1	fight_club	\N	Fight Club is a 1999 American film based on the 1996 novel of the same name by Chuck Palahniuk.	The first rule of fight club is you do not talk about fight club	APPROVED	t	f	3	1	0	0	1	0	0	1	t	UNCLASSIFIED	f	3	229	\N	230	228	216	2	\N	227	f	0	None	0
56	Floppy Disk	2017-11-09 10:31:45.648309-05	2017-11-09 10:32:03.212793-05	A floppy disk, also called a floppy, diskette, or just disk, is a type of disk storage composed of a disk of thin and flexible magnetic storage medium, sealed in a rectangular plastic enclosure lined with fabric that removes dust particles. Floppy disks are read and written by a floppy disk drive.	http://localhost.com	12	floppy_disk	\N	They got destroyed by USB drives later on.	Must have floppy disk drive	APPROVED	t	f	3.20000000000000018	4	1	0	2	1	0	4	t	UNCLASSIFIED	f	8	233	\N	234	232	220	3	\N	231	f	0	None	0
57	Formula	2017-11-09 10:31:45.734555-05	2017-11-09 10:31:45.734566-05	A formula is a concise way of expressing information symbolically, as in a mathematical or chemical formula. The informal use of the term formula in science refers to the general construct of a relationship between given quantities. The plural of formula can be spelled either as formulas or formulae	https://en.wikipedia.org/wiki/Formula	8.1.9	formula	When the chemical compound of the formula consists of simple molecules, chemical formulas often employ ways to suggest the structure of the molecule. There are several types of these formulas, including molecular formulas and condensed formulas	A formula is a concise way of expressing information symbolically	Expressions are distinct from formulas in that they cannot contain an equals sign (=). Whereas formulas are comparable to sentences, expressions are more like phrases.	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	2	237	\N	238	236	224	2	\N	235	f	0	None	0
58	FrameIt	2017-11-09 10:31:45.819808-05	2017-11-09 10:31:45.819818-05	Show things in an iframe	https://localhost:8443/demo_apps/frameit/index.html	1.0.0	ozp.test.frameit	Nothing really new here	Its an iframe	None	APPROVED	t	t	0	0	0	0	0	0	0	0	f	UNCLASSIFIED	f	1	241	\N	242	240	228	3	\N	239	f	0	None	0
59	Gallery of Maps	2017-11-09 10:31:45.992449-05	2017-11-09 10:32:03.266751-05	Featured pictures/Non-photographic media/Maps\nGallery of Maps\nThis page is a gallery of featured pictures that the community has chosen to be highlighted as some of the finest on Commons.\n\nContents  \n1\t  Gallery of Maps\n2\tMaps\n2.1\tMaps of Africa\n2.2\tMaps of Asia\n2.3\tMaps of the Caribbean\n2.4\tMaps of Europe\n2.5\tMaps of North America\n2.6\tMaps of Oceania\n2.7\tMaps of South America\n2.8\tOthers maps\n3\tUnsorted	https://commons.wikimedia.org/wiki/Commons:Featured_pictures/Non-photographic_media/Maps	1.0	gallery_of_maps	\N	Commons:Featured pictures/Non-photographic media/Maps	None	APPROVED	t	f	3.5	2	0	1	1	0	0	2	t	UNCLASSIFIED	f	4	245	\N	246	244	232	5	\N	243	f	0	None	0
60	Gerris	2017-11-09 10:31:46.047292-05	2017-11-09 10:31:46.047302-05	Gerris is computer software in the field of computational fluid dynamics (CFD). Gerris was released as free and open-source software, subject to the usage_requirements of the GNU General Public License (GPL), version 2 or any later.	https://en.wikipedia.org/wiki/Gerris_%28software%29	3d	gerris	\N	Gerris is computer software in the field of computational fluid dynamics (CFD).	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	249	\N	250	248	236	1	\N	247	f	0	None	0
66	Hatch Latch	2017-11-09 10:31:46.532519-05	2017-11-09 10:31:46.532533-05	Hatch latches	https://localhost:8443/demo_apps/centerSampleListings/hatchLatch/index.html	1.0.0	ozp.test.hatchlatch	Nothing really new here	Its a hatch latch	None	APPROVED	t	t	0	0	0	0	0	0	0	0	f	UNCLASSIFIED	f	1	273	\N	274	272	262	3	\N	271	f	0	None	0
61	Global Navigation Grid Code	2017-11-09 10:31:46.110391-05	2017-11-09 10:32:03.324223-05	From Wikipedia, the free encyclopedia The Global Navigation Grid Code (GNGC) is a Chinese-developed point reference system designed for global navigation. It is similar in design to national grid reference systems used throughout the world. GNGC was based upon the work of the GeoSOT team, headquartered in the Institute of Remote Sensing and GIS, Peking University. The concept for this system was proposed in 2015 in Bin Li's dissertation: Navigation Computing Model of Global Navigation Grid Code. GNGC allows easy calculation of space and spatial indexes and can be extended to the provide navigation mesh coding. Along with the Beidou navigation system, GNGC provides independent intellectual property rights, globally applicable standards and global navigation trellis code.	https://en.wikipedia.org/wiki/Global_Navigation_Grid_Code	1.0	global_navigation_grid_code	\N	The Global Navigation Grid Code (GNGC) is a reference system designed for global navigation	None	APPROVED	t	f	5	2	2	0	0	0	0	2	t	UNCLASSIFIED	f	4	253	\N	254	252	240	4	\N	251	f	0	None	0
62	Gramophone record	2017-11-09 10:31:46.203648-05	2017-11-09 10:31:46.203659-05	A gramophone record (phonograph record in the US), commonly known as a vinyl record or simply vinyl or record, is an analog sound storage medium in the form of a flat polyvinyl chloride (previously shellac) disc with an inscribed, modulated spiral groove. The groove usually starts near the periphery and ends near the center of the disc.\n\nThe phonograph disc record was the primary medium used for music reproduction until late in the 20th century. It had co-existed with the phonograph cylinder from the late 1880s and replaced it by the late 1920s. Records retained the largest market share even when new formats such as compact cassette were mass-marketed. By the late 1980s, digital media, in the form of the compact disc, had gained a larger market share, and the vinyl record left the mainstream in 1991. From the 1990s to the 2010s, records continued to be manufactured and sold on a much smaller scale, and were especially used by disc jockeys (DJs), released by artists in some genres, and listened to by a niche market of audiophiles. The phonograph record has made a niche resurgence in the early 21st century - 9.2 million records were sold in the U.S. in 2014, a 260% increase since 2009. Likewise, in the UK sales have increased five-fold from 2009 to 2014.	https://en.wikipedia.org/wiki/Gramophone_record	45	gramophone_record	\N	A gramophone record (phonograph record in the US), commonly known as a vinyl record.	Record player	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	5	257	\N	258	256	244	5	\N	255	f	0	None	0
63	Grandfather clock	2017-11-09 10:31:46.248274-05	2017-11-09 10:31:46.248285-05	A longcase clock, also tall-case clock, floor clock, or grandfather clock, is a tall, freestanding, weight-driven pendulum clock with the pendulum held inside the tower or waist of the case. Clocks of this style are commonly 1.8-2.4 metres (6-8 feet) tall. The case often features elaborately carved ornamentation on the hood (or bonnet), which surrounds and frames the dial, or clock face. The English clockmaker William Clement is credited with the development of this form in 1670. Until the early 20th century, pendulum clocks were the world's most accurate timekeeping technology, and longcase clocks, due to their superior accuracy, served as time standards for households and businesses. Today they are kept mainly for their decorative and antique value.	https://en.wikipedia.org/wiki/Longcase_clock	1	grandfather_clock	Traditionally, longcase clocks were made with two types of movement: eight-day and one-day (30-hour) movements. A clock with an eight-day movement required winding only once a week, while generally less expensive 30-hour clocks had to be wound every day.	A longcase clock, also tall-case clock, floor clock, or grandfather clock.	none	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	261	\N	262	260	248	2	\N	259	f	0	None	0
64	Great white shark	2017-11-09 10:31:46.330057-05	2017-11-09 10:32:03.383895-05	The great white shark (Carcharodon carcharias), also known as the great white, white pointer, white shark, or white death, is a species of large mackerel shark which can be found in the coastal surface waters of all the major oceans. The great white shark is notable for its size, with larger female individuals growing to 6.1 m (20 ft) in length and 1,950 kg (4,300 lb) in weight at maturity. However most are smaller, males measuring 3.4 to 4.0 m (11 to 13 ft) and females 4.6 to 4.9 m (15 to 16 ft) on average. According to a 2014 study the lifespan of great white sharks is estimated to be as long as 70 years or more, well above previous estimates, making it one of the longest lived cartilaginous fish currently known. According to the same study, male great white sharks take 26 years to reach sexual maturity, while the females take 33 years to be ready to produce offspring. Great white sharks can swim at speeds of over 56 km/h (35 mph), and can swim to depths of 1,200 m (3,900 ft).	https://en.wikipedia.org/wiki/Great_white_shark	10.1.9	great_white_shark	The great white shark has no known natural predators other than, on very rare occasion, the killer whale.	The great white shark has a robust, large, conical snout.	Great white sharks live in almost all coastal and offshore waters which have water temperature between 12 and 24 °C (54 and 75 °F), with greater concentrations in the United States (Northeast and California), South Africa, Japan, Oceania, Chile, and the Mediterranean. One of the densest known populations is found around Dyer Island, South Africa.	APPROVED	t	f	4	2	1	0	1	0	0	2	t	UNCLASSIFIED	f	3	265	\N	266	264	252	3	\N	263	f	0	None	0
65	Harley-Davidson CVO	2017-11-09 10:31:46.399547-05	2017-11-09 10:32:03.414302-05	Harley-Davidson CVO (for Custom Vehicle Operations) motorcycles are a family of models created by Harley-Davidson for the factory custom market. For every model year since the program's inception in 1999, Harley-Davidson has chosen a small selection of its mass-produced motorcycle models and created limited-edition customizations of those platforms with larger-displacement engines, costlier paint designs, and additional accessories not found on the mainstream models. Special features for the CVO lineup have included performance upgrades from Harley's "Screamin' Eagle" branded parts, hand-painted pinstripes, ostrich leather on seats and trunks, gold leaf incorporated in the paint, and electronic accessories like GPS navigation systems and iPod music players.\nCVO models are produced in Harley-Davidson's York, Pennsylvania plant, where touring and Softail models are also manufactured. In each model year, CVO models feature larger-displacement engines than the mainstream models, and these larger-displacement engines make their way into the normal "big twin" line within a few years when CVO models are again upgraded. Accessories created for these customized units are sometimes offered in the Harley-Davidson accessory catalog for all models in later years, but badging and paint are kept exclusively for CVO model owners, and cannot be replaced without providing proof of ownership to the ordering dealer	https://en.wikipedia.org/wiki/Harley-Davidson_CVO	2	harley-davidson_cvo	CVO 125 big bore motors	CVOs are fast and loud.	None	APPROVED	t	t	3	1	0	0	1	0	0	1	t	UNCLASSIFIED	f	1	269	\N	270	268	258	1	\N	267	f	0	None	0
67	Hawaii	2017-11-09 10:31:46.675355-05	2017-11-09 10:32:03.503767-05	Hawaii is the only U.S. state located in Oceania and the only one composed entirely of islands. It is the northernmost island group in Polynesia, occupying most of an archipelago in the central Pacific Ocean. Hawaii is the only U.S. state located outside North America.	http://localhost.com	1	hawaii	\N	Hawaii is the 50th and most recent state to have joined the United States of America.	None	APPROVED	t	f	4	3	1	1	1	0	0	3	t	UNCLASSIFIED	f	2	277	\N	278	276	266	3	\N	275	f	0	None	0
68	House Lannister	2017-11-09 10:31:46.797607-05	2017-11-09 10:32:03.532884-05	This is a full description of House Lannister	http://www.google.com	v5.0	house_lannister	\N	This is a short description of House Lannister	none	APPROVED	t	f	1	1	0	0	0	0	1	1	t	UNCLASSIFIED	f	2	281	\N	282	280	270	3	\N	279	f	0	None	0
69	House Stark	2017-11-09 10:31:47.507893-05	2017-11-09 10:32:03.594092-05	Full Description of House Stark and members	http://www.google.com	v6.0	house_stark	\N	Short Description of House Stark and members	none	APPROVED	t	f	2.5	2	0	1	0	0	1	2	t	UNCLASSIFIED	f	1	285	\N	286	284	274	3	\N	283	f	0	None	0
70	House Targaryen	2017-11-09 10:31:47.578695-05	2017-11-09 10:32:03.625322-05	House Targaryen is a former Great House of Westeros and was the ruling royal House of the Seven Kingdoms for three centuries since it conquered and unified the realm, before it was deposed during Robert's Rebellion and House Baratheon replaced it as the new royal House. The few surviving Targaryens fled into exile to the Free Cities of Essos across the Narrow Sea. Currently based on Dragonstone off of the eastern coast of Westeros, House Targaryen seeks to retake the Seven Kingdoms from House Lannister, who formally replaced House Baratheon as the royal House following the destruction of the Great Sept of Baelor.	http://gameofthrones.wikia.com/wiki/House_Targaryen	11	house_targaryen	Now seeking allies to take down the false rulers of Westeros	The rightful rulers of Westeros. Currently in exile after betrayal by kingsmen.	None	APPROVED	t	f	5	1	1	0	0	0	0	1	t	UNCLASSIFIED	f	1	289	\N	290	288	278	4	\N	287	f	0	None	0
71	Huexotzinco Codex	2017-11-09 10:31:47.639691-05	2017-11-09 10:31:47.639701-05	The Huexotzinco Codex or Huejotzingo Codex is a colonial-era Nahua pictorial manuscript, collectively known as Aztec codices. The Huexotzinco Codex eight-sheet document on amatl, a pre-European paper made in Mesoamerica. It is part of the testimony in a legal case against members of the First Audiencia (high court) in Mexico, particularly its president, Nuño de Guzmán, ten years after the Spanish conquest in 1521. Huexotzinco, (Way-hoat-ZINC-o) is a town southeast of Mexico City, in the state of Puebla. In 1521, the Nahua Indian people of the town were the allies of the Spanish conqueror Hernán Cortes, and together they confronted their enemies to overcome Moctezuma, leader of the Aztec Empire. Cortes's indigenous allies from Tlaxcala were more successful than those Huejotzinco in translating that alliance into privileges in the colonial era and the Huejotzincan's petitioned the crown for such privileges. A 1560 petition to the crown in Nahuatl outlines their participation.	https://en.wikipedia.org/wiki/Huexotzinco_Codex	1	huexotzinco_codex	\N	The Huexotzinco Codex or Huejotzingo Codex is a colonial-era Nahua pictorial manuscript.	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED//FOR OFFICIAL USE ONLY	f	9	293	\N	294	292	282	1	\N	291	f	0	None	0
72	India Pale Ale	2017-11-09 10:31:47.672989-05	2017-11-09 10:31:47.672997-05	India pale ale (IPA) is a hoppy beer style within the broader category of pale ale. It has also been referred to as pale ale as prepared for India, India ale, pale India ale, or pale export India ale.\nThe term pale ale originally denoted an ale that had been brewed from pale malt. Among the first brewers known to export beer to India was George Hodgson's Bow Brewery, on the Middlesex-Essex border. Bow Brewery beers became popular among East India Company traders in the late 18th century because of the brewery's location near the East India Docks. Demand for the export style of pale ale, which had become known as India pale ale, developed in England around 1840 and it later became a popular product there. IPAs have a long history in Canada and the United States, and many breweries there produce a version of the style.	https://en.wikipedia.org/wiki/India_pale_ale	12	india_pale_ale	\N	India pale ale (IPA) is a hoppy beer style.	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	297	\N	298	296	286	2	\N	295	f	0	None	0
73	Informational Book	2017-11-09 10:31:47.745764-05	2017-11-09 10:32:03.656903-05	The Wikimedia Foundation, Inc. is a nonprofit charitable organization dedicated to encouraging the growth, development and distribution of free, multilingual, educational content, and to providing the full content of these wiki-based projects to the public free of charge. The Wikimedia Foundation operates some of the largest collaboratively edited reference projects in the world, including Wikipedia, a top-ten internet property.\nImagine a world in which every single human being can freely share in the sum of all knowledge. That’s our commitment	https://wikimediafoundation.org/wiki/Home	1.0.5	informational_book	The annual plan documents the Foundation's 2016-17 financial plan, strategic targets, activities, and staffing overview.	The Free Encyclopedia	The Wikimedia Foundation relies heavily on the generous support from our users. Please consider making a donation today, be it time or money.\nThe Wikimedia Foundation is incorporated as a 501(c)(3) nonprofit organization in the United States, and donations from US citizens are tax deductible. Donations made by citizens of other countries may also be tax deductible. Please see deductibility of donations for details. Please see our fundraising page for details of making donations via credit card, PayPal, postal mail or direct deposit. For all other types of donations, please contact us.	APPROVED	t	f	5	1	1	0	0	0	0	1	t	UNCLASSIFIED//FOR OFFICIAL USE ONLY	f	2	301	\N	302	300	290	3	\N	299	f	0	None	0
127	Piano	2017-11-09 10:31:52.842327-05	2017-11-09 10:31:52.842338-05	piano is an acoustic, stringed musical instrument invented around the year 1700 (the exact year is uncertain), in which the strings are struck by hammers	https://en.wikipedia.org/wiki/Piano	10.8	piano	Most modern pianos have a row of 88 black and white keys	Acoustic, Stringed Musical Instrument	52 white keys for the notes of the C major scale (C, D, E, F, G, A and B) and 36 shorter black keys	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	2	517	\N	518	516	506	3	\N	515	f	0	None	0
74	Intelligence Unleashed	2017-11-09 10:31:48.120524-05	2017-11-09 10:31:48.120532-05	Business Intelligence (BI) comprises the strategies and technologies used by enterprises for the data analysis of business information. BI technologies provide historical, current and predictive views of business operations. Common functions of business intelligence technologies include reporting, online analytical processing, analytics, data mining, process mining, complex event processing, business performance management, benchmarking, text mining, predictive analytics and prescriptive analytics. BI technologies can handle large amounts of structured and sometimes unstructured data to help identify, develop and otherwise create new strategic business opportunities. They aim to allow for the easy interpretation of these big data. Identifying new opportunities and implementing an effective strategy based on insights can provide businesses with a competitive market advantage and long-term stability.	http://bi.com	2.0	intelligence_unleashed	\N	Business Intelligence (BI) comprises the strategies and technologies used by enterprises.	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	305	\N	306	304	294	2	\N	303	f	0	None	0
75	Intelligent transportation system	2017-11-09 10:31:48.222544-05	2017-11-09 10:31:48.222553-05	From Wikipedia, the free encyclopedia\nAn intelligent transportation system (ITS) is an advanced application which, without embodying intelligence as such, aims to provide innovative services relating to different modes of transport and traffic management and enable various users to be better informed and make safer, more coordinated, and 'smarter' use of transport networks.\nAlthough ITS may refer to all modes of transport, the directive of the European Union 2010/40/EU, made on the 7 July, 2010, defined ITS as systems in which information and communication technologies are applied in the field of road transport, including infrastructure, vehicles and users, and in traffic management and mobility management, as well as for interfaces with other modes of transport.	https://en.wikipedia.org/wiki/Intelligent_transportation_system	1.5	intelligent_transportation_system	\N	An intelligent transportation system (ITS) is an advanced application	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	309	\N	310	308	298	3	\N	307	f	0	None	0
76	Internet meme	2017-11-09 10:31:48.320931-05	2017-11-09 10:31:48.320953-05	An Internet meme (/miːm/ MEEM)  is an activity, concept, catchphrase or piece of media which spreads, often as mimicry or for humorous purposes, from person to person via the Internet. An Internet meme may also take the form of an image (typically an image macro), hyperlink, video, website, or hashtag. It may be just a word or phrase, sometimes including an intentional misspelling. These small movements tend to spread from person to person via social networks, blogs, direct email, or news sources. They may relate to various existing Internet cultures or subcultures, often created or spread on various websites, or by Usenet boards and other such early-internet communications facilities. Fads and sensations tend to grow rapidly on the Internet, because the instant communication facilitates word-of-mouth transmission. Some examples include posting a photo of people lying down in public places (called "planking") and uploading a short video of people dancing to the Harlem Shake.	https://en.wikipedia.org/wiki/Internet_meme	1	internet_meme	\N	An Internet meme is a piece of media which spreads, often as mimicry or for humorous purposes	A funny bone	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	313	\N	314	312	302	3	\N	311	f	0	None	0
77	Iron Man	2017-11-09 10:31:48.376007-05	2017-11-09 10:32:03.746921-05	Iron Man (Tony Stark) is a fictional superhero appearing in American comic books published by Marvel Comics. The character was created by writer and editor Stan Lee, developed by scripter Larry Lieber, and designed by artists Don Heck and Jack Kirby. The character made his first appearance in Tales of Suspense #39 (cover dated March 1963).\nA wealthy American business magnate, playboy, and ingenious scientist, Tony Stark suffers a severe chest injury during a kidnapping in which his captors attempt to force him to build a weapon of mass destruction. He instead creates a powered suit of armor to save his life and escape captivity. Later, Stark augments his suit with weapons and other technological devices he designed through his company, Stark Industries. He uses the suit and successive versions to protect the world as Iron Man, while at first concealing his true identity. Initially, Iron Man was a vehicle for Stan Lee to explore Cold War themes, particularly the role of American technology and business in the fight against communism. Subsequent re-imaginings of Iron Man have transitioned from Cold War themes to contemporary concerns, such as corporate crime and terrorism.\nThroughout most of the character's publication history, Iron Man has been a founding member of the superhero team the Avengers and has been featured in several incarnations of his own various comic book series. Iron Man has been adapted for several animated TV shows and films. The character is portrayed by Robert Downey Jr. in the live action film Iron Man (2008), which was a critical and box office success. Downey, who received much acclaim for his performance, reprised the role in a cameo in The Incredible Hulk (2008), two Iron Man sequels Iron Man 2 (2010) and Iron Man 3 (2013), The Avengers (2012), Avengers: Age of Ultron (2015), Captain America: Civil War (2016), and Spider-Man: Homecoming (2017), and will do so again in Avengers: Infinity War (2018) and its untitled sequel (2019) in the Marvel Cinematic Universe.\nIron Man was ranked 12th on IGN's "Top 100 Comic Book Heroes" in 2011, and third in their list of "The Top 50 Avengers" in 2012.	https://en.wikipedia.org/wiki/Iron_Man	1	iron_man	\N	pew pew pew	None	APPROVED	t	f	4.29999999999999982	3	2	0	1	0	0	3	t	UNCLASSIFIED	f	2	317	\N	318	316	306	1	\N	315	f	0	None	0
78	Jar of Flies	2017-11-09 10:31:48.48157-05	2017-11-09 10:32:03.777764-05	Jar of Flies is the second studio EP by the American rock band Alice in Chains, released on January 25, 1994 through Columbia Records. It is the first EP in music history to debut at number one on the Billboard 200 Chart with the first week sales exceeding 141,000 copies in the United States and was well received by critics. The EP has since been certified triple-platinum by the RIAA and has gone on to sell 4 million copies worldwide,[citation needed] making Jar of Flies one of the biggest sellers in Alice in Chains' catalog.	https://en.wikipedia.org/wiki/Jar_of_Flies	1.994	jar_of_flies	\N	Jar of Flies is the second studio EP by the American rock band Alice in Chains	None	APPROVED	t	f	3	1	0	0	1	0	0	1	t	UNCLASSIFIED//FOR OFFICIAL USE ONLY	f	3	321	\N	322	320	310	3	\N	319	f	0	None	0
79	Jasoom	2017-11-09 10:31:48.611799-05	2017-11-09 10:32:03.839962-05	Earth is the third planet from the Sun and the only object in the Universe known to harbor life. According to radiometric dating and other sources of evidence, Earth formed over 4 billion years ago. Earth's gravity interacts with other objects in space, especially the Sun and the Moon, Earth's only natural satellite. During one orbit around the Sun, Earth rotates about its axis about 365.26 times; thus, an Earth year is about 365.26 days long.[n 5]\nEarth's axis of rotation is tilted, producing seasonal variations on the planet's surface. The gravitational interaction between the Earth and Moon causes ocean tides, stabilizes the Earth's orientation on its axis, and gradually slows its rotation. Earth is the densest planet in the Solar System and the largest of the four terrestrial planets.\nEarth's lithosphere is divided into several rigid tectonic plates that migrate across the surface over periods of many millions of years. About 71% of Earth's surface is covered with water, mostly by its oceans. The remaining 29% is land consisting of continents and islands that together have many lakes, rivers and other sources of water that contribute to the hydrosphere. The majority of Earth's polar regions are covered in ice, including the Antarctic ice sheet and the sea ice of the Arctic ice pack. Earth's interior remains active with a solid iron inner core, a liquid outer core that generates the Earth's magnetic field, and a convecting mantle that drives plate tectonics.\nWithin the first billion years of Earth's history, life appeared in the oceans and began to affect the Earth's atmosphere and surface, leading to the proliferation of aerobic and anaerobic organisms. Some geological evidence indicates that life may have arisen as much as 4.1 billion years ago. Since then, the combination of Earth's distance from the Sun, physical properties, and geological history have allowed life to evolve and thrive. In the history of the Earth, biodiversity has gone through long periods of expansion, occasionally punctuated by mass extinction events. Over 99% of all species that ever lived on Earth are extinct. Estimates of the number of species on Earth today vary widely; most species have not been described. Over 7.4 billion humans live on Earth and depend on its biosphere and minerals for their survival. Humans have developed diverse societies and cultures; politically, the world has about 200 sovereign states.	https://en.wikipedia.org/wiki/Earth	1.0	jasoom	\N	Earth is the third planet from the Sun and the only object in the Universe known to harbor life.	Requires the internet.	APPROVED	t	f	3.5	2	1	0	0	1	0	2	t	UNCLASSIFIED	f	3	325	\N	326	324	314	3	\N	323	f	0	None	0
82	JotSpot	2017-11-09 10:31:48.790994-05	2017-11-09 10:32:03.990981-05	Jot things down	https://localhost:8443/demo_apps/centerSampleListings/jotSpot/index.html	1.0.0	ozp.test.jotspot	Nothing really new here	Jot stuff down	None	APPROVED	t	t	4	1	0	1	0	0	0	1	f	UNCLASSIFIED	f	1	337	\N	338	336	326	3	\N	335	f	0	None	0
80	Jay and Silent Bob Strike Back	2017-11-09 10:31:48.656354-05	2017-11-09 10:32:03.870964-05	Jay and Silent Bob Strike Back is a 2001 American comedy film written and directed by Kevin Smith, the fifth to be set in his View Askewniverse, a growing collection of characters and settings that developed out of his cult favorite Clerks. It focuses on the two eponymous characters, played respectively by Jason Mewes and Smith. The film features a large number of cameo appearances by famous actors and directors, and its title and logo for Jay and Silent Bob Strike Back are direct references to The Empire Strikes Back.\nOriginally intended to be the last film set in the Askewniverse, or to feature Jay and Silent Bob, Strike Back features many characters from the previous Askew films, some in dual roles and reprising roles from the previous entries. The film was a minor commercial success, grossing $33.8 million worldwide from a $22 million budget, and received mixed reviews from critics.\nFive years later and following the commercial failure of Jersey Girl, Smith reconsidered and decided to continue the series with Clerks II, resurrecting Jay and Silent Bob in supporting roles. Smith announced in February 2017 that he was writing a sequel called Jay and Silent Bob Reboot and hoped to start filming in summer 2017.	https://en.wikipedia.org/wiki/Jay_and_Silent_Bob_Strike_Back	20.01	jay_and_silent_bob_strike_back	\N	Jay and Silent Bob Strike Back is a 2001 American comedy film written and directed by Kevin Smith.	Pop culture knowledge	APPROVED	t	f	1	1	0	0	0	0	1	1	t	UNCLASSIFIED//FOR OFFICIAL USE ONLY	f	9	329	\N	330	328	318	5	\N	327	f	0	None	0
88	Komodo Dragon	2017-11-09 10:31:49.316377-05	2017-11-09 10:32:04.144126-05	The Komodo dragon (Varanus komodoensis), also known as the Komodo monitor, is a large species of lizard found in the Indonesian islands of Komodo, Rinca, Flores, Gili Motang, and Padar. A member of the monitor lizard family Varanidae, it is the largest living species of lizard, growing to a maximum length of 3 metres (10 ft) in rare cases and weighing up to approximately 70 kilograms (150 lb).\nTheir unusually large size has been attributed to island gigantism, since no other carnivorous animals fill the niche on the islands where they live. However, recent research suggests the large size of Komodo dragons may be better understood as representative of a relict population of very large varanid lizards that once lived across Indonesia and Australia, most of which, along with other megafauna, died out after the Pleistocene. Fossils very similar to V. komodoensis have been found in Australia dating to greater than 3.8 million years ago, and its body size remained stable on Flores, one of the handful of Indonesian islands where it is currently found, over the last 900,000 years, "a time marked by major faunal turnovers, extinction of the island's megafauna, and the arrival of early hominids by 880 ka [kiloannums]."\nAs a result of their size, these lizards dominate the ecosystems in which they live. Komodo dragons hunt and ambush prey including invertebrates, birds, and mammals. It has been claimed that they have a venomous bite; there are two glands in the lower jaw which secrete several toxic proteins. The biological significance of these proteins is disputed, but the glands have been shown to secrete an anticoagulant. Komodo dragon group behaviour in hunting is exceptional in the reptile world. The diet of big Komodo dragons mainly consists of deer, though they also eat considerable amounts of carrion. Komodo dragons also occasionally attack humans.\nMating begins between May and August, and the eggs are laid in September. About 20 eggs are deposited in abandoned megapode nests or in a self-dug nesting hole. The eggs are incubated for seven to eight months, hatching in April, when insects are most plentiful. Young Komodo dragons are vulnerable and therefore dwell in trees, safe from predators and cannibalistic adults. They take 8 to 9 years to mature, and are estimated to live up to 30 years.\nKomodo dragons were first recorded by Western scientists in 1910. Their large size and fearsome reputation make them popular zoo exhibits. In the wild, their range has contracted due to human activities, and they are listed as vulnerable by the IUCN. They are protected under Indonesian law, and a national park, Komodo National Park, was founded to aid protection efforts.	https://en.wikipedia.org/wiki/Komodo_dragon	1	komodo_dragon	\N	A huge lizard!	None	APPROVED	t	f	1	1	0	0	0	0	1	1	t	UNCLASSIFIED	f	1	361	\N	362	360	350	2	\N	359	f	0	None	0
81	Jean Grey	2017-11-09 10:31:48.704915-05	2017-11-09 10:32:03.960827-05	Jean Grey-Summers (born Jean Elaine Grey) is a fictional superhero appearing in American comic books published by Marvel Comics. The character has been known under the aliases Marvel Girl, Phoenix, and Dark Phoenix. Created by writer Stan Lee and artist Jack Kirby, the character first appeared in The X-Men #1 (September 1963).\nJean Grey is a member of a subspecies of humans known as mutants, who are born with superhuman abilities. She was born with telepathic and telekinetic powers. Her powers first manifested when she saw her childhood friend being hit by a car. She is a caring, nurturing figure, but she also has to deal with being an Omega-level mutant and the physical manifestation of the cosmic Phoenix Force. Jean Grey experienced a transformation into the Phoenix in the X-Men storyline "The Dark Phoenix Saga". She has faced death numerous times in the history of the series. Her first death was under her guise as Marvel Girl, when she died and was "reborn" as Phoenix in "The Dark Phoenix Saga". This transformation led to her second death, which was suicide, though not her last.\nShe is an important figure in the lives of other Marvel Universe characters, mostly the X-Men, including her husband Cyclops, her mentor and father figure Charles Xavier, her unrequited love interest Wolverine, her best friend and sister-like figure Storm, and her genetic children Rachel Summers, X-Man, Cable, and Stryfe.\nThe character was present for much of the X-Men's history, and she was featured in all three X-Men animated series and several video games. She is a playable character in X-Men Legends (2004), X-Men Legends II: Rise of Apocalypse (2005), Marvel Ultimate Alliance 2 (2009), Marvel vs Capcom 3: Fate of Two Worlds (2011), Marvel Heroes (2013), and Lego Marvel Super Heroes (2013), and appeared as a non-playable in the first Marvel: Ultimate Alliance.\nFamke Janssen portrayed the character in five installments of the X-Men films. Sophie Turner portrays a younger version in the 2016 film X-Men: Apocalypse.\nIn 2006, IGN rated Jean Grey 6th on their list of top 25 X-Men from the past forty years, and in 2011, IGN ranked her 13th in the "Top 100 Comic Book Heroes". Her Dark Phoenix persona was ranked 9th in IGN's "Top 100 Comic Book Villains of All Time" list, the highest rank for a female character.	https://en.wikipedia.org/wiki/Jean_Grey	1	jean_grey	\N	Dies a lot	None	APPROVED	t	f	4.29999999999999982	3	2	0	1	0	0	3	t	UNCLASSIFIED	f	2	333	\N	334	332	322	2	\N	331	f	0	None	0
83	Jupiter	2017-11-09 10:31:48.884505-05	2017-11-09 10:32:04.052881-05	Jupiter is the fifth planet from the Sun and the largest in the Solar System. It is a giant planet with a mass one-thousandth that of the Sun, but two and a half times that of all the other planets in the Solar System combined. Jupiter and Saturn are gas giants; the other two giant planets, Uranus and Neptune are ice giants. Jupiter has been known to astronomers since antiquity. The Romans named it after their god Jupiter. When viewed from Earth, Jupiter can reach an apparent magnitude of −2.94, bright enough for its reflected light to cast shadows, and making it on average the third-brightest object in the night sky after the Moon and Venus.\n\nJupiter is primarily composed of hydrogen with a quarter of its mass being helium, though helium comprises only about a tenth of the number of molecules. It may also have a rocky core of heavier elements, but like the other giant planets, Jupiter lacks a well-defined solid surface. Because of its rapid rotation, the planet's shape is that of an oblate spheroid (it has a slight but noticeable bulge around the equator). The outer atmosphere is visibly segregated into several bands at different latitudes, resulting in turbulence and storms along their interacting boundaries. A prominent result is the Great Red Spot, a giant storm that is known to have existed since at least the 17th century when it was first seen by telescope. Surrounding Jupiter is a faint planetary ring system and a powerful magnetosphere. Jupiter has at least 69 moons, including the four large Galilean moons discovered by Galileo Galilei in 1610. Ganymede, the largest of these, has a diameter greater than that of the planet Mercury.\n\nJupiter has been explored on several occasions by robotic spacecraft, most notably during the early Pioneer and Voyager flyby missions and later by the Galileo orbiter. In late February 2007, Jupiter was visited by the New Horizons probe, which used Jupiter's gravity to increase its speed and bend its trajectory en route to Pluto. The latest probe to visit the planet is Juno, which entered into orbit around Jupiter on July 4, 2016. Future targets for exploration in the Jupiter system include the probable ice-covered liquid ocean of its moon Europa.	https://en.wikipedia.org/wiki/Jupiter	1.0	jupiter	\N	Jupiter is the fifth planet from the Sun and the largest in the Solar System.	Requires the internet.	APPROVED	t	f	4	2	1	0	1	0	0	2	t	UNCLASSIFIED	f	3	341	\N	342	340	330	3	\N	339	f	0	None	0
84	KIAA0319	2017-11-09 10:31:48.922897-05	2017-11-09 10:31:48.922907-05	KIAA0319 is a protein which in humans is encoded by the KIAA0319 gene.\nVariants of the KIAA0319 gene have been associated with developmental dyslexia.\nReading disability, or dyslexia, is a major social, educational, and mental health problem. In spite of average intelligence and adequate educational opportunities, 5 to 10% of school children have substantial reading deficits. Twin and family studies have shown a substantial genetic component to this disorder, with heritable variation estimated at 50 to 70%.\nAn NIDCD-supported investigator recently has identified a mutation in a gene on chromosome 6, called the KIAA0319 gene, that appears to play a key role in Specific Language Impairment.	https://en.wikipedia.org/wiki/KIAA0319	KIAA0319	kiaa0319	\N	KIAA0319 is a protein which in humans is encoded by the KIAA0319 gene	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	345	\N	346	344	334	5	\N	343	f	0	None	0
85	KSnapshot	2017-11-09 10:31:49.024577-05	2017-11-09 10:31:49.024588-05	KSnapshot is a screenshot application for the KDE desktop environment developed by Richard J. Moore, Matthias Ettrich and Aaron J. Seigo. The screenshots taken by KSnapshot are also called snapshots, which explains its name. It is written in Qt and C++. KSnapshot allows users to use hotkeys to take a screenshot.\nIn December 2015, KSnapshot has been replaced by Spectacle.	https://en.wikipedia.org/wiki/KSnapshot	0.8.1	ksnapshot	\N	KSnapshot is a screenshot application	KDE	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	7	349	\N	350	348	338	2	\N	347	f	0	None	0
86	Karta GPS	2017-11-09 10:31:49.130575-05	2017-11-09 10:31:49.130585-05	Karta GPS is a mobile application developed by Karta Software Technologies Lda a daughter company of NDrive for the Android and iOS operating systems. It is distributed for free and pairs open-source map data from OpenStreetMap alongside curated content from Yelp and Foursquare.\nThe application does not require connection to Internet data (e.g. 3G, 4G, WiFi, etc.) and uses a GPS satellite connection to determine its location. Routes are calculated and plotted based on real-time traffic information provided by Inrix.	https://en.wikipedia.org/wiki/Karta_GPS	1.0	karta_gps	\N	Karta GPS is a mobile app developed by Karta Software Technologies Lda a daughter company of NDrive	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	353	\N	354	352	342	1	\N	351	f	0	None	0
87	Killer Whale	2017-11-09 10:31:49.219965-05	2017-11-09 10:32:04.114554-05	The killer whale or orca (Orcinus orca) is a toothed whale belonging to the oceanic dolphin family, of which it is the largest member. Killer whales have a diverse diet, although individual populations often specialize in particular types of prey. Some feed exclusively on fish, while others hunt marine mammals such as seals and dolphins. They have been known to attack baleen whale calves, and even adult whales. Killer whales are apex predators, as there is no animal that preys on them. Killer whales are considered a cosmopolitan species, and can be found in each of the world's oceans in a variety of marine environments, from Arctic and Antarctic regions to tropical seas.\nKiller whales are highly social; some populations are composed of matrilineal family groups (pods) which are the most stable of any animal species. Their sophisticated hunting techniques and vocal behaviours, which are often specific to a particular group and passed across generations, have been described as manifestations of animal culture.Killer whales have a diverse diet, although individual populations often specialize in particular types of prey. Some feed exclusively on fish, while others hunt marine mammals such as seals and dolphins. They have been known to attack baleen whale calves, and even adult whales. Killer whales are apex predators, as there is no animal that preys on them. Killer whales are considered a cosmopolitan species, and can be found in each of the world's oceans in a variety of marine environments, from Arctic and Antarctic regions to tropical seas.\nKiller whales are highly social; some populations are composed of matrilineal family groups (pods) which are the most stable of any animal species. Their sophisticated hunting techniques and vocal behaviours, which are often specific to a particular group and passed across generations, have been described as manifestations of animal culture.	https://en.wikipedia.org/wiki/Killer_whale	1.0.1	killer_whale	Wild killer whales are not considered a threat to humans	orca is a toothed whale belonging to the oceanic dolphin family, of which it is the largest member	Killer whales are found in all oceans and most seas. Due to their enormous range, numbers, and density, distributional estimates are difficult to compare, but they clearly prefer higher latitudes and coastal areas over pelagic environments.	APPROVED	t	f	3.5	2	0	1	1	0	0	2	t	UNCLASSIFIED	f	2	357	\N	358	356	346	3	\N	355	f	0	None	0
95	LocationAnalyzer	2017-11-09 10:31:49.965394-05	2017-11-09 10:31:49.965402-05	Analyze locations	https://localhost:8443/demo_apps/locationAnalyzer/index.html	1.0.0	ozp.test.locationanalyzer	Nothing really new here	Analyze locations	None	APPROVED	t	t	0	0	0	0	0	0	0	0	f	UNCLASSIFIED	f	1	389	\N	390	388	378	3	\N	387	f	0	None	0
89	LIT RANCH	2017-11-09 10:31:49.471064-05	2017-11-09 10:32:04.236491-05	The 60,000 acre Lit Ranch is located on the Canadian River in Oldham, Hartley, Moore and Potter counties and now includes the Lit Farms -- 5000 acres of farmland in Hartley and Moore Counties. The ranch's history is as old as the history of the Texas Panhandle. The ranch began in the 1880s when Major Littlefield discovered the value of the mild climate and protection of the river breaks when trail driving cattle from Abilene to Dodge City. Major Littlefield sold the ranch to the Prairie Land and Cattle Company, a Scottish land company, who developed the ranch into a 240,000 acre ranch stretching from Tascosa to Dumas. Lee Bivins purchased the ranch from Prairie in the early 1900s and it was operated by the Bivins until 1980s when it was purchased by the W. H. O'Brien family of Amarillo, Texas	http://localhost.com	1	lit_ranch	\N	Its in Texas	None	APPROVED	t	f	3.70000000000000018	3	2	0	0	0	1	3	t	UNCLASSIFIED	f	3	365	\N	366	364	354	5	\N	363	f	0	None	0
90	Lager	2017-11-09 10:31:49.578924-05	2017-11-09 10:32:04.29791-05	Lager (German: storeroom or warehouse) (Czech: ležák) is a type of beer originating from the Austrian Empire (now Czech Republic) that is conditioned at low temperatures, normally at the brewery. It may be pale, golden, amber, or dark.\n\nAlthough one of the most defining features of lager is its maturation in cold storage, it is also distinguished by the use of a specific yeast. While it is possible to use lager yeast in a warm fermentation process, such as with American steam beer, the lack of a cold storage maturation phase precludes such beer from being classified as lager. On the other hand, German Altbier and Kölsch, brewed with a top-fermenting yeast at a warm temperature, but with a cold storage finishing stage, are classified as obergäriges Lagerbier (top-fermented lager beer)	https://en.wikipedia.org/wiki/Lager	5.5	lager	\N	Lager is a type of beer.	Tall cold glass	APPROVED	t	f	3.5	2	1	0	0	1	0	2	t	UNCLASSIFIED	f	1	369	\N	370	368	358	5	\N	367	f	0	None	0
91	Lamprey	2017-11-09 10:31:49.633744-05	2017-11-09 10:31:49.633753-05	Lampreys (sometimes also called, inaccurately, lamprey eels) are any jawless fish of the order Petromyzontiformes, placed in the superclass Cyclostomata. The adult lamprey may be characterized by a toothed, funnel-like sucking mouth. The common name "lamprey" is probably derived from Latin lampetra, which may mean "stone licker" (lambere "to lick" + petra "stone"), though the etymology is uncertain.\nCurrently there are about 38 known extant species of lampreys. Parasitic species are the best known, and feed by boring into the flesh of other fish to suck their blood; but only 18 species of lampreys are parasitic. Parasitic lampreys also attach themselves to larger animals to get a free ride. Adults of the non-parasitic species do not feed; they live off reserves acquired as ammocoetes (larvae), which they obtain through filter feeding.\nThe lampreys are a very ancient lineage of vertebrates, though their exact relationship to hagfishes and jawed vertebrates is still a matter of dispute.	https://en.wikipedia.org/wiki/Lamprey	1.0.5	lamprey	Lampreys have long been used as food for humans. They were highly appreciated by ancient Romans	Are any jawless fish of the order Petromyzontiformes	Adult lampreys spawn in rivers and then die. The young larvae, ammocoetes, spend several years in the rivers, where they live burrowed in fine sediment, filter feeding on detritus and microorganisms. Then, ammocoetes undergo a metamorphosis lasting several months	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED//FOR OFFICIAL USE ONLY	f	2	373	\N	374	372	362	3	\N	371	f	0	None	0
92	Learning Curves	2017-11-09 10:31:49.736686-05	2017-11-09 10:31:49.736695-05	A learning curve is a graphical representation of the increase of learning (vertical axis) with experience (horizontal axis).\nA learning curve averaged over many trials is smooth, and can be expressed as a mathematical function\nThe term learning curve is used in two main ways: where the same task is repeated in a series of trials, or where a body of knowledge is learned over time. The first person to describe the learning curve was Hermann Ebbinghaus in 1885, in the field of the psychology of learning, although the name wasn't used until 1909\nThe familiar expression "a steep learning curve" is intended to mean that the activity is difficult to learn, although a learning curve with a steep start actually represents rapid progress	https://en.wikipedia.org/wiki/Learning_curve	1.1	learning_curves	How to help yourself help with your learning curves	This book will teach you how to get others to help you with your learning curves	Must be able to learn	APPROVED	f	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	377	\N	378	376	366	4	\N	375	f	0	None	0
93	Lightning	2017-11-09 10:31:49.806567-05	2017-11-09 10:31:49.806576-05	Lightning is a sudden electrostatic discharge that occurs during a thunderstorm. This discharge occurs between electrically charged regions of a cloud (called intra-cloud lightning or IC), between two clouds (CC lightning), or between a cloud and the ground (CG lightning).	https://en.wikipedia.org/wiki/Lightning	8.0.9	lightning	Lightning creates light in the form of black body radiation from the very hot plasma created by the electron flow	Dudden electrostatic discharge that occurs during a thunderstorm	Charged regions in the atmosphere temporarily equalize themselves through this discharge	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	2	381	\N	382	380	370	3	\N	379	f	0	None	0
94	Lion Finder	2017-11-09 10:31:49.888134-05	2017-11-09 10:32:04.329294-05	The lion (Panthera leo) is one of the big cats in the genus Panthera and a member of the family Felidae. The commonly used term African lion collectively denotes the several subspecies in Africa. With some males exceeding 250 kg (550 lb) in weight, it is the second-largest living cat after the tiger, barring hybrids like the liger. Wild lions currently exist in sub-Saharan Africa and in India (where an endangered remnant population resides in and around Gir Forest National Park). In ancient historic times, their range was in most of Africa, including North Africa, and across Eurasia from Greece and southeastern Europe to India. In the late Pleistocene, about 10,000 years ago, the lion was the most widespread large land mammal after humans: Panthera leo spelaea lived in northern and western Europe and Panthera leo atrox lived in the Americas from the Yukon to Peru. The lion is classified as a vulnerable species by the International Union for Conservation of Nature (IUCN), having seen a major population decline in its African range of 30-50% over two decades during the second half of the twentieth century. Lion populations are untenable outside designated reserves and national parks. Although the cause of the decline is not fully understood, habitat loss and conflicts with humans are the greatest causes of concern. Within Africa, the West African lion population is particularly endangered.	https://en.wikipedia.org/wiki/Lion	2.0	lion_finder	\N	The lion is one of the big cats in the genus Panthera and a member of the family Felidae	Lions are muscular, deep-chested felids with short, rounded heads, reduced necks and round ears	APPROVED	t	f	1	1	0	0	0	0	1	1	t	UNCLASSIFIED	f	2	385	\N	386	384	374	3	\N	383	f	0	None	0
98	Luigi	2017-11-09 10:31:50.182473-05	2017-11-09 10:31:50.182482-05	Luigi (Japanese: ルイージ Hepburn: Ruīji, [ɾɯ.iː.dʑi̥]) (English: /luˈiːdʒi/; Italian: [luˈiːdʒi]) is a fictional character featured in video games and related media released by Nintendo. Created by prominent game designer Shigeru Miyamoto, Luigi is portrayed as the slightly younger but taller fraternal twin brother of Nintendo's mascot Mario, and appears in many games throughout the Mario franchise, often as a sidekick to his brother.	https://en.wikipedia.org/wiki/Luigi	1	luigi	\N	Luigi is a fictional character featured in video games and related media released by Nintendo.	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	2	401	\N	402	400	390	1	\N	399	f	0	None	0
99	Magnetic positioning	2017-11-09 10:31:50.226978-05	2017-11-09 10:32:04.41881-05	Magnetic positioning is an IPS (Indoor positioning system) solution based on magnetic sensor data from a smartphone used to wirelessly locate objects or people inside a building.\n\nThere is currently no de facto standard for IPS, however magnetic positioning appears to be the most complete and cost effective[citation needed]. It offers accuracy without any hardware usage_requirements and a relatively low total cost of ownership[citation needed]. According to Opus Research magnetic positioning will emerge as a “foundational” indoor location technology.\n\nMagnetic positioning was invented by Professor Janne Haverinen and Anssi Kemppainen. Noticing that buildings' magnetic distortions were leading machines astray, they eventually turned the problem around and focused attention on the magnetic interferences caused by steel structures. What they found was that the disturbances inside them were consistent, creating a magnetic fingerprint unique to a building.\n\nProfessor Janne Haverinen founded the company IndoorAtlas in 2012 to commercialize the magnetic positioning solution with dual headquarters in Mountain View, CA and Oulu, Finland.	https://en.wikipedia.org/wiki/Magnetic_positioning	1.0	magnetic_positioning	\N	Magnetic positioning is an IPS (Indoor positioning system) solution based on magnetic sensor data	None	APPROVED	t	f	3	2	1	0	0	0	1	2	t	UNCLASSIFIED	f	4	405	\N	406	404	394	4	\N	403	f	0	None	0
101	Mallrats	2017-11-09 10:31:50.358599-05	2017-11-09 10:32:04.508941-05	Mallrats is a 1995 American comedy film written and directed by Kevin Smith. It is the second film in the View Askewniverse after 1994's Clerks.\nAs in the other View Askewniverse films, the characters Jay and Silent Bob feature prominently, and characters and events from other films are discussed. Several cast members, including Jason Lee, Ben Affleck, and Joey Lauren Adams, have gone on to work in several other Smith films. Comic book icon Stan Lee appeared, as did Brian O'Halloran, the star of Smith's breakout feature Clerks.\nPlans for a sequel, MallBrats, were announced in March 2015. In June 2016, Smith announced that the sequel would instead be a 10-episode TV series; in February 2017, Smith announced that he had not been able to sell the TV series to any network, and the sequel was shelved indefinitely.	https://en.wikipedia.org/wiki/Mallrats	1995	mallrats	\N	Mallrats is a 1995 American comedy film written and directed by Kevin Smith.	None	APPROVED	t	f	4	1	0	1	0	0	0	1	t	UNCLASSIFIED	f	2	413	\N	414	412	402	4	\N	411	f	0	None	0
102	Map of the world	2017-11-09 10:31:50.429608-05	2017-11-09 10:32:04.569409-05	A map is a symbolic depiction emphasizing relationships between elements of some space, such as objects, regions, or themes.\nMany maps are static, fixed to paper or some other durable medium, while others are dynamic or interactive. Although most commonly used to depict geography, maps may represent any space, real or imagined, without regard to context or scale, such as in brain mapping, DNA mapping, or computer network topology mapping. The space being mapped may be two dimensional, such as the surface of the earth, three dimensional, such as the interior of the earth, or even more abstract spaces of any dimension, such as arise in modeling phenomena having many independent variables.\nAlthough the earliest maps known are of the heavens, geographic maps of territory have a very long tradition and exist from ancient times. The word "map" comes from the medieval Latin Mappa mundi, wherein mappa meant napkin or cloth and mundi the world. Thus, "map" became the shortened term referring to a two-dimensional representation of the surface of the world.	https://en.wikipedia.org/wiki/Map	1.0	map_of_the_world	\N	A map is a symbolic depiction emphasizing relationships between elements of some space and objects.	None	APPROVED	t	f	5	2	2	0	0	0	0	2	t	UNCLASSIFIED	f	4	417	\N	418	416	406	5	\N	415	f	0	None	0
103	Mario	2017-11-09 10:31:50.496082-05	2017-11-09 10:31:50.496091-05	Mario (Japanese: マリオ Hepburn: Mario, [ma.ɾʲi.o]) (English: /ˈmɑːrioʊ/; Italian: [ˈmaːrjo]) is a fictional character in the Mario video game franchise, owned by Nintendo and created by Japanese video game designer Shigeru Miyamoto. Serving as the company's mascot and the eponymous protagonist of the series, Mario has appeared in over 200 video games since his creation. Depicted as a short, pudgy, Italian plumber who resides in the Mushroom Kingdom, his adventures generally center upon rescuing Princess Peach from the Koopa villain Bowser. His younger brother and sidekick is Luigi.	https://en.wikipedia.org/wiki/Mario	1	mario	\N	Mario is a fictional character in the Mario video game franchise.	Mushrooms	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	421	\N	422	420	410	5	\N	419	f	0	None	0
104	Minesweeper	2017-11-09 10:31:50.54037-05	2017-11-09 10:32:04.630769-05	Minesweeper is a single-player puzzle video game. The objective of the game is to clear a rectangular board containing hidden "mines" or bombs without detonating any of them, with help from clues about the number of neighboring mines in each field. The game originates from the 1960s, and has been written for many computing platforms in use today. It has many variations and offshoots.	https://en.wikipedia.org/wiki/Minesweeper_%28video_game%29	1	minesweeper	\N	Minesweeper is a single-player puzzle video game.	None	APPROVED	t	f	3.5	2	1	0	0	1	0	2	t	UNCLASSIFIED	f	3	425	\N	426	424	414	2	\N	423	f	0	None	0
105	Mini Dachshund	2017-11-09 10:31:50.616712-05	2017-11-09 10:32:04.937062-05	Miniature dachshunds have a typical weight of 8 to 11 pounds in the United States. They also are normally a height of 5 to 7 inches at the withers.	http://localhost.com	1	mini_dachshund	\N	Some of their nicknames include "wiener dogs", "hot  dogs", or "sausage dogs."	None	APPROVED	t	f	1.80000000000000004	10	2	0	0	0	8	10	t	UNCLASSIFIED	f	3	429	\N	430	428	418	2	\N	427	f	0	None	0
106	Mister Mxyzptlk	2017-11-09 10:31:50.666055-05	2017-11-09 10:31:50.666064-05	Mister Mxyzptlk (/mɪksˈjɛzpɪtlɪk/ miks-YEZ-pit-lik, /ˈmɪksɪlplɪk/ or /mɪksˈjɛzpɪtəlɪk/), sometimes called Mxy, is a fictional impish character who appears in DC Comics' Superman comic books, sometimes as a supervillain and other times as an antihero.\n\nMr. Mxyzptlk was created to appear in Superman #30 (Sept. 1944), in the story "The Mysterious Mr. Mxyzptlk", by writer Jerry Siegel and artist Ira Yarborough. But due to publishing lag time, the character saw print first in the Superman daily comic strip by writer Whitney Ellsworth and artist Wayne Boring.	https://en.wikipedia.org/wiki/Mister_Mxyzptlk	1	mister_mxyzptlk	\N	Mister Mxyzptlk (/mɪksˈjɛzpɪtlɪk/ miks-YEZ-pit-lik, /ˈmɪksɪlplɪk/ or /mɪksˈjɛzpɪtəlɪk/)	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	2	433	\N	434	432	422	5	\N	431	f	0	None	0
107	Mixing Console	2017-11-09 10:31:50.737415-05	2017-11-09 10:32:04.968044-05	In audio, a mixing console is an electronic device for combining (also called "mixing"), routing, and changing the volume level, timbre (tone color) and/or dynamics of many different audio signals, such as microphones being used by singers, mics picking up acoustic instruments such as drums or saxophones, signals from electric or electronic instruments such as the electric bass or synthesizer, or recorded music playing on a CD player. In the 2010s, a mixer is able to control analog or digital signals, depending on the type of mixer. The modified signals (voltages or digital samples) are summed to produce the combined output signals, which can then be broadcast, amplified through a sound reinforcement system or recorded (or some combination of these applications).\nMixing consoles are used in many applications, including recording studios, public address systems, sound reinforcement systems, nightclubs, dance clubs, broadcasting, television, and film post-production. A typical, simple application combines signals from two microphones (each used by vocalists singing a duet, perhaps) into an amplifier that drives one set of speakers simultaneously. In live performances, the signal from the mixer usually goes directly to an amplifier which is plugged into speaker cabinets, unless the mixer has a built-in power amplifier or is connected to powered speakers. A DJ mixer may have only two channels, for mixing two record players. A coffeehouse's tiny stage might only have a six channel mixer, enough for two singer-guitarists and a percussionist. A nightclub stage's mixer for rock music shows may have 24 channels for mixing the signals from a rhythm section, lead guitar and several vocalists. A mixing console for a large concert may have 48 channels. A mixing console in a professional recording studio may have as many as 96 channels.	https://en.wikipedia.org/wiki/Mixing_console	1	mixing_console	\N	a mixing console is an electronic device for combining, routing, and changing the volume level	Music	APPROVED	t	f	1	1	0	0	0	0	1	1	t	UNCLASSIFIED	f	3	437	\N	438	436	426	2	\N	435	f	0	None	0
108	Monkey Finder	2017-11-09 10:31:50.812905-05	2017-11-09 10:32:05.02907-05	Monkeys are haplorhine primates, a group generally possessing tails and consisting of about 260 known living species. There are two distinct lineages of monkeys: New World Monkeys and catarrhines. Apes emerged within the catarrhines with the Old World monkeys as a sister group, so cladistically they are monkeys as well. However, traditionally apes are not considered monkeys, rendering this grouping paraphyletic. The equivalent monophyletic clade are the simians. Many monkey species are tree-dwelling (arboreal), although there are species that live primarily on the ground, such as baboons. Most species are also active during the day (diurnal). Monkeys are generally considered to be intelligent, particularly Old World monkeys., a group generally possessing tails and consisting of about 260 known living species. There are two distinct lineages of monkeys: New World Monkeys and catarrhines. Apes emerged within the catarrhines with the Old World monkeys as a sister group, so cladistically they are monkeys as well. However, traditionally apes are not considered monkeys, rendering this grouping paraphyletic. The equivalent monophyletic clade are the simians. Many monkey species are tree-dwelling (arboreal), although there are species that live primarily on the ground, such as baboons. Most species are also active during the day (diurnal). Monkeys are generally considered to be intelligent, particularly Old World monkeys.	https://en.wikipedia.org/wiki/Monkey	5.0.5	monkey_finder	Hanuman, a prominent divine entity in Hinduism, is a human-like monkey god.	Monkeys are haplorhine primates	The many species of monkey have varied relationships with humans	APPROVED	t	f	1	2	0	0	0	0	2	2	t	UNCLASSIFIED//FOR OFFICIAL USE ONLY	f	2	441	\N	442	440	430	3	\N	439	f	0	None	0
109	Moonshine	2017-11-09 10:31:50.862466-05	2017-11-09 10:32:05.091179-05	Moonshine was originally a slang term used to describe high-proof distilled spirits usually produced illicitly, without government authorization. In recent years, however, moonshine has been legalized in various countries and has become a term of art. Legal in the United States since 2010, moonshine is defined as "clear, unaged whiskey".\nIn the United States, moonshine is typically made with corn mash as its main ingredient. Liquor-control laws in the United States that prohibit moonshining, once consisting of a total ban under the 18th Amendment of the Constitution, now focus on evasion of revenue taxation on spiritous or intoxicating liquors. They are enforced by the Bureau of Alcohol, Tobacco, Firearms and Explosives of the US Department of Justice; such enforcers of these laws are known by the often derisive nickname of "revenooers."	https://en.wikipedia.org/wiki/Moonshine	1	moonshine		The distillation was done at night to avoid discovery.	None	APPROVED	t	f	3.5	2	1	0	0	1	0	2	t	UNCLASSIFIED	f	1	445	\N	446	444	434	2	\N	443	f	0	None	0
128	Pluto (Not a planet)	2017-11-09 10:31:52.882478-05	2017-11-09 10:32:05.694315-05	NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET NOT A PLANET	https://notaplanet.com	not.a.planet	pluto_(not_a_planet)	Not a planet again!	NOT A PLANET	Doesn't need anything to be not a planet.	APPROVED	t	f	3	2	1	0	0	0	1	2	t	UNCLASSIFIED	f	3	521	\N	522	520	510	3	\N	519	f	0	None	0
110	Morse Code	2017-11-09 10:31:50.93105-05	2017-11-09 10:31:50.931059-05	Morse code is a method of transmitting text information as a series of on-off tones, lights, or clicks that can be directly understood by a skilled listener or observer without special equipment. It is named for Samuel F. B. Morse, an inventor of the telegraph. The International Morse Code encodes the ISO basic Latin alphabet, some extra Latin letters, the Arabic numerals and a small set of punctuation and procedural signals (prosigns) as standardized sequences of short and long signals called "dots" and "dashes", or "dits" and "dahs", as in amateur radio practice. Because many non-English natural languages use more than the 26 Roman letters, extensions to the Morse alphabet exist for those languages.	https://en.wikipedia.org/wiki/Morse_code	1	morse_code	\N	It is named for Samuel F. B. Morse, an inventor of the telegraph.	-. --- -. .	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	449	\N	450	448	438	1	\N	447	f	0	None	0
111	Motorcycle Helmet	2017-11-09 10:31:51.014391-05	2017-11-09 10:32:05.123336-05	A motorcycle helmet is a type of helmet used by motorcycle riders. The primary goal of a motorcycle helmet is motorcycle safety - to protect the rider's head during impact, thus preventing or reducing head injury and saving the rider's life. Some helmets provide additional conveniences, such as ventilation, face shields, ear protection, intercom etc.\nMotorcyclists are at high risk in traffic crashes. A 2008 systematic review examined studies on motorcycle riders who had crashed and looked at helmet use as an intervention. The review concluded that helmets reduce the risk of head injury by around 69% and death by around 42%. Although it was once speculated that wearing a motorcycle helmet increased neck and spinal injuries in a crash, recent evidence has shown the opposite to be the case, that helmets protect against cervical spine injury, and that an often-cited small study dating to the mid-1980s, "used flawed statistical reasoning".	https://en.wikipedia.org/wiki/Motorcycle_helmet	1	motorcycle_helmet	\N	A motorcycle helmet is a type of helmet used by motorcycle riders.	A motorcycle A head	APPROVED	t	f	5	1	1	0	0	0	0	1	t	UNCLASSIFIED	f	3	453	\N	454	452	442	2	\N	451	f	0	None	0
112	Motorsport	2017-11-09 10:31:51.082935-05	2017-11-09 10:32:05.184514-05	Motorsport or motorsports is a global term used to encompass the group of competitive sporting events which primarily involve the use of motorised vehicles, whether for racing or non-racing competition. The terminology can also be used to describe forms of competition of two-wheeled motorised vehicles under the banner of motorcycle racing, and includes off-road racing such as motocross.\n\nFour- (or more) wheeled motorsport competition is globally governed by the Federation Internationale de l'Automobile (FIA); and the Federation Internationale de Motocyclisme (FIM) governs two-wheeled competition.	https://en.wikipedia.org/wiki/Motorsport	1.0	motorsport	\N	Motorsport is a global term used to encompass the group of competitive sporting events.	None	APPROVED	t	f	3.5	2	0	1	1	0	0	2	t	UNCLASSIFIED	f	4	457	\N	458	456	446	2	\N	455	f	0	None	0
113	Movie Projector	2017-11-09 10:31:51.165376-05	2017-11-09 10:31:51.165392-05	A movie projector is an opto-mechanical device for displaying motion picture film by projecting it onto a screen. Most of the optical and mechanical elements, except for the illumination and sound devices, are present in movie cameras.	https://en.wikipedia.org/wiki/Movie_projector	1	movie_projector	\N	A movie projector is an opto-mechanical device for displaying motion pictures.	A Wall	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	461	\N	462	460	450	2	\N	459	f	0	None	0
117	Navigation using Maps	2017-11-09 10:31:51.833906-05	2017-11-09 10:32:05.437314-05	From Wikipedia:\nGoogle Maps is a web mapping service developed by Google. It offers satellite imagery, street maps, 360° panoramic views of streets (Street View), real-time traffic conditions (Google Traffic), and route planning for traveling by foot, car, bicycle (in beta), or public transportation.\n\nGoogle Maps began as a C++ desktop program designed by Lars and Jens Eilstrup Rasmussen at Where 2 Technologies. In October 2004, the company was acquired by Google, which converted it into a web application. After additional acquisitions of a geospatial data visualization company and a realtime traffic analyzer, Google Maps was launched in February 2005. The service's front end utilizes JavaScript, XML, and Ajax. Google Maps offers an API that allows maps to be embedded on third-party websites, and offers a locator for urban businesses and other organizations in numerous countries around the world. Google Map Maker allowed users to collaboratively expand and update the service's mapping worldwide but was discontinued from March, 2017. However crowdsourced contributions to Google Maps are not ending as the company announced those features will be transferred to Google's Local Guides programme.\n\nGoogle Maps' satellite view is a "top-down" or "birds eye" view; most of the high-resolution imagery of cities is aerial photography taken from aircraft flying at 800 to 1,500 feet (240 to 460 m), while most other imagery is from satellites. Much of the available satellite imagery is no more than three years old and is updated on a regular basis. Google Maps uses a close variant of the Mercator projection, and therefore cannot accurately show areas around the poles.\n\nThe current redesigned version of the desktop application was made available in 2013, alongside the "classic" (pre-2013) version. Google Maps for mobile was released in September 2008 and features GPS turn-by-turn navigation. In August 2013, it was determined to be the world's most popular app for smartphones, with over 54% of global smartphone owners using it at least once.\n\nIn 2012, Google reported having over 7,100 employees and contractors directly working in mapping.	https://en.wikipedia.org/wiki/Google_Maps#External_links	1.0	navigation_using_maps	\N	Description of Google Maps is a web mapping service developed by Google	None	APPROVED	t	f	3.5	2	0	1	1	0	0	2	t	UNCLASSIFIED	f	4	477	\N	478	476	466	2	\N	475	f	0	None	0
114	N64	2017-11-09 10:31:51.32638-05	2017-11-09 10:31:51.32639-05	The Nintendo 64 (Japanese: ニンテンドウ64 Hepburn: Nintendō Rokujūyon), stylized as the NINTENDO64 and abbreviated to N64, is Nintendo's third home video game console for the international market. Named for its 64-bit central processing unit, it was released in June 1996 in Japan, September 1996 in North America, March 1997 in Europe and Australia, September 1997 in France and December 1997 in Brazil. It was the last major home console to use the cartridge as its primary storage format until Nintendo's seventh console, the Nintendo Switch, released in 2017. While the Nintendo 64 was succeeded by Nintendo's MiniDVD-based GameCube in September 2001, the consoles remained available until the system was retired in late 2003.	https://en.wikipedia.org/wiki/Nintendo_64	64bit	n64	\N	The Nintendo 64, stylized as the NINTENDO64 and abbreviated to N64.	A TV	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	465	\N	466	464	454	2	\N	463	f	0	None	0
115	NES	2017-11-09 10:31:51.621081-05	2017-11-09 10:31:51.621091-05	The Nintendo Entertainment System (commonly abbreviated as NES) is an 8-bit home video game console that was developed and manufactured by Nintendo. It was initially released in Japan as the Family Computer (Japanese: ファミリーコンピュータ Hepburn: Famirī Konpyūta) (also known by the portmanteau abbreviation Famicom (ファミコン Famikon) and abbreviated as FC) on July 15, 1983, and was later released in North America during 1985, in Europe during 1986, and Australia in 1987. In South Korea, it was known as the Hyundai Comboy (현대 컴보이 Hyeondae Keomboi) and was distributed by SK Hynix which then was known as Hyundai Electronics. The best-selling gaming console of its time,e[›] the NES helped revitalize the US video game industry following the video game crash of 1983. With the NES, Nintendo introduced a now-standard business model of licensing third-party developers, authorizing them to produce and distribute titles for Nintendo's platform. It was succeeded by the Super Nintendo Entertainment System.	https://en.wikipedia.org/wiki/Nintendo_Entertainment_System	8bit	nes	\N	The Nintendo Entertainment System (commonly abbreviated as NES) is an 8-bit home video game console.	A TV	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	469	\N	470	468	458	2	\N	467	f	0	None	0
118	Neptune	2017-11-09 10:31:51.942376-05	2017-11-09 10:32:05.536703-05	Neptune is the eighth and farthest known planet from the Sun in the Solar System. In the Solar System, it is the fourth-largest planet by diameter, the third-most-massive planet, and the densest giant planet. Neptune is 17 times the mass of Earth and is slightly more massive than its near-twin Uranus, which is 15 times the mass of Earth and slightly larger than Neptune. Neptune orbits the Sun once every 164.8 years at an average distance of 30.1 astronomical units (4.50×109 km). It is named after the Roman god of the sea and has the astronomical symbol ♆, a stylised version of the god Neptune's trident.\n\nNeptune is not visible to the unaided eye and is the only planet in the Solar System found by mathematical prediction rather than by empirical observation. Unexpected changes in the orbit of Uranus led Alexis Bouvard to deduce that its orbit was subject to gravitational perturbation by an unknown planet. Neptune was subsequently observed with a telescope on 23 September 1846 by Johann Galle within a degree of the position predicted by Urbain Le Verrier. Its largest moon, Triton, was discovered shortly thereafter, though none of the planet's remaining known 14 moons were located telescopically until the 20th century. The planet's distance from Earth gives it a very small apparent size, making it challenging to study with Earth-based telescopes. Neptune was visited by Voyager 2, when it flew by the planet on 25 August 1989. The advent of the Hubble Space Telescope and large ground-based telescopes with adaptive optics has recently allowed for additional detailed observations from afar.\n\nLike Jupiter and Saturn, Neptune's atmosphere is composed primarily of hydrogen and helium, along with traces of hydrocarbons and possibly nitrogen, but it contains a higher proportion of "ices" such as water, ammonia, and methane. However, its interior, like that of Uranus, is primarily composed of ices and rock, which is why Uranus and Neptune are normally considered "ice giants" to emphasise this distinction. Traces of methane in the outermost regions in part account for the planet's blue appearance.\n\nIn contrast to the hazy, relatively featureless atmosphere of Uranus, Neptune's atmosphere has active and visible weather patterns. For example, at the time of the Voyager 2 flyby in 1989, the planet's southern hemisphere had a Great Dark Spot comparable to the Great Red Spot on Jupiter. These weather patterns are driven by the strongest sustained winds of any planet in the Solar System, with recorded wind speeds as high as 2,100 kilometres per hour (580 m/s; 1,300 mph). Because of its great distance from the Sun, Neptune's outer atmosphere is one of the coldest places in the Solar System, with temperatures at its cloud tops approaching 55 K (−218 °C). Temperatures at the planet's centre are approximately 5,400 K (5,100 °C). Neptune has a faint and fragmented ring system (labelled "arcs"), which was discovered in 1982, then later confirmed by Voyager 2.	https://en.wikipedia.org/wiki/Neptune	1.0	neptune	\N	Neptune is the eighth and farthest known planet from the Sun in the Solar System.	Requires the internet.	APPROVED	t	f	3	2	1	0	0	0	1	2	t	UNCLASSIFIED	f	3	481	\N	482	480	470	3	\N	479	f	0	None	0
119	Network Switch	2017-11-09 10:31:52.022368-05	2017-11-09 10:32:05.580847-05	A computer networking device that connects devices together on a computer network by using packet switching to receive, process, and forward data to the destination device.  Multiple data cables are plugged into a switch to enable communication between different networked devices. Switches manage the flow of data across a network by transmitting a received network packet only to the one or more devices for which the packet is intended. Each networked device connected to a switch can be identified by its network address, allowing the switch to regulate the flow of traffic. This maximizes the security and efficiency of the network.	https://en.wikipedia.org/wiki/Network_switch	0.5.8	network_switch	Layer-7 switches may distribute the load based on uniform resource locators (URLs)	A computer networking device that connects devices together on a computer network	Unmanaged switches - these switches have no configuration interface or options. They are plug and play. They are typically the least expensive switches, and therefore often used in a small office/home office environment. Unmanaged switches can be desktop or rack mounted.\nManaged switches - these switches have one or more methods to modify the operation of the switch. Common management methods include: a command-line interface (CLI) accessed via serial console, telnet or Secure Shell, an embedded Simple Network Management Protocol (SNMP) agent allowing management from a remote console or management station, or a web interface for management from a web browser. Examples of configuration changes that one can do from a managed switch include: enabling features such as Spanning Tree Protocol or port mirroring, setting port bandwidth, creating or modifying virtual LANs (VLANs), etc. Two sub-classes of managed switches are marketed today:	APPROVED	t	f	4	1	0	1	0	0	0	1	t	UNCLASSIFIED	f	2	485	\N	486	484	474	3	\N	483	f	0	None	0
120	Newspaper	2017-11-09 10:31:52.112567-05	2017-11-09 10:31:52.112577-05	A serial publication containing news about current events, other informative articles about politics, sports, arts, and so on, and advertising. A newspaper is usually, but not exclusively, printed on relatively inexpensive, low-grade paper such as newsprint. The journalism organizations that publish newspapers are themselves often metonymically called newspapers.	https://en.wikipedia.org/wiki/Newspaper	8.05	newspaper	By the early 19th century, many cities in Europe, as well as North and South America, published newspapers. As of 2017, most newspapers are now published online as well as in print. The online versions are called online newspapers or news websites.	A publication containing news about current events usually on low-grade paper	Wide variety of material is published in newspapers, including opinion columns, weather forecasts, reviews of local services, obituaries, birth notices, crosswords, editorial cartoons, comic strips, and advice columns. Most newspapers are businesses, and they pay their expenses with a mixture of subscription revenue, newsstand sales, and advertising revenue.	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	2	489	\N	490	488	478	4	\N	487	f	0	None	0
121	Parrot	2017-11-09 10:31:52.203952-05	2017-11-09 10:31:52.203978-05	Birds of the roughly 393 species in 92 genera that make up the order Psittaciformes, found in most tropical and subtropical regions.  Characteristic features of parrots include a strong, curved bill, an upright stance, strong legs, and clawed zygodactyl feet	https://en.wikipedia.org/wiki/Parrot	0.4.8	parrot	Psittaciform diversity in South America and Australasia suggests that the order may have evolved in Gondwana	Birds of the roughly 393 species in 92 genera found in most tropical and subtropical regions	Parrots are found on all tropical and subtropical continents and regions including Australia and Oceania, South Asia, Southeast Asia, Central America, South America, and Africa	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	2	493	\N	494	492	482	3	\N	491	f	0	None	0
122	Parrotlet	2017-11-09 10:31:52.265567-05	2017-11-09 10:31:52.265578-05	The blue-winged parrotlet (Forpus xanthopterygius) is a small parrot found in much of South America. The blue-winged parrotlet is mainly found in lowlands, but locally up to 1200m in south-eastern Brazil. It occurs in woodland, scrub, savanna, and pastures. Flocks are usually around 20 birds but can grow to over 50 around fruiting trees or seeding grasses. It is generally common and widespread, though more localized in the Amazon Basin.	https://en.wikipedia.org/wiki/Blue-winged_parrotlet	1	parrotlet	The blue-winged parrotlet is a small parrot found in much of South America.	Parrotlets are a group of the smallest New World parrot species.	none	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	497	\N	498	496	486	3	\N	495	f	0	None	0
125	Phentolamine	2017-11-09 10:31:52.669558-05	2017-11-09 10:32:05.621083-05	Phentolamine (Regitine) is a reversible nonselective α-adrenergic antagonist	https://en.wikipedia.org/wiki/Phentolamine	1	phentolamine	\N	Phentolamine (Regitine) is a reversible nonselective α-adrenergic antagonist	None	APPROVED	t	f	5	1	1	0	0	0	0	1	t	UNCLASSIFIED	f	5	509	\N	510	508	498	1	\N	507	f	0	None	0
123	Pencil	2017-11-09 10:31:52.304497-05	2017-11-09 10:31:52.304508-05	A pencil is a writing implement or art medium constructed of a narrow, solid pigment core inside a protective casing which prevents the core from being broken and/or from leaving marks on the user’s hand during use.\n\nPencils create marks by physical abrasion, leaving behind a trail of solid core material that adheres to a sheet of paper or other surface. They are distinct from pens, which instead disperse a trail of liquid or gel ink that stains the light colour of the paper.	https://en.wikipedia.org/wiki/Pencil	1	pencil	\N	A pencil is a writing implement	Paper	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	501	\N	502	500	490	2	\N	499	f	0	None	0
124	Personal Computer	2017-11-09 10:31:52.591323-05	2017-11-09 10:31:52.591333-05	A personal computer (PC) is a multi-purpose electronic computer whose size, capabilities, and price make it feasible for individual use. PCs are intended to be operated directly by an end user, rather than by a computer expert or technician.\n"Computers were invented to 'compute': to solve complex mathematical problems, but today, due to media dependency and the everyday use of computers, it is seen that 'computing' is the least important thing computers do." The computer time-sharing models that were typically used with larger, more expensive minicomputer and mainframe systems, to enable them be used by many people at the same time, are not used with PCs.\nEarly computer owners in the 1960s, invariably institutional or corporate, had to write their own programs to do any useful work with the machines. In the 2010s, personal computer users have access to a wide range of commercial software, free software ("freeware") and free and open-source software, which are provided in ready-to-run form. Software for personal computers is typically developed and distributed independently from the hardware or OS manufacturers. Many personal computer users no longer need to write their own programs to make any use of a personal computer, although end-user programming is still feasible. This contrasts with systems such as smartphones or tablet computers, where software is often only available through a manufacturer-supported channel, and end-user program development may be discouraged by lack of support by the manufacturer.\nSince the early 1990s, Microsoft operating systems and Intel hardware have dominated much of the personal computer market, first with MS-DOS and then with Windows. Alternatives to Microsoft's Windows operating systems occupy a minority share of the industry. These include Apple's macOS and free open-source Unix-like operating systems such as Linux. Advanced Micro Devices (AMD) provides the main alternative to Intel's processors.	https://en.wikipedia.org/wiki/Personal_computer	1.0	personal_computer	\N	PCs are intended to be operated directly by an end user.	Web Browser	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	2	505	\N	506	504	494	4	\N	503	f	0	None	0
126	Phylo	2017-11-09 10:31:52.76009-05	2017-11-09 10:31:52.760101-05	Phylo is an experimental video game about multiple sequence alignment optimisation. Developed by the McGill Centre for Bioinformatics, it was originally released as a free Flash game in November 2010. Designed as a game with a purpose, players solve pattern-matching puzzles that represent nucleotide sequences of different phylogenetic taxa to optimize alignments over a computer algorithm. By aligning together each nucleotide sequence, represented as differently coloured blocks, players attempt to create the highest point value score for each set of sequences by matching as many colours as possible and minimizing gaps.\nThe nucleotide sequences generated by Phylo are obtained from actual sequence data from the UCSC Genome Browser. High-scoring player alignments are collected as data and sent back to the McGill Centre for Bioinformatics to be further evaluated with a stronger scoring algorithm. Those player alignments that score higher than the current computer-generated score will be re-introduced into the global alignment as an optimization.	https://en.wikipedia.org/wiki/Phylo_%28video_game%29	1	phylo	\N	Phylo is an experimental video game about multiple sequence alignment optimisation	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	513	\N	514	512	502	2	\N	511	f	0	None	0
129	Pokemon Ruby and Sapphire	2017-11-09 10:31:52.978744-05	2017-11-09 10:31:52.978755-05	Pokemon Ruby Version and Sapphire Version (ポケットモンスタールビー・サファイア Poketto Monsutā Rubī & Safaia, "Pocket Monsters: Ruby & Sapphire") are the third installments of the Pokemon series of role-playing video games, developed by Game Freak and published by Nintendo for the Game Boy Advance. The games were first released in Japan in late 2002 and internationally in 2003. Pokemon Emerald, a special edition version, was released two years later in each region. These three games (Pokemon Ruby, Sapphire, and Emerald) are part of the third generation of the Pokemon video game series, also known as the "advanced generation". Remakes of the two games, titled Omega Ruby and Alpha Sapphire, were released for the Nintendo 3DS worldwide on November 21, 2014, exactly twelve years to the date of the original Ruby and Sapphire release date, with the exception of Europe, where it was released on November 28, 2014.\n\nThe gameplay is mostly unchanged from the previous games; the player controls the main character from an overhead perspective, and the controls are largely the same as those of previous games. As with previous games, the main objectives are to catch all of the Pokemon in the games and defeat the Elite Four (a group of Pokemon trainers); also like their predecessors, the games' main subplot involves the main character defeating a criminal organization that attempts to take over the region. New features, such as double battles and Pokemon abilities along with 135 new Pokemon, have been added. As the Game Boy Advance is more powerful than its predecessors, four players may be connected at a time instead of the previous limit of two. Additionally, the games can be connected to an e-Reader or other advanced generation Pokemon games.	https://en.wikipedia.org/wiki/Pok%C3%A9mon_Ruby_and_Sapphire	3	pokemon_ruby_and_sapphire	Now has versions for the Nintendo 3DS!	Third installments of the Pokemon series of video games	Must have the nintendo gaming system for the version of the game	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	525	\N	526	524	514	2	\N	523	f	0	None	0
130	Polynesian navigation	\N	2017-11-09 10:31:53.084242-05	From Wikipedia, the free encyclopedia\nTraditional Polynesian navigation was used for thousands of years to make long voyages across thousands of miles of the open Pacific Ocean. Navigators travelled to small inhabited islands using wayfinding techniques and knowledge passed by oral tradition from master to apprentice, often in the form of song. Generally each island maintained a guild of navigators who had very high status; in times of famine or difficulty they could trade for aid or evacuate people to neighboring islands. As of 2014, these traditional navigation methods are still taught in the Polynesian outlier of Taumako Island in the Solomons.\nPolynesian navigation used some navigational instruments, which predate and are distinct from the machined metal tools used by European navigators (such as the sextant, first produced 1730, sea astrolabe, ~late 15th century, and marine chronometer, invented 1761). However, they also relied heavily on close observation of sea sign and a large body of knowledge from oral tradition.\nBoth wayfinding techniques and outrigger canoe construction methods have been kept as guild secrets, but in the modern revival of these skills, they are being recorded and published.	https://en.wikipedia.org/wiki/Polynesian_navigation	1.0	polynesian_navigation	\N	used for thousands of years to make long voyages	None	PENDING	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	529	\N	530	528	518	2	\N	527	f	0	None	0
131	Postage Stamp	2017-11-09 10:31:53.142922-05	2017-11-09 10:31:53.142932-05	A postage stamp is a small piece of paper that is purchased and displayed on an item of mail as evidence of payment of postage. Typically, stamps are printed on special custom-made paper, show a national designation and a denomination (value) on the front, and have an adhesive gum on the back or are self-adhesive. Postage stamps are purchased from a postal administration (post office) or other authorized vendor, and are used to pay for the costs involved in moving mail, as well as other business necessities such as insurance and registration. They are sometimes a source of net profit to the issuing agency, especially when sold to collectors who will not actually use them for postage.	https://en.wikipedia.org/wiki/Postage_stamp	1c	postage_stamp	\N	A postage stamp is a small piece of paper that is displayed on an item of mail as payment of postage	Saliva	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	6	533	\N	534	532	522	1	\N	531	f	0	None	0
137	Ruby Miner	2017-11-09 10:31:54.090492-05	2017-11-09 10:31:54.0905-05	A discovery app for Ruby on Rails gems.	http://guides.rubyonrails.org/active_record_migrations.html	1	ruby_miner	New gems!	A discovery app for Ruby on Rails gems	Linux, windows or mac compatible.	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	557	\N	558	556	546	2	\N	555	f	0	None	0
132	Princess Peach	2017-11-09 10:31:53.290029-05	2017-11-09 10:32:05.729673-05	Princess Peach (Japanese: ピーチ姫 Hepburn: Pīchi-hime, [piː.tɕi̥ çi̥.me]) is a character in Nintendo's Mario franchise. Originally created by Shigeru Miyamoto, Peach is the princess of the fictional Mushroom Kingdom, which is constantly under attack by Bowser. She often plays the damsel in distress role within the series and is the lead female. She is often portrayed as Mario's love interest and has appeared in Super Princess Peach, where she is the main playable character.	https://en.wikipedia.org/wiki/Princess_Peach	1	princess_peach	\N	Princess Peach is a character in Nintendo's Mario franchise.	None	APPROVED	t	f	3	1	0	0	1	0	0	1	t	UNCLASSIFIED	f	4	537	\N	538	536	526	4	\N	535	f	0	None	0
133	Project Management	2017-11-09 10:31:53.623628-05	2017-11-09 10:32:05.800267-05	Project management is the discipline of initiating, planning, executing, controlling, and closing the work of a team to achieve specific goals and meet specific success criteria. A project is a temporary endeavor designed to produce a unique product, service or result with a defined beginning and end (usually time-constrained, and often constrained by funding or deliverable) undertaken to meet unique goals and objectives, typically to bring about beneficial change or added value. The temporary nature of projects stands in contrast with business as usual (or operations), which are repetitive, permanent, or semi-permanent functional activities to produce products or services. In practice, the management of such distinct production approaches requires the development of distinct technical skills and management strategies.\n\nThe primary challenge of project management is to achieve all of the project goals within the given constraints. This information is usually described in project documentation, created at the beginning of the development process. The primary constraints are scope, time, quality and budget. The secondary — and more ambitious — challenge is to optimize the allocation of necessary inputs and apply them to meet pre-defined objectives.	https://localhost:8443/default/index.html	1.0	project_management	\N	Project management is the discipline of initiating, planning, executing, controlling, and closing.	None	APPROVED	t	f	1.5	2	0	0	0	1	1	2	t	UNCLASSIFIED	f	1	541	\N	542	540	530	2	\N	539	f	0	None	0
134	Railroad	2017-11-09 10:31:53.834788-05	2017-11-09 10:32:05.899108-05	Rail transport is a means of transferring of passengers and goods on wheeled vehicles running on rails, also known as tracks. It is also commonly referred to as train transport. In contrast to road transport, where vehicles run on a prepared flat surface, rail vehicles (rolling stock) are directionally guided by the tracks on which they run. Tracks usually consist of steel rails, installed on ties (sleepers) and ballast, on which the rolling stock, usually fitted with metal wheels, moves. Other variations are also possible, such as slab track, where the rails are fastened to a concrete foundation resting on a prepared subsurface.\nRolling stock in a rail transport system generally encounters lower frictional resistance than road vehicles, so passenger and freight cars (carriages and wagons) can be coupled into longer trains. The operation is carried out by a railway company, providing transport between train stations or freight customer facilities. Power is provided by locomotives which either draw electric power from a railway electrification system or produce their own power, usually by diesel engines. Most tracks are accompanied by a signalling system. Railways are a safe land transport system when compared to other forms of transport.[Nb 1] Railway transport is capable of high levels of passenger and cargo utilization and energy efficiency, but is often less flexible and more capital-intensive than road transport, when lower traffic levels are considered.\nThe oldest, man-hauled railways date back to the 6th century BC, with Periander, one of the Seven Sages of Greece, credited with its invention. Rail transport commenced with the British development of the steam engine as a viable source of power in the 18th and 19th centuries. Steam locomotives were first developed in the United Kingdom in the early 19th century. Built by George Stephenson and his son Robert's company Robert Stephenson and Company, the Locomotion No. 1 is the first steam locomotive to carry passengers on a public rail line, the Stockton and Darlington Railway in 1825. George also built the first public inter-city railway line in the world to use steam locomotives, the Liverpool and Manchester Railway which opened in 1830. With steam engines, one could construct mainline railways, which were a key component of the Industrial Revolution. Also, railways reduced the costs of shipping, and allowed for fewer lost goods, compared with water transport, which faced occasional sinking of ships. The change from canals to railways allowed for "national markets" in which prices varied very little from city to city. The invention and development of the railway in the United Kingdom was one of the most important technological inventions of the 19th century.\nIn the 1880s, electrified trains were introduced, and also the first tramways and rapid transit systems came into being. Starting during the 1940s, the non-electrified railways in most countries had their steam locomotives replaced by diesel-electric locomotives, with the process being almost complete by 2000. During the 1960s, electrified high-speed railway systems were introduced in Japan and later in some other countries. Other forms of guided ground transport outside the traditional railway definitions, such as monorail or maglev, have been tried but have seen limited use. Following decline after World War II due to competition from cars, rail transport has had a revival in recent decades due to road congestion and rising fuel prices, as well as governments investing in rail as a means of reducing CO2 emissions in the context of concerns about global warming.	https://en.wikipedia.org/wiki/Rail_transport	1.0	railroad	\N	Rail transport is a means of transferring of passengers & goods on vehicles running on rails.	None	APPROVED	t	f	4	3	1	1	1	0	0	3	t	UNCLASSIFIED	f	4	545	\N	546	544	534	3	\N	543	f	0	None	0
142	Sailboat Racing	2017-11-09 10:31:54.897778-05	2017-11-09 10:32:05.993877-05	A form of sport involving yachts and larger sailboats, as distinguished from dinghy racing. It is composed of multiple yachts, in direct competition, racing around a course marked by buoys or other fixed navigational devices or racing longer distances across open water from point-to-point. It can involve a series of races when buoy racing or multiple legs when point-to-point racing.	https://en.wikipedia.org/wiki/Yacht_racing	5.0	sailboat_racing	America's Cup established in 1851	A form of sport involving yachts and larger sailboats	competition between countries who are allowed to send one team and three boats of a chosen one design class	APPROVED	t	f	3	1	0	0	1	0	0	1	t	UNCLASSIFIED	f	2	577	\N	578	576	566	3	\N	575	f	0	None	0
135	Rogue	2017-11-09 10:31:53.877528-05	2017-11-09 10:32:05.930917-05	Rogue is a fictional superhero appearing in American comic books published by Marvel Comics, commonly in association with the X-Men. The character debuted in Avengers Annual #10 (November 1981) as a villain, but then soon after she joined the X-Men.\nRogue is part of a subspecies of humans called mutants, who are born with superhuman abilities. Rogue has the involuntary ability to absorb and sometimes also remove the memories, physical strength, and superpowers of anyone she touches. Therefore, Rogue considers her powers to be a curse. For most of her life, she limited her physical contact with others, including her on-off love interest, Gambit. However, after many years, Rogue finally gained full control over her mutant ability.\nHailing from the fictional Caldecott County, Mississippi, Rogue is the X-Men's self-described southern belle. A runaway, she was adopted by Mystique of the Brotherhood of Evil Mutants and grew up as a villain. After Rogue permanently absorbs Ms. Marvel's psyche and Kree powers, she reforms and turns to the X-Men, fearing for her sanity. Rogue's real name and early history were not revealed until nearly 20 years after her introduction. Until the back story provided by Robert Rodi in the ongoing Rogue series, which began in September 2004, Rogue's background was only hinted at. Her name was revealed as Anna Marie, although her surname is still unknown. She has sometimes adopted the name Raven, which is the first name of her foster mother Mystique.\nRogue has been one of the most prominent members of the X-Men since the 1980s. She was #5 on IGN's Top 25 X-Men list for 2006, #4 on their Top Ten X-Babes list for 2006, #3 on Marvel's list of Top 10 Toughest Females for 2009 and was given title of #1 X-Man on CBR's Top 50 X-Men of All Time for 2008. She was ranked tenth in Comics Buyer's Guide's "100 Sexiest Women in Comics" list. Rogue has been featured in most of the X-Men animated series, and various video games. In the X-Men film series, she is portrayed by Anna Paquin. Her visual cue is often the white streak that runs through her hair.	https://en.wikipedia.org/wiki/Rogue_(comics)	1	rogue	\N	No touching	None	APPROVED	t	f	2	1	0	0	0	1	0	1	t	UNCLASSIFIED	f	2	549	\N	550	548	538	5	\N	547	f	0	None	0
136	Ruby	2017-11-09 10:31:53.955767-05	2017-11-09 10:32:05.961942-05	A ruby is a pink to blood-red colored gemstone, a variety of the mineral corundum (aluminium oxide). Other varieties of gem-quality corundum are called sapphires. Ruby is one of the traditional cardinal gems, together with amethyst, sapphire, emerald, and diamond. The word ruby comes from ruber, Latin for red. The color of a ruby is due to the element chromium.\nThe quality of a ruby is determined by its color, cut, and clarity, which, along with carat weight, affect its value. The brightest and most valuable shade of red called blood-red or pigeon blood, commands a large premium over other rubies of similar quality. After color follows clarity: similar to diamonds, a clear stone will command a premium, but a ruby without any needle-like rutile inclusions may indicate that the stone has been treated. Ruby is the traditional birthstone for July and is usually more pink than garnet, although some rhodolite garnets have a similar pinkish hue to most rubies. The world's most expensive ruby is the Sunrise Ruby.	https://en.wikipedia.org/wiki/Ruby	1	ruby	\N	A red-colored gem stone	Must be wealthy	APPROVED	t	f	5	1	1	0	0	0	0	1	t	UNCLASSIFIED	f	1	553	\N	554	552	542	5	\N	551	f	0	None	0
138	Ruby on Rails	2017-11-09 10:31:54.368222-05	2017-11-09 10:31:54.368231-05	Ruby on Rails, or simply Rails, is a server-side web application framework written in Ruby under the MIT License. Rails is a model-view-controller (MVC) framework, providing default structures for a database, a web service, and web pages. It encourages and facilitates the use of web standards such as JSON or XML for data transfer, and HTML, CSS and JavaScript for display and user interfacing. In addition to MVC, Rails emphasizes the use of other well-known software engineering patterns and paradigms, including convention over configuration (CoC), don't repeat yourself (DRY), and the active record pattern.	https://en.wikipedia.org/wiki/Ruby_on_Rails	5	ruby_on_rails	\N	Ruby on Rails, or simply Rails, is a server-side web application framework written in Ruby	Installers are available for all modern operating system	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	561	\N	562	560	550	1	\N	559	f	0	None	0
139	Rutebok for Norge	2017-11-09 10:31:54.455493-05	2017-11-09 10:31:54.455502-05	From Wikipedia, the free encyclopedia\nRutebok for Norge is an overview of the entire Norwegian public transport network containing timetables, prices, maps and other essential information. It also contains a list of Norwegian accommodation.\n\nRutebok for Norge was first published in 1869 under the name "Norges Kommunikasjoner" or "Reiseblad". It got its current name in 1918 when it was merged with the state railways equivalent. The Rutebok was issued weekly 1880-1932, later every 14 days. It has been published since 1991 by Norsk Reiseinformasjon AS with 4 issues per year. Since 1994 an electronic version is also published, in the form of a CD-ROM containing the same information as the paper version; since 2003 it has also been available online at http://www.rutebok.no.	https://en.wikipedia.org/wiki/Rutebok_for_Norge	1.0	rutebok_for_norge	\N	Rutebok for Norge is an overview of the entire Norwegian public transport network	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	565	\N	566	564	554	3	\N	563	f	0	None	0
140	SImple Text	2017-11-09 10:31:54.490883-05	2017-11-09 10:31:54.490892-05	SimpleText is the native text editor for the Apple classic Mac OS. SimpleText allows editing including text formatting (underline, italic, bold, etc.), fonts, and sizes. It was developed to integrate the features included in the different versions of TeachText that were created by various software development groups within Apple.\nIt can be considered similar to Windows' WordPad application. In later versions it also gained additional read only display capabilities for PICT files, as well as other Mac OS built-in formats like Quickdraw GX and QTIF, 3DMF and even QuickTime movies. SimpleText can even record short sound samples and, using Apple's PlainTalk speech system, read out text in English. Users who wanted to add sounds longer than 24 seconds, however, needed to use a separate program to create the sound and then paste the desired sound into the document using ResEdit.	https://en.wikipedia.org/wiki/SimpleText	1.4	simple_text	\N	SimpleText is the native text editor for the Apple classic Mac OS.	Mac OS	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	569	\N	570	568	558	2	\N	567	f	0	None	0
141	SNES	2017-11-09 10:31:54.732552-05	2017-11-09 10:31:54.732561-05	The Super Nintendo Entertainment System (officially abbreviated the Super NES or SNES, and commonly shortened to Super Nintendo) is a 16-bit home video game console developed by Nintendo that was released in 1990 in Japan and South Korea, 1991 in North America, 1992 in Europe and Australasia (Oceania), and 1993 in South America. In Japan, the system is called the Super Famicom (Japanese: スーパーファミコン Hepburn: Sūpā Famikon, officially adopting the abbreviated name of its predecessor, the Famicom), or SFC for short. In South Korea, it is known as the Super Comboy (슈퍼 컴보이 Syupeo Keomboi) and was distributed by Hyundai Electronics. Although each version is essentially the same, several forms of regional lockout prevent the different versions from being compatible with one another. It was released in Brazil on September 2, 1992, by Playtronic.	https://en.wikipedia.org/wiki/Super_Nintendo_Entertainment_System	16bit	snes	\N	The Super Nintendo Entertainment System (officially abbreviated the Super NES or SNES.	A TV	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	573	\N	574	572	562	2	\N	571	f	0	None	0
143	Salmon	2017-11-09 10:31:54.992047-05	2017-11-09 10:31:54.992061-05	Salmon /ˈsæmən/ is the common name for several species of ray-finned fish in the family Salmonidae. Other fish in the same family include trout, char, grayling and whitefish. Salmon are native to tributaries of the North Atlantic (genus Salmo) and Pacific Ocean (genus Oncorhynchus). Many species of salmon have been introduced into non-native environments such as the Great Lakes of North America and Patagonia in South America. Salmon are intensively farmed in many parts of the world.\n\nTypically, salmon are anadromous: they are born in fresh water, migrate to the ocean, then return to fresh water to reproduce. However, populations of several species are restricted to fresh water through their lives. Various species of salmon display anadromous life strategies while others display freshwater resident life strategies. Folklore has it that the fish return to the exact spot where they were born to spawn; tracking studies have shown this to be mostly true. A portion of a returning salmon run may stray and spawn in different freshwater systems. The percent of straying depends on the species of salmon. Homing behavior has been shown to depend on olfactory memory	https://en.wikipedia.org/wiki/Salmon	1	salmon	\N	Atlantic salmon (Salmo salar) reproduce in northern rivers on both coasts of the Atlantic Ocean.	none	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	581	\N	582	580	570	2	\N	579	f	0	None	0
144	San Bernardino Strait	\N	2017-11-09 10:31:56.129543-05	The San Bernardino Strait (Filipino: Kipot ng San Bernardino) is a strait in the Philippines, connecting the Samar Sea with the Philippine Sea. It separates the Bicol Peninsula of Luzon island from the island of Samar in the south.	https://en.wikipedia.org/wiki/San_Bernardino_Strait	1	san_bernardino_strait	\N	The San Bernardino Strait (Filipino: Kipot ng San Bernardino) is a strait in the Philippines	None	PENDING	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	585	\N	586	584	574	3	\N	583	f	0	None	0
151	Sir Baboon McGood	2017-11-09 10:31:56.749336-05	2017-11-09 10:31:56.749345-05	Sir Baboon McGoon was an American Boeing B-17 Flying Fortress, a Douglas-Long Beach built B-17F-75-DL, ASN 42-3506, last assigned to the 324th Bombardment Squadron, 91st Bomb Group, 8th Air Force, operating out of RAF Bassingbourn (AAF Station 121), Cambridgeshire, England. Its nose art and name were based on the male character Baboon McGoon from Al Capp's comic strip, Li'l Abner.	https://en.wikipedia.org/wiki/Sir_Baboon_McGoon	B-17	sir_baboon_mcgood	\N	Sir Baboon McGoon was an American Boeing B-17 Flying Fortress.	gas	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	5	613	\N	614	612	602	2	\N	611	f	0	None	0
145	Sapphire	2017-11-09 10:31:56.212127-05	2017-11-09 10:31:56.212136-05	Sapphire is a gemstone, a variety of the mineral corundum, an aluminium oxide (α-Al2O3). It is typically blue in color, but natural "fancy" sapphires also occur in yellow, purple, orange, and green colors; "parti sapphires" show two or more colors. The only color which sapphire cannot be is red - as red colored corundum is called ruby, another corundum variety. Pink colored corundum may be either classified as ruby or sapphire depending on locale. This variety in color is due to trace amounts of elements such as iron, titanium, chromium, copper, or magnesium.\n\nCommonly, natural sapphires are cut and polished into gemstones and worn in jewelry. They also may be created synthetically in laboratories for industrial or decorative purposes in large crystal boules. Because of the remarkable hardness of sapphires - 9 on the Mohs scale (the third hardest mineral, after diamond at 10 and moissanite at 9.5) - sapphires are also used in some non-ornamental applications, such as infrared optical components, high-durability windows, wristwatch crystals and movement bearings, and very thin electronic wafers, which are used as the insulating substrates of very special-purpose solid-state electronics (especially integrated circuits and GaN-based LEDs).	https://en.wikipedia.org/wiki/Sapphire	3	sapphire	\N	A blue gem stone	Must be fairly wealthy	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	589	\N	590	588	578	5	\N	587	f	0	None	0
146	Satellite navigation	2017-11-09 10:31:56.32499-05	2017-11-09 10:32:06.056-05	From Wikipedia, the free encyclopedia\nFor satellite navigation in automobile navigation systems, see Automotive navigation system.\nA satellite navigation or satnav system is a system that uses satellites to provide autonomous geo-spatial positioning. It allows small electronic receivers to determine their location (longitude, latitude, and altitude/elevation) to high precision (within a few metres) using time signals transmitted along a line of sight by radio from satellites. The system can be used for providing position, navigation or for tracking the position of something fitted with a receiver (satellite tracking). The signals also allow the electronic receiver to calculate the current local time to high precision, which allows time synchronisation. Satnav systems operate independently of any telephonic or internet reception, though these technologies can enhance the usefulness of the positioning information generated.\n\nA satellite navigation system with global coverage may be termed a global navigation satellite system (GNSS). As of December 2016 only the United States NAVSTAR Global Positioning System (GPS), the Russian GLONASS and the European Union's Galileo are global operational GNSSs. The European Union's Galileo GNSS is scheduled to be fully operational by 2020. China is in the process of expanding its regional BeiDou Navigation Satellite System into the global BeiDou-2 GNSS by 2020. France, India and Japan are in the process of developing regional navigation and augmentation systems as well.\n\nGlobal coverage for each system is generally achieved by a satellite constellation of 18-30 medium Earth orbit (MEO) satellites spread between several orbital planes. The actual systems vary, but use orbital inclinations of >50° and orbital periods of roughly twelve hours (at an altitude of about 20,000 kilometres or 12,000 miles).	https://en.wikipedia.org/wiki/Satellite_navigation	1.0	satellite_navigation	\N	A satellite navigation or satnav system is a system that uses satellites to provide geo positioning	None	APPROVED	t	f	4	2	1	0	1	0	0	2	t	UNCLASSIFIED	f	4	593	\N	594	592	582	4	\N	591	f	0	None	0
147	Saturn	2017-11-09 10:31:56.449962-05	2017-11-09 10:32:06.118335-05	Saturn is the sixth planet from the Sun and the second-largest in the Solar System, after Jupiter. It is a gas giant with an average radius about nine times that of Earth. Although it has only one-eighth the average density of Earth, with its larger volume Saturn is just over 95 times more massive. Saturn is named after the Roman god of agriculture; its astronomical symbol (♄) represents the god's sickle.\n\nSaturn's interior is probably composed of a core of iron-nickel and rock (silicon and oxygen compounds). This core is surrounded by a deep layer of metallic hydrogen, an intermediate layer of liquid hydrogen and liquid helium, and finally outside the Frenkel line a gaseous outer layer. Saturn has a pale yellow hue due to ammonia crystals in its upper atmosphere. Electrical current within the metallic hydrogen layer is thought to give rise to Saturn's planetary magnetic field, which is weaker than Earth's, but has a magnetic moment 580 times that of Earth due to Saturn's larger size. Saturn's magnetic field strength is around one-twentieth of Jupiter's. The outer atmosphere is generally bland and lacking in contrast, although long-lived features can appear. Wind speeds on Saturn can reach 1,800 km/h (500 m/s), higher than on Jupiter, but not as high as those on Neptune.\n\nSaturn has a prominent ring system that consists of nine continuous main rings and three discontinuous arcs and that is composed mostly of ice particles with a smaller amount of rocky debris and dust. 62 moons are known to orbit Saturn, of which fifty-three are officially named. This does not include the hundreds of moonlets comprising the rings. Titan, Saturn's largest moon, and the second-largest in the Solar System, is larger than the planet Mercury, although less massive, and is the only moon in the Solar System to have a substantial atmosphere.	https://en.wikipedia.org/wiki/Saturn	1.0	saturn	\N	Saturn is the sixth planet from the Sun and the second-largest in the Solar System	Requires the internet.	APPROVED	t	f	4	2	1	0	1	0	0	2	t	UNCLASSIFIED	f	3	597	\N	598	596	586	3	\N	595	f	0	None	0
148	Screamin Eagle CVO	2017-11-09 10:31:56.519517-05	2017-11-09 10:31:56.519525-05	Harley-Davidson CVO (for Custom Vehicle Operations) motorcycles are a family of models created by Harley-Davidson for the factory custom market. For every model year since the program's inception in 1999, Harley-Davidson has chosen a small selection of its mass-produced motorcycle models and created limited-edition customizations of those platforms with larger-displacement engines, costlier paint designs, and additional accessories not found on the mainstream models. Special features for the CVO lineup have included performance upgrades from Harley's "Screamin' Eagle" branded parts, hand-painted pinstripes, ostrich leather on seats and trunks, gold leaf incorporated in the paint, and electronic accessories like GPS navigation systems and iPod music players.\nCVO models are produced in Harley-Davidson's York, Pennsylvania plant, where touring and Softail models are also manufactured. In each model year, CVO models feature larger-displacement engines than the mainstream models, and these larger-displacement engines make their way into the normal "big twin" line within a few years when CVO models are again upgraded. Accessories created for these customized units are sometimes offered in the Harley-Davidson accessory catalog for all models in later years, but badging and paint are kept exclusively for CVO model owners, and cannot be replaced without providing proof of ownership to the ordering dealer.	https://en.wikipedia.org/wiki/Harley-Davidson_CVO#Critical_reception	1	screamin_eagle_cvo	none	CVO is the the program targets what Harley-Davidson calls its "Alpha Customer"; ride fast and hard.	none	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	601	\N	602	600	590	3	\N	599	f	0	None	0
149	Sheet music	2017-11-09 10:31:56.583733-05	2017-11-09 10:31:56.583741-05	Sheet music is a handwritten or printed form of music notation that uses modern musical symbols to indicate the pitches (melodies), rhythms and/or chords of a song or instrumental musical piece. Like its analogs - printed books or pamphlets in English, Arabic or other languages - the medium of sheet music typically is paper (or, in earlier centuries, papyrus or parchment), although the access to musical notation since the 1980s has included the presentation of musical notation on computer screens and the development of scorewriter computer programs that can notate a song or piece electronically, and, in some cases, "play back" the notated music using a synthesizer or virtual instruments.	https://en.wikipedia.org/wiki/Sheet_music	1.09	sheet_music	Use of the term "sheet" is intended to differentiate written or printed forms of music from sound recordings	Sheet music is a handwritten or printed form of music notation that uses modern musical symbols	Knowledge to understand notes on music sheet	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	2	605	\N	606	604	594	2	\N	603	f	0	None	0
150	Siemens Mobility	2017-11-09 10:31:56.684179-05	2017-11-09 10:31:56.684188-05	From Wikipedia, the free encyclopedia\nNot to be confused with Siemens Mobile.\nSiemens Mobility is a division of the German conglomerate Siemens. Prior to the corporate restructuring of Siemens AG (effective from 1 January 2008) Siemens Transportation Systems was the operational division most closely related to Siemens Mobility; products produced included automation and power systems, rolling stock for mass-transit, railway signalling and control systems, and railway electrification.\nThe group also incorporates the former railway rolling stock and locomotive division Siemens Schienenfahrzeugtechnik (Siemens Railway Technology).	https://en.wikipedia.org/wiki/Siemens_Mobility	1.9	siemens_mobility	\N	Siemens Mobility is a division of the German conglomerate Siemens	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	609	\N	610	608	598	4	\N	607	f	0	None	0
153	Smart Phone	2017-11-09 10:31:56.947639-05	2017-11-09 10:31:56.947652-05	A mobile personal computer with a mobile operating system with features useful for mobile or handheld use. Smartphones, which are typically pocket-sized (as opposed to tablets, which are much larger than a pocket), have the ability to place and receive voice/video calls and create and receive text messages, have personal digital assistants	https://en.wikipedia.org/wiki/Smartphone	7.0	smart_phone	5G Connection will be faster than 4G	Handheld Wireless Phone used to call people and connect to the internet	Have high-speed mobile broadband 4G LTE, motion sensors, and mobile payment features	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	2	621	\N	622	620	610	3	\N	619	f	0	None	0
154	Snow	2017-11-09 10:31:57.001221-05	2017-11-09 10:32:06.209108-05	Snow refers to forms of ice crystals that precipitate from the atmosphere (usually from clouds) and undergo changes on the Earth's surface.	http://localhost.com	1	snow	\N	Ice crystals precipitating.	None	APPROVED	t	f	2	3	0	0	1	1	1	3	t	UNCLASSIFIED	f	2	625	\N	626	624	614	3	\N	623	f	0	None	0
155	Soterosanthus	2017-11-09 10:31:57.129137-05	2017-11-09 10:31:57.129147-05	Soterosanthus shepheardii is a species of orchid found in Ecuador and Colombia, and the only species of the monotypic genus Soterosanthus. This species segregated from Sievekingia because of its upright inflorescence. Flowers are somewhat similar to Sievekingia as is the plant stature, being on the small side, around 6" tall. Plants are semi-deciduous and warmth tolerant. Grow in small pots of medium grade bark mix under same conditions as for Gongora; shaded light, even moisture, drier in winter. It is a rarely seen relative of Stanhopea.	https://en.wikipedia.org/wiki/Soterosanthus	1	soterosanthus	\N	Soterosanthus shepheardii is a species of orchid	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	6	629	\N	630	628	618	2	\N	627	f	0	None	0
156	Sound Mixer	2017-11-09 10:31:57.214317-05	2017-11-09 10:31:57.214327-05	is an electronic device for combining (also called "mixing"), routing, and changing the volume level, timbre (tone color) and/or dynamics of many different audio signals, such as microphones being used by singers, mics picking up acoustic instruments such as drums or saxophones, signals from electric or electronic instruments such as the electric bass or synthesizer, or recorded music playing on a CD player. In the 2010s, a mixer is able to control analog or digital signals, depending on the type of mixer	https://en.wikipedia.org/wiki/Mixing_console	1.0.15	sound_mixer	Input jacks, Microphone preamplifiers, equalization	Electronic device for combining routing, and changing the volume level, different audio signals	Mixing consoles are used in many applications	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	2	633	\N	634	632	622	3	\N	631	f	0	None	0
157	Steak	\N	2017-11-09 10:31:57.256953-05	A steak (/ˈsteɪk/) is a meat generally sliced across the muscle fibers, potentially including a bone. Exceptions, in which the meat is sliced parallel to the fibers, include the skirt steak that is cut from the plate, the flank steak that is cut from the abdominal muscles, and the Silverfinger steak that is cut from the loin and includes three rib bones. When the word "steak" is used without qualification, it generally refers to a beefsteak. In a larger sense, there are also fish steaks, ground meat steaks, pork steak and many more varieties of steaks.\n\nSteaks are usually grilled, but they can be pan-fried, or broiled. Steak is often grilled in an attempt to replicate the flavor of steak cooked over the glowing coals of an open fire. Steak can also be cooked in sauce, such as in steak and kidney pie, or minced and formed into patties, such as hamburgers.\n\nSteaks are also cut from grazing animals, usually farmed, other than cattle, including bison, camel, goat, horse, kangaroo, sheep, ostrich, pigs, reindeer, turkey, deer and zebu as well as various types of fish, especially salmon and large pelagic fish such as swordfish, shark and marlin. For some meats, such as pork, lamb and mutton, chevon and veal, these cuts are often referred to as chops. Some cured meat, such as gammon, is commonly served as steak.\n\nGrilled Portobello mushroom may be called mushroom steak, and similarly for other vegetarian dishes. Imitation steak is a food product that is formed into a steak shape from various pieces of meat. Grilled fruits, such as watermelon have been used as vegetarian steak alternatives.	https://en.wikipedia.org/wiki/Steak	1	steak	King of meats.	Beef steaks are commonly grilled, broiled or occasionally fried.	none	PENDING	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	637	\N	638	636	624	1	\N	635	f	0	None	0
158	Stop sign	2017-11-09 10:31:57.325486-05	2017-11-09 10:32:06.269416-05	A stop sign is a traffic sign to notify drivers that they must make sure no cars are coming and stop before proceeding.	https://en.wikipedia.org/wiki/Stop_sign	8	stop_sign	\N	A stop sign is a traffic sign to notify drivers that they must stop before proceeding.	Brake Pedal	APPROVED	t	f	5	2	2	0	0	0	0	2	t	UNCLASSIFIED	f	3	641	\N	642	640	628	2	\N	639	f	0	None	0
159	Stout	2017-11-09 10:31:57.388476-05	2017-11-09 10:32:06.299865-05	Stout is a dark beer made using roasted malt or roasted barley, hops, water and yeast. Stouts were traditionally the generic term for the strongest or stoutest porters, typically 7% or 8%, produced by a brewery. There are a number of variations including Baltic porter, milk stout, and imperial stout; the most common variation is dry stout, exemplified by Guinness Draught, the world's best selling stout.[citation needed]\nThe first known use of the word stout for beer was in a document dated 1677 found in the Egerton Manuscript, the sense being that a stout beer was a strong beer not a dark beer. The name porter was first used in 1721 to describe a dark brown beer that had been made with roasted malts. Because of the huge popularity of porters, brewers made them in a variety of strengths. The stronger beers were called "stout porters", so the history and development of stout and porter are intertwined, and the term stout has become firmly associated with dark beer, rather than just strong beer.	https://en.wikipedia.org/wiki/Stout	17.20	stout	\N	Stout is a dark beer made using roasted malt or roasted barley, hops, water and yeast	None	APPROVED	t	f	5	1	1	0	0	0	0	1	t	UNCLASSIFIED	f	4	645	\N	646	644	632	2	\N	643	f	0	None	0
160	Stroke play	2017-11-09 10:31:57.446749-05	2017-11-09 10:32:06.329864-05	Stroke play, also known as medal play, is a scoring system in the sport of golf. It involves counting the total number of strokes taken on each hole during a given round, or series of rounds. The winner is the player who has taken the fewest strokes over the course of the round, or rounds.\nAlthough most professional tournaments are played using the stroke play scoring system, there are, or have been, some notable exceptions, for example the WGC-Accenture Match Play Championship and Volvo World Match Play Championship, which are both played in a match play format, and The International, a former PGA Tour event that used a modified stableford system. Most team events, for example the Ryder Cup, are also contested using the match play format.	https://en.wikipedia.org/wiki/Stroke_play	1	stroke_play	none	Golf scoring.	Most tournaments enforce a cut, which in a typical 72-hole tournament is done after 36 holes. The number of players who "make the cut" depends on the tournament rules - in a typical PGA Tour event the top 70 professionals (plus ties) after 36 holes. Any player who turns in a score higher than the "cut line" will "miss the cut" and take no further part in the tournament.\nCount back:\nOne method commonly used in amateur competitions, especially when a playoff is not practicable, is a scorecard "count back", whereby comparing scores hole by hole starting with 17, then 16 and so on... the first player with a lower score is declared the loser. This ensures that the player who was in the lead before the tie occurred is declared the winner. To put it another way, to win a tournament one must equal and then pass the leader...not merely catch up to him.	APPROVED	t	f	3	1	0	0	1	0	0	1	t	UNCLASSIFIED	f	1	649	\N	650	648	636	4	\N	647	f	0	None	0
161	Sudovian Book	2017-11-09 10:31:57.54318-05	2017-11-09 10:31:57.543202-05	The so-called Sudovian Book[nb 1] (German: Sudauer Büchlein, Lithuanian: Sūduvių knygelė) was an anonymous work about the customs, religion, and daily life of the Old Prussians from Sambia. The manuscript was written in German in the 16th century. The original did not survive and the book is known from later copies, transcriptions and publications. Modern scholars disagree on the origin and value of the book. Despite doubts about its reliability, the book became popular and was frequently quoted in other history books. Much of the Prussian mythology is reconstructed based on this work or its derivatives.	https://en.wikipedia.org/wiki/Sudovian_Book	1545	sudovian_book	\N	The so-called Sudovian Bookwas an anonymous work about the customs of the Old Prussians.	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	653	\N	654	652	640	3	\N	651	f	0	None	0
162	Sun	2017-11-09 10:31:57.631938-05	2017-11-09 10:32:06.39243-05	The Sun is the star at the center of the Solar System. It is a nearly perfect sphere of hot plasma, with internal convective motion that generates a magnetic field via a dynamo process. It is by far the most important source of energy for life on Earth. Its diameter is about 109 times that of Earth, and its mass is about 330,000 times that of Earth, accounting for about 99.86% of the total mass of the Solar System. About three quarters of the Sun's mass consists of hydrogen (~73%); the rest is mostly helium (~25%), with much smaller quantities of heavier elements, including oxygen, carbon, neon, and iron.\nThe Sun is a G-type main-sequence star (G2V) based on its spectral class. As such, it is informally referred to as a yellow dwarf. It formed approximately 4.6 billion years ago from the gravitational collapse of matter within a region of a large molecular cloud. Most of this matter gathered in the center, whereas the rest flattened into an orbiting disk that became the Solar System. The central mass became so hot and dense that it eventually initiated nuclear fusion in its core. It is thought that almost all stars form by this process.\nThe Sun is roughly middle-aged; it has not changed dramatically for more than four billion years, and will remain fairly stable for more than another five billion years. After hydrogen fusion in its core has diminished to the point at which it is no longer in hydrostatic equilibrium, the core of the Sun will experience a marked increase in density and temperature while its outer layers expand to eventually become a red giant. It is calculated that the Sun will become sufficiently large to engulf the current orbits of Mercury and Venus, and render Earth uninhabitable.\nThe enormous effect of the Sun on Earth has been recognized since prehistoric times, and the Sun has been regarded by some cultures as a deity. The synodic rotation of Earth and its orbit around the Sun are the basis of the solar calendar, which is the predominant calendar in use today.	https://en.wikipedia.org/wiki/Sun	1.0	sun	\N	The Sun is the star at the center of the Solar System.	Requires the internet.	APPROVED	t	f	5	2	2	0	0	0	0	2	t	UNCLASSIFIED	f	3	657	\N	658	656	644	3	\N	655	f	0	None	0
163	Superunknown	2017-11-09 10:31:57.718447-05	2017-11-09 10:32:06.452792-05	Superunknown is the fourth album by American rock band Soundgarden, released on February 18, 1994, through A&M Records. It is the band's second album with bassist Ben Shepherd, and features new producer Michael Beinhorn.	https://en.wikipedia.org/wiki/Superunknown	19.94	superunknown	\N	Superunknown is the fourth album by American rock band Soundgarden	Good speakers	APPROVED	t	f	4	2	1	0	1	0	0	2	t	UNCLASSIFIED//FOR OFFICIAL USE ONLY	f	2	661	\N	662	660	648	1	\N	659	f	0	None	0
164	T-slot nut	2017-11-09 10:31:57.833451-05	2017-11-09 10:31:57.833462-05	A T-slot nut is used with a threaded clamp to position and secure pieces being worked on in a workshop. The T-slot nut slides along a T-slot track, which is set in workbench or table for a router, drill press, or bandsaw. T-slot nuts are also used with extruded aluminum framing, such as 80/20, to build a variety of industrial structures and machines.\n\nA T-slot bolt is generally stronger than a T-slot nut and hex-head cap screw.\n\nA heavy-duty T-slot nut with a M12 bolt is rated to support 10000 N (about 1 imperial ton).\n\nProfile 40×40 (40 mm by 40 mm, with 8 mm grooves) extruded aluminum profile[clarify] and the T-slot nuts to fit into them comprised the first modular system developed for use in mechanical engineering in 1980 by item Industrietechnik. The item aluminum framing system has since been expanded to include a variety of t-slot nuts that have been designed for specific applications.\n\nThe item system is very similar to the "channel-and-groove design" used in some toys.	https://en.wikipedia.org/wiki/T-slot_nut	1	t-slot_nut	\N	A T-slot nut is used with a threaded clamp.	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	665	\N	666	664	652	5	\N	663	f	0	None	0
174	Venus	2017-11-09 10:31:58.788347-05	2017-11-09 10:32:06.820515-05	Venus is the second planet from the Sun, orbiting it every 224.7 Earth days. It has the longest rotation period (243 days) of any planet in the Solar System and rotates in the opposite direction to most other planets. It has no natural satellites. It is named after the Roman goddess of love and beauty. It is the second-brightest natural object in the night sky after the Moon, reaching an apparent magnitude of −4.6 - bright enough to cast shadows at night and, rarely, visible to the naked eye in broad daylight. Orbiting within Earth's orbit, Venus is an inferior planet and never appears to venture far from the Sun; its maximum angular distance from the Sun (elongation) is 47.8°.\n\nVenus is a terrestrial planet and is sometimes called Earth's "sister planet" because of their similar size, mass, proximity to the Sun, and bulk composition. It is radically different from Earth in other respects. It has the densest atmosphere of the four terrestrial planets, consisting of more than 96% carbon dioxide. The atmospheric pressure at the planet's surface is 92 times that of Earth, or roughly the pressure found 900 m (3,000 ft) underwater on Earth. Venus is by far the hottest planet in the Solar System, with a mean surface temperature of 735 K (462 °C; 863 °F), even though Mercury is closer to the Sun. Venus is shrouded by an opaque layer of highly reflective clouds of sulfuric acid, preventing its surface from being seen from space in visible light. It may have had water oceans in the past, but these would have vaporized as the temperature rose due to a runaway greenhouse effect. The water has probably photodissociated, and the free hydrogen has been swept into interplanetary space by the solar wind because of the lack of a planetary magnetic field. Venus's surface is a dry desertscape interspersed with slab-like rocks and is periodically resurfaced by volcanism.\n\nAs one of the brightest objects in the sky, Venus has been a major fixture in human culture for as long as records have existed. It has been made sacred to gods of many cultures, and has been a prime inspiration for writers and poets as the "morning star" and "evening star". Venus was the first planet to have its motions plotted across the sky, as early as the second millennium BC.\n\nAs the closest planet to Earth, Venus has been a prime target for early interplanetary exploration. It was the first planet beyond Earth visited by a spacecraft (Mariner 2 in 1962), and the first to be successfully landed on (by Venera 7 in 1970). Venus's thick clouds render observation of its surface impossible in visible light, and the first detailed maps did not emerge until the arrival of the Magellan orbiter in 1991. Plans have been proposed for rovers or more complex missions, but they are hindered by Venus's hostile surface conditions.	https://en.wikipedia.org/wiki/Venus	1.0	venus	\N	Venus is the second planet from the Sun, orbiting it every 224.7 Earth days.	Requires the internet.	APPROVED	t	f	2.5	2	0	1	0	0	1	2	t	UNCLASSIFIED	f	3	705	\N	706	704	692	3	\N	703	f	0	None	0
165	Taxonomy Classifier	2017-11-09 10:31:57.961612-05	2017-11-09 10:31:57.961629-05	Taxonomy (from Ancient Greek τάξις (taxis), meaning 'arrangement', and -νομία (-nomia), meaning 'method') is the science of defining and naming groups of biological organisms on the basis of shared characteristics. Organisms are grouped together into taxa (singular: taxon) and these groups are given a taxonomic rank; groups of a given rank can be aggregated to form a super group of higher rank, thus creating a taxonomic hierarchy. The Swedish botanist Carl Linnaeus is regarded as the father of taxonomy, as he developed a system known as Linnaean taxonomy for categorization of organisms and binomial nomenclature for naming organisms.	https://en.wikipedia.org/wiki/Taxonomy_(biology)	10.5.1	taxonomy_classifier	Linnaean system has progressed to a system of modern biological classification based on the evolutionary relationships between organisms, both living and extinct.	Science of defining and naming groups of biological organisms on the basis of shared characteristics	Knowledge of Science	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	669	\N	670	668	656	3	\N	667	f	0	None	0
166	Ten	2017-11-09 10:31:58.060064-05	2017-11-09 10:32:06.544726-05	Ten is the debut studio album by American rock band Pearl Jam, released on August 27, 1991 through Epic Records. Following the disbanding of bassist Jeff Ament and guitarist Stone Gossard's previous group Mother Love Bone, the two recruited vocalist Eddie Vedder, guitarist Mike McCready, and drummer Dave Krusen to form Pearl Jam in 1990. Most of the songs began as instrumental jams, to which Vedder added lyrics about topics such as depression, homelessness, and abuse.	https://en.wikipedia.org/wiki/Ten_%28Pearl_Jam_album%29	19.91	ten	\N	Ten is the debut studio album by American rock band Pearl Jam	More Flannel	APPROVED	t	f	4	3	1	1	1	0	0	3	t	UNCLASSIFIED	f	3	673	\N	674	672	660	3	\N	671	f	0	None	0
167	Tennis	2017-11-09 10:31:58.146602-05	2017-11-09 10:31:58.146612-05	Tennis is a racket sport that can be played individually against a single opponent (singles) or between two teams of two players each (doubles). Each player uses a tennis racket that is strung with cord to strike a hollow rubber ball covered with felt over or around a net and into the opponent's court. The object of the game is to play the ball in such a way that the opponent is not able to play a valid return. The player who is unable to return the ball will not gain a point, while the opposite player will.	https://en.wikipedia.org/wiki/Tennis	2-4	tennis	\N	Tennis is a racket sport.	Rackets & Balls	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	677	\N	678	676	664	5	\N	675	f	0	None	0
168	Tiny Music... Songs from the Vatican Gift Shop	2017-11-09 10:31:58.227041-05	2017-11-09 10:32:06.604862-05	Tiny Music... Songs from the Vatican Gift Shop is the third album by American rock band Stone Temple Pilots, released on March 26, 1996, on Atlantic Records. After a brief hiatus in 1995, the band regrouped to record Tiny Music, living and recording the album together in a mansion located in Santa Barbara, California.	https://en.wikipedia.org/wiki/Tiny_Music..._Songs_from_the_Vatican_Gift_Shop	199.6	tiny_music..._songs_from_the_vatican_gift_shop	\N	Tiny Music... Songs from the Vatican Gift Shop is the third album by American rock band STP.	None	APPROVED	t	f	3.5	2	0	1	1	0	0	2	t	UNCLASSIFIED	f	8	681	\N	682	680	668	5	\N	679	f	0	None	0
169	Tornado	2017-11-09 10:31:58.349947-05	2017-11-09 10:32:06.694902-05	Tornado is a rapidly rotating column of air that is in contact with both the surface of the Earth and a cumulonimbus cloud or, in rare cases, the base of a cumulus cloud. They are often referred to as twisters, whirlwinds or cyclones, although the word cyclone is used in meteorology to name a weather system with a low-pressure area in the center around which winds blow counterclockwise in the Northern Hemisphere and clockwise in the Southern	https://en.wikipedia.org/wiki/Tornado	1.85	tornado	Most tornadoes have wind speeds less than 110 miles per hour	Rotating column of air that is in contact with both the surface of the Earth and a cloud	Weather system with a low-pressure area in the center around which winds blow counterclockwise	APPROVED	t	t	1	3	0	0	0	0	3	3	t	UNCLASSIFIED	f	2	685	\N	686	684	672	3	\N	683	f	0	None	0
170	Toyota	2017-11-09 10:31:58.480992-05	2017-11-09 10:31:58.481002-05	Toyota Motor Corporation (Japanese: トヨタ自動車株式会社 Hepburn: Toyota Jidōsha KK, IPA: [toꜜjota], English: /tɔɪˈoʊtə/) is a Japanese multinational automotive manufacturer headquartered in Toyota, Aichi, Japan. In March 2014, Toyota's corporate structure consisted of 338,875 employees worldwide and, as of October 2016, was the ninth-largest company in the world by revenue. As of 2016, Toyota is the world's largest automotive manufacturer. Toyota was the world's first automobile manufacturer to produce more than 10 million vehicles per year which it has done since 2012, when it also reported the production of its 200-millionth vehicle. As of July 2014, Toyota was the largest listed company in Japan by market capitalization (worth more than twice as much as #2-ranked SoftBank) and by revenue.	https://en.wikipedia.org/wiki/Toyota	1	toyota	\N	Toyota Motor Corporation is a Japanese multinational automotive manufacturer.	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	689	\N	690	688	676	4	\N	687	f	0	None	0
171	Transport Direct Portal	2017-11-09 10:31:58.586923-05	2017-11-09 10:31:58.586933-05	From Wikipedia, the free encyclopedia\nThe Transport Direct Portal was a distributed Internet-based multi-modal journey planner providing information for travel in England, Wales and Scotland. It was managed by Transport Direct, a division of the Department for Transport. It was launched in 2004 and was operated by a consortium led by Atos and later enhanced to include a cycle journey planning function. The closure of the portal was announced in September 2014 "Closure of the Transport Direct website" (PDF). and the portal closed on 30 September 2014.	https://en.wikipedia.org/wiki/Transport_Direct_Portal	1.0	transport_direct_portal	\N	Transport Direct Portal was a distributed Internet-based multi-modal	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	693	\N	694	692	680	4	\N	691	f	0	None	0
172	Udea washingtonalis	2017-11-09 10:31:58.643578-05	2017-11-09 10:31:58.643588-05	Udea washingtonalis is a moth in the Crambidae family. It was described by Grote in 1882. It is found in North America, where it has been recorded from Alaska, British Columbia, California, Montana and Washington.\nThe wingspan is about 21 mm. The forewings are white with a dark brown band from the middle of the costa half-way to the inner margin. The antemedial and postmedial lines are broken and indistinct and there are black spots along the outer margin and the distal half of the costa. There is also pale yellowish shading in the median area. The hindwings are white with a diffuse yellowish terminal band and black dots along the outer margin. Adults are on wing from May to August.	https://en.wikipedia.org/wiki/Udea_washingtonalis	1	udea_washingtonalis	\N	Udea washingtonalis is a moth in the Crambidae family.	None	APPROVED	f	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	3	697	\N	698	696	684	5	\N	695	f	0	None	0
173	Uranus	2017-11-09 10:31:58.739447-05	2017-11-09 10:32:06.755891-05	Uranus is the seventh planet from the Sun. It has the third-largest planetary radius and fourth-largest planetary mass in the Solar System. Uranus is similar in composition to Neptune, and both have different bulk chemical composition from that of the larger gas giants Jupiter and Saturn. For this reason, scientists often classify Uranus and Neptune as "ice giants" to distinguish them from the gas giants. Uranus's atmosphere is similar to Jupiter's and Saturn's in its primary composition of hydrogen and helium, but it contains more "ices" such as water, ammonia, and methane, along with traces of other hydrocarbons. It is the coldest planetary atmosphere in the Solar System, with a minimum temperature of 49 K (−224 °C; −371 °F), and has a complex, layered cloud structure with water thought to make up the lowest clouds and methane the uppermost layer of clouds. The interior of Uranus is mainly composed of ices and rock.\n\nUranus is the only planet whose name is derived from a figure from Greek mythology, from the Latinised version of the Greek god of the sky Ouranos. Like the other giant planets, Uranus has a ring system, a magnetosphere, and numerous moons. The Uranian system has a unique configuration among those of the planets because its axis of rotation is tilted sideways, nearly into the plane of its solar orbit. Its north and south poles, therefore, lie where most other planets have their equators. In 1986, images from Voyager 2 showed Uranus as an almost featureless planet in visible light, without the cloud bands or storms associated with the other giant planets. Observations from Earth have shown seasonal change and increased weather activity as Uranus approached its equinox in 2007. Wind speeds can reach 250 metres per second (900 km/h; 560 mph).	https://en.wikipedia.org/wiki/Uranus	1.0	uranus	\N	Uranus is the seventh planet from the Sun.	Requires the internet.	APPROVED	t	f	3.5	2	1	0	0	1	0	2	t	UNCLASSIFIED	f	3	701	\N	702	700	688	3	\N	699	f	0	None	0
175	Violin	2017-11-09 10:31:58.969053-05	2017-11-09 10:31:58.969064-05	Violin is a wooden string instrument in the violin family. It is the smallest and highest-pitched instrument in the family in regular use. Smaller violin-type instruments are known, including the violino piccolo and the kit violin, but these are virtually unused in the 2010s	https://en.wikipedia.org/wiki/Violin	0.5.1	violin	earliest stringed instruments were mostly plucked	Wooden string instrument in the violin family	The body of violin and bow	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	2	709	\N	710	708	696	3	\N	707	f	0	None	0
176	Virtual Boy	\N	2017-11-09 10:31:59.476455-05	The Virtual Boy is a 32-bit table-top video game console developed and manufactured by Nintendo. Released in 1995, it was marketed as the first console capable of displaying stereoscopic 3D graphics. The player uses the console in a manner similar to a head-mounted display, placing their head against the eyepiece to see a red monochrome display. The games use a parallax effect to create the illusion of depth. Sales failed to meet targets, and by early 1996, Nintendo ceased distribution and game development, only ever releasing 22 games for the system.	https://en.wikipedia.org/wiki/Virtual_Boy	32bit	virtual_boy	\N	The Virtual Boy is a 32-bit table-top video game console developed and manufactured by Nintendo.	Pain meds for headaches and poor posture.  Ability to see red and black.	APPROVED_ORG	f	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	4	713	\N	714	712	699	2	\N	711	f	0	None	0
177	Voodoo	\N	2017-11-09 10:31:59.507812-05	Louisiana Voodoo, also known as New Orleans Voodoo, describes a set of spiritual folkways developed from the traditions of the African diaspora. It is a cultural form of the Afro-American religions developed by West and Central Africans populations of the U.S. state of Louisiana. Voodoo is one of many incarnations of African-based spiritual folkways rooted in West African Dahomeyan Vodun. Its liturgical language is Louisiana Creole French, the language of the Louisiana Creole people.\n\nVoodoo became syncretized with the Catholic and Francophone culture of New Orleans as a result of the African cultural oppression in the region resulting from the Atlantic slave trade. Louisiana Voodoo is often confused with—but is not completely separable from—Haitian Vodou and Deep Southern Hoodoo. It differs from Haitian Vodou in its emphasis upon gris-gris, Voodoo queens, use of Hoodoo paraphernalia, and Li Grand Zombi. It was through Louisiana Voodoo that such terms as gris-gris (a Wolof term)[citation needed] and "Voodoo dolls"' were introduced into the American lexicon.	https://en.wikipedia.org/wiki/Louisiana_Voodoo	1	voodoo	None.	Voodoo was brought to French Louisiana during the colonial period by enslaved Africans.	none	PENDING	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	717	\N	718	716	701	5	\N	715	f	0	None	0
178	Waterme Lon	2017-11-09 10:31:59.596925-05	2017-11-09 10:32:06.913942-05	Watermelon Citrullus lanatus var. lanatus is a scrambling and trailing vine in the flowering plant family Cucurbitaceae. The species originated in southern Africa, and there is evidence of its cultivation in Ancient Egypt. It is grown in tropical and sub-tropical areas worldwide for its large edible fruit, also known as a watermelon, which is a special kind of berry with a hard rind and no internal division, botanically called a pepo. The sweet, juicy flesh is usually deep red to pink, with many black seeds. The fruit can be eaten raw or pickled and the rind is edible after cooking.	http://localhost.com	1	waterme_lon	\N	Tasty fruit for the summer.	None	APPROVED	t	f	4.70000000000000018	3	2	1	0	0	0	3	t	UNCLASSIFIED	f	4	721	\N	722	720	705	2	\N	719	f	0	None	0
179	Weissbier	\N	2017-11-09 10:31:59.683682-05	Weizenbier or Hefeweizen, in the southern parts of Bavaria usually called Weißbier (literally "white beer", but the name probably derives from Weizenbier, "wheat beer"), is a beer, traditionally from Bavaria, in which a significant proportion of malted barley is replaced with malted wheat. By German law, Weißbiers brewed in Germany must be top-fermented. Specialized strains of yeast are used which produce overtones of banana and clove as by-products of fermentation. Weißbier is so called because it was, at the time of its inception, paler in color than Munich's traditional brown beer. It is well known throughout Germany, though better known as Weizen ("Wheat") outside Bavaria. The terms Hefeweizen ("yeast wheat") or Hefeweißbier refer to wheat beer in its traditional, unfiltered form. The term Kristallweizen (crystal wheat), or kristall Weiß (crystal white beer), refers to a wheat beer that is filtered to remove the yeast and wheat proteins which contribute to its cloudy appearance.	https://en.wikipedia.org/wiki/Wheat_beer#Weissbier	15ibu	weissbier	\N	Weizenbier or Hefeweizen, in the southern parts of Bavaria usually called Weißbier.	None	PENDING	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED//FOR OFFICIAL USE ONLY	f	2	725	\N	726	724	707	5	\N	723	f	0	None	0
180	White Horse	2017-11-09 10:31:59.774393-05	2017-11-09 10:32:06.944716-05	is one of two extant subspecies of Equus ferus. It is an odd-toed ungulate mammal belonging to the taxonomic family Equidae. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, Eohippus, into the large, single-toed animal of today. Humans began to domesticate horses around 4000 BC, and their domestication is believed to have been widespread by 3000 BC. Horses in the subspecies caballus are domesticated, although some domesticated populations live in the wild as feral horses. These feral populations are not true wild horses, as this term is used to describe horses that have never been domesticated, such as the endangered Przewalski's horse, a separate subspecies, and the only remaining true wild horse. There is an extensive, specialized vocabulary used to describe equine-related concepts, covering everything from anatomy to life stages, size, colors, markings, breeds, locomotion, and behavior.	https://en.wikipedia.org/wiki/Horse	1.5	white_horse	Horses' anatomy enables them to make use of speed to escape predators and they have a well-developed sense of balance and a strong fight-or-flight response	Large single-toed animal	Horses are prey animals with a strong fight-or-flight response	APPROVED	t	f	4	1	0	1	0	0	0	1	t	UNCLASSIFIED	f	2	729	\N	730	728	711	3	\N	727	f	0	None	0
181	White-tailed olalla rat	2017-11-09 10:31:59.866828-05	2017-11-09 10:31:59.866838-05	The white-tailed olalla rat (Olallamys albicauda) is a species of rodent in the family Echimyidae. It is endemic to Colombia. Its natural habitat is subtropical or tropical moist lowland forests. It is threatened by habitat loss.	https://en.wikipedia.org/wiki/White-tailed_olalla_rat	1	white-tailed_olalla_rat	\N	The white-tailed olalla rat (Olallamys albicauda) is a species of rodent in the family Echimyidae.	None	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED//FOR OFFICIAL USE ONLY	f	3	733	\N	734	732	715	5	\N	731	f	0	None	0
182	Wii	2017-11-09 10:32:00.126665-05	2017-11-09 10:32:00.126673-05	The Wii (/ˈwiː/ WEE) is a home video game console released by Nintendo on November 19, 2006. As a seventh-generation console, the Wii competed with Microsoft's Xbox 360 and Sony's PlayStation 3. Nintendo states that its console targets a broader demographic than that of the two others. As of the first quarter of 2012, the Wii leads its generation over PlayStation 3 and Xbox 360 in worldwide sales, with more than 101 million units sold; in December 2009, the console broke the sales record for a single month in the United States.	https://en.wikipedia.org/wiki/Wii	249.99	wii	\N	The Wii (/ˈwiː/ WEE) is a home video game console released by Nintendo on November 19, 2006.	A TV	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	737	\N	738	736	719	2	\N	735	f	0	None	0
183	Wii U	\N	2017-11-09 10:32:00.778283-05	The Wii U (/ˌwiː ˈjuː/ WEE YOO) is a home video game console developed by Nintendo, and the successor to the Wii. The console was released in November 2012 and was the first eighth-generation video game console, as it competes with Sony's PlayStation 4 and Microsoft's Xbox One.\n\nThe Wii U is the first Nintendo console to support HD graphics. The system's primary controller is the Wii U GamePad, which features an embedded touchscreen, and combines directional buttons, analog sticks, and action buttons. The screen can be used either as a supplement to the main display (either providing an alternate, asymmetric gameplay experience, or a means of local multiplayer without resorting to a split screen), or in supported games, to play the game directly on the GamePad independently of the television. The Wii U is backward compatible with all Wii software and accessories - games can support any combination of the GamePad, Wii Remote, Nunchuk, Balance Board, or Nintendo's more traditionally designed Classic Controller or Wii U Pro Controller for input. Online functionality centers around the Nintendo Network platform and Miiverse, an integrated social networking service which allows users to share content in game-specific communities.	https://en.wikipedia.org/wiki/Wii_U	U	wii_u	\N	The Wii U is the first Nintendo console to support HD graphics.	A TV, or not.	PENDING	f	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED//FOR OFFICIAL USE ONLY	f	4	741	\N	742	740	721	2	\N	739	f	0	None	0
185	Witch Doctor	\N	2017-11-09 10:32:00.882774-05	A witch doctor was originally a type of healer who treated ailments believed to be caused by witchcraft. The term witch doctor is sometimes used to refer to healers, particularly in third world regions, who use traditional healing rather than contemporary medicine. In contemporary society, "witch doctor" is sometimes used derisively to refer to chiropractors,[dubious - discuss] homeopaths and faith healers.	https://en.wikipedia.org/wiki/Witch_doctor	1	witch_doctor	Modern science.	In southern Africa, the witch doctors are known as sangomas	none	PENDING	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	749	\N	750	748	725	5	\N	747	f	0	None	0
184	Wikipedia	\N	2017-11-09 10:32:00.82954-05	Wikipedia (/ˌwɪkɪˈpiːdiə/ (About this sound listen) WIK-i-PEE-dee-ə or /ˌwɪkiˈpiːdiə/ (About this sound listen) WIK-ee-PEE-dee-ə) is a free online encyclopedia with the aim to allow anyone to edit articles. Wikipedia is the largest and most popular general reference work on the Internet and is ranked among the ten most popular websites. Wikipedia is owned by the nonprofit Wikimedia Foundation.\n\nWikipedia was launched on January 15, 2001, by Jimmy Wales and Larry Sanger. Sanger coined its name, a portmanteau of wiki[notes 4] and encyclopedia. There was only the English-language version initially, but it quickly developed similar versions in other languages, which differ in content and in editing practices. With 5,459,675 articles,[notes 5] the English Wikipedia is the largest of the more than 290 Wikipedia encyclopedias. Overall, Wikipedia consists of more than 40 million articles in more than 250 different languages and, as of February 2014, it had 18 billion page views and nearly 500 million unique visitors each month.\n\nAs of March 2017, Wikipedia has about forty thousand high-quality articles known as Featured Articles and Good Articles that cover vital topics. In 2005, Nature published a peer review comparing 42 science articles from Encyclopædia Britannica and Wikipedia, and found that Wikipedia's level of accuracy approached that of Encyclopædia Britannica.\n\nWikipedia has been criticized for allegedly exhibiting systemic bias, presenting a mixture of "truths, half truths, and some falsehoods", and, in controversial topics, being subject to manipulation and spin.	https://en.wikipedia.org/wiki/Wikipedia	1	wikipedia	\N	Wikipedia, the free encyclopedia	none	PENDING	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED	f	1	745	\N	746	744	723	5	\N	743	f	0	None	0
186	Wolf Finder	2017-11-09 10:32:01.058168-05	2017-11-09 10:32:07.00588-05	The gray wolf or grey wolf (Canis lupus), also known as the timber wolf or western wolf, is a canine native to the wilderness and remote areas of Eurasia and North America. It is the largest extant member of its family, with males averaging 43-45 kg (95-99 lb) and females 36-38.5 kg (79-85 lb). Like the red wolf, it is distinguished from other Canis species by its larger size and less pointed features, particularly on the ears and muzzle. Its winter fur is long and bushy and predominantly a mottled gray in color, although nearly pure white, red, and brown to black also occur. As of 2005, 37 subspecies of C. lupus are recognised by MSW3.\n\nThe gray wolf is the second most specialised member of the genus Canis, after the Ethiopian wolf, as demonstrated by its morphological adaptations to hunting large prey, its more gregarious nature, and its highly advanced expressive behavior. It is nonetheless closely related enough to smaller Canis species, such as the eastern wolf, coyote, and golden jackal, to produce fertile hybrids. It is the only species of Canis to have a range encompassing both the Old and New Worlds, and originated in Eurasia during the Pleistocene, colonizing North America on at least three separate occasions during the Rancholabrean. It is a social animal, travelling in nuclear families consisting of a mated pair, accompanied by the pair's adult offspring. The gray wolf is typically an apex predator throughout its range, with only humans and tigers posing a serious threat to it. It feeds primarily on large ungulates, though it also eats smaller animals, livestock, carrion, and garbage.	https://en.wikipedia.org/wiki/Gray_wolf	1.0.9	wolf_finder	\N	The gray wolf is one of the world's best-known and most-researched animals.	The gray wolf is a habitat generalist, and can occur in deserts, grasslands, forests and arctic tundras	APPROVED	t	f	4.5	2	1	1	0	0	0	2	t	UNCLASSIFIED	f	2	753	\N	754	752	729	3	\N	751	f	0	None	0
187	Wolverine	2017-11-09 10:32:01.119678-05	2017-11-09 10:32:07.037143-05	Wolverine (born James Howlett commonly known as Logan and sometimes as Weapon X) is a fictional character appearing in American comic books published by Marvel Comics, mostly in association with the X-Men. He is a mutant who possesses animal-keen senses, enhanced physical capabilities, powerful regenerative ability known as a healing factor, and three retractable bone claws in each hand. Wolverine has been depicted variously as a member of the X-Men, Alpha Flight, and the Avengers.\nThe character appeared in the last panel of The Incredible Hulk #180 before having a larger role in #181 (cover-dated Nov. 1974). He was created by writer Len Wein and Marvel art director John Romita, Sr., who designed the character, and was first drawn for publication by Herb Trimpe. Wolverine then joined a revamped version of the superhero team the X-Men, where eventually writer Chris Claremont and artist-writer John Byrne would play significant roles in the character's development. Artist Frank Miller collaborated with Claremont and helped to revise the character with a four-part eponymous limited series from September to December 1982 which debuted Wolverine's catchphrase, "I'm the best there is at what I do, but what I do best isn't very nice."\nWolverine is typical of the many tough antiheroes that emerged in American popular culture after the Vietnam War; his willingness to use deadly force and his brooding nature became standard characteristics for comic book antiheroes by the end of the 1980s. As a result, the character became a fan favorite of the increasingly popular X-Men franchise, and has been featured in his own solo comic since 1988.\nHe has appeared in most X-Men adaptations, including animated television series, video games, and the live-action 20th Century Fox X-Men film series, in which he is portrayed by Hugh Jackman in nine of the ten films. The character is highly rated in many comics best-of lists, ranked #1 in Wizard magazine's 2008 Top 200 Comic Book Characters; 4th in Empire's 2008 Greatest Comic Characters; and 4th on IGN's 2011 Top 100 Comic Book Heroes.	https://en.wikipedia.org/wiki/Wolverine_(character)	1	wolverine	\N	Stabs things	None	APPROVED	t	f	3	1	0	0	1	0	0	1	t	UNCLASSIFIED	f	2	757	\N	758	756	733	4	\N	755	f	0	None	0
188	Writing	2017-11-09 10:32:01.222567-05	2017-11-09 10:32:01.222582-05	Writing is a medium of human communication that represents language and emotion with signs and symbols. In most languages, writing is a complement to speech or spoken language. Writing is not a language, but a tool developed by human society. Within a language system, writing relies on many of the same structures as speech, such as vocabulary, grammar, and semantics, with the added dependency of a system of signs or symbols. The result of writing is called text, and the recipient of text is called a reader. Motivations for writing include publication, storytelling, correspondence and diary. Writing has been instrumental in keeping history, maintaining culture, dissemination of knowledge through the media and the formation of legal systems.	https://en.wikipedia.org/wiki/Writing	15.05	writing	It is possible to also write using a laptop	Writing is a medium of human communication, represents language and emotion with signs and symbols	A pen and paper	APPROVED	t	f	0	0	0	0	0	0	0	0	t	UNCLASSIFIED//FOR OFFICIAL USE ONLY	f	2	761	\N	762	760	737	3	\N	759	f	0	None	0
9	Azeroth	2017-11-09 10:31:40.771953-05	2017-11-09 10:32:01.99707-05	Azeroth is the name of the world in which the majority of the Warcraft series is set. The world of Azeroth is the birthplace of many races, most notable being elves (night elves, high elves, and blood elves), humans, dwarves, tauren, goblins, trolls, gnomes, pandarens and dragons. At its birth, Azeroth was blessed by the titans. One day, the demonic armies of the Burning Legion came and shattered the peace and led the night elves to sunder their world. Gradually, races were dragged to Azeroth (such as the orcs, draenei, and ogres), others evolved, and others were brought up from the dust itself.\nThe peoples of Azeroth have fought brutally against the demons and their servants, and much blood was, and is still being, shed. After the Third War, three major powers emerged: the Scourge, Horde, and Alliance. Other major powers include the naga, qiraji, and Scarlet Crusade. Although ravaged by conflict, somehow through trickery, betrayal, and sheer blood, Azeroth has survived the Burning Legion four times. However, Azeroth is still torn by conflict, hate, and war.	http://wowwiki.wikia.com/wiki/Azeroth_(world)	1.0	azeroth	\N	Azeroth is the name of the world in which the majority of the Warcraft series is set.	Requires the internet. And skillz.	APPROVED	t	f	4.20000000000000018	5	3	0	2	0	0	5	t	UNCLASSIFIED	f	3	45	\N	46	44	34	3	\N	43	f	0	None	0
\.


--
-- Name: ozpcenter_listing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_listing_id_seq', 188, true);


--
-- Data for Name: ozpcenter_listingactivity; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_listingactivity (id, action, activity_date, description, author_id, listing_id) FROM stdin;
1	CREATED	2017-11-09 10:31:40.017617-05	\N	1	1
2	SUBMITTED	2017-11-09 10:31:40.022394-05	\N	1	1
3	APPROVED_ORG	2017-11-09 10:31:40.026122-05	\N	1	1
4	APPROVED	2017-11-09 10:31:40.029736-05	\N	1	1
5	CREATED	2017-11-09 10:31:40.152044-05	\N	5	2
6	SUBMITTED	2017-11-09 10:31:40.155838-05	\N	5	2
7	APPROVED_ORG	2017-11-09 10:31:40.159531-05	\N	5	2
8	APPROVED	2017-11-09 10:31:40.163356-05	\N	5	2
9	CREATED	2017-11-09 10:31:40.18506-05	\N	4	3
10	SUBMITTED	2017-11-09 10:31:40.188639-05	\N	4	3
11	CREATED	2017-11-09 10:31:40.229225-05	\N	9	4
12	SUBMITTED	2017-11-09 10:31:40.232767-05	\N	9	4
13	APPROVED_ORG	2017-11-09 10:31:40.236498-05	\N	4	4
14	APPROVED	2017-11-09 10:31:40.240068-05	\N	4	4
15	CREATED	2017-11-09 10:31:40.29623-05	\N	15	5
16	SUBMITTED	2017-11-09 10:31:40.29975-05	\N	15	5
17	APPROVED_ORG	2017-11-09 10:31:40.303331-05	\N	1	5
18	APPROVED	2017-11-09 10:31:40.306899-05	\N	1	5
19	CREATED	2017-11-09 10:31:40.339869-05	\N	17	6
20	SUBMITTED	2017-11-09 10:31:40.343329-05	\N	17	6
21	APPROVED_ORG	2017-11-09 10:31:40.347276-05	\N	1	6
22	APPROVED	2017-11-09 10:31:40.351146-05	\N	1	6
23	CREATED	2017-11-09 10:31:40.604987-05	\N	5	7
24	SUBMITTED	2017-11-09 10:31:40.609058-05	\N	5	7
25	APPROVED_ORG	2017-11-09 10:31:40.613058-05	\N	1	7
26	APPROVED	2017-11-09 10:31:40.617078-05	\N	1	7
27	CREATED	2017-11-09 10:31:40.677765-05	\N	4	8
28	SUBMITTED	2017-11-09 10:31:40.681793-05	\N	4	8
29	APPROVED_ORG	2017-11-09 10:31:40.685865-05	\N	4	8
30	APPROVED	2017-11-09 10:31:40.689784-05	\N	4	8
31	CREATED	2017-11-09 10:31:40.757759-05	\N	12	9
32	SUBMITTED	2017-11-09 10:31:40.761558-05	\N	12	9
33	APPROVED_ORG	2017-11-09 10:31:40.765532-05	\N	1	9
34	APPROVED	2017-11-09 10:31:40.769691-05	\N	1	9
35	CREATED	2017-11-09 10:31:40.939743-05	\N	4	10
36	SUBMITTED	2017-11-09 10:31:40.943805-05	\N	4	10
37	APPROVED_ORG	2017-11-09 10:31:40.947724-05	\N	4	10
38	APPROVED	2017-11-09 10:31:40.951646-05	\N	4	10
39	CREATED	2017-11-09 10:31:40.984333-05	\N	13	11
40	SUBMITTED	2017-11-09 10:31:40.989056-05	\N	13	11
41	APPROVED_ORG	2017-11-09 10:31:40.99399-05	\N	4	11
42	APPROVED	2017-11-09 10:31:40.998578-05	\N	4	11
43	CREATED	2017-11-09 10:31:41.080536-05	\N	12	12
44	SUBMITTED	2017-11-09 10:31:41.084913-05	\N	12	12
45	APPROVED_ORG	2017-11-09 10:31:41.089298-05	\N	1	12
46	APPROVED	2017-11-09 10:31:41.093567-05	\N	1	12
47	CREATED	2017-11-09 10:31:41.126996-05	\N	9	13
48	SUBMITTED	2017-11-09 10:31:41.131028-05	\N	9	13
49	APPROVED_ORG	2017-11-09 10:31:41.135031-05	\N	4	13
50	APPROVED	2017-11-09 10:31:41.139155-05	\N	4	13
51	CREATED	2017-11-09 10:31:41.170189-05	\N	13	14
52	SUBMITTED	2017-11-09 10:31:41.174089-05	\N	13	14
53	APPROVED_ORG	2017-11-09 10:31:41.178026-05	\N	4	14
54	APPROVED	2017-11-09 10:31:41.18197-05	\N	4	14
55	CREATED	2017-11-09 10:31:41.216309-05	\N	13	15
56	SUBMITTED	2017-11-09 10:31:41.220815-05	\N	13	15
57	APPROVED_ORG	2017-11-09 10:31:41.225338-05	\N	4	15
58	APPROVED	2017-11-09 10:31:41.229893-05	\N	4	15
59	CREATED	2017-11-09 10:31:41.265308-05	\N	17	16
60	SUBMITTED	2017-11-09 10:31:41.26939-05	\N	17	16
61	APPROVED_ORG	2017-11-09 10:31:41.273543-05	\N	1	16
62	APPROVED	2017-11-09 10:31:41.277729-05	\N	1	16
63	CREATED	2017-11-09 10:31:41.358885-05	\N	15	17
64	SUBMITTED	2017-11-09 10:31:41.36359-05	\N	15	17
65	APPROVED_ORG	2017-11-09 10:31:41.368254-05	\N	1	17
66	APPROVED	2017-11-09 10:31:41.372953-05	\N	1	17
67	CREATED	2017-11-09 10:31:41.421167-05	\N	4	18
68	SUBMITTED	2017-11-09 10:31:41.424807-05	\N	4	18
69	APPROVED_ORG	2017-11-09 10:31:41.428419-05	\N	4	18
70	APPROVED	2017-11-09 10:31:41.431973-05	\N	4	18
71	CREATED	2017-11-09 10:31:41.46649-05	\N	17	19
72	SUBMITTED	2017-11-09 10:31:41.470154-05	\N	17	19
73	APPROVED_ORG	2017-11-09 10:31:41.473738-05	\N	1	19
74	APPROVED	2017-11-09 10:31:41.477278-05	\N	1	19
75	CREATED	2017-11-09 10:31:41.5523-05	\N	15	20
76	SUBMITTED	2017-11-09 10:31:41.556392-05	\N	15	20
77	APPROVED_ORG	2017-11-09 10:31:41.560507-05	\N	1	20
78	APPROVED	2017-11-09 10:31:41.564385-05	\N	1	20
79	CREATED	2017-11-09 10:31:41.614477-05	\N	13	21
80	SUBMITTED	2017-11-09 10:31:41.618332-05	\N	13	21
81	APPROVED_ORG	2017-11-09 10:31:41.622364-05	\N	4	21
82	APPROVED	2017-11-09 10:31:41.626134-05	\N	4	21
83	CREATED	2017-11-09 10:31:41.727299-05	\N	4	22
84	SUBMITTED	2017-11-09 10:31:41.734639-05	\N	4	22
85	APPROVED_ORG	2017-11-09 10:31:41.742255-05	\N	4	22
86	APPROVED	2017-11-09 10:31:41.749459-05	\N	4	22
87	CREATED	2017-11-09 10:31:41.831781-05	\N	6	23
88	SUBMITTED	2017-11-09 10:31:41.835562-05	\N	6	23
89	APPROVED_ORG	2017-11-09 10:31:41.839449-05	\N	5	23
90	APPROVED	2017-11-09 10:31:41.84339-05	\N	5	23
91	CREATED	2017-11-09 10:31:41.896361-05	\N	13	24
92	SUBMITTED	2017-11-09 10:31:41.902232-05	\N	13	24
93	APPROVED_ORG	2017-11-09 10:31:41.908121-05	\N	1	24
94	APPROVED	2017-11-09 10:31:41.913854-05	\N	1	24
95	CREATED	2017-11-09 10:31:41.989027-05	\N	9	25
96	SUBMITTED	2017-11-09 10:31:41.994936-05	\N	9	25
97	APPROVED_ORG	2017-11-09 10:31:42.000902-05	\N	4	25
98	APPROVED	2017-11-09 10:31:42.006854-05	\N	4	25
99	CREATED	2017-11-09 10:31:42.278814-05	\N	5	26
100	SUBMITTED	2017-11-09 10:31:42.283191-05	\N	5	26
101	APPROVED_ORG	2017-11-09 10:31:42.287698-05	\N	1	26
102	APPROVED	2017-11-09 10:31:42.292314-05	\N	1	26
103	CREATED	2017-11-09 10:31:42.443218-05	\N	5	27
104	SUBMITTED	2017-11-09 10:31:42.44737-05	\N	1	27
105	APPROVED_ORG	2017-11-09 10:31:42.451467-05	\N	1	27
106	APPROVED	2017-11-09 10:31:42.455599-05	\N	1	27
107	CREATED	2017-11-09 10:31:42.552699-05	\N	15	28
108	SUBMITTED	2017-11-09 10:31:42.556821-05	\N	15	28
109	APPROVED_ORG	2017-11-09 10:31:42.560926-05	\N	1	28
110	APPROVED	2017-11-09 10:31:42.565352-05	\N	1	28
111	CREATED	2017-11-09 10:31:42.637996-05	\N	15	29
112	SUBMITTED	2017-11-09 10:31:42.642-05	\N	15	29
113	APPROVED_ORG	2017-11-09 10:31:42.646346-05	\N	1	29
114	APPROVED	2017-11-09 10:31:42.650558-05	\N	1	29
115	CREATED	2017-11-09 10:31:42.722849-05	\N	5	30
116	SUBMITTED	2017-11-09 10:31:42.726709-05	\N	5	30
117	APPROVED_ORG	2017-11-09 10:31:42.730733-05	\N	5	30
118	APPROVED	2017-11-09 10:31:42.735103-05	\N	5	30
119	CREATED	2017-11-09 10:31:42.762961-05	\N	4	31
120	SUBMITTED	2017-11-09 10:31:42.767221-05	\N	4	31
121	APPROVED_ORG	2017-11-09 10:31:42.771802-05	\N	4	31
122	APPROVED	2017-11-09 10:31:42.776165-05	\N	4	31
123	CREATED	2017-11-09 10:31:42.846635-05	\N	6	32
124	SUBMITTED	2017-11-09 10:31:42.850792-05	\N	6	32
125	APPROVED_ORG	2017-11-09 10:31:42.854984-05	\N	5	32
126	APPROVED	2017-11-09 10:31:42.859643-05	\N	5	32
127	CREATED	2017-11-09 10:31:43.018707-05	\N	4	33
128	SUBMITTED	2017-11-09 10:31:43.022849-05	\N	4	33
129	APPROVED_ORG	2017-11-09 10:31:43.027149-05	\N	4	33
130	APPROVED	2017-11-09 10:31:43.031823-05	\N	4	33
131	CREATED	2017-11-09 10:31:43.085853-05	\N	13	34
132	SUBMITTED	2017-11-09 10:31:43.089835-05	\N	13	34
133	APPROVED_ORG	2017-11-09 10:31:43.094302-05	\N	4	34
134	APPROVED	2017-11-09 10:31:43.098699-05	\N	4	34
135	CREATED	2017-11-09 10:31:43.279735-05	\N	4	35
136	SUBMITTED	2017-11-09 10:31:43.283912-05	\N	4	35
137	APPROVED_ORG	2017-11-09 10:31:43.288082-05	\N	4	35
138	APPROVED	2017-11-09 10:31:43.29276-05	\N	4	35
139	CREATED	2017-11-09 10:31:43.324659-05	\N	4	36
140	SUBMITTED	2017-11-09 10:31:43.328613-05	\N	4	36
141	APPROVED_ORG	2017-11-09 10:31:43.3326-05	\N	4	36
142	APPROVED	2017-11-09 10:31:43.336813-05	\N	4	36
143	CREATED	2017-11-09 10:31:43.374876-05	\N	4	37
144	SUBMITTED	2017-11-09 10:31:43.378673-05	\N	4	37
145	APPROVED_ORG	2017-11-09 10:31:43.382466-05	\N	4	37
146	APPROVED	2017-11-09 10:31:43.386514-05	\N	4	37
147	CREATED	2017-11-09 10:31:43.457952-05	\N	5	38
148	SUBMITTED	2017-11-09 10:31:43.461855-05	\N	5	38
149	APPROVED_ORG	2017-11-09 10:31:43.465976-05	\N	5	38
150	APPROVED	2017-11-09 10:31:43.470349-05	\N	5	38
151	CREATED	2017-11-09 10:31:43.524679-05	\N	4	39
152	SUBMITTED	2017-11-09 10:31:43.528736-05	\N	4	39
153	APPROVED_ORG	2017-11-09 10:31:43.532981-05	\N	4	39
154	APPROVED	2017-11-09 10:31:43.536943-05	\N	4	39
155	CREATED	2017-11-09 10:31:43.572595-05	\N	13	40
156	SUBMITTED	2017-11-09 10:31:43.57688-05	\N	13	40
157	APPROVED_ORG	2017-11-09 10:31:43.581144-05	\N	4	40
158	APPROVED	2017-11-09 10:31:43.585474-05	\N	4	40
159	CREATED	2017-11-09 10:31:43.623221-05	\N	17	41
160	SUBMITTED	2017-11-09 10:31:43.627139-05	\N	17	41
161	APPROVED_ORG	2017-11-09 10:31:43.631279-05	\N	1	41
162	APPROVED	2017-11-09 10:31:43.635128-05	\N	1	41
163	CREATED	2017-11-09 10:31:43.695748-05	\N	17	42
164	SUBMITTED	2017-11-09 10:31:43.699726-05	\N	17	42
165	APPROVED_ORG	2017-11-09 10:31:43.703734-05	\N	1	42
166	APPROVED	2017-11-09 10:31:43.707713-05	\N	1	42
167	CREATED	2017-11-09 10:31:44.030308-05	\N	5	43
168	SUBMITTED	2017-11-09 10:31:44.034962-05	\N	5	43
169	APPROVED_ORG	2017-11-09 10:31:44.039601-05	\N	1	43
170	APPROVED	2017-11-09 10:31:44.043989-05	\N	1	43
171	CREATED	2017-11-09 10:31:44.294808-05	\N	3	44
172	SUBMITTED	2017-11-09 10:31:44.299353-05	\N	3	44
173	APPROVED_ORG	2017-11-09 10:31:44.304076-05	\N	3	44
174	APPROVED	2017-11-09 10:31:44.308873-05	\N	3	44
175	CREATED	2017-11-09 10:31:44.420194-05	\N	9	45
176	SUBMITTED	2017-11-09 10:31:44.42439-05	\N	9	45
177	APPROVED_ORG	2017-11-09 10:31:44.428633-05	\N	4	45
178	APPROVED	2017-11-09 10:31:44.432907-05	\N	4	45
179	CREATED	2017-11-09 10:31:44.474198-05	\N	4	46
180	SUBMITTED	2017-11-09 10:31:44.478174-05	\N	4	46
181	APPROVED_ORG	2017-11-09 10:31:44.482259-05	\N	4	46
182	APPROVED	2017-11-09 10:31:44.486391-05	\N	4	46
183	CREATED	2017-11-09 10:31:44.649591-05	\N	3	47
184	SUBMITTED	2017-11-09 10:31:44.652926-05	\N	3	47
185	APPROVED_ORG	2017-11-09 10:31:44.656292-05	\N	3	47
186	APPROVED	2017-11-09 10:31:44.659674-05	\N	3	47
187	CREATED	2017-11-09 10:31:44.763313-05	\N	4	48
188	SUBMITTED	2017-11-09 10:31:44.767449-05	\N	4	48
189	APPROVED_ORG	2017-11-09 10:31:44.771061-05	\N	4	48
190	APPROVED	2017-11-09 10:31:44.77465-05	\N	4	48
191	CREATED	2017-11-09 10:31:44.825113-05	\N	1	49
192	SUBMITTED	2017-11-09 10:31:44.828417-05	\N	1	49
193	APPROVED_ORG	2017-11-09 10:31:44.831584-05	\N	1	49
194	APPROVED	2017-11-09 10:31:44.834841-05	\N	1	49
195	CREATED	2017-11-09 10:31:44.911473-05	\N	1	50
196	SUBMITTED	2017-11-09 10:31:44.915939-05	\N	1	50
197	APPROVED_ORG	2017-11-09 10:31:44.920209-05	\N	1	50
198	APPROVED	2017-11-09 10:31:44.924475-05	\N	1	50
199	CREATED	2017-11-09 10:31:45.033993-05	\N	4	51
200	SUBMITTED	2017-11-09 10:31:45.038071-05	\N	1	51
201	CREATED	2017-11-09 10:31:45.119522-05	\N	4	52
202	SUBMITTED	2017-11-09 10:31:45.123515-05	\N	4	52
203	APPROVED_ORG	2017-11-09 10:31:45.127574-05	\N	4	52
204	APPROVED	2017-11-09 10:31:45.131352-05	\N	4	52
205	CREATED	2017-11-09 10:31:45.166003-05	\N	4	53
206	SUBMITTED	2017-11-09 10:31:45.169604-05	\N	4	53
207	APPROVED_ORG	2017-11-09 10:31:45.173134-05	\N	4	53
208	APPROVED	2017-11-09 10:31:45.176736-05	\N	4	53
209	CREATED	2017-11-09 10:31:45.280485-05	\N	4	54
210	SUBMITTED	2017-11-09 10:31:45.284923-05	\N	4	54
211	APPROVED_ORG	2017-11-09 10:31:45.289232-05	\N	4	54
212	APPROVED	2017-11-09 10:31:45.293399-05	\N	4	54
213	CREATED	2017-11-09 10:31:45.33332-05	\N	4	55
214	SUBMITTED	2017-11-09 10:31:45.337948-05	\N	4	55
215	APPROVED_ORG	2017-11-09 10:31:45.345263-05	\N	4	55
216	APPROVED	2017-11-09 10:31:45.352338-05	\N	4	55
217	CREATED	2017-11-09 10:31:45.632763-05	\N	9	56
218	SUBMITTED	2017-11-09 10:31:45.636991-05	\N	9	56
219	APPROVED_ORG	2017-11-09 10:31:45.641364-05	\N	4	56
220	APPROVED	2017-11-09 10:31:45.6458-05	\N	4	56
221	CREATED	2017-11-09 10:31:45.719604-05	\N	1	57
222	SUBMITTED	2017-11-09 10:31:45.723646-05	\N	1	57
223	APPROVED_ORG	2017-11-09 10:31:45.727957-05	\N	1	57
224	APPROVED	2017-11-09 10:31:45.732135-05	\N	1	57
225	CREATED	2017-11-09 10:31:45.804669-05	\N	5	58
226	SUBMITTED	2017-11-09 10:31:45.808857-05	\N	5	58
227	APPROVED_ORG	2017-11-09 10:31:45.813117-05	\N	5	58
228	APPROVED	2017-11-09 10:31:45.817479-05	\N	5	58
229	CREATED	2017-11-09 10:31:45.978334-05	\N	15	59
230	SUBMITTED	2017-11-09 10:31:45.982217-05	\N	15	59
231	APPROVED_ORG	2017-11-09 10:31:45.986171-05	\N	1	59
232	APPROVED	2017-11-09 10:31:45.990121-05	\N	1	59
233	CREATED	2017-11-09 10:31:46.033678-05	\N	4	60
234	SUBMITTED	2017-11-09 10:31:46.037297-05	\N	4	60
235	APPROVED_ORG	2017-11-09 10:31:46.041174-05	\N	4	60
236	APPROVED	2017-11-09 10:31:46.044988-05	\N	4	60
237	CREATED	2017-11-09 10:31:46.094915-05	\N	15	61
238	SUBMITTED	2017-11-09 10:31:46.09882-05	\N	15	61
239	APPROVED_ORG	2017-11-09 10:31:46.103502-05	\N	1	61
240	APPROVED	2017-11-09 10:31:46.107791-05	\N	1	61
241	CREATED	2017-11-09 10:31:46.187763-05	\N	4	62
242	SUBMITTED	2017-11-09 10:31:46.19205-05	\N	4	62
243	APPROVED_ORG	2017-11-09 10:31:46.196551-05	\N	4	62
244	APPROVED	2017-11-09 10:31:46.200979-05	\N	4	62
245	CREATED	2017-11-09 10:31:46.230938-05	\N	13	63
246	SUBMITTED	2017-11-09 10:31:46.235324-05	\N	13	63
247	APPROVED_ORG	2017-11-09 10:31:46.241025-05	\N	4	63
248	APPROVED	2017-11-09 10:31:46.245689-05	\N	4	63
249	CREATED	2017-11-09 10:31:46.313329-05	\N	1	64
250	SUBMITTED	2017-11-09 10:31:46.318097-05	\N	1	64
251	APPROVED_ORG	2017-11-09 10:31:46.322851-05	\N	1	64
252	APPROVED	2017-11-09 10:31:46.327302-05	\N	1	64
253	CREATED	2017-11-09 10:31:46.375258-05	\N	13	65
254	SUBMITTED	2017-11-09 10:31:46.379634-05	\N	13	65
255	APPROVED_ORG	2017-11-09 10:31:46.383725-05	\N	4	65
256	SUBMITTED	2017-11-09 10:31:46.388007-05	\N	4	65
257	APPROVED_ORG	2017-11-09 10:31:46.392294-05	\N	4	65
258	APPROVED	2017-11-09 10:31:46.39698-05	\N	4	65
259	CREATED	2017-11-09 10:31:46.514123-05	\N	5	66
260	SUBMITTED	2017-11-09 10:31:46.519367-05	\N	5	66
261	APPROVED_ORG	2017-11-09 10:31:46.524502-05	\N	5	66
262	APPROVED	2017-11-09 10:31:46.529571-05	\N	5	66
263	CREATED	2017-11-09 10:31:46.660798-05	\N	9	67
264	SUBMITTED	2017-11-09 10:31:46.664879-05	\N	9	67
265	APPROVED_ORG	2017-11-09 10:31:46.668919-05	\N	4	67
266	APPROVED	2017-11-09 10:31:46.672941-05	\N	4	67
267	CREATED	2017-11-09 10:31:46.783088-05	\N	1	68
268	SUBMITTED	2017-11-09 10:31:46.787307-05	\N	1	68
269	APPROVED_ORG	2017-11-09 10:31:46.791259-05	\N	1	68
270	APPROVED	2017-11-09 10:31:46.795261-05	\N	1	68
271	CREATED	2017-11-09 10:31:47.494281-05	\N	1	69
272	SUBMITTED	2017-11-09 10:31:47.498137-05	\N	1	69
273	APPROVED_ORG	2017-11-09 10:31:47.501832-05	\N	1	69
274	APPROVED	2017-11-09 10:31:47.505568-05	\N	1	69
275	CREATED	2017-11-09 10:31:47.563579-05	\N	3	70
276	SUBMITTED	2017-11-09 10:31:47.567471-05	\N	3	70
277	APPROVED_ORG	2017-11-09 10:31:47.572601-05	\N	3	70
278	APPROVED	2017-11-09 10:31:47.576433-05	\N	3	70
279	CREATED	2017-11-09 10:31:47.625604-05	\N	4	71
280	SUBMITTED	2017-11-09 10:31:47.629727-05	\N	4	71
281	APPROVED_ORG	2017-11-09 10:31:47.63358-05	\N	4	71
282	APPROVED	2017-11-09 10:31:47.637513-05	\N	4	71
283	CREATED	2017-11-09 10:31:47.659685-05	\N	4	72
284	SUBMITTED	2017-11-09 10:31:47.663485-05	\N	1	72
285	APPROVED_ORG	2017-11-09 10:31:47.667187-05	\N	1	72
286	APPROVED	2017-11-09 10:31:47.670841-05	\N	1	72
287	CREATED	2017-11-09 10:31:47.732411-05	\N	1	73
288	SUBMITTED	2017-11-09 10:31:47.736219-05	\N	1	73
289	APPROVED_ORG	2017-11-09 10:31:47.739834-05	\N	1	73
290	APPROVED	2017-11-09 10:31:47.743604-05	\N	1	73
291	CREATED	2017-11-09 10:31:48.106035-05	\N	5	74
292	SUBMITTED	2017-11-09 10:31:48.11024-05	\N	5	74
293	APPROVED_ORG	2017-11-09 10:31:48.114168-05	\N	1	74
294	APPROVED	2017-11-09 10:31:48.118181-05	\N	1	74
295	CREATED	2017-11-09 10:31:48.207925-05	\N	15	75
296	SUBMITTED	2017-11-09 10:31:48.211807-05	\N	15	75
297	APPROVED_ORG	2017-11-09 10:31:48.21613-05	\N	1	75
298	APPROVED	2017-11-09 10:31:48.220234-05	\N	1	75
299	CREATED	2017-11-09 10:31:48.307306-05	\N	4	76
300	SUBMITTED	2017-11-09 10:31:48.311046-05	\N	4	76
301	APPROVED_ORG	2017-11-09 10:31:48.314787-05	\N	4	76
302	APPROVED	2017-11-09 10:31:48.318519-05	\N	4	76
303	CREATED	2017-11-09 10:31:48.352098-05	\N	17	77
304	SUBMITTED	2017-11-09 10:31:48.358078-05	\N	17	77
305	APPROVED_ORG	2017-11-09 10:31:48.36497-05	\N	1	77
306	APPROVED	2017-11-09 10:31:48.372434-05	\N	1	77
307	CREATED	2017-11-09 10:31:48.464939-05	\N	4	78
308	SUBMITTED	2017-11-09 10:31:48.469746-05	\N	4	78
309	APPROVED_ORG	2017-11-09 10:31:48.47432-05	\N	4	78
310	APPROVED	2017-11-09 10:31:48.478866-05	\N	4	78
311	CREATED	2017-11-09 10:31:48.594674-05	\N	12	79
312	SUBMITTED	2017-11-09 10:31:48.599404-05	\N	12	79
313	APPROVED_ORG	2017-11-09 10:31:48.604104-05	\N	1	79
314	APPROVED	2017-11-09 10:31:48.60888-05	\N	1	79
315	CREATED	2017-11-09 10:31:48.643041-05	\N	4	80
316	SUBMITTED	2017-11-09 10:31:48.646788-05	\N	4	80
317	APPROVED_ORG	2017-11-09 10:31:48.650547-05	\N	4	80
318	APPROVED	2017-11-09 10:31:48.65426-05	\N	4	80
319	CREATED	2017-11-09 10:31:48.690313-05	\N	17	81
320	SUBMITTED	2017-11-09 10:31:48.694333-05	\N	17	81
321	APPROVED_ORG	2017-11-09 10:31:48.69832-05	\N	1	81
322	APPROVED	2017-11-09 10:31:48.702352-05	\N	1	81
323	CREATED	2017-11-09 10:31:48.776309-05	\N	5	82
324	SUBMITTED	2017-11-09 10:31:48.78039-05	\N	5	82
325	APPROVED_ORG	2017-11-09 10:31:48.784478-05	\N	5	82
326	APPROVED	2017-11-09 10:31:48.788588-05	\N	5	82
327	CREATED	2017-11-09 10:31:48.868369-05	\N	12	83
328	SUBMITTED	2017-11-09 10:31:48.872807-05	\N	12	83
329	APPROVED_ORG	2017-11-09 10:31:48.877143-05	\N	1	83
330	APPROVED	2017-11-09 10:31:48.881929-05	\N	1	83
331	CREATED	2017-11-09 10:31:48.908531-05	\N	4	84
332	SUBMITTED	2017-11-09 10:31:48.912365-05	\N	4	84
333	APPROVED_ORG	2017-11-09 10:31:48.916513-05	\N	4	84
334	APPROVED	2017-11-09 10:31:48.920608-05	\N	4	84
335	CREATED	2017-11-09 10:31:49.009955-05	\N	4	85
336	SUBMITTED	2017-11-09 10:31:49.014149-05	\N	4	85
337	APPROVED_ORG	2017-11-09 10:31:49.018224-05	\N	4	85
338	APPROVED	2017-11-09 10:31:49.022253-05	\N	4	85
339	CREATED	2017-11-09 10:31:49.116002-05	\N	15	86
340	SUBMITTED	2017-11-09 10:31:49.120143-05	\N	15	86
341	APPROVED_ORG	2017-11-09 10:31:49.12418-05	\N	1	86
342	APPROVED	2017-11-09 10:31:49.128227-05	\N	1	86
343	CREATED	2017-11-09 10:31:49.20492-05	\N	1	87
344	SUBMITTED	2017-11-09 10:31:49.209099-05	\N	1	87
345	APPROVED_ORG	2017-11-09 10:31:49.213293-05	\N	1	87
346	APPROVED	2017-11-09 10:31:49.217573-05	\N	1	87
347	CREATED	2017-11-09 10:31:49.299424-05	\N	3	88
348	SUBMITTED	2017-11-09 10:31:49.304238-05	\N	3	88
349	APPROVED_ORG	2017-11-09 10:31:49.309061-05	\N	3	88
350	APPROVED	2017-11-09 10:31:49.313724-05	\N	3	88
351	CREATED	2017-11-09 10:31:49.455326-05	\N	9	89
352	SUBMITTED	2017-11-09 10:31:49.460061-05	\N	9	89
353	APPROVED_ORG	2017-11-09 10:31:49.464394-05	\N	4	89
354	APPROVED	2017-11-09 10:31:49.468676-05	\N	4	89
355	CREATED	2017-11-09 10:31:49.564708-05	\N	4	90
356	SUBMITTED	2017-11-09 10:31:49.568564-05	\N	4	90
357	APPROVED_ORG	2017-11-09 10:31:49.572386-05	\N	4	90
358	APPROVED	2017-11-09 10:31:49.576403-05	\N	4	90
359	CREATED	2017-11-09 10:31:49.620177-05	\N	1	91
360	SUBMITTED	2017-11-09 10:31:49.624072-05	\N	1	91
361	APPROVED_ORG	2017-11-09 10:31:49.627793-05	\N	1	91
362	APPROVED	2017-11-09 10:31:49.631633-05	\N	1	91
363	CREATED	2017-11-09 10:31:49.722346-05	\N	3	92
364	SUBMITTED	2017-11-09 10:31:49.726249-05	\N	3	92
365	APPROVED_ORG	2017-11-09 10:31:49.730312-05	\N	3	92
366	APPROVED	2017-11-09 10:31:49.734262-05	\N	3	92
367	CREATED	2017-11-09 10:31:49.792847-05	\N	1	93
368	SUBMITTED	2017-11-09 10:31:49.796808-05	\N	1	93
369	APPROVED_ORG	2017-11-09 10:31:49.800627-05	\N	1	93
370	APPROVED	2017-11-09 10:31:49.804385-05	\N	1	93
371	CREATED	2017-11-09 10:31:49.87419-05	\N	1	94
372	SUBMITTED	2017-11-09 10:31:49.878132-05	\N	1	94
373	APPROVED_ORG	2017-11-09 10:31:49.881962-05	\N	1	94
374	APPROVED	2017-11-09 10:31:49.885833-05	\N	1	94
375	CREATED	2017-11-09 10:31:49.95162-05	\N	5	95
376	SUBMITTED	2017-11-09 10:31:49.955341-05	\N	5	95
377	APPROVED_ORG	2017-11-09 10:31:49.959227-05	\N	5	95
378	APPROVED	2017-11-09 10:31:49.963031-05	\N	5	95
379	CREATED	2017-11-09 10:31:50.028228-05	\N	5	96
380	SUBMITTED	2017-11-09 10:31:50.031842-05	\N	5	96
381	APPROVED_ORG	2017-11-09 10:31:50.035499-05	\N	5	96
382	APPROVED	2017-11-09 10:31:50.039105-05	\N	5	96
383	CREATED	2017-11-09 10:31:50.104754-05	\N	5	97
384	SUBMITTED	2017-11-09 10:31:50.10836-05	\N	5	97
385	APPROVED_ORG	2017-11-09 10:31:50.111955-05	\N	5	97
386	APPROVED	2017-11-09 10:31:50.115677-05	\N	5	97
387	CREATED	2017-11-09 10:31:50.169997-05	\N	4	98
388	SUBMITTED	2017-11-09 10:31:50.173568-05	\N	4	98
389	APPROVED_ORG	2017-11-09 10:31:50.176984-05	\N	4	98
390	APPROVED	2017-11-09 10:31:50.180474-05	\N	4	98
391	CREATED	2017-11-09 10:31:50.213301-05	\N	15	99
392	SUBMITTED	2017-11-09 10:31:50.217108-05	\N	15	99
393	APPROVED_ORG	2017-11-09 10:31:50.220813-05	\N	1	99
394	APPROVED	2017-11-09 10:31:50.224788-05	\N	1	99
395	CREATED	2017-11-09 10:31:50.308803-05	\N	17	100
396	SUBMITTED	2017-11-09 10:31:50.312925-05	\N	17	100
397	APPROVED_ORG	2017-11-09 10:31:50.317307-05	\N	1	100
398	APPROVED	2017-11-09 10:31:50.321697-05	\N	1	100
399	CREATED	2017-11-09 10:31:50.3459-05	\N	4	101
400	SUBMITTED	2017-11-09 10:31:50.349522-05	\N	4	101
401	APPROVED_ORG	2017-11-09 10:31:50.353053-05	\N	4	101
402	APPROVED	2017-11-09 10:31:50.356549-05	\N	4	101
403	CREATED	2017-11-09 10:31:50.41757-05	\N	15	102
404	SUBMITTED	2017-11-09 10:31:50.420916-05	\N	15	102
405	APPROVED_ORG	2017-11-09 10:31:50.424391-05	\N	1	102
406	APPROVED	2017-11-09 10:31:50.427721-05	\N	1	102
407	CREATED	2017-11-09 10:31:50.483869-05	\N	4	103
408	SUBMITTED	2017-11-09 10:31:50.487248-05	\N	4	103
409	APPROVED_ORG	2017-11-09 10:31:50.490762-05	\N	4	103
410	APPROVED	2017-11-09 10:31:50.494129-05	\N	4	103
411	CREATED	2017-11-09 10:31:50.527791-05	\N	4	104
412	SUBMITTED	2017-11-09 10:31:50.531118-05	\N	4	104
413	APPROVED_ORG	2017-11-09 10:31:50.534595-05	\N	4	104
414	APPROVED	2017-11-09 10:31:50.538088-05	\N	4	104
415	CREATED	2017-11-09 10:31:50.604987-05	\N	9	105
416	SUBMITTED	2017-11-09 10:31:50.608286-05	\N	9	105
417	APPROVED_ORG	2017-11-09 10:31:50.611582-05	\N	4	105
418	APPROVED	2017-11-09 10:31:50.614771-05	\N	4	105
419	CREATED	2017-11-09 10:31:50.654206-05	\N	4	106
420	SUBMITTED	2017-11-09 10:31:50.657513-05	\N	4	106
421	APPROVED_ORG	2017-11-09 10:31:50.66084-05	\N	4	106
422	APPROVED	2017-11-09 10:31:50.664105-05	\N	4	106
423	CREATED	2017-11-09 10:31:50.724712-05	\N	4	107
424	SUBMITTED	2017-11-09 10:31:50.728245-05	\N	4	107
425	APPROVED_ORG	2017-11-09 10:31:50.731871-05	\N	4	107
426	APPROVED	2017-11-09 10:31:50.735552-05	\N	4	107
427	CREATED	2017-11-09 10:31:50.800853-05	\N	1	108
428	SUBMITTED	2017-11-09 10:31:50.804088-05	\N	1	108
429	APPROVED_ORG	2017-11-09 10:31:50.807485-05	\N	1	108
430	APPROVED	2017-11-09 10:31:50.810726-05	\N	1	108
431	CREATED	2017-11-09 10:31:50.850902-05	\N	13	109
432	SUBMITTED	2017-11-09 10:31:50.8541-05	\N	13	109
433	APPROVED_ORG	2017-11-09 10:31:50.857387-05	\N	4	109
434	APPROVED	2017-11-09 10:31:50.860611-05	\N	4	109
435	CREATED	2017-11-09 10:31:50.919497-05	\N	4	110
436	SUBMITTED	2017-11-09 10:31:50.922707-05	\N	4	110
437	APPROVED_ORG	2017-11-09 10:31:50.925932-05	\N	4	110
438	APPROVED	2017-11-09 10:31:50.929098-05	\N	4	110
439	CREATED	2017-11-09 10:31:51.001802-05	\N	4	111
440	SUBMITTED	2017-11-09 10:31:51.004996-05	\N	4	111
441	APPROVED_ORG	2017-11-09 10:31:51.008272-05	\N	4	111
442	APPROVED	2017-11-09 10:31:51.012001-05	\N	4	111
443	CREATED	2017-11-09 10:31:51.070826-05	\N	15	112
444	SUBMITTED	2017-11-09 10:31:51.074101-05	\N	15	112
445	APPROVED_ORG	2017-11-09 10:31:51.077513-05	\N	7	112
446	APPROVED	2017-11-09 10:31:51.080817-05	\N	1	112
447	CREATED	2017-11-09 10:31:51.146832-05	\N	4	113
448	SUBMITTED	2017-11-09 10:31:51.152123-05	\N	4	113
449	APPROVED_ORG	2017-11-09 10:31:51.15737-05	\N	4	113
450	APPROVED	2017-11-09 10:31:51.16246-05	\N	4	113
451	CREATED	2017-11-09 10:31:51.313311-05	\N	4	114
452	SUBMITTED	2017-11-09 10:31:51.317058-05	\N	4	114
453	APPROVED_ORG	2017-11-09 10:31:51.320648-05	\N	4	114
454	APPROVED	2017-11-09 10:31:51.324246-05	\N	4	114
455	CREATED	2017-11-09 10:31:51.606079-05	\N	4	115
456	SUBMITTED	2017-11-09 10:31:51.61071-05	\N	4	115
457	APPROVED_ORG	2017-11-09 10:31:51.614775-05	\N	4	115
458	APPROVED	2017-11-09 10:31:51.618863-05	\N	4	115
459	CREATED	2017-11-09 10:31:51.705851-05	\N	15	116
460	SUBMITTED	2017-11-09 10:31:51.70965-05	\N	15	116
461	APPROVED_ORG	2017-11-09 10:31:51.713838-05	\N	1	116
462	APPROVED	2017-11-09 10:31:51.717947-05	\N	1	116
463	CREATED	2017-11-09 10:31:51.816754-05	\N	15	117
464	SUBMITTED	2017-11-09 10:31:51.821544-05	\N	15	117
465	APPROVED_ORG	2017-11-09 10:31:51.826299-05	\N	1	117
466	APPROVED	2017-11-09 10:31:51.831257-05	\N	1	117
467	CREATED	2017-11-09 10:31:51.923749-05	\N	12	118
468	SUBMITTED	2017-11-09 10:31:51.928819-05	\N	12	118
469	APPROVED_ORG	2017-11-09 10:31:51.934035-05	\N	1	118
470	APPROVED	2017-11-09 10:31:51.939263-05	\N	1	118
471	CREATED	2017-11-09 10:31:52.006423-05	\N	1	119
472	SUBMITTED	2017-11-09 10:31:52.010844-05	\N	1	119
473	APPROVED_ORG	2017-11-09 10:31:52.015392-05	\N	1	119
474	APPROVED	2017-11-09 10:31:52.019781-05	\N	1	119
475	CREATED	2017-11-09 10:31:52.097993-05	\N	1	120
476	SUBMITTED	2017-11-09 10:31:52.102086-05	\N	1	120
477	APPROVED_ORG	2017-11-09 10:31:52.106327-05	\N	1	120
478	APPROVED	2017-11-09 10:31:52.110276-05	\N	1	120
479	CREATED	2017-11-09 10:31:52.188477-05	\N	1	121
480	SUBMITTED	2017-11-09 10:31:52.192327-05	\N	1	121
481	APPROVED_ORG	2017-11-09 10:31:52.196109-05	\N	1	121
482	APPROVED	2017-11-09 10:31:52.201079-05	\N	1	121
483	CREATED	2017-11-09 10:31:52.24995-05	\N	13	122
484	SUBMITTED	2017-11-09 10:31:52.254369-05	\N	13	122
485	APPROVED_ORG	2017-11-09 10:31:52.258693-05	\N	4	122
486	APPROVED	2017-11-09 10:31:52.26295-05	\N	4	122
487	CREATED	2017-11-09 10:31:52.288726-05	\N	4	123
488	SUBMITTED	2017-11-09 10:31:52.293017-05	\N	4	123
489	APPROVED_ORG	2017-11-09 10:31:52.297836-05	\N	4	123
490	APPROVED	2017-11-09 10:31:52.302171-05	\N	4	123
491	CREATED	2017-11-09 10:31:52.576056-05	\N	1	124
492	SUBMITTED	2017-11-09 10:31:52.580322-05	\N	1	124
493	APPROVED_ORG	2017-11-09 10:31:52.584602-05	\N	1	124
494	APPROVED	2017-11-09 10:31:52.588945-05	\N	1	124
495	CREATED	2017-11-09 10:31:52.655427-05	\N	4	125
496	SUBMITTED	2017-11-09 10:31:52.65927-05	\N	4	125
497	APPROVED_ORG	2017-11-09 10:31:52.663422-05	\N	4	125
498	APPROVED	2017-11-09 10:31:52.667377-05	\N	4	125
499	CREATED	2017-11-09 10:31:52.744384-05	\N	4	126
500	SUBMITTED	2017-11-09 10:31:52.748847-05	\N	4	126
501	APPROVED_ORG	2017-11-09 10:31:52.753157-05	\N	4	126
502	APPROVED	2017-11-09 10:31:52.757616-05	\N	4	126
503	CREATED	2017-11-09 10:31:52.826709-05	\N	1	127
504	SUBMITTED	2017-11-09 10:31:52.831067-05	\N	1	127
505	APPROVED_ORG	2017-11-09 10:31:52.835499-05	\N	1	127
506	APPROVED	2017-11-09 10:31:52.839843-05	\N	1	127
507	CREATED	2017-11-09 10:31:52.865672-05	\N	12	128
508	SUBMITTED	2017-11-09 10:31:52.87014-05	\N	12	128
509	APPROVED_ORG	2017-11-09 10:31:52.875036-05	\N	1	128
510	APPROVED	2017-11-09 10:31:52.879745-05	\N	1	128
511	CREATED	2017-11-09 10:31:52.962474-05	\N	3	129
512	SUBMITTED	2017-11-09 10:31:52.967043-05	\N	3	129
513	APPROVED_ORG	2017-11-09 10:31:52.971656-05	\N	3	129
514	APPROVED	2017-11-09 10:31:52.975928-05	\N	3	129
515	CREATED	2017-11-09 10:31:53.070621-05	\N	15	130
516	SUBMITTED	2017-11-09 10:31:53.074479-05	\N	15	130
517	APPROVED_ORG	2017-11-09 10:31:53.078267-05	\N	1	130
518	SUBMITTED	2017-11-09 10:31:53.082006-05	\N	15	130
519	CREATED	2017-11-09 10:31:53.130166-05	\N	4	131
520	SUBMITTED	2017-11-09 10:31:53.133726-05	\N	4	131
521	APPROVED_ORG	2017-11-09 10:31:53.137298-05	\N	4	131
522	APPROVED	2017-11-09 10:31:53.140795-05	\N	4	131
523	CREATED	2017-11-09 10:31:53.274261-05	\N	4	132
524	SUBMITTED	2017-11-09 10:31:53.278555-05	\N	4	132
525	APPROVED_ORG	2017-11-09 10:31:53.283033-05	\N	4	132
526	APPROVED	2017-11-09 10:31:53.287602-05	\N	4	132
527	CREATED	2017-11-09 10:31:53.609195-05	\N	5	133
528	SUBMITTED	2017-11-09 10:31:53.61342-05	\N	5	133
529	APPROVED_ORG	2017-11-09 10:31:53.617343-05	\N	1	133
530	APPROVED	2017-11-09 10:31:53.621344-05	\N	1	133
531	CREATED	2017-11-09 10:31:53.817966-05	\N	15	134
532	SUBMITTED	2017-11-09 10:31:53.822807-05	\N	15	134
533	APPROVED_ORG	2017-11-09 10:31:53.8276-05	\N	7	134
534	APPROVED	2017-11-09 10:31:53.832158-05	\N	1	134
535	CREATED	2017-11-09 10:31:53.862998-05	\N	17	135
536	SUBMITTED	2017-11-09 10:31:53.867035-05	\N	17	135
537	APPROVED_ORG	2017-11-09 10:31:53.871074-05	\N	1	135
538	APPROVED	2017-11-09 10:31:53.875127-05	\N	1	135
539	CREATED	2017-11-09 10:31:53.943292-05	\N	3	136
540	SUBMITTED	2017-11-09 10:31:53.946721-05	\N	3	136
541	APPROVED_ORG	2017-11-09 10:31:53.950282-05	\N	3	136
542	APPROVED	2017-11-09 10:31:53.953754-05	\N	3	136
543	CREATED	2017-11-09 10:31:54.079404-05	\N	3	137
544	SUBMITTED	2017-11-09 10:31:54.082593-05	\N	3	137
545	APPROVED_ORG	2017-11-09 10:31:54.085691-05	\N	3	137
546	APPROVED	2017-11-09 10:31:54.088693-05	\N	3	137
547	CREATED	2017-11-09 10:31:54.354182-05	\N	3	138
548	SUBMITTED	2017-11-09 10:31:54.358259-05	\N	3	138
549	APPROVED_ORG	2017-11-09 10:31:54.3622-05	\N	3	138
550	APPROVED	2017-11-09 10:31:54.365978-05	\N	3	138
551	CREATED	2017-11-09 10:31:54.442189-05	\N	15	139
552	SUBMITTED	2017-11-09 10:31:54.445829-05	\N	15	139
553	APPROVED_ORG	2017-11-09 10:31:54.449532-05	\N	1	139
554	APPROVED	2017-11-09 10:31:54.453249-05	\N	1	139
555	CREATED	2017-11-09 10:31:54.476766-05	\N	4	140
556	SUBMITTED	2017-11-09 10:31:54.480955-05	\N	4	140
557	APPROVED_ORG	2017-11-09 10:31:54.484867-05	\N	4	140
558	APPROVED	2017-11-09 10:31:54.488728-05	\N	4	140
559	CREATED	2017-11-09 10:31:54.719492-05	\N	4	141
560	SUBMITTED	2017-11-09 10:31:54.723121-05	\N	4	141
561	APPROVED_ORG	2017-11-09 10:31:54.726641-05	\N	4	141
562	APPROVED	2017-11-09 10:31:54.730483-05	\N	4	141
563	CREATED	2017-11-09 10:31:54.883827-05	\N	1	142
564	SUBMITTED	2017-11-09 10:31:54.887837-05	\N	1	142
565	APPROVED_ORG	2017-11-09 10:31:54.891677-05	\N	1	142
566	APPROVED	2017-11-09 10:31:54.895555-05	\N	1	142
567	CREATED	2017-11-09 10:31:54.97222-05	\N	13	143
568	SUBMITTED	2017-11-09 10:31:54.977799-05	\N	13	143
569	APPROVED_ORG	2017-11-09 10:31:54.983403-05	\N	4	143
570	APPROVED	2017-11-09 10:31:54.988889-05	\N	4	143
571	CREATED	2017-11-09 10:31:56.114116-05	\N	4	144
572	SUBMITTED	2017-11-09 10:31:56.11842-05	\N	4	144
573	APPROVED_ORG	2017-11-09 10:31:56.122712-05	\N	4	144
574	SUBMITTED	2017-11-09 10:31:56.126969-05	\N	4	144
575	CREATED	2017-11-09 10:31:56.197402-05	\N	3	145
576	SUBMITTED	2017-11-09 10:31:56.201513-05	\N	3	145
577	APPROVED_ORG	2017-11-09 10:31:56.205587-05	\N	3	145
578	APPROVED	2017-11-09 10:31:56.209803-05	\N	3	145
579	CREATED	2017-11-09 10:31:56.308639-05	\N	15	146
580	SUBMITTED	2017-11-09 10:31:56.312939-05	\N	15	146
581	APPROVED_ORG	2017-11-09 10:31:56.317425-05	\N	1	146
582	APPROVED	2017-11-09 10:31:56.322221-05	\N	1	146
583	CREATED	2017-11-09 10:31:56.433914-05	\N	12	147
584	SUBMITTED	2017-11-09 10:31:56.438346-05	\N	12	147
585	APPROVED_ORG	2017-11-09 10:31:56.442875-05	\N	1	147
586	APPROVED	2017-11-09 10:31:56.447248-05	\N	1	147
587	CREATED	2017-11-09 10:31:56.504499-05	\N	13	148
588	SUBMITTED	2017-11-09 10:31:56.508764-05	\N	13	148
589	APPROVED_ORG	2017-11-09 10:31:56.512868-05	\N	1	148
590	APPROVED	2017-11-09 10:31:56.517156-05	\N	1	148
591	CREATED	2017-11-09 10:31:56.56966-05	\N	1	149
592	SUBMITTED	2017-11-09 10:31:56.573629-05	\N	1	149
593	APPROVED_ORG	2017-11-09 10:31:56.577498-05	\N	1	149
594	APPROVED	2017-11-09 10:31:56.581432-05	\N	1	149
595	CREATED	2017-11-09 10:31:56.670356-05	\N	15	150
596	SUBMITTED	2017-11-09 10:31:56.67419-05	\N	15	150
597	APPROVED_ORG	2017-11-09 10:31:56.678027-05	\N	1	150
598	APPROVED	2017-11-09 10:31:56.681947-05	\N	1	150
599	CREATED	2017-11-09 10:31:56.736275-05	\N	4	151
600	SUBMITTED	2017-11-09 10:31:56.739903-05	\N	4	151
601	APPROVED_ORG	2017-11-09 10:31:56.743508-05	\N	4	151
602	APPROVED	2017-11-09 10:31:56.747093-05	\N	4	151
603	CREATED	2017-11-09 10:31:56.814882-05	\N	5	152
604	SUBMITTED	2017-11-09 10:31:56.818717-05	\N	5	152
605	APPROVED_ORG	2017-11-09 10:31:56.822625-05	\N	5	152
606	APPROVED	2017-11-09 10:31:56.826478-05	\N	5	152
607	CREATED	2017-11-09 10:31:56.929979-05	\N	1	153
608	SUBMITTED	2017-11-09 10:31:56.93499-05	\N	1	153
609	APPROVED_ORG	2017-11-09 10:31:56.939777-05	\N	1	153
610	APPROVED	2017-11-09 10:31:56.944791-05	\N	1	153
611	CREATED	2017-11-09 10:31:56.98538-05	\N	9	154
612	SUBMITTED	2017-11-09 10:31:56.989852-05	\N	9	154
613	APPROVED_ORG	2017-11-09 10:31:56.99427-05	\N	4	154
614	APPROVED	2017-11-09 10:31:56.998696-05	\N	4	154
615	CREATED	2017-11-09 10:31:57.113629-05	\N	4	155
616	SUBMITTED	2017-11-09 10:31:57.117989-05	\N	4	155
617	APPROVED_ORG	2017-11-09 10:31:57.122335-05	\N	4	155
618	APPROVED	2017-11-09 10:31:57.126546-05	\N	4	155
619	CREATED	2017-11-09 10:31:57.198398-05	\N	1	156
620	SUBMITTED	2017-11-09 10:31:57.202839-05	\N	1	156
621	APPROVED_ORG	2017-11-09 10:31:57.207154-05	\N	1	156
622	APPROVED	2017-11-09 10:31:57.211733-05	\N	1	156
623	CREATED	2017-11-09 10:31:57.249449-05	\N	13	157
624	SUBMITTED	2017-11-09 10:31:57.25406-05	\N	13	157
625	CREATED	2017-11-09 10:31:57.310113-05	\N	4	158
626	SUBMITTED	2017-11-09 10:31:57.314321-05	\N	4	158
627	APPROVED_ORG	2017-11-09 10:31:57.318525-05	\N	4	158
628	APPROVED	2017-11-09 10:31:57.322942-05	\N	4	158
629	CREATED	2017-11-09 10:31:57.374605-05	\N	4	159
630	SUBMITTED	2017-11-09 10:31:57.378427-05	\N	4	159
631	APPROVED_ORG	2017-11-09 10:31:57.382289-05	\N	4	159
632	APPROVED	2017-11-09 10:31:57.386234-05	\N	4	159
633	CREATED	2017-11-09 10:31:57.430884-05	\N	13	160
634	SUBMITTED	2017-11-09 10:31:57.435194-05	\N	13	160
635	APPROVED_ORG	2017-11-09 10:31:57.43957-05	\N	4	160
636	APPROVED	2017-11-09 10:31:57.444196-05	\N	4	160
637	CREATED	2017-11-09 10:31:57.526903-05	\N	4	161
638	SUBMITTED	2017-11-09 10:31:57.531319-05	\N	4	161
639	APPROVED_ORG	2017-11-09 10:31:57.535937-05	\N	4	161
640	APPROVED	2017-11-09 10:31:57.540399-05	\N	4	161
641	CREATED	2017-11-09 10:31:57.614917-05	\N	12	162
642	SUBMITTED	2017-11-09 10:31:57.619648-05	\N	12	162
643	APPROVED_ORG	2017-11-09 10:31:57.624355-05	\N	1	162
644	APPROVED	2017-11-09 10:31:57.629288-05	\N	1	162
645	CREATED	2017-11-09 10:31:57.703251-05	\N	4	163
646	SUBMITTED	2017-11-09 10:31:57.707421-05	\N	4	163
647	APPROVED_ORG	2017-11-09 10:31:57.711558-05	\N	4	163
648	APPROVED	2017-11-09 10:31:57.715954-05	\N	4	163
649	CREATED	2017-11-09 10:31:57.8172-05	\N	4	164
650	SUBMITTED	2017-11-09 10:31:57.821679-05	\N	4	164
651	APPROVED_ORG	2017-11-09 10:31:57.826268-05	\N	4	164
652	APPROVED	2017-11-09 10:31:57.830788-05	\N	4	164
653	CREATED	2017-11-09 10:31:57.939823-05	\N	1	165
654	SUBMITTED	2017-11-09 10:31:57.945857-05	\N	1	165
655	APPROVED_ORG	2017-11-09 10:31:57.9521-05	\N	1	165
656	APPROVED	2017-11-09 10:31:57.957868-05	\N	1	165
657	CREATED	2017-11-09 10:31:58.042504-05	\N	4	166
658	SUBMITTED	2017-11-09 10:31:58.047463-05	\N	4	166
659	APPROVED_ORG	2017-11-09 10:31:58.052379-05	\N	4	166
660	APPROVED	2017-11-09 10:31:58.057073-05	\N	4	166
661	CREATED	2017-11-09 10:31:58.130616-05	\N	4	167
662	SUBMITTED	2017-11-09 10:31:58.134941-05	\N	4	167
663	APPROVED_ORG	2017-11-09 10:31:58.139339-05	\N	4	167
664	APPROVED	2017-11-09 10:31:58.143995-05	\N	4	167
665	CREATED	2017-11-09 10:31:58.210957-05	\N	4	168
666	SUBMITTED	2017-11-09 10:31:58.21528-05	\N	4	168
667	APPROVED_ORG	2017-11-09 10:31:58.219867-05	\N	4	168
668	APPROVED	2017-11-09 10:31:58.224214-05	\N	4	168
669	CREATED	2017-11-09 10:31:58.334231-05	\N	1	169
670	SUBMITTED	2017-11-09 10:31:58.338498-05	\N	1	169
671	APPROVED_ORG	2017-11-09 10:31:58.342983-05	\N	1	169
672	APPROVED	2017-11-09 10:31:58.347359-05	\N	1	169
673	CREATED	2017-11-09 10:31:58.465397-05	\N	4	170
674	SUBMITTED	2017-11-09 10:31:58.469642-05	\N	4	170
675	APPROVED_ORG	2017-11-09 10:31:58.473915-05	\N	4	170
676	APPROVED	2017-11-09 10:31:58.478282-05	\N	4	170
677	CREATED	2017-11-09 10:31:58.571815-05	\N	15	171
678	SUBMITTED	2017-11-09 10:31:58.575902-05	\N	15	171
679	APPROVED_ORG	2017-11-09 10:31:58.580198-05	\N	1	171
680	APPROVED	2017-11-09 10:31:58.584477-05	\N	1	171
681	CREATED	2017-11-09 10:31:58.626998-05	\N	4	172
682	SUBMITTED	2017-11-09 10:31:58.632038-05	\N	4	172
683	APPROVED_ORG	2017-11-09 10:31:58.636367-05	\N	4	172
684	APPROVED	2017-11-09 10:31:58.640931-05	\N	4	172
685	CREATED	2017-11-09 10:31:58.722209-05	\N	12	173
686	SUBMITTED	2017-11-09 10:31:58.727114-05	\N	12	173
687	APPROVED_ORG	2017-11-09 10:31:58.732107-05	\N	1	173
688	APPROVED	2017-11-09 10:31:58.736857-05	\N	1	173
689	CREATED	2017-11-09 10:31:58.770039-05	\N	12	174
690	SUBMITTED	2017-11-09 10:31:58.775147-05	\N	12	174
691	APPROVED_ORG	2017-11-09 10:31:58.78033-05	\N	1	174
692	APPROVED	2017-11-09 10:31:58.785321-05	\N	1	174
693	CREATED	2017-11-09 10:31:58.953113-05	\N	1	175
694	SUBMITTED	2017-11-09 10:31:58.957642-05	\N	1	175
695	APPROVED_ORG	2017-11-09 10:31:58.961983-05	\N	1	175
696	APPROVED	2017-11-09 10:31:58.966333-05	\N	1	175
697	CREATED	2017-11-09 10:31:59.465287-05	\N	4	176
698	SUBMITTED	2017-11-09 10:31:59.469703-05	\N	4	176
699	APPROVED_ORG	2017-11-09 10:31:59.473918-05	\N	4	176
700	CREATED	2017-11-09 10:31:59.501214-05	\N	13	177
701	SUBMITTED	2017-11-09 10:31:59.505234-05	\N	13	177
702	CREATED	2017-11-09 10:31:59.582987-05	\N	9	178
703	SUBMITTED	2017-11-09 10:31:59.586877-05	\N	9	178
704	APPROVED_ORG	2017-11-09 10:31:59.590784-05	\N	4	178
705	APPROVED	2017-11-09 10:31:59.594701-05	\N	4	178
706	CREATED	2017-11-09 10:31:59.677171-05	\N	4	179
707	SUBMITTED	2017-11-09 10:31:59.681278-05	\N	4	179
708	CREATED	2017-11-09 10:31:59.760406-05	\N	1	180
709	SUBMITTED	2017-11-09 10:31:59.76437-05	\N	1	180
710	APPROVED_ORG	2017-11-09 10:31:59.768376-05	\N	1	180
711	APPROVED	2017-11-09 10:31:59.772209-05	\N	1	180
712	CREATED	2017-11-09 10:31:59.8525-05	\N	4	181
713	SUBMITTED	2017-11-09 10:31:59.856332-05	\N	4	181
714	APPROVED_ORG	2017-11-09 10:31:59.86065-05	\N	4	181
715	APPROVED	2017-11-09 10:31:59.864556-05	\N	4	181
716	CREATED	2017-11-09 10:32:00.112249-05	\N	4	182
717	SUBMITTED	2017-11-09 10:32:00.116404-05	\N	4	182
718	APPROVED_ORG	2017-11-09 10:32:00.120373-05	\N	4	182
719	APPROVED	2017-11-09 10:32:00.124458-05	\N	4	182
720	CREATED	2017-11-09 10:32:00.771469-05	\N	4	183
721	SUBMITTED	2017-11-09 10:32:00.775718-05	\N	4	183
722	CREATED	2017-11-09 10:32:00.822668-05	\N	13	184
723	SUBMITTED	2017-11-09 10:32:00.826922-05	\N	13	184
724	CREATED	2017-11-09 10:32:00.876866-05	\N	13	185
725	SUBMITTED	2017-11-09 10:32:00.880587-05	\N	13	185
726	CREATED	2017-11-09 10:32:01.040311-05	\N	1	186
727	SUBMITTED	2017-11-09 10:32:01.045123-05	\N	1	186
728	APPROVED_ORG	2017-11-09 10:32:01.050092-05	\N	1	186
729	APPROVED	2017-11-09 10:32:01.055207-05	\N	1	186
730	CREATED	2017-11-09 10:32:01.096369-05	\N	17	187
731	SUBMITTED	2017-11-09 10:32:01.101148-05	\N	17	187
732	APPROVED_ORG	2017-11-09 10:32:01.107551-05	\N	1	187
733	APPROVED	2017-11-09 10:32:01.115299-05	\N	1	187
734	CREATED	2017-11-09 10:32:01.20191-05	\N	1	188
735	SUBMITTED	2017-11-09 10:32:01.207694-05	\N	1	188
736	APPROVED_ORG	2017-11-09 10:32:01.213366-05	\N	1	188
737	APPROVED	2017-11-09 10:32:01.219296-05	\N	1	188
\.


--
-- Name: ozpcenter_listingactivity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_listingactivity_id_seq', 737, true);


--
-- Data for Name: ozpcenter_listingtype; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_listingtype (id, title, description) FROM stdin;
1	Code Library	code library
2	Desktop App	desktop app
3	Web Application	web applications
4	Web Services	web services
5	Widget	widget things
\.


--
-- Name: ozpcenter_listingtype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_listingtype_id_seq', 5, true);


--
-- Data for Name: ozpcenter_notification; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_notification (id, created_date, message, expires_date, author_id, listing_id, agency_id, peer, group_target, notification_type, entity_id, notification_subtype) FROM stdin;
1	2017-11-09 10:31:33.910918-05	System will be going down for approximately 30 minutes on X/Y at 1100Z	2017-11-16 15:31:33.890575-05	5	\N	\N	\N	all	system	\N	\N
2	2017-11-09 10:31:33.928546-05	System will be functioning in a degredaded state between 1800Z-0400Z on A/B	2017-11-16 15:31:33.890575-05	6	\N	\N	\N	all	system	\N	\N
3	2017-11-09 10:31:33.94467-05	System will be going down for approximately 30 minutes on C/D at 1700Z	2017-11-02 15:31:33.942025-04	5	\N	\N	\N	all	system	\N	\N
4	2017-11-09 10:31:33.959442-05	System will be functioning in a degredaded state between 2100Z-0430Z on F/G	2017-11-02 15:31:33.942025-04	6	\N	\N	\N	all	system	\N	\N
5	2017-11-09 10:32:01.384637-05	A user has rated listing <b>Acoustic Guitar</b> 3 stars	2017-12-09 10:32:01.37996-05	1	1	\N	\N	user	listing	1	listing_review
6	2017-11-09 10:32:01.430245-05	A user has rated listing <b>Acoustic Guitar</b> 1 star	2017-12-09 10:32:01.425528-05	5	1	\N	\N	user	listing	1	listing_review
7	2017-11-09 10:32:01.474082-05	A user has rated listing <b>Acoustic Guitar</b> 5 stars	2017-12-09 10:32:01.469491-05	17	1	\N	\N	user	listing	1	listing_review
8	2017-11-09 10:32:01.518534-05	A user has rated listing <b>Air Mail</b> 5 stars	2017-12-09 10:32:01.513918-05	21	2	\N	\N	user	listing	2	listing_review
9	2017-11-09 10:32:01.562869-05	A user has rated listing <b>Air Mail</b> 3 stars	2017-12-09 10:32:01.558275-05	19	2	\N	\N	user	listing	2	listing_review
10	2017-11-09 10:32:01.606253-05	A user has rated listing <b>Air Mail</b> 1 star	2017-12-09 10:32:01.601723-05	17	2	\N	\N	user	listing	2	listing_review
11	2017-11-09 10:32:01.648574-05	A user has rated listing <b>Air Mail</b> 4 stars	2017-12-09 10:32:01.644272-05	3	2	\N	\N	user	listing	2	listing_review
12	2017-11-09 10:32:01.689221-05	A user has rated listing <b>Aliens</b> 5 stars	2017-12-09 10:32:01.685157-05	9	4	\N	\N	user	listing	4	listing_review
13	2017-11-09 10:32:01.727112-05	A user has rated listing <b>Aliens</b> 1 star	2017-12-09 10:32:01.723134-05	17	4	\N	\N	user	listing	4	listing_review
14	2017-11-09 10:32:01.762836-05	A user has rated listing <b>Aliens</b> 4 stars	2017-12-09 10:32:01.759253-05	13	4	\N	\N	user	listing	4	listing_review
15	2017-11-09 10:32:01.797818-05	A user has rated listing <b>Apocalypse</b> 1 star	2017-12-09 10:32:01.793936-05	17	6	\N	\N	user	listing	6	listing_review
16	2017-11-09 10:32:01.832322-05	A user has rated listing <b>Astrology software</b> 5 stars	2017-12-09 10:32:01.828656-05	15	8	\N	\N	user	listing	8	listing_review
17	2017-11-09 10:32:01.865968-05	A user has rated listing <b>Azeroth</b> 5 stars	2017-12-09 10:32:01.862384-05	12	9	\N	\N	user	listing	9	listing_review
18	2017-11-09 10:32:01.900279-05	A user has rated listing <b>Azeroth</b> 5 stars	2017-12-09 10:32:01.896784-05	17	9	\N	\N	user	listing	9	listing_review
19	2017-11-09 10:32:01.935049-05	A user has rated listing <b>Azeroth</b> 3 stars	2017-12-09 10:32:01.931501-05	5	9	\N	\N	user	listing	9	listing_review
20	2017-11-09 10:32:01.970447-05	A user has rated listing <b>Azeroth</b> 3 stars	2017-12-09 10:32:01.966766-05	3	9	\N	\N	user	listing	9	listing_review
21	2017-11-09 10:32:02.005229-05	A user has rated listing <b>Azeroth</b> 5 stars	2017-12-09 10:32:02.001775-05	4	9	\N	\N	user	listing	9	listing_review
22	2017-11-09 10:32:02.039037-05	A user has rated listing <b>Baltimore Ravens</b> 5 stars	2017-12-09 10:32:02.03556-05	4	10	\N	\N	user	listing	10	listing_review
23	2017-11-09 10:32:02.073047-05	A user has rated listing <b>Barbecue</b> 5 stars	2017-12-09 10:32:02.06963-05	3	11	\N	\N	user	listing	11	listing_review
24	2017-11-09 10:32:02.105945-05	A user has rated listing <b>Barsoom</b> 5 stars	2017-12-09 10:32:02.102565-05	12	12	\N	\N	user	listing	12	listing_review
25	2017-11-09 10:32:02.137824-05	A user has rated listing <b>Barsoom</b> 3 stars	2017-12-09 10:32:02.134387-05	17	12	\N	\N	user	listing	12	listing_review
26	2017-11-09 10:32:02.169638-05	A user has rated listing <b>Barsoom</b> 5 stars	2017-12-09 10:32:02.166213-05	4	12	\N	\N	user	listing	12	listing_review
27	2017-11-09 10:32:02.20061-05	A user has rated listing <b>Basketball</b> 2 stars	2017-12-09 10:32:02.197127-05	9	13	\N	\N	user	listing	13	listing_review
28	2017-11-09 10:32:02.230312-05	A user has rated listing <b>Basketball</b> 5 stars	2017-12-09 10:32:02.227277-05	17	13	\N	\N	user	listing	13	listing_review
29	2017-11-09 10:32:02.259559-05	A user has rated listing <b>Bass Fishing</b> 4 stars	2017-12-09 10:32:02.256487-05	13	14	\N	\N	user	listing	14	listing_review
30	2017-11-09 10:32:02.290267-05	A user has rated listing <b>Beast</b> 5 stars	2017-12-09 10:32:02.286864-05	8	16	\N	\N	user	listing	16	listing_review
31	2017-11-09 10:32:02.320372-05	A user has rated listing <b>Beast</b> 3 stars	2017-12-09 10:32:02.317133-05	17	16	\N	\N	user	listing	16	listing_review
32	2017-11-09 10:32:02.350687-05	A user has rated listing <b>BeiDou Navigation Satellite System</b> 4 stars	2017-12-09 10:32:02.347443-05	1	17	\N	\N	user	listing	17	listing_review
33	2017-11-09 10:32:02.38104-05	A user has rated listing <b>BeiDou Navigation Satellite System</b> 3 stars	2017-12-09 10:32:02.377845-05	15	17	\N	\N	user	listing	17	listing_review
34	2017-11-09 10:32:02.411606-05	A user has rated listing <b>Bleach</b> 4 stars	2017-12-09 10:32:02.408376-05	15	18	\N	\N	user	listing	18	listing_review
35	2017-11-09 10:32:02.442105-05	A user has rated listing <b>Bleach</b> 5 stars	2017-12-09 10:32:02.43903-05	17	18	\N	\N	user	listing	18	listing_review
36	2017-11-09 10:32:02.472259-05	A user has rated listing <b>Blink</b> 5 stars	2017-12-09 10:32:02.469099-05	8	19	\N	\N	user	listing	19	listing_review
37	2017-11-09 10:32:02.500759-05	A user has rated listing <b>Blink</b> 5 stars	2017-12-09 10:32:02.497739-05	17	19	\N	\N	user	listing	19	listing_review
38	2017-11-09 10:32:02.530177-05	A user has rated listing <b>Blink</b> 1 star	2017-12-09 10:32:02.527096-05	12	19	\N	\N	user	listing	19	listing_review
39	2017-11-09 10:32:02.558663-05	A user has rated listing <b>Bread Basket</b> 2 stars	2017-12-09 10:32:02.555636-05	13	23	\N	\N	user	listing	23	listing_review
40	2017-11-09 10:32:02.588312-05	A user has rated listing <b>Bread Basket</b> 5 stars	2017-12-09 10:32:02.585215-05	6	23	\N	\N	user	listing	23	listing_review
41	2017-11-09 10:32:02.617644-05	A user has rated listing <b>Building</b> 4 stars	2017-12-09 10:32:02.614624-05	9	25	\N	\N	user	listing	25	listing_review
42	2017-11-09 10:32:02.645763-05	A user has rated listing <b>Building</b> 2 stars	2017-12-09 10:32:02.642794-05	17	25	\N	\N	user	listing	25	listing_review
43	2017-11-09 10:32:02.673577-05	A user has rated listing <b>Business Management System</b> 3 stars	2017-12-09 10:32:02.670701-05	1	27	\N	\N	user	listing	27	listing_review
44	2017-11-09 10:32:02.70142-05	A user has rated listing <b>Business Management System</b> 4 stars	2017-12-09 10:32:02.698549-05	4	27	\N	\N	user	listing	27	listing_review
45	2017-11-09 10:32:02.728403-05	A user has rated listing <b>Business Management System</b> 2 stars	2017-12-09 10:32:02.725564-05	17	27	\N	\N	user	listing	27	listing_review
46	2017-11-09 10:32:02.755285-05	A user has rated listing <b>Chart Course</b> 2 stars	2017-12-09 10:32:02.752508-05	5	30	\N	\N	user	listing	30	listing_review
47	2017-11-09 10:32:02.781778-05	A user has rated listing <b>Chart Course</b> 5 stars	2017-12-09 10:32:02.778981-05	1	30	\N	\N	user	listing	30	listing_review
48	2017-11-09 10:32:02.809705-05	A user has rated listing <b>Chasing Amy</b> 4 stars	2017-12-09 10:32:02.806871-05	15	31	\N	\N	user	listing	31	listing_review
49	2017-11-09 10:32:02.836998-05	A user has rated listing <b>Clerks</b> 3 stars	2017-12-09 10:32:02.834021-05	15	36	\N	\N	user	listing	36	listing_review
50	2017-11-09 10:32:02.864508-05	A user has rated listing <b>Clerks II</b> 3 stars	2017-12-09 10:32:02.861593-05	15	37	\N	\N	user	listing	37	listing_review
51	2017-11-09 10:32:02.891999-05	A user has rated listing <b>Cyclops</b> 1 star	2017-12-09 10:32:02.889126-05	17	41	\N	\N	user	listing	41	listing_review
52	2017-11-09 10:32:02.919084-05	A user has rated listing <b>Cyclops</b> 5 stars	2017-12-09 10:32:02.916178-05	12	41	\N	\N	user	listing	41	listing_review
53	2017-11-09 10:32:02.946479-05	A user has rated listing <b>Deadpool</b> 5 stars	2017-12-09 10:32:02.943379-05	4	42	\N	\N	user	listing	42	listing_review
54	2017-11-09 10:32:02.974842-05	A user has rated listing <b>Deadpool</b> 2 stars	2017-12-09 10:32:02.971771-05	17	42	\N	\N	user	listing	42	listing_review
55	2017-11-09 10:32:03.003215-05	A user has rated listing <b>Dinosaur</b> 1 star	2017-12-09 10:32:03.000214-05	9	45	\N	\N	user	listing	45	listing_review
56	2017-11-09 10:32:03.030781-05	A user has rated listing <b>Dinosaur</b> 5 stars	2017-12-09 10:32:03.027885-05	8	45	\N	\N	user	listing	45	listing_review
57	2017-11-09 10:32:03.058152-05	A user has rated listing <b>Dinosaur</b> 4 stars	2017-12-09 10:32:03.05524-05	3	45	\N	\N	user	listing	45	listing_review
58	2017-11-09 10:32:03.085382-05	A user has rated listing <b>Dragons</b> 5 stars	2017-12-09 10:32:03.082531-05	3	47	\N	\N	user	listing	47	listing_review
59	2017-11-09 10:32:03.112759-05	A user has rated listing <b>Fight Club</b> 3 stars	2017-12-09 10:32:03.109898-05	4	55	\N	\N	user	listing	55	listing_review
60	2017-11-09 10:32:03.140243-05	A user has rated listing <b>Floppy Disk</b> 3 stars	2017-12-09 10:32:03.137405-05	9	56	\N	\N	user	listing	56	listing_review
61	2017-11-09 10:32:03.166811-05	A user has rated listing <b>Floppy Disk</b> 5 stars	2017-12-09 10:32:03.16396-05	17	56	\N	\N	user	listing	56	listing_review
62	2017-11-09 10:32:03.192873-05	A user has rated listing <b>Floppy Disk</b> 3 stars	2017-12-09 10:32:03.190047-05	4	56	\N	\N	user	listing	56	listing_review
63	2017-11-09 10:32:03.21917-05	A user has rated listing <b>Floppy Disk</b> 2 stars	2017-12-09 10:32:03.216382-05	3	56	\N	\N	user	listing	56	listing_review
64	2017-11-09 10:32:03.245476-05	A user has rated listing <b>Gallery of Maps</b> 4 stars	2017-12-09 10:32:03.242683-05	17	59	\N	\N	user	listing	59	listing_review
65	2017-11-09 10:32:03.27397-05	A user has rated listing <b>Gallery of Maps</b> 3 stars	2017-12-09 10:32:03.270795-05	15	59	\N	\N	user	listing	59	listing_review
66	2017-11-09 10:32:03.302717-05	A user has rated listing <b>Global Navigation Grid Code</b> 5 stars	2017-12-09 10:32:03.299641-05	1	61	\N	\N	user	listing	61	listing_review
67	2017-11-09 10:32:03.331387-05	A user has rated listing <b>Global Navigation Grid Code</b> 5 stars	2017-12-09 10:32:03.328219-05	15	61	\N	\N	user	listing	61	listing_review
68	2017-11-09 10:32:03.361477-05	A user has rated listing <b>Great white shark</b> 5 stars	2017-12-09 10:32:03.35821-05	17	64	\N	\N	user	listing	64	listing_review
69	2017-11-09 10:32:03.391387-05	A user has rated listing <b>Great white shark</b> 3 stars	2017-12-09 10:32:03.388142-05	15	64	\N	\N	user	listing	64	listing_review
70	2017-11-09 10:32:03.421671-05	A user has rated listing <b>Harley-Davidson CVO</b> 3 stars	2017-12-09 10:32:03.418536-05	5	65	\N	\N	user	listing	65	listing_review
71	2017-11-09 10:32:03.452499-05	A user has rated listing <b>Hawaii</b> 4 stars	2017-12-09 10:32:03.449375-05	9	67	\N	\N	user	listing	67	listing_review
72	2017-11-09 10:32:03.481775-05	A user has rated listing <b>Hawaii</b> 5 stars	2017-12-09 10:32:03.478668-05	17	67	\N	\N	user	listing	67	listing_review
73	2017-11-09 10:32:03.510878-05	A user has rated listing <b>Hawaii</b> 3 stars	2017-12-09 10:32:03.507757-05	15	67	\N	\N	user	listing	67	listing_review
74	2017-11-09 10:32:03.540455-05	A user has rated listing <b>House Lannister</b> 1 star	2017-12-09 10:32:03.537249-05	3	68	\N	\N	user	listing	68	listing_review
75	2017-11-09 10:32:03.570515-05	A user has rated listing <b>House Stark</b> 1 star	2017-12-09 10:32:03.566935-05	12	69	\N	\N	user	listing	69	listing_review
76	2017-11-09 10:32:03.601522-05	A user has rated listing <b>House Stark</b> 4 stars	2017-12-09 10:32:03.598236-05	3	69	\N	\N	user	listing	69	listing_review
77	2017-11-09 10:32:03.633036-05	A user has rated listing <b>House Targaryen</b> 5 stars	2017-12-09 10:32:03.629647-05	3	70	\N	\N	user	listing	70	listing_review
78	2017-11-09 10:32:03.664477-05	A user has rated listing <b>Informational Book</b> 5 stars	2017-12-09 10:32:03.661176-05	17	73	\N	\N	user	listing	73	listing_review
79	2017-11-09 10:32:03.69467-05	A user has rated listing <b>Iron Man</b> 5 stars	2017-12-09 10:32:03.691383-05	17	77	\N	\N	user	listing	77	listing_review
80	2017-11-09 10:32:03.724496-05	A user has rated listing <b>Iron Man</b> 3 stars	2017-12-09 10:32:03.721217-05	15	77	\N	\N	user	listing	77	listing_review
81	2017-11-09 10:32:03.754635-05	A user has rated listing <b>Iron Man</b> 5 stars	2017-12-09 10:32:03.751413-05	3	77	\N	\N	user	listing	77	listing_review
82	2017-11-09 10:32:03.785187-05	A user has rated listing <b>Jar of Flies</b> 3 stars	2017-12-09 10:32:03.782033-05	15	78	\N	\N	user	listing	78	listing_review
83	2017-11-09 10:32:03.816796-05	A user has rated listing <b>Jasoom</b> 5 stars	2017-12-09 10:32:03.813451-05	12	79	\N	\N	user	listing	79	listing_review
84	2017-11-09 10:32:03.847608-05	A user has rated listing <b>Jasoom</b> 2 stars	2017-12-09 10:32:03.844457-05	17	79	\N	\N	user	listing	79	listing_review
85	2017-11-09 10:32:03.878506-05	A user has rated listing <b>Jay and Silent Bob Strike Back</b> 1 star	2017-12-09 10:32:03.875225-05	12	80	\N	\N	user	listing	80	listing_review
86	2017-11-09 10:32:03.908111-05	A user has rated listing <b>Jean Grey</b> 5 stars	2017-12-09 10:32:03.904855-05	17	81	\N	\N	user	listing	81	listing_review
87	2017-11-09 10:32:03.938248-05	A user has rated listing <b>Jean Grey</b> 5 stars	2017-12-09 10:32:03.935027-05	15	81	\N	\N	user	listing	81	listing_review
88	2017-11-09 10:32:03.968403-05	A user has rated listing <b>Jean Grey</b> 3 stars	2017-12-09 10:32:03.965149-05	5	81	\N	\N	user	listing	81	listing_review
89	2017-11-09 10:32:03.998595-05	A user has rated listing <b>JotSpot</b> 4 stars	2017-12-09 10:32:03.995369-05	21	82	\N	\N	user	listing	82	listing_review
90	2017-11-09 10:32:04.029491-05	A user has rated listing <b>Jupiter</b> 5 stars	2017-12-09 10:32:04.026175-05	12	83	\N	\N	user	listing	83	listing_review
91	2017-11-09 10:32:04.060761-05	A user has rated listing <b>Jupiter</b> 3 stars	2017-12-09 10:32:04.05736-05	17	83	\N	\N	user	listing	83	listing_review
92	2017-11-09 10:32:04.091791-05	A user has rated listing <b>Killer Whale</b> 4 stars	2017-12-09 10:32:04.088472-05	13	87	\N	\N	user	listing	87	listing_review
93	2017-11-09 10:32:04.121988-05	A user has rated listing <b>Killer Whale</b> 3 stars	2017-12-09 10:32:04.118818-05	15	87	\N	\N	user	listing	87	listing_review
94	2017-11-09 10:32:04.151647-05	A user has rated listing <b>Komodo Dragon</b> 1 star	2017-12-09 10:32:04.148508-05	1	88	\N	\N	user	listing	88	listing_review
95	2017-11-09 10:32:04.18281-05	A user has rated listing <b>LIT RANCH</b> 1 star	2017-12-09 10:32:04.1795-05	9	89	\N	\N	user	listing	89	listing_review
96	2017-11-09 10:32:04.213351-05	A user has rated listing <b>LIT RANCH</b> 5 stars	2017-12-09 10:32:04.210097-05	8	89	\N	\N	user	listing	89	listing_review
97	2017-11-09 10:32:04.243757-05	A user has rated listing <b>LIT RANCH</b> 5 stars	2017-12-09 10:32:04.240594-05	3	89	\N	\N	user	listing	89	listing_review
98	2017-11-09 10:32:04.274374-05	A user has rated listing <b>Lager</b> 5 stars	2017-12-09 10:32:04.271107-05	13	90	\N	\N	user	listing	90	listing_review
99	2017-11-09 10:32:04.305573-05	A user has rated listing <b>Lager</b> 2 stars	2017-12-09 10:32:04.30227-05	5	90	\N	\N	user	listing	90	listing_review
100	2017-11-09 10:32:04.336667-05	A user has rated listing <b>Lion Finder</b> 1 star	2017-12-09 10:32:04.333436-05	3	94	\N	\N	user	listing	94	listing_review
101	2017-11-09 10:32:04.366138-05	A user has rated listing <b>LocationLister</b> 4 stars	2017-12-09 10:32:04.362909-05	21	96	\N	\N	user	listing	96	listing_review
102	2017-11-09 10:32:04.396518-05	A user has rated listing <b>Magnetic positioning</b> 1 star	2017-12-09 10:32:04.393254-05	17	99	\N	\N	user	listing	99	listing_review
103	2017-11-09 10:32:04.426651-05	A user has rated listing <b>Magnetic positioning</b> 5 stars	2017-12-09 10:32:04.423368-05	15	99	\N	\N	user	listing	99	listing_review
104	2017-11-09 10:32:04.456629-05	A user has rated listing <b>Magneto</b> 1 star	2017-12-09 10:32:04.453373-05	4	100	\N	\N	user	listing	100	listing_review
105	2017-11-09 10:32:04.486639-05	A user has rated listing <b>Magneto</b> 3 stars	2017-12-09 10:32:04.483317-05	8	100	\N	\N	user	listing	100	listing_review
106	2017-11-09 10:32:04.516653-05	A user has rated listing <b>Mallrats</b> 4 stars	2017-12-09 10:32:04.513405-05	15	101	\N	\N	user	listing	101	listing_review
107	2017-11-09 10:32:04.546791-05	A user has rated listing <b>Map of the world</b> 5 stars	2017-12-09 10:32:04.54357-05	17	102	\N	\N	user	listing	102	listing_review
108	2017-11-09 10:32:04.57715-05	A user has rated listing <b>Map of the world</b> 5 stars	2017-12-09 10:32:04.57374-05	15	102	\N	\N	user	listing	102	listing_review
109	2017-11-09 10:32:04.607405-05	A user has rated listing <b>Minesweeper</b> 5 stars	2017-12-09 10:32:04.604137-05	1	104	\N	\N	user	listing	104	listing_review
110	2017-11-09 10:32:04.638103-05	A user has rated listing <b>Minesweeper</b> 2 stars	2017-12-09 10:32:04.634855-05	15	104	\N	\N	user	listing	104	listing_review
111	2017-11-09 10:32:04.668729-05	A user has rated listing <b>Mini Dachshund</b> 5 stars	2017-12-09 10:32:04.665353-05	1	105	\N	\N	user	listing	105	listing_review
112	2017-11-09 10:32:04.699617-05	A user has rated listing <b>Mini Dachshund</b> 5 stars	2017-12-09 10:32:04.696282-05	9	105	\N	\N	user	listing	105	listing_review
113	2017-11-09 10:32:04.730758-05	A user has rated listing <b>Mini Dachshund</b> 1 star	2017-12-09 10:32:04.727277-05	17	105	\N	\N	user	listing	105	listing_review
114	2017-11-09 10:32:04.761421-05	A user has rated listing <b>Mini Dachshund</b> 1 star	2017-12-09 10:32:04.758236-05	2	105	\N	\N	user	listing	105	listing_review
115	2017-11-09 10:32:04.791654-05	A user has rated listing <b>Mini Dachshund</b> 1 star	2017-12-09 10:32:04.788537-05	3	105	\N	\N	user	listing	105	listing_review
116	2017-11-09 10:32:04.822247-05	A user has rated listing <b>Mini Dachshund</b> 1 star	2017-12-09 10:32:04.819024-05	4	105	\N	\N	user	listing	105	listing_review
117	2017-11-09 10:32:04.852831-05	A user has rated listing <b>Mini Dachshund</b> 1 star	2017-12-09 10:32:04.849755-05	5	105	\N	\N	user	listing	105	listing_review
118	2017-11-09 10:32:04.883245-05	A user has rated listing <b>Mini Dachshund</b> 1 star	2017-12-09 10:32:04.880068-05	6	105	\N	\N	user	listing	105	listing_review
119	2017-11-09 10:32:04.913629-05	A user has rated listing <b>Mini Dachshund</b> 1 star	2017-12-09 10:32:04.910501-05	7	105	\N	\N	user	listing	105	listing_review
120	2017-11-09 10:32:04.944508-05	A user has rated listing <b>Mini Dachshund</b> 1 star	2017-12-09 10:32:04.941232-05	8	105	\N	\N	user	listing	105	listing_review
121	2017-11-09 10:32:04.975944-05	A user has rated listing <b>Mixing Console</b> 1 star	2017-12-09 10:32:04.972536-05	1	107	\N	\N	user	listing	107	listing_review
122	2017-11-09 10:32:05.006815-05	A user has rated listing <b>Monkey Finder</b> 1 star	2017-12-09 10:32:05.003367-05	13	108	\N	\N	user	listing	108	listing_review
123	2017-11-09 10:32:05.036441-05	A user has rated listing <b>Monkey Finder</b> 1 star	2017-12-09 10:32:05.033189-05	3	108	\N	\N	user	listing	108	listing_review
124	2017-11-09 10:32:05.066892-05	A user has rated listing <b>Moonshine</b> 5 stars	2017-12-09 10:32:05.063735-05	3	109	\N	\N	user	listing	109	listing_review
125	2017-11-09 10:32:05.098985-05	A user has rated listing <b>Moonshine</b> 2 stars	2017-12-09 10:32:05.095297-05	15	109	\N	\N	user	listing	109	listing_review
126	2017-11-09 10:32:05.131032-05	A user has rated listing <b>Motorcycle Helmet</b> 5 stars	2017-12-09 10:32:05.12771-05	1	111	\N	\N	user	listing	111	listing_review
127	2017-11-09 10:32:05.161691-05	A user has rated listing <b>Motorsport</b> 4 stars	2017-12-09 10:32:05.158458-05	17	112	\N	\N	user	listing	112	listing_review
128	2017-11-09 10:32:05.191932-05	A user has rated listing <b>Motorsport</b> 3 stars	2017-12-09 10:32:05.188704-05	15	112	\N	\N	user	listing	112	listing_review
129	2017-11-09 10:32:05.222385-05	A user has rated listing <b>Navigation</b> 5 stars	2017-12-09 10:32:05.219108-05	1	116	\N	\N	user	listing	116	listing_review
130	2017-11-09 10:32:05.252625-05	A user has rated listing <b>Navigation</b> 4 stars	2017-12-09 10:32:05.249355-05	15	116	\N	\N	user	listing	116	listing_review
131	2017-11-09 10:32:05.282526-05	A user has rated listing <b>Navigation</b> 2 stars	2017-12-09 10:32:05.27926-05	5	116	\N	\N	user	listing	116	listing_review
132	2017-11-09 10:32:05.312477-05	A user has rated listing <b>Navigation</b> 5 stars	2017-12-09 10:32:05.309153-05	3	116	\N	\N	user	listing	116	listing_review
133	2017-11-09 10:32:05.350978-05	A user has rated listing <b>Navigation</b> 5 stars	2017-12-09 10:32:05.345456-05	4	116	\N	\N	user	listing	116	listing_review
134	2017-11-09 10:32:05.39824-05	A user has rated listing <b>Navigation using Maps</b> 4 stars	2017-12-09 10:32:05.393486-05	1	117	\N	\N	user	listing	117	listing_review
135	2017-11-09 10:32:05.450047-05	A user has rated listing <b>Navigation using Maps</b> 3 stars	2017-12-09 10:32:05.444565-05	15	117	\N	\N	user	listing	117	listing_review
136	2017-11-09 10:32:05.500467-05	A user has rated listing <b>Neptune</b> 5 stars	2017-12-09 10:32:05.495385-05	12	118	\N	\N	user	listing	118	listing_review
137	2017-11-09 10:32:05.547854-05	A user has rated listing <b>Neptune</b> 1 star	2017-12-09 10:32:05.54321-05	17	118	\N	\N	user	listing	118	listing_review
138	2017-11-09 10:32:05.591254-05	A user has rated listing <b>Network Switch</b> 4 stars	2017-12-09 10:32:05.586716-05	1	119	\N	\N	user	listing	119	listing_review
139	2017-11-09 10:32:05.630171-05	A user has rated listing <b>Phentolamine</b> 5 stars	2017-12-09 10:32:05.626217-05	1	125	\N	\N	user	listing	125	listing_review
140	2017-11-09 10:32:05.666801-05	A user has rated listing <b>Pluto (Not a planet)</b> 1 star	2017-12-09 10:32:05.662784-05	12	128	\N	\N	user	listing	128	listing_review
141	2017-11-09 10:32:05.702675-05	A user has rated listing <b>Pluto (Not a planet)</b> 5 stars	2017-12-09 10:32:05.698985-05	17	128	\N	\N	user	listing	128	listing_review
142	2017-11-09 10:32:05.738152-05	A user has rated listing <b>Princess Peach</b> 3 stars	2017-12-09 10:32:05.734602-05	3	132	\N	\N	user	listing	132	listing_review
143	2017-11-09 10:32:05.772814-05	A user has rated listing <b>Project Management</b> 2 stars	2017-12-09 10:32:05.769072-05	3	133	\N	\N	user	listing	133	listing_review
144	2017-11-09 10:32:05.808363-05	A user has rated listing <b>Project Management</b> 1 star	2017-12-09 10:32:05.804901-05	4	133	\N	\N	user	listing	133	listing_review
145	2017-11-09 10:32:05.843285-05	A user has rated listing <b>Railroad</b> 3 stars	2017-12-09 10:32:05.839779-05	4	134	\N	\N	user	listing	134	listing_review
146	2017-11-09 10:32:05.875358-05	A user has rated listing <b>Railroad</b> 5 stars	2017-12-09 10:32:05.871866-05	17	134	\N	\N	user	listing	134	listing_review
147	2017-11-09 10:32:05.90712-05	A user has rated listing <b>Railroad</b> 4 stars	2017-12-09 10:32:05.90369-05	15	134	\N	\N	user	listing	134	listing_review
148	2017-11-09 10:32:05.938923-05	A user has rated listing <b>Rogue</b> 2 stars	2017-12-09 10:32:05.935684-05	8	135	\N	\N	user	listing	135	listing_review
149	2017-11-09 10:32:05.969754-05	A user has rated listing <b>Ruby</b> 5 stars	2017-12-09 10:32:05.966456-05	3	136	\N	\N	user	listing	136	listing_review
150	2017-11-09 10:32:06.001664-05	A user has rated listing <b>Sailboat Racing</b> 3 stars	2017-12-09 10:32:05.998274-05	5	142	\N	\N	user	listing	142	listing_review
151	2017-11-09 10:32:06.03273-05	A user has rated listing <b>Satellite navigation</b> 3 stars	2017-12-09 10:32:06.029483-05	1	146	\N	\N	user	listing	146	listing_review
152	2017-11-09 10:32:06.063673-05	A user has rated listing <b>Satellite navigation</b> 5 stars	2017-12-09 10:32:06.060349-05	15	146	\N	\N	user	listing	146	listing_review
153	2017-11-09 10:32:06.094865-05	A user has rated listing <b>Saturn</b> 3 stars	2017-12-09 10:32:06.091279-05	12	147	\N	\N	user	listing	147	listing_review
154	2017-11-09 10:32:06.125759-05	A user has rated listing <b>Saturn</b> 5 stars	2017-12-09 10:32:06.122578-05	17	147	\N	\N	user	listing	147	listing_review
155	2017-11-09 10:32:06.156453-05	A user has rated listing <b>Snow</b> 1 star	2017-12-09 10:32:06.153194-05	1	154	\N	\N	user	listing	154	listing_review
156	2017-11-09 10:32:06.186726-05	A user has rated listing <b>Snow</b> 3 stars	2017-12-09 10:32:06.183589-05	17	154	\N	\N	user	listing	154	listing_review
157	2017-11-09 10:32:06.216522-05	A user has rated listing <b>Snow</b> 2 stars	2017-12-09 10:32:06.213209-05	3	154	\N	\N	user	listing	154	listing_review
158	2017-11-09 10:32:06.246248-05	A user has rated listing <b>Stop sign</b> 5 stars	2017-12-09 10:32:06.242945-05	1	158	\N	\N	user	listing	158	listing_review
159	2017-11-09 10:32:06.276661-05	A user has rated listing <b>Stop sign</b> 5 stars	2017-12-09 10:32:06.273512-05	15	158	\N	\N	user	listing	158	listing_review
160	2017-11-09 10:32:06.30729-05	A user has rated listing <b>Stout</b> 5 stars	2017-12-09 10:32:06.304059-05	5	159	\N	\N	user	listing	159	listing_review
161	2017-11-09 10:32:06.337587-05	A user has rated listing <b>Stroke play</b> 3 stars	2017-12-09 10:32:06.334309-05	5	160	\N	\N	user	listing	160	listing_review
162	2017-11-09 10:32:06.369115-05	A user has rated listing <b>Sun</b> 5 stars	2017-12-09 10:32:06.365957-05	12	162	\N	\N	user	listing	162	listing_review
163	2017-11-09 10:32:06.399742-05	A user has rated listing <b>Sun</b> 5 stars	2017-12-09 10:32:06.396603-05	17	162	\N	\N	user	listing	162	listing_review
164	2017-11-09 10:32:06.430385-05	A user has rated listing <b>Superunknown</b> 5 stars	2017-12-09 10:32:06.427112-05	17	163	\N	\N	user	listing	163	listing_review
165	2017-11-09 10:32:06.460232-05	A user has rated listing <b>Superunknown</b> 3 stars	2017-12-09 10:32:06.457028-05	15	163	\N	\N	user	listing	163	listing_review
166	2017-11-09 10:32:06.49035-05	A user has rated listing <b>Ten</b> 4 stars	2017-12-09 10:32:06.487125-05	15	166	\N	\N	user	listing	166	listing_review
167	2017-11-09 10:32:06.521089-05	A user has rated listing <b>Ten</b> 5 stars	2017-12-09 10:32:06.517842-05	1	166	\N	\N	user	listing	166	listing_review
168	2017-11-09 10:32:06.552186-05	A user has rated listing <b>Ten</b> 3 stars	2017-12-09 10:32:06.548962-05	8	166	\N	\N	user	listing	166	listing_review
169	2017-11-09 10:32:06.58285-05	A user has rated listing <b>Tiny Music... Songs from the Vatican Gift Shop</b> 3 stars	2017-12-09 10:32:06.579682-05	15	168	\N	\N	user	listing	168	listing_review
170	2017-11-09 10:32:06.612263-05	A user has rated listing <b>Tiny Music... Songs from the Vatican Gift Shop</b> 4 stars	2017-12-09 10:32:06.609044-05	17	168	\N	\N	user	listing	168	listing_review
171	2017-11-09 10:32:06.64207-05	A user has rated listing <b>Tornado</b> 1 star	2017-12-09 10:32:06.638826-05	1	169	\N	\N	user	listing	169	listing_review
172	2017-11-09 10:32:06.672467-05	A user has rated listing <b>Tornado</b> 1 star	2017-12-09 10:32:06.669119-05	4	169	\N	\N	user	listing	169	listing_review
173	2017-11-09 10:32:06.702407-05	A user has rated listing <b>Tornado</b> 1 star	2017-12-09 10:32:06.699126-05	3	169	\N	\N	user	listing	169	listing_review
174	2017-11-09 10:32:06.732693-05	A user has rated listing <b>Uranus</b> 5 stars	2017-12-09 10:32:06.729404-05	17	173	\N	\N	user	listing	173	listing_review
175	2017-11-09 10:32:06.763514-05	A user has rated listing <b>Uranus</b> 2 stars	2017-12-09 10:32:06.760267-05	13	173	\N	\N	user	listing	173	listing_review
176	2017-11-09 10:32:06.794825-05	A user has rated listing <b>Venus</b> 4 stars	2017-12-09 10:32:06.791576-05	12	174	\N	\N	user	listing	174	listing_review
177	2017-11-09 10:32:06.82867-05	A user has rated listing <b>Venus</b> 1 star	2017-12-09 10:32:06.825379-05	17	174	\N	\N	user	listing	174	listing_review
178	2017-11-09 10:32:06.860088-05	A user has rated listing <b>Waterme Lon</b> 4 stars	2017-12-09 10:32:06.856728-05	9	178	\N	\N	user	listing	178	listing_review
179	2017-11-09 10:32:06.890599-05	A user has rated listing <b>Waterme Lon</b> 5 stars	2017-12-09 10:32:06.887049-05	17	178	\N	\N	user	listing	178	listing_review
180	2017-11-09 10:32:06.921509-05	A user has rated listing <b>Waterme Lon</b> 5 stars	2017-12-09 10:32:06.918192-05	3	178	\N	\N	user	listing	178	listing_review
181	2017-11-09 10:32:06.952281-05	A user has rated listing <b>White Horse</b> 4 stars	2017-12-09 10:32:06.949001-05	3	180	\N	\N	user	listing	180	listing_review
182	2017-11-09 10:32:06.98305-05	A user has rated listing <b>Wolf Finder</b> 5 stars	2017-12-09 10:32:06.979736-05	15	186	\N	\N	user	listing	186	listing_review
183	2017-11-09 10:32:07.013741-05	A user has rated listing <b>Wolf Finder</b> 4 stars	2017-12-09 10:32:07.010272-05	3	186	\N	\N	user	listing	186	listing_review
184	2017-11-09 10:32:07.045121-05	A user has rated listing <b>Wolverine</b> 3 stars	2017-12-09 10:32:07.04168-05	17	187	\N	\N	user	listing	187	listing_review
185	2017-11-09 10:32:07.173873-05	Acoustic Guitar update next week	2017-11-16 15:31:33.890575-05	1	1	\N	\N	all	listing	1	\N
186	2017-11-09 10:32:07.196239-05	Air Mail update next week	2017-11-16 15:31:33.890575-05	5	2	\N	\N	all	listing	2	\N
187	2017-11-09 10:32:07.219857-05	Air Mail update next week	2017-11-16 15:31:33.890575-05	5	2	\N	\N	all	listing	2	\N
188	2017-11-09 10:32:07.245521-05	Azeroth update next week	2017-11-16 15:31:33.890575-05	12	9	\N	\N	all	listing	9	\N
189	2017-11-09 10:32:07.270672-05	Azeroth update next week	2017-11-16 15:31:33.890575-05	12	9	\N	\N	all	listing	9	\N
190	2017-11-09 10:32:07.29226-05	Baltimore Ravens update next week	2017-11-16 15:31:33.890575-05	4	10	\N	\N	all	listing	10	\N
191	2017-11-09 10:32:07.313424-05	Baltimore Ravens update next week	2017-11-16 15:31:33.890575-05	4	10	\N	\N	all	listing	10	\N
192	2017-11-09 10:32:07.33431-05	Bass Fishing update next week	2017-11-16 15:31:33.890575-05	4	14	\N	\N	all	listing	14	\N
193	2017-11-09 10:32:07.353774-05	Bleach update next week	2017-11-16 15:31:33.890575-05	4	18	\N	\N	all	listing	18	\N
194	2017-11-09 10:32:07.375598-05	Bourbon update next week	2017-11-16 15:31:33.890575-05	13	21	\N	\N	all	listing	21	\N
195	2017-11-09 10:32:07.393731-05	Bread Basket update next week	2017-11-16 15:31:33.890575-05	6	23	\N	\N	all	listing	23	\N
196	2017-11-09 10:32:07.412435-05	Bread Basket update next week	2017-11-16 15:31:33.890575-05	6	23	\N	\N	all	listing	23	\N
197	2017-11-09 10:32:07.433481-05	Chain boat navigation update next week	2017-11-16 15:31:33.890575-05	15	29	\N	\N	all	listing	29	\N
198	2017-11-09 10:32:07.450462-05	Chart Course update next week	2017-11-16 15:31:33.890575-05	5	30	\N	\N	all	listing	30	\N
199	2017-11-09 10:32:07.46787-05	Chart Course update next week	2017-11-16 15:31:33.890575-05	5	30	\N	\N	all	listing	30	\N
200	2017-11-09 10:32:07.48485-05	Diamond update next week	2017-11-16 15:31:33.890575-05	5	44	\N	\N	all	listing	44	\N
201	2017-11-09 10:32:07.500688-05	Dragons update next week	2017-11-16 15:31:33.890575-05	2	47	\N	\N	all	listing	47	\N
202	2017-11-09 10:32:07.52094-05	Electric Guitar update next week	2017-11-16 15:31:33.890575-05	1	49	\N	\N	all	listing	49	\N
203	2017-11-09 10:32:07.544692-05	Electric Piano update next week	2017-11-16 15:31:33.890575-05	1	50	\N	\N	all	listing	50	\N
204	2017-11-09 10:32:07.570992-05	Gallery of Maps update next week	2017-11-16 15:31:33.890575-05	15	59	\N	\N	all	listing	59	\N
205	2017-11-09 10:32:07.592767-05	Grandfather clock update next week	2017-11-16 15:31:33.890575-05	4	63	\N	\N	all	listing	63	\N
206	2017-11-09 10:32:07.614365-05	House Lannister update next week	2017-11-16 15:31:33.890575-05	1	68	\N	\N	all	listing	68	\N
207	2017-11-09 10:32:07.635752-05	House Stark update next week	2017-11-16 15:31:33.890575-05	1	69	\N	\N	all	listing	69	\N
208	2017-11-09 10:32:07.656109-05	House Targaryen update next week	2017-11-16 15:31:33.890575-05	3	70	\N	\N	all	listing	70	\N
209	2017-11-09 10:32:07.676069-05	India Pale Ale update next week	2017-11-16 15:31:33.890575-05	4	72	\N	\N	all	listing	72	\N
210	2017-11-09 10:32:07.695867-05	Informational Book update next week	2017-11-16 15:31:33.890575-05	1	73	\N	\N	all	listing	73	\N
211	2017-11-09 10:32:07.71535-05	Internet meme update next week	2017-11-16 15:31:33.890575-05	4	76	\N	\N	all	listing	76	\N
212	2017-11-09 10:32:07.736763-05	Iron Man update next week	2017-11-16 15:31:33.890575-05	17	77	\N	\N	all	listing	77	\N
213	2017-11-09 10:32:07.75786-05	Jean Grey update next week	2017-11-16 15:31:33.890575-05	17	81	\N	\N	all	listing	81	\N
214	2017-11-09 10:32:07.776151-05	JotSpot update next week	2017-11-16 15:31:33.890575-05	5	82	\N	\N	all	listing	82	\N
215	2017-11-09 10:32:07.793942-05	Killer Whale update next week	2017-11-16 15:31:33.890575-05	1	87	\N	\N	all	listing	87	\N
216	2017-11-09 10:32:07.811749-05	Killer Whale update next week	2017-11-16 15:31:33.890575-05	1	87	\N	\N	all	listing	87	\N
217	2017-11-09 10:32:07.829851-05	Lager update next week	2017-11-16 15:31:33.890575-05	4	90	\N	\N	all	listing	90	\N
218	2017-11-09 10:32:07.846291-05	Lightning update next week	2017-11-16 15:31:33.890575-05	1	93	\N	\N	all	listing	93	\N
219	2017-11-09 10:32:07.862158-05	Lion Finder update next week	2017-11-16 15:31:33.890575-05	1	94	\N	\N	all	listing	94	\N
220	2017-11-09 10:32:07.878055-05	LocationLister update next week	2017-11-16 15:31:33.890575-05	5	96	\N	\N	all	listing	96	\N
221	2017-11-09 10:32:07.893819-05	Mallrats update next week	2017-11-16 15:31:33.890575-05	4	101	\N	\N	all	listing	101	\N
222	2017-11-09 10:32:07.910067-05	Mallrats update next week	2017-11-16 15:31:33.890575-05	4	101	\N	\N	all	listing	101	\N
223	2017-11-09 10:32:07.926175-05	Mario update next week	2017-11-16 15:31:33.890575-05	4	103	\N	\N	all	listing	103	\N
224	2017-11-09 10:32:07.941592-05	Monkey Finder update next week	2017-11-16 15:31:33.890575-05	1	108	\N	\N	all	listing	108	\N
225	2017-11-09 10:32:07.957315-05	NES update next week	2017-11-16 15:31:33.890575-05	4	115	\N	\N	all	listing	115	\N
226	2017-11-09 10:32:07.974792-05	Navigation update next week	2017-11-16 15:31:33.890575-05	15	116	\N	\N	all	listing	116	\N
227	2017-11-09 10:32:07.992586-05	Parrotlet update next week	2017-11-16 15:31:33.890575-05	13	122	\N	\N	all	listing	122	\N
228	2017-11-09 10:32:08.008262-05	Piano update next week	2017-11-16 15:31:33.890575-05	1	127	\N	\N	all	listing	127	\N
229	2017-11-09 10:32:08.026135-05	Saturn update next week	2017-11-16 15:31:33.890575-05	12	147	\N	\N	all	listing	147	\N
230	2017-11-09 10:32:08.044381-05	Screamin Eagle CVO update next week	2017-11-16 15:31:33.890575-05	13	148	\N	\N	all	listing	148	\N
231	2017-11-09 10:32:08.062518-05	Snow update next week	2017-11-16 15:31:33.890575-05	9	154	\N	\N	all	listing	154	\N
232	2017-11-09 10:32:08.077822-05	Sound Mixer update next week	2017-11-16 15:31:33.890575-05	1	156	\N	\N	all	listing	156	\N
233	2017-11-09 10:32:08.092613-05	Stop sign update next week	2017-11-16 15:31:33.890575-05	4	158	\N	\N	all	listing	158	\N
234	2017-11-09 10:32:08.107213-05	Tornado update next week	2017-11-16 15:31:33.890575-05	1	169	\N	\N	all	listing	169	\N
235	2017-11-09 10:32:08.121027-05	Violin update next week	2017-11-16 15:31:33.890575-05	1	175	\N	\N	all	listing	175	\N
236	2017-11-09 10:32:08.134109-05	White Horse update next week	2017-11-16 15:31:33.890575-05	1	180	\N	\N	all	listing	180	\N
237	2017-11-09 10:32:08.146977-05	Wolf Finder update next week	2017-11-16 15:31:33.890575-05	1	186	\N	\N	all	listing	186	\N
238	2017-11-09 10:32:08.160544-05	Wolf Finder update next week	2017-11-16 15:31:33.890575-05	1	186	\N	\N	all	listing	186	\N
\.


--
-- Name: ozpcenter_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_notification_id_seq', 238, true);


--
-- Data for Name: ozpcenter_notificationmailbox; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_notificationmailbox (id, target_profile_id, notification_id, emailed_status, read_status, acknowledged_status) FROM stdin;
1	1	1	f	f	f
2	2	1	f	f	f
3	3	1	f	f	f
4	4	1	f	f	f
5	5	1	f	f	f
6	6	1	f	f	f
7	7	1	f	f	f
8	8	1	f	f	f
9	9	1	f	f	f
10	10	1	f	f	f
11	11	1	f	f	f
12	12	1	f	f	f
13	13	1	f	f	f
14	14	1	f	f	f
15	15	1	f	f	f
16	16	1	f	f	f
17	17	1	f	f	f
18	18	1	f	f	f
19	19	1	f	f	f
20	20	1	f	f	f
21	21	1	f	f	f
22	22	1	f	f	f
23	1	2	f	f	f
24	2	2	f	f	f
25	3	2	f	f	f
26	4	2	f	f	f
27	5	2	f	f	f
28	6	2	f	f	f
29	7	2	f	f	f
30	8	2	f	f	f
31	9	2	f	f	f
32	10	2	f	f	f
33	11	2	f	f	f
34	12	2	f	f	f
35	13	2	f	f	f
36	14	2	f	f	f
37	15	2	f	f	f
38	16	2	f	f	f
39	17	2	f	f	f
40	18	2	f	f	f
41	19	2	f	f	f
42	20	2	f	f	f
43	21	2	f	f	f
44	22	2	f	f	f
45	1	3	f	f	f
46	2	3	f	f	f
47	3	3	f	f	f
48	4	3	f	f	f
49	5	3	f	f	f
50	6	3	f	f	f
51	7	3	f	f	f
52	8	3	f	f	f
53	9	3	f	f	f
54	10	3	f	f	f
55	11	3	f	f	f
56	12	3	f	f	f
57	13	3	f	f	f
58	14	3	f	f	f
59	15	3	f	f	f
60	16	3	f	f	f
61	17	3	f	f	f
62	18	3	f	f	f
63	19	3	f	f	f
64	20	3	f	f	f
65	21	3	f	f	f
66	22	3	f	f	f
67	1	4	f	f	f
68	2	4	f	f	f
69	3	4	f	f	f
70	4	4	f	f	f
71	5	4	f	f	f
72	6	4	f	f	f
73	7	4	f	f	f
74	8	4	f	f	f
75	9	4	f	f	f
76	10	4	f	f	f
77	11	4	f	f	f
78	12	4	f	f	f
79	13	4	f	f	f
80	14	4	f	f	f
81	15	4	f	f	f
82	16	4	f	f	f
83	17	4	f	f	f
84	18	4	f	f	f
85	19	4	f	f	f
86	20	4	f	f	f
87	21	4	f	f	f
88	22	4	f	f	f
89	1	5	f	f	f
90	7	5	f	f	f
91	1	6	f	f	f
92	7	6	f	f	f
93	1	7	f	f	f
94	7	7	f	f	f
95	4	8	f	f	f
96	5	8	f	f	f
97	6	8	f	f	f
98	4	9	f	f	f
99	5	9	f	f	f
100	6	9	f	f	f
101	4	10	f	f	f
102	5	10	f	f	f
103	6	10	f	f	f
104	4	11	f	f	f
105	5	11	f	f	f
106	6	11	f	f	f
107	9	12	f	f	f
108	4	12	f	f	f
109	9	13	f	f	f
110	4	13	f	f	f
111	9	14	f	f	f
112	4	14	f	f	f
113	17	15	f	f	f
114	7	15	f	f	f
115	4	16	f	f	f
116	8	17	f	f	f
117	12	17	f	f	f
118	6	17	f	f	f
119	8	18	f	f	f
120	12	18	f	f	f
121	6	18	f	f	f
122	8	19	f	f	f
123	12	19	f	f	f
124	6	19	f	f	f
125	8	20	f	f	f
126	12	20	f	f	f
127	6	20	f	f	f
128	8	21	f	f	f
129	12	21	f	f	f
130	6	21	f	f	f
131	8	22	f	f	f
132	4	22	f	f	f
133	6	22	f	f	f
134	4	23	f	f	f
135	13	23	f	f	f
136	5	23	f	f	f
137	6	23	f	f	f
138	8	24	f	f	f
139	12	24	f	f	f
140	6	24	f	f	f
141	8	25	f	f	f
142	12	25	f	f	f
143	6	25	f	f	f
144	8	26	f	f	f
145	12	26	f	f	f
146	6	26	f	f	f
147	8	27	f	f	f
148	9	27	f	f	f
149	6	27	f	f	f
150	8	28	f	f	f
151	9	28	f	f	f
152	6	28	f	f	f
153	4	29	f	f	f
154	13	29	f	f	f
155	5	29	f	f	f
156	6	29	f	f	f
157	17	30	f	f	f
158	7	30	f	f	f
159	17	31	f	f	f
160	7	31	f	f	f
161	7	32	f	f	f
162	15	32	f	f	f
163	7	33	f	f	f
164	15	33	f	f	f
165	4	34	f	f	f
166	5	34	f	f	f
167	6	34	f	f	f
168	4	35	f	f	f
169	5	35	f	f	f
170	6	35	f	f	f
171	17	36	f	f	f
172	7	36	f	f	f
173	17	37	f	f	f
174	7	37	f	f	f
175	17	38	f	f	f
176	7	38	f	f	f
177	4	39	f	f	f
178	5	39	f	f	f
179	6	39	f	f	f
180	4	40	f	f	f
181	5	40	f	f	f
182	6	40	f	f	f
183	9	41	f	f	f
184	4	41	f	f	f
185	9	42	f	f	f
186	4	42	f	f	f
187	4	43	f	f	f
188	5	43	f	f	f
189	6	43	f	f	f
190	4	44	f	f	f
191	5	44	f	f	f
192	6	44	f	f	f
193	4	45	f	f	f
194	5	45	f	f	f
195	6	45	f	f	f
196	4	46	f	f	f
197	5	46	f	f	f
198	6	46	f	f	f
199	4	47	f	f	f
200	5	47	f	f	f
201	6	47	f	f	f
202	4	48	f	f	f
203	8	49	f	f	f
204	4	49	f	f	f
205	6	49	f	f	f
206	8	50	f	f	f
207	4	50	f	f	f
208	6	50	f	f	f
209	17	51	f	f	f
210	7	51	f	f	f
211	17	52	f	f	f
212	7	52	f	f	f
213	17	53	f	f	f
214	7	53	f	f	f
215	17	54	f	f	f
216	7	54	f	f	f
217	9	55	f	f	f
218	4	55	f	f	f
219	9	56	f	f	f
220	4	56	f	f	f
221	9	57	f	f	f
222	4	57	f	f	f
223	2	58	f	f	f
224	3	58	f	f	f
225	7	58	f	f	f
226	8	59	f	f	f
227	4	59	f	f	f
228	6	59	f	f	f
229	9	60	f	f	f
230	4	60	f	f	f
231	9	61	f	f	f
232	4	61	f	f	f
233	9	62	f	f	f
234	4	62	f	f	f
235	9	63	f	f	f
236	4	63	f	f	f
237	7	64	f	f	f
238	15	64	f	f	f
239	7	65	f	f	f
240	15	65	f	f	f
241	7	66	f	f	f
242	15	66	f	f	f
243	7	67	f	f	f
244	15	67	f	f	f
245	8	68	f	f	f
246	1	68	f	f	f
247	6	68	f	f	f
248	8	69	f	f	f
249	1	69	f	f	f
250	6	69	f	f	f
251	4	70	f	f	f
252	13	70	f	f	f
253	5	70	f	f	f
254	6	70	f	f	f
255	9	71	f	f	f
256	7	71	f	f	f
257	9	72	f	f	f
258	7	72	f	f	f
259	9	73	f	f	f
260	7	73	f	f	f
261	1	74	f	f	f
262	7	74	f	f	f
263	1	75	f	f	f
264	4	75	f	f	f
265	5	75	f	f	f
266	6	75	f	f	f
267	1	76	f	f	f
268	4	76	f	f	f
269	5	76	f	f	f
270	6	76	f	f	f
271	3	77	f	f	f
272	4	77	f	f	f
273	5	77	f	f	f
274	6	77	f	f	f
275	1	78	f	f	f
276	7	78	f	f	f
277	17	79	f	f	f
278	7	79	f	f	f
279	17	80	f	f	f
280	7	80	f	f	f
281	17	81	f	f	f
282	7	81	f	f	f
283	8	82	f	f	f
284	1	82	f	f	f
285	4	82	f	f	f
286	6	82	f	f	f
287	8	83	f	f	f
288	12	83	f	f	f
289	6	83	f	f	f
290	8	84	f	f	f
291	12	84	f	f	f
292	6	84	f	f	f
293	4	85	f	f	f
294	17	86	f	f	f
295	7	86	f	f	f
296	17	87	f	f	f
297	7	87	f	f	f
298	17	88	f	f	f
299	7	88	f	f	f
300	4	89	f	f	f
301	5	89	f	f	f
302	6	89	f	f	f
303	8	90	f	f	f
304	12	90	f	f	f
305	6	90	f	f	f
306	8	91	f	f	f
307	12	91	f	f	f
308	6	91	f	f	f
309	1	92	f	f	f
310	7	92	f	f	f
311	1	93	f	f	f
312	7	93	f	f	f
313	3	94	f	f	f
314	4	94	f	f	f
315	5	94	f	f	f
316	6	94	f	f	f
317	8	95	f	f	f
318	9	95	f	f	f
319	6	95	f	f	f
320	8	96	f	f	f
321	9	96	f	f	f
322	6	96	f	f	f
323	8	97	f	f	f
324	9	97	f	f	f
325	6	97	f	f	f
326	4	98	f	f	f
327	5	98	f	f	f
328	6	98	f	f	f
329	4	99	f	f	f
330	5	99	f	f	f
331	6	99	f	f	f
332	1	100	f	f	f
333	7	100	f	f	f
334	4	101	f	f	f
335	5	101	f	f	f
336	6	101	f	f	f
337	7	102	f	f	f
338	15	102	f	f	f
339	7	103	f	f	f
340	15	103	f	f	f
341	17	104	f	f	f
342	7	104	f	f	f
343	17	105	f	f	f
344	7	105	f	f	f
345	4	106	f	f	f
346	7	106	f	f	f
347	7	107	f	f	f
348	15	107	f	f	f
349	7	108	f	f	f
350	15	108	f	f	f
351	8	109	f	f	f
352	4	109	f	f	f
353	6	109	f	f	f
354	8	110	f	f	f
355	4	110	f	f	f
356	6	110	f	f	f
357	8	111	f	f	f
358	9	111	f	f	f
359	6	111	f	f	f
360	8	112	f	f	f
361	9	112	f	f	f
362	6	112	f	f	f
363	8	113	f	f	f
364	9	113	f	f	f
365	6	113	f	f	f
366	8	114	f	f	f
367	9	114	f	f	f
368	6	114	f	f	f
369	8	115	f	f	f
370	9	115	f	f	f
371	6	115	f	f	f
372	8	116	f	f	f
373	9	116	f	f	f
374	6	116	f	f	f
375	8	117	f	f	f
376	9	117	f	f	f
377	6	117	f	f	f
378	8	118	f	f	f
379	9	118	f	f	f
380	6	118	f	f	f
381	8	119	f	f	f
382	9	119	f	f	f
383	6	119	f	f	f
384	8	120	f	f	f
385	9	120	f	f	f
386	6	120	f	f	f
387	8	121	f	f	f
388	4	121	f	f	f
389	6	121	f	f	f
390	1	122	f	f	f
391	7	122	f	f	f
392	1	123	f	f	f
393	7	123	f	f	f
394	4	124	f	f	f
395	13	124	f	f	f
396	5	124	f	f	f
397	6	124	f	f	f
398	4	125	f	f	f
399	13	125	f	f	f
400	5	125	f	f	f
401	6	125	f	f	f
402	8	126	f	f	f
403	4	126	f	f	f
404	6	126	f	f	f
405	7	127	f	f	f
406	15	127	f	f	f
407	7	128	f	f	f
408	15	128	f	f	f
409	7	129	f	f	f
410	15	129	f	f	f
411	7	130	f	f	f
412	15	130	f	f	f
413	7	131	f	f	f
414	15	131	f	f	f
415	7	132	f	f	f
416	15	132	f	f	f
417	7	133	f	f	f
418	15	133	f	f	f
419	7	134	f	f	f
420	15	134	f	f	f
421	7	135	f	f	f
422	15	135	f	f	f
423	8	136	f	f	f
424	12	136	f	f	f
425	6	136	f	f	f
426	8	137	f	f	f
427	12	137	f	f	f
428	6	137	f	f	f
429	1	138	f	f	f
430	7	138	f	f	f
431	4	139	f	f	f
432	8	140	f	f	f
433	12	140	f	f	f
434	6	140	f	f	f
435	8	141	f	f	f
436	12	141	f	f	f
437	6	141	f	f	f
438	4	142	f	f	f
439	7	142	f	f	f
440	2	143	f	f	f
441	4	143	f	f	f
442	5	143	f	f	f
443	13	143	f	f	f
444	6	143	f	f	f
445	2	144	f	f	f
446	4	144	f	f	f
447	5	144	f	f	f
448	13	144	f	f	f
449	6	144	f	f	f
450	7	145	f	f	f
451	15	145	f	f	f
452	7	146	f	f	f
453	15	146	f	f	f
454	7	147	f	f	f
455	15	147	f	f	f
456	17	148	f	f	f
457	7	148	f	f	f
458	4	149	f	f	f
459	5	149	f	f	f
460	6	149	f	f	f
461	1	150	f	f	f
462	7	150	f	f	f
463	7	151	f	f	f
464	15	151	f	f	f
465	7	152	f	f	f
466	15	152	f	f	f
467	8	153	f	f	f
468	12	153	f	f	f
469	6	153	f	f	f
470	8	154	f	f	f
471	12	154	f	f	f
472	6	154	f	f	f
473	9	155	f	f	f
474	7	155	f	f	f
475	9	156	f	f	f
476	7	156	f	f	f
477	9	157	f	f	f
478	7	157	f	f	f
479	8	158	f	f	f
480	4	158	f	f	f
481	6	158	f	f	f
482	8	159	f	f	f
483	4	159	f	f	f
484	6	159	f	f	f
485	4	160	f	f	f
486	7	160	f	f	f
487	4	161	f	f	f
488	13	161	f	f	f
489	5	161	f	f	f
490	6	161	f	f	f
491	8	162	f	f	f
492	12	162	f	f	f
493	6	162	f	f	f
494	8	163	f	f	f
495	12	163	f	f	f
496	6	163	f	f	f
497	4	164	f	f	f
498	7	164	f	f	f
499	4	165	f	f	f
500	7	165	f	f	f
501	8	166	f	f	f
502	4	166	f	f	f
503	6	166	f	f	f
504	8	167	f	f	f
505	4	167	f	f	f
506	6	167	f	f	f
507	8	168	f	f	f
508	4	168	f	f	f
509	6	168	f	f	f
510	4	169	f	f	f
511	4	170	f	f	f
512	1	171	f	f	f
513	7	171	f	f	f
514	1	172	f	f	f
515	7	172	f	f	f
516	1	173	f	f	f
517	7	173	f	f	f
518	8	174	f	f	f
519	12	174	f	f	f
520	6	174	f	f	f
521	8	175	f	f	f
522	12	175	f	f	f
523	6	175	f	f	f
524	8	176	f	f	f
525	12	176	f	f	f
526	6	176	f	f	f
527	8	177	f	f	f
528	12	177	f	f	f
529	6	177	f	f	f
530	9	178	f	f	f
531	7	178	f	f	f
532	9	179	f	f	f
533	7	179	f	f	f
534	9	180	f	f	f
535	7	180	f	f	f
536	1	181	f	f	f
537	7	181	f	f	f
538	1	182	f	f	f
539	7	182	f	f	f
540	1	183	f	f	f
541	7	183	f	f	f
542	17	184	f	f	f
543	7	184	f	f	f
544	1	185	f	f	f
545	5	186	f	f	f
546	11	186	f	f	f
547	5	187	f	f	f
548	11	187	f	f	f
549	5	188	f	f	f
550	15	188	f	f	f
551	5	189	f	f	f
552	15	189	f	f	f
553	5	190	f	f	f
554	4	190	f	f	f
555	5	191	f	f	f
556	4	191	f	f	f
557	13	192	f	f	f
558	4	193	f	f	f
559	4	194	f	f	f
560	1	195	f	f	f
561	5	195	f	f	f
562	1	196	f	f	f
563	5	196	f	f	f
564	1	197	f	f	f
565	1	198	f	f	f
566	11	198	f	f	f
567	1	199	f	f	f
568	11	199	f	f	f
569	5	200	f	f	f
570	3	201	f	f	f
571	1	202	f	f	f
572	1	203	f	f	f
573	1	204	f	f	f
574	5	205	f	f	f
575	3	206	f	f	f
576	3	207	f	f	f
577	3	208	f	f	f
578	4	209	f	f	f
579	1	210	f	f	f
580	4	211	f	f	f
581	5	212	f	f	f
582	5	213	f	f	f
583	11	214	f	f	f
584	1	215	f	f	f
585	13	215	f	f	f
586	1	216	f	f	f
587	13	216	f	f	f
588	13	217	f	f	f
589	1	218	f	f	f
590	1	219	f	f	f
591	11	220	f	f	f
592	5	221	f	f	f
593	4	221	f	f	f
594	5	222	f	f	f
595	4	222	f	f	f
596	4	223	f	f	f
597	1	224	f	f	f
598	4	225	f	f	f
599	15	226	f	f	f
600	1	227	f	f	f
601	1	228	f	f	f
602	5	229	f	f	f
603	4	230	f	f	f
604	1	231	f	f	f
605	1	232	f	f	f
606	1	233	f	f	f
607	1	234	f	f	f
608	1	235	f	f	f
609	1	236	f	f	f
610	1	237	f	f	f
611	3	237	f	f	f
612	1	238	f	f	f
613	3	238	f	f	f
\.


--
-- Name: ozpcenter_notificationmailbox_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_notificationmailbox_id_seq', 613, true);


--
-- Data for Name: ozpcenter_profile; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_profile (id, display_name, bio, dn, issuer_dn, auth_expires, access_control, user_id, center_tour_flag, hud_tour_flag, webtop_tour_flag, email_notification_flag, listing_notification_flag, subscription_notification_flag, leaving_ozp_warning_flag) FROM stdin;
1	Big Brother		Big Brother bigbrother	\N	2017-11-09 10:31:33.00025-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET", "TOP SECRET"], "visas": ["NOVEMBER"], "formal_accesses": ["SIERRA", "TANGO", "GOLF", "HOTEL"]}	1	t	t	t	t	t	t	t
2	Big Brother2		Big Brother 2 bigbrother2	\N	2017-11-09 10:31:33.042077-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET", "TOP SECRET"], "visas": ["NOVEMBER"], "formal_accesses": ["SIERRA", "TANGO", "GOLF", "HOTEL"]}	2	t	t	t	t	t	t	t
3	Daenerys Targaryen		Daenerys Targaryen khaleesi	\N	2017-11-09 10:31:33.081035-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET", "TOP SECRET"], "visas": ["DRS"], "formal_accesses": ["SIERRA", "TANGO", "GOLF", "HOTEL"]}	3	t	t	t	t	t	t	t
4	Betta Fish		Bettafish bettafish	\N	2017-11-09 10:31:33.123245-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET", "TOP SECRET"], "visas": ["NOVEMBER"], "formal_accesses": ["SIERRA", "TANGO", "GOLF", "HOTEL"]}	4	t	t	t	t	t	t	t
5	Winston Smith		Winston Smith wsmith	\N	2017-11-09 10:31:33.180708-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET", "TOP SECRET"], "visas": ["NOVEMBER"], "formal_accesses": ["SIERRA", "TANGO"]}	5	t	t	t	t	t	t	t
6	Julia Dixon		Julia Dixon jdixon	\N	2017-11-09 10:31:33.2224-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET", "TOP SECRET"], "visas": [], "formal_accesses": ["SIERRA"]}	6	t	t	t	t	t	t	t
7	O'brien		OBrien obrien	\N	2017-11-09 10:31:33.26744-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET", "TOP SECRET"], "visas": ["NOVEMBER"], "formal_accesses": ["SIERRA", "TANGO", "GOLF", "HOTEL"]}	7	t	t	t	t	t	t	t
8	David		David david	\N	2017-11-09 10:31:33.312375-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET", "TOP SECRET"], "visas": ["NOVEMBER"], "formal_accesses": ["SIERRA", "TANGO", "GOLF", "HOTEL"]}	8	t	t	t	t	t	t	t
9	Aaronson		Aaronson aaronson	\N	2017-11-09 10:31:33.354326-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET"], "visas": ["NOVEMBER"], "formal_accesses": []}	9	t	t	t	t	t	t	t
10	pmurt		dlanod pmurt	\N	2017-11-09 10:31:33.393793-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET"], "visas": ["NOVEMBER"], "formal_accesses": []}	10	t	t	t	t	t	t	t
11	Hodor		Hodor hodor	\N	2017-11-09 10:31:33.433041-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET"], "visas": ["STE", "RVR", "PKI"], "formal_accesses": []}	11	t	t	t	t	t	t	t
12	Beta Ray Bill		BetaRayBill betaraybill	\N	2017-11-09 10:31:33.474816-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET", "TOP SECRET"], "visas": ["NOVEMBER"], "formal_accesses": ["SIERRA", "TANGO", "GOLF", "HOTEL"]}	12	t	t	t	t	t	t	t
13	Jones		Jones jones	\N	2017-11-09 10:31:33.514796-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET"], "visas": ["NOVEMBER"], "formal_accesses": []}	13	t	t	t	t	t	t	t
14	Tammy		Tammy tammy	\N	2017-11-09 10:31:33.553846-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET"], "visas": ["NOVEMBER", "PKI"], "formal_accesses": []}	14	t	t	t	t	t	t	t
15	Rutherford		Rutherford rutherford	\N	2017-11-09 10:31:33.592881-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET"], "visas": [], "formal_accesses": []}	15	t	t	t	t	t	t	t
16	Noah		Noah noah	\N	2017-11-09 10:31:33.632233-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET"], "visas": ["PKI"], "formal_accesses": []}	16	t	t	t	t	t	t	t
17	Syme		Syme syme	\N	2017-11-09 10:31:33.671204-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET", "TOP SECRET"], "visas": [], "formal_accesses": ["SIERRA"]}	17	t	t	t	t	t	t	t
18	Abe		Abe abe	\N	2017-11-09 10:31:33.710661-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET", "TOP SECRET"], "visas": ["PKI"], "formal_accesses": ["SIERRA"]}	18	t	t	t	t	t	t	t
19	Tom Parsons		Tparsons tparsons	\N	2017-11-09 10:31:33.749681-05	{"clearances": ["UNCLASSIFIED"], "visas": [], "formal_accesses": []}	19	t	t	t	t	t	t	t
20	Jon Snow		Jonsnow jsnow	\N	2017-11-09 10:31:33.792067-05	{"clearances": ["UNCLASSIFIED"], "visas": ["TWN", "PKI"], "formal_accesses": []}	20	t	t	t	t	t	t	t
21	Charrington		Charrington charrington	\N	2017-11-09 10:31:33.833272-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET", "TOP SECRET"], "visas": ["NOVEMBER"], "formal_accesses": ["SIERRA", "TANGO", "GOLF", "HOTEL"]}	21	t	t	t	t	t	t	t
22	Johnson		Johnson johnson	\N	2017-11-09 10:31:33.872709-05	{"clearances": ["UNCLASSIFIED", "CONFIDENTIAL", "SECRET", "TOP SECRET"], "visas": ["NOVEMBER", "PKI"], "formal_accesses": ["SIERRA", "TANGO", "GOLF", "HOTEL"]}	22	t	t	t	t	t	t	t
\.


--
-- Name: ozpcenter_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_profile_id_seq', 22, true);


--
-- Data for Name: ozpcenter_recommendationfeedback; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_recommendationfeedback (id, feedback, target_listing_id, target_profile_id) FROM stdin;
\.


--
-- Name: ozpcenter_recommendationfeedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_recommendationfeedback_id_seq', 1, false);


--
-- Data for Name: ozpcenter_recommendationsentry; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_recommendationsentry (id, target_profile_id, recommendation_data) FROM stdin;
1	1	\\x82a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb40200000000000009217cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb4019333333333333a76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000da0020426f6f6b6d61726b20436f6c6c61626f7261746976652046696c746572696e6783af7265636f6d6d656e646174696f6e73dc00119202cb40000000000000009260cb3ff00000000000009244cb3ff00000000000009245cb3ff00000000000009246cb3ff00000000000009209cb3ff0000000000000920acb3ff0000000000000922ccb3ff0000000000000924dcb3ff0000000000000920ecb3ff0000000000000922fcb3ff00000000000009251cb3ff00000000000009252cb3ff000000000000092cc93cb3ff0000000000000925acb3ff00000000000009265cb3ff0000000000000923fcb3ff0000000000000a76d735f746f6f6bcb4027636000000000a6776569676874cb4014000000000000
2	2	\\x81a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb40200000000000009217cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb4019333333333333a76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000
3	3	\\x82a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb40200000000000009217cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb4019333333333333a76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000da0020426f6f6b6d61726b20436f6c6c61626f7261746976652046696c746572696e6783af7265636f6d6d656e646174696f6e73dc00149201cb3ff00000000000009249cb3ff0000000000000927acb3ff00000000000009217cb3ff0000000000000926ccb3ff000000000000092ccafcb3ff000000000000092cc9ecb3ff0000000000000921dcb3ff00000000000009231cb3ff00000000000009232cb3ff000000000000092ccb4cb3ff0000000000000925ecb3ff00000000000009257cb3ff000000000000092cca9cb3ff000000000000092cc9acb3ff0000000000000923bcb3ff000000000000092cc9ccb3ff0000000000000925dcb3ff0000000000000921ecb3ff0000000000000927fcb3ff0000000000000a76d735f746f6f6bcb4027636000000000a6776569676874cb4014000000000000
4	4	\\x82a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb40200000000000009217cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb4019333333333333a76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000da0020426f6f6b6d61726b20436f6c6c61626f7261746976652046696c746572696e6783af7265636f6d6d656e646174696f6e73989251cb3ff00000000000009202cb3ff000000000000092cc93cb3ff00000000000009217cb3ff00000000000009209cb3ff0000000000000922ccb3ff0000000000000924dcb3ff0000000000000923fcb3ff0000000000000a76d735f746f6f6bcb4027636000000000a6776569676874cb4014000000000000
5	5	\\x82a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb40200000000000009217cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb4019333333333333a76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000da0020426f6f6b6d61726b20436f6c6c61626f7261746976652046696c746572696e6783af7265636f6d6d656e646174696f6e73dc0014921ecb40000000000000009201cb3ff00000000000009248cb3ff00000000000009249cb3ff0000000000000924ccb3ff00000000000009212cb3ff000000000000092cc94cb3ff00000000000009215cb3ff00000000000009257cb3ff000000000000092cc9acb3ff000000000000092cc9ccb3ff0000000000000921dcb3ff000000000000092cc9ecb3ff00000000000009260cb3ff00000000000009267cb3ff000000000000092cca9cb3ff0000000000000927acb3ff0000000000000926ccb3ff00000000000009252cb3ff0000000000000925dcb3ff0000000000000a76d735f746f6f6bcb4027636000000000a6776569676874cb4014000000000000
6	6	\\x81a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb40200000000000009217cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb4019333333333333a76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000
7	7	\\x81a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb40193333333333339274cb4018cccccccccccda76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000
8	8	\\x81a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb40193333333333339274cb4018cccccccccccda76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000
9	9	\\x81a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb40193333333333339274cb4018cccccccccccda76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000
10	10	\\x81a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb40193333333333339274cb4018cccccccccccda76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000
11	11	\\x82a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb40193333333333339274cb4018cccccccccccda76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000da0020426f6f6b6d61726b20436f6c6c61626f7261746976652046696c746572696e6783af7265636f6d6d656e646174696f6e73dc00149217cb40000000000000009201cb3ff00000000000009249cb3ff0000000000000920acb3ff00000000000009257cb3ff0000000000000924dcb3ff00000000000009251cb3ff000000000000092cc93cb3ff0000000000000927acb3ff000000000000092cc9acb3ff000000000000092cc9ccb3ff0000000000000921dcb3ff000000000000092cc9ecb3ff00000000000009265cb3ff000000000000092cca9cb3ff0000000000000927fcb3ff0000000000000922ccb3ff0000000000000925dcb3ff000000000000092ccafcb3ff00000000000009231cb3ff0000000000000a76d735f746f6f6bcb4027636000000000a6776569676874cb4014000000000000
12	12	\\x81a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb40193333333333339274cb4018cccccccccccda76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000
13	13	\\x82a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb40200000000000009217cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb4019333333333333a76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000da0020426f6f6b6d61726b20436f6c6c61626f7261746976652046696c746572696e6783af7265636f6d6d656e646174696f6e73dc00149201cb3ff00000000000009249cb3ff0000000000000927acb3ff0000000000000926ccb3ff000000000000092ccafcb3ff000000000000092cc9ecb3ff0000000000000921dcb3ff00000000000009231cb3ff00000000000009232cb3ff000000000000092ccb4cb3ff0000000000000925ecb3ff000000000000092cc9acb3ff00000000000009217cb3ff000000000000092cca9cb3ff000000000000092ccbacb3ff0000000000000923bcb3ff000000000000092cc9ccb3ff0000000000000925dcb3ff0000000000000921ecb3ff0000000000000927fcb3ff0000000000000a76d735f746f6f6bcb4027636000000000a6776569676874cb4014000000000000
14	14	\\x81a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb40200000000000009217cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb4019333333333333a76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000
15	15	\\x82a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb40193333333333339274cb4018cccccccccccda76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000da0020426f6f6b6d61726b20436f6c6c61626f7261746976652046696c746572696e6783af7265636f6d6d656e646174696f6e73999251cb3ff00000000000009202cb3ff000000000000092cc93cb3ff00000000000009265cb3ff00000000000009217cb3ff0000000000000920acb3ff0000000000000922ccb3ff0000000000000924dcb3ff0000000000000923fcb3ff0000000000000a76d735f746f6f6bcb4027636000000000a6776569676874cb4014000000000000
16	16	\\x81a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb40193333333333339274cb4018cccccccccccda76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000
17	17	\\x81a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb40193333333333339274cb4018cccccccccccda76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000
18	18	\\x81a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb40193333333333339274cb4018cccccccccccda76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000
19	19	\\x81a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb40193333333333339274cb4018cccccccccccda76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000
20	20	\\x81a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb40193333333333339274cb4018cccccccccccda76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000
21	21	\\x81a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb40200000000000009217cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb4019333333333333a76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000
22	22	\\x81a8426173656c696e6583af7265636f6d6d656e646174696f6e73dc001492ccbacb4027000000000000920acb40240000000000009209cb40226666666666669260cb40220000000000009265cb402200000000000092cc9ecb40220000000000009202cb40200000000000009217cb4020000000000000921ecb402000000000000092cc93cb402000000000000092ccb4cb4020000000000000922fcb401c0000000000009246cb401c0000000000009249cb401c00000000000092cc9fcb401c00000000000092cca2cb401c00000000000092ccb2cb401acccccccccccd9212cb401a000000000000924dcb40193333333333339251cb4019333333333333a76d735f746f6f6bcb409f3a7e00000000a6776569676874cb3ff0000000000000
\.


--
-- Name: ozpcenter_recommendationsentry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_recommendationsentry_id_seq', 22, true);


--
-- Data for Name: ozpcenter_review; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_review (id, text, rate, edited_date, author_id, listing_id, review_parent_id, created_date) FROM stdin;
1	Favorite Instrument by far. BY. FAR.	3	2017-11-09 10:32:01.349228-05	1	1	\N	2017-11-09 10:32:01.349258-05
2	I don't like the sound of acoustic guitars. I like electric guitars more	1	2017-11-09 10:32:01.399103-05	5	1	\N	2017-11-09 10:32:01.399127-05
3	I love the sound of acoustic guitars	5	2017-11-09 10:32:01.443673-05	17	1	\N	2017-11-09 10:32:01.443692-05
4	This app is great - well designed and easy to use	5	2017-11-09 10:32:01.487894-05	21	2	\N	2017-11-09 10:32:01.487912-05
5	Air mail is ok - does what it says and no more	3	2017-11-09 10:32:01.533318-05	19	2	\N	2017-11-09 10:32:01.533335-05
6	Air mail crashes all the time - it doesn't even support IE 6!	1	2017-11-09 10:32:01.577486-05	17	2	\N	2017-11-09 10:32:01.577503-05
7	On par with sending ravens across Westeros, though less likely to be eaten along the way. 	4	2017-11-09 10:32:01.620651-05	3	2	\N	2017-11-09 10:32:01.620667-05
8	Very friendly. Would recommend to others	5	2017-11-09 10:32:01.662353-05	9	4	\N	2017-11-09 10:32:01.662368-05
9	I don't want to talk about it. 	1	2017-11-09 10:32:01.701338-05	17	4	\N	2017-11-09 10:32:01.701353-05
10	The Gray's... Moulder where are you?	4	2017-11-09 10:32:01.738787-05	13	4	\N	2017-11-09 10:32:01.738801-05
11	I will downvote anybody who is blue and you can't stop me. 	1	2017-11-09 10:32:01.773995-05	17	6	\N	2017-11-09 10:32:01.774019-05
12	I think that this is very cool software.  Must try it out.	5	2017-11-09 10:32:01.80869-05	15	8	\N	2017-11-09 10:32:01.808703-05
13	Favorite planet by far. BY. FAR.	5	2017-11-09 10:32:01.842462-05	12	9	\N	2017-11-09 10:32:01.842476-05
14	It was better in 2010.	5	2017-11-09 10:32:01.877324-05	17	9	\N	2017-11-09 10:32:01.877337-05
15	not everything can be 5 stars.	3	2017-11-09 10:32:01.911562-05	5	9	\N	2017-11-09 10:32:01.911575-05
16	Lots of great dragons but the humanoids sure like trying to kill them for loot. Not sure it's worth the effort to visit.	3	2017-11-09 10:32:01.946808-05	3	9	\N	2017-11-09 10:32:01.946821-05
17	Everything should be 5 stars	5	2017-11-09 10:32:01.981985-05	4	9	\N	2017-11-09 10:32:01.981998-05
18	BEST FOOTBALL TEAM EVER.	5	2017-11-09 10:32:02.016465-05	4	10	\N	2017-11-09 10:32:02.016478-05
19	I love to bbq with my 3 dragons. Extra yum with dragon fire!	5	2017-11-09 10:32:02.050268-05	3	11	\N	2017-11-09 10:32:02.050281-05
20	Looking like the next home.	5	2017-11-09 10:32:02.084323-05	12	12	\N	2017-11-09 10:32:02.084335-05
21	No roller coaster, a curfew and ice warriors.	3	2017-11-09 10:32:02.116603-05	17	12	\N	2017-11-09 10:32:02.116614-05
22	Found this in the Marketplace.  Much better than expected.	5	2017-11-09 10:32:02.148173-05	4	12	\N	2017-11-09 10:32:02.148184-05
23	Bad user interface but good content	2	2017-11-09 10:32:02.179905-05	9	13	\N	2017-11-09 10:32:02.179916-05
24	If you're complaining about the UI, its because you have neither hops nor handles.  I've contacted the mods, you will be removed.  FOREVER. 	5	2017-11-09 10:32:02.210772-05	17	13	\N	2017-11-09 10:32:02.210783-05
25	So easy a kid can do it.	4	2017-11-09 10:32:02.239894-05	13	14	\N	2017-11-09 10:32:02.239905-05
26	I like the blue.  I dislike having to have more than 20 characters.\n	5	2017-11-09 10:32:02.270359-05	8	16	\N	2017-11-09 10:32:02.27037-05
27	Why are they always blue?  It just doesn't make any sense. 	3	2017-11-09 10:32:02.299972-05	17	16	\N	2017-11-09 10:32:02.299983-05
28	Should consider this one.  It might be worth it.	4	2017-11-09 10:32:02.329917-05	1	17	\N	2017-11-09 10:32:02.329928-05
29	Okay app must try it today.	3	2017-11-09 10:32:02.360334-05	15	17	\N	2017-11-09 10:32:02.360345-05
30	Better than average and grew up with them	4	2017-11-09 10:32:02.390881-05	15	18	\N	2017-11-09 10:32:02.390892-05
31	I think they could go places!	5	2017-11-09 10:32:02.421796-05	17	18	\N	2017-11-09 10:32:02.421807-05
32	Too scared to fly United?  Try a blink.	5	2017-11-09 10:32:02.452531-05	8	19	\N	2017-11-09 10:32:02.452543-05
33	5/5 Not blue!  Thank the lords.	5	2017-11-09 10:32:02.481256-05	17	19	\N	2017-11-09 10:32:02.481267-05
34	I shimmer, not blink. SAD!	1	2017-11-09 10:32:02.510085-05	12	19	\N	2017-11-09 10:32:02.510096-05
35	This bread is stale!	2	2017-11-09 10:32:02.539214-05	13	23	\N	2017-11-09 10:32:02.539225-05
36	Yum!	5	2017-11-09 10:32:02.568675-05	6	23	\N	2017-11-09 10:32:02.568686-05
37	Essential for living life	4	2017-11-09 10:32:02.598005-05	9	25	\N	2017-11-09 10:32:02.598026-05
38	I don't get it.  Does its just sit there? 	2	2017-11-09 10:32:02.626654-05	17	25	\N	2017-11-09 10:32:02.626665-05
39	Management (or managing) is the administration of an organization, whether it be a business, a not-for-profit organization, or government body.	3	2017-11-09 10:32:02.654952-05	1	27	\N	2017-11-09 10:32:02.654963-05
40	Individuals who aim at becoming management researchers or professors may complete the Doctor of Management (DM), the Doctor of Business Administration (DBA), or the PhD in Business Administration or Management.	4	2017-11-09 10:32:02.68295-05	4	27	\N	2017-11-09 10:32:02.682961-05
41	I was told there would be cake, last time I did not get any cake, and i just want some cake. 	2	2017-11-09 10:32:02.710234-05	17	27	\N	2017-11-09 10:32:02.710244-05
42	This Chart is bad!	2	2017-11-09 10:32:02.737236-05	5	30	\N	2017-11-09 10:32:02.737247-05
43	Good Chart!	5	2017-11-09 10:32:02.763984-05	1	30	\N	2017-11-09 10:32:02.763994-05
44	Might be pretty good to look at.	4	2017-11-09 10:32:02.790897-05	15	31	\N	2017-11-09 10:32:02.790908-05
45	I really don't care for this one, but it might be good for others.	3	2017-11-09 10:32:02.818085-05	15	36	\N	2017-11-09 10:32:02.818096-05
46	This is an okay image and app.	3	2017-11-09 10:32:02.846126-05	15	37	\N	2017-11-09 10:32:02.846137-05
47	Blame the writers if you'd like, but easily the most worst x-men.   Besides Angel.  Oh?  you can fly?  Cause of your wings?  Half of everybody can fly and you can sit behind them at concerts and still see the show.	1	2017-11-09 10:32:02.873615-05	17	41	\N	2017-11-09 10:32:02.873625-05
48	BEST. X-MEN. EVER!!!	5	2017-11-09 10:32:02.900619-05	12	41	\N	2017-11-09 10:32:02.90063-05
49	Rating 5 stars because I don't want to make him mad.	5	2017-11-09 10:32:02.927522-05	4	42	\N	2017-11-09 10:32:02.927533-05
50	He wrecked the freeway.  I was late to work and rushed my experiment.  After drinking the radioactive material i just got sick :(	2	2017-11-09 10:32:02.955655-05	17	42	\N	2017-11-09 10:32:02.955666-05
51	Got attacked by one and was scary	1	2017-11-09 10:32:02.984062-05	9	45	\N	2017-11-09 10:32:02.984073-05
52	I like that they are oil now.   That is a useful substance. 	5	2017-11-09 10:32:03.011976-05	8	45	\N	2017-11-09 10:32:03.011987-05
53	Close to dragons but -1 star for not having wings, breathing fire or flying	4	2017-11-09 10:32:03.039377-05	3	45	\N	2017-11-09 10:32:03.039388-05
54	Dragons are the best! I want to mother them all <3	5	2017-11-09 10:32:03.066687-05	3	47	\N	2017-11-09 10:32:03.066698-05
55	Who broke the first rule?!?!	3	2017-11-09 10:32:03.094313-05	4	55	\N	2017-11-09 10:32:03.094324-05
56	Not the best tool now but still works	3	2017-11-09 10:32:03.12204-05	9	56	\N	2017-11-09 10:32:03.122051-05
57	You would not copy a car would you?  No!  Because that doesn't make any sense.  You would copy X-COM though. 	5	2017-11-09 10:32:03.148556-05	17	56	\N	2017-11-09 10:32:03.148567-05
58	Won't even hold an MP3.  Write time is very slow.  Somewhat noisy too.	3	2017-11-09 10:32:03.174951-05	4	56	\N	2017-11-09 10:32:03.174961-05
59	Real men don't use floppies.	2	2017-11-09 10:32:03.201147-05	3	56	\N	2017-11-09 10:32:03.201157-05
60	I keep hitting M and the map doesn't show up. 	4	2017-11-09 10:32:03.227486-05	17	59	\N	2017-11-09 10:32:03.227496-05
61	Okay app must try it today.	3	2017-11-09 10:32:03.253939-05	15	59	\N	2017-11-09 10:32:03.25395-05
62	One of the better ones that I have seen.	5	2017-11-09 10:32:03.283289-05	1	61	\N	2017-11-09 10:32:03.2833-05
63	Great app must try it today.	5	2017-11-09 10:32:03.311816-05	15	61	\N	2017-11-09 10:32:03.311827-05
64	Growing up I had a friend who talk during movies.  The worst.  Anyways after a trip to the beach I didn't have to worry about that anymore. 	5	2017-11-09 10:32:03.341107-05	17	64	\N	2017-11-09 10:32:03.341118-05
65	Okay this might be a good one.	3	2017-11-09 10:32:03.371469-05	15	64	\N	2017-11-09 10:32:03.37148-05
66	All new four-valve engine and suspension. Doubling down on valves, staying pat on styling.	3	2017-11-09 10:32:03.401451-05	5	65	\N	2017-11-09 10:32:03.401462-05
67	Very nice place! Expensive though	4	2017-11-09 10:32:03.432673-05	9	67	\N	2017-11-09 10:32:03.432684-05
68	I feel like I would like it!  10 stars!	5	2017-11-09 10:32:03.46174-05	17	67	\N	2017-11-09 10:32:03.461751-05
69	I know that I should not worry, but it is the volcanoes that I am worried about.  Otherwise a good place to visit.	3	2017-11-09 10:32:03.490932-05	15	67	\N	2017-11-09 10:32:03.490943-05
70	False rulers of the iron throne. They will soon fall in battle to my army of dragons. If I could give a 0 rating I would!	1	2017-11-09 10:32:03.520275-05	3	68	\N	2017-11-09 10:32:03.520286-05
71	Guy's not even a full stark.	1	2017-11-09 10:32:03.549982-05	12	69	\N	2017-11-09 10:32:03.549993-05
72	Won't bend the knee, but could prove to be a valuable ally. Dragons still beat direwolves though.	4	2017-11-09 10:32:03.581245-05	3	69	\N	2017-11-09 10:32:03.581257-05
73	The best, most powerful house ever. True rulers of Westeros.	5	2017-11-09 10:32:03.612391-05	3	70	\N	2017-11-09 10:32:03.612402-05
74	Zeus controls the world by creating brainwave modifiers that are sent through the air as cotton candy.  Its true!  You can read about it on wikipedia. 	5	2017-11-09 10:32:03.644032-05	17	73	\N	2017-11-09 10:32:03.644043-05
75	This is not Jarvis upvoting this.  It is not.  you cannot prove anything.  Also the fact that this site does not have a capatcha is AWESOME!  	5	2017-11-09 10:32:03.673949-05	17	77	\N	2017-11-09 10:32:03.67396-05
76	Ironman is okay not 100% sure it is good.	3	2017-11-09 10:32:03.70419-05	15	77	\N	2017-11-09 10:32:03.704201-05
77	I like my men rich and arrogant. 	5	2017-11-09 10:32:03.733915-05	3	77	\N	2017-11-09 10:32:03.733926-05
78	this okay not so sure.	3	2017-11-09 10:32:03.764453-05	15	78	\N	2017-11-09 10:32:03.764465-05
79	I like this planet. It's alright.	5	2017-11-09 10:32:03.796364-05	12	79	\N	2017-11-09 10:32:03.796375-05
80	Contains florida and the dallas cowboys.  This makes it irredeemable in the eyes of the lord.	2	2017-11-09 10:32:03.826924-05	17	79	\N	2017-11-09 10:32:03.826935-05
81	One of the main characters doesn't even speak. SAD!	1	2017-11-09 10:32:03.857971-05	12	80	\N	2017-11-09 10:32:03.857982-05
82	These timelines are way too confusing. 	5	2017-11-09 10:32:03.887312-05	17	81	\N	2017-11-09 10:32:03.887324-05
83	Yes a definite winner.	5	2017-11-09 10:32:03.917601-05	15	81	\N	2017-11-09 10:32:03.917612-05
84	After Jean and the X-Men defeated scientist Stephen Lang and his robotic Sentinels on his space station, the heroes escaped back to Earth in a shuttle through a lethal solar radiation storm.	3	2017-11-09 10:32:03.947748-05	5	81	\N	2017-11-09 10:32:03.94776-05
85	I really like it	4	2017-11-09 10:32:03.978138-05	21	82	\N	2017-11-09 10:32:03.978149-05
86	It's pretty big. Like, bigly big.	5	2017-11-09 10:32:04.008895-05	12	83	\N	2017-11-09 10:32:04.008906-05
87	To hard to to talk to because you just want to look at its eyestorm birthmark thing.	3	2017-11-09 10:32:04.039581-05	17	83	\N	2017-11-09 10:32:04.039591-05
88	Samoo was fun to watch at Sea World.	4	2017-11-09 10:32:04.070945-05	13	87	\N	2017-11-09 10:32:04.070956-05
89	They are nice but not a big fan.	3	2017-11-09 10:32:04.101464-05	15	87	\N	2017-11-09 10:32:04.101476-05
90	I don't think that cold blooded animals are very efficient 	1	2017-11-09 10:32:04.131328-05	1	88	\N	2017-11-09 10:32:04.131339-05
91	No children were allowed	1	2017-11-09 10:32:04.162463-05	9	89	\N	2017-11-09 10:32:04.162475-05
92	No children were allowed.	5	2017-11-09 10:32:04.193042-05	8	89	\N	2017-11-09 10:32:04.193053-05
93	This place was LIT! Definitely will return.	5	2017-11-09 10:32:04.223515-05	3	89	\N	2017-11-09 10:32:04.223527-05
94	This is an absolute must for every developers took kit.	5	2017-11-09 10:32:04.25414-05	13	90	\N	2017-11-09 10:32:04.254151-05
95	not everything can be 5 stars.	2	2017-11-09 10:32:04.284717-05	5	90	\N	2017-11-09 10:32:04.284728-05
96	Lions (and Lanisters) are the worst! The only reason you should want to find them is to feed them to your dragons.	1	2017-11-09 10:32:04.316191-05	3	94	\N	2017-11-09 10:32:04.316202-05
97	I really like it	4	2017-11-09 10:32:04.34616-05	21	96	\N	2017-11-09 10:32:04.346171-05
98	Useless, everybody knows rooms are round.  So how does this even work?  	1	2017-11-09 10:32:04.376334-05	17	99	\N	2017-11-09 10:32:04.376345-05
99	Great app must try it today.	5	2017-11-09 10:32:04.405949-05	15	99	\N	2017-11-09 10:32:04.40596-05
100	Not the nicest to work with.  I keep losing my stapler when around.	1	2017-11-09 10:32:04.43622-05	4	100	\N	2017-11-09 10:32:04.436231-05
101	Won't kill you for no reason.  Will kill you though. 	3	2017-11-09 10:32:04.466131-05	8	100	\N	2017-11-09 10:32:04.466142-05
102	Interesting this might be something to look at.	4	2017-11-09 10:32:04.49623-05	15	101	\N	2017-11-09 10:32:04.496242-05
103	I don't understand how this works.  How can the map represent something that exists?  Like, if i'm standing on the ground, then how that ground be on the map?  Pure nonsense.  5/5 stars	5	2017-11-09 10:32:04.526217-05	17	102	\N	2017-11-09 10:32:04.526227-05
104	Great app must try it today.	5	2017-11-09 10:32:04.55637-05	15	102	\N	2017-11-09 10:32:04.556381-05
105	A very very very very fun game	5	2017-11-09 10:32:04.58696-05	1	104	\N	2017-11-09 10:32:04.586972-05
106	I am not a very big fan of minesweeper.  But it would be good to pass the time.	2	2017-11-09 10:32:04.617609-05	15	104	\N	2017-11-09 10:32:04.617621-05
107	Cute small sized dogs	5	2017-11-09 10:32:04.648294-05	1	105	\N	2017-11-09 10:32:04.648305-05
108	The best looking dog	5	2017-11-09 10:32:04.678963-05	9	105	\N	2017-11-09 10:32:04.678975-05
109	Obvious attempt to influence people based on cuteness.	1	2017-11-09 10:32:04.70989-05	17	105	\N	2017-11-09 10:32:04.709901-05
110	I, a completely different person, also dislike this app and everything it stands for.	1	2017-11-09 10:32:04.741161-05	2	105	\N	2017-11-09 10:32:04.741172-05
111	Hello, comrade, this is also a completely different person.  I agree, worst dog ever. 	1	2017-11-09 10:32:04.771581-05	3	105	\N	2017-11-09 10:32:04.771592-05
112	Where was this dog on 9/11?  Hmm?  Do you kneow?  I don't.  Just asking a question.	1	2017-11-09 10:32:04.8019-05	4	105	\N	2017-11-09 10:32:04.801911-05
113	How do I give less than 1 star?  zero stars for this smug little brat of a dog. 	1	2017-11-09 10:32:04.832497-05	5	105	\N	2017-11-09 10:32:04.832508-05
114	Hitler's favorite breed.  Look it up. 	1	2017-11-09 10:32:04.863198-05	6	105	\N	2017-11-09 10:32:04.863209-05
115	I can't even with this dog. 	1	2017-11-09 10:32:04.893414-05	7	105	\N	2017-11-09 10:32:04.893425-05
116	Nobody likes this dog.  I asked everybody who is me.  YET!  Still it persists at a 2.0 rating?  fake reviews sheeple!  wake up. 	1	2017-11-09 10:32:04.924246-05	8	105	\N	2017-11-09 10:32:04.924257-05
117	I was looking for a food mixer and could not find it	1	2017-11-09 10:32:04.954959-05	1	107	\N	2017-11-09 10:32:04.95497-05
118	Is this a primate dating app?	1	2017-11-09 10:32:04.986126-05	13	108	\N	2017-11-09 10:32:04.986137-05
119	Not big enough for my dragons to eat	1	2017-11-09 10:32:05.016385-05	3	108	\N	2017-11-09 10:32:05.016397-05
120	An essential component of dragon fire. Helps burn citadels down. A+	5	2017-11-09 10:32:05.046599-05	3	109	\N	2017-11-09 10:32:05.04661-05
121	I am not a big fan of moonshine.	2	2017-11-09 10:32:05.078379-05	15	109	\N	2017-11-09 10:32:05.07839-05
122	A motorcycle helmet can be a life saver	5	2017-11-09 10:32:05.110119-05	1	111	\N	2017-11-09 10:32:05.11013-05
123	I'm confused about that sport part.  Doesn't the engine do all the work?  Shouldn't it be called, "Trynottocrashthemotor"	4	2017-11-09 10:32:05.141235-05	17	112	\N	2017-11-09 10:32:05.141246-05
124	Okay so it does not make sense from the images but the app is still great.	3	2017-11-09 10:32:05.171446-05	15	112	\N	2017-11-09 10:32:05.171458-05
125	Very good to use for navigation.	5	2017-11-09 10:32:05.201756-05	1	116	\N	2017-11-09 10:32:05.201767-05
126	Great app must try it today.	4	2017-11-09 10:32:05.231995-05	15	116	\N	2017-11-09 10:32:05.232007-05
127	not everything can be 5 stars.	2	2017-11-09 10:32:05.262191-05	5	116	\N	2017-11-09 10:32:05.262201-05
128	Aided us safely in our journey to Westeros.	5	2017-11-09 10:32:05.291973-05	3	116	\N	2017-11-09 10:32:05.291984-05
129	Everything can be 5 stars if you put your mind to it.	5	2017-11-09 10:32:05.322211-05	4	116	\N	2017-11-09 10:32:05.322222-05
130	Pretty good to use for navigation.	4	2017-11-09 10:32:05.366301-05	1	117	\N	2017-11-09 10:32:05.366321-05
131	Okay app must try it today.	3	2017-11-09 10:32:05.413147-05	15	117	\N	2017-11-09 10:32:05.413169-05
132	It's so blueeeee~~~!!!!!	5	2017-11-09 10:32:05.466394-05	12	118	\N	2017-11-09 10:32:05.466415-05
133	NO MORE #$(*)&@#% BLUE THINGS. 	1	2017-11-09 10:32:05.516212-05	17	118	\N	2017-11-09 10:32:05.516231-05
134	This switch allows many computers to be connected	4	2017-11-09 10:32:05.562232-05	1	119	\N	2017-11-09 10:32:05.562249-05
135	It prevented and controlled my high blood pressure during surgery	5	2017-11-09 10:32:05.603921-05	1	125	\N	2017-11-09 10:32:05.603936-05
136	LOL what is this doing here? Not even a planet.	1	2017-11-09 10:32:05.64132-05	12	128	\N	2017-11-09 10:32:05.641335-05
137	Fake news, Pluto was a planet when I was a kid, so its a planet now.  You can't just go around unplaneting things. 	5	2017-11-09 10:32:05.678988-05	17	128	\N	2017-11-09 10:32:05.679001-05
138	Strong female rulers! As long as she doesn't invade Westeros she's cool	3	2017-11-09 10:32:05.714383-05	3	132	\N	2017-11-09 10:32:05.714396-05
139	This is what I have a hand to assist me with. This does not meet my use cases at all.	2	2017-11-09 10:32:05.74923-05	3	133	\N	2017-11-09 10:32:05.749243-05
140	Not very interesting.  Hard to follow.  Does not seem to work.	1	2017-11-09 10:32:05.785797-05	4	133	\N	2017-11-09 10:32:05.78581-05
141	The rail road is fine, but when I tried to drive my car on it, it was very slow.  I think the rail road should have better compatibility. 	3	2017-11-09 10:32:05.820818-05	4	134	\N	2017-11-09 10:32:05.82083-05
142	Railroad Ima gonna let you finish but everybody knows shipping lanes had the best transport ever. 	5	2017-11-09 10:32:05.853504-05	17	134	\N	2017-11-09 10:32:05.853516-05
143	Great app must try it today.	4	2017-11-09 10:32:05.885437-05	15	134	\N	2017-11-09 10:32:05.885448-05
144	gave her a hug and was in a coma for 9 years.  Can't recommend. 	2	2017-11-09 10:32:05.917321-05	8	135	\N	2017-11-09 10:32:05.917332-05
145	Good for jewelry in my house colors.	5	2017-11-09 10:32:05.948594-05	3	136	\N	2017-11-09 10:32:05.948605-05
146	The currently available sailing publications and web sites are often filled with stories that are something less than insightful. 	3	2017-11-09 10:32:05.980333-05	5	142	\N	2017-11-09 10:32:05.980345-05
147	Okay to use for navigation, not the best.	3	2017-11-09 10:32:06.011484-05	1	146	\N	2017-11-09 10:32:06.011495-05
148	Great app must try it today.	5	2017-11-09 10:32:06.042607-05	15	146	\N	2017-11-09 10:32:06.042618-05
149	What's up with that dumb ring?	3	2017-11-09 10:32:06.07347-05	12	147	\N	2017-11-09 10:32:06.073481-05
150	I did like it.  I did like it so much.  So i put rings on it.  -God, probably. 	5	2017-11-09 10:32:06.105338-05	17	147	\N	2017-11-09 10:32:06.105349-05
151	The cold does not feel good	1	2017-11-09 10:32:06.135928-05	1	154	\N	2017-11-09 10:32:06.135939-05
152	I've heard that it knows nothing. 	3	2017-11-09 10:32:06.166024-05	17	154	\N	2017-11-09 10:32:06.166036-05
153	Snows refuse to bend the knee in my experience.	2	2017-11-09 10:32:06.196326-05	3	154	\N	2017-11-09 10:32:06.196337-05
154	This stop sign saved me from a accident!!! 	5	2017-11-09 10:32:06.225931-05	1	158	\N	2017-11-09 10:32:06.225943-05
155	I think that this is very necessary item to have on the roads.	5	2017-11-09 10:32:06.256535-05	15	158	\N	2017-11-09 10:32:06.256546-05
156	It takes bold brewers to brew bold beers. Brewers prepared to go to lengths that others wouldn't to perfect their craft. 	5	2017-11-09 10:32:06.287181-05	5	159	\N	2017-11-09 10:32:06.287192-05
157	Stroke play, also known as medal play, is a scoring system in the sport of golf. 	3	2017-11-09 10:32:06.317044-05	5	160	\N	2017-11-09 10:32:06.317055-05
158	Kinda need this guy.	5	2017-11-09 10:32:06.348456-05	12	162	\N	2017-11-09 10:32:06.348467-05
159	I will allow it for now, but I dislike his posturing threat of blowing up in a billion years. 	5	2017-11-09 10:32:06.379259-05	17	162	\N	2017-11-09 10:32:06.37927-05
160	I like this!  Are they touring soon? 	5	2017-11-09 10:32:06.410052-05	17	163	\N	2017-11-09 10:32:06.410063-05
161	Not sure about this one.	3	2017-11-09 10:32:06.439928-05	15	163	\N	2017-11-09 10:32:06.439939-05
162	Pretty good group would say that they are better than average.	4	2017-11-09 10:32:06.469957-05	15	166	\N	2017-11-09 10:32:06.469968-05
163	My favorite type of music genre 	5	2017-11-09 10:32:06.500653-05	1	166	\N	2017-11-09 10:32:06.500664-05
164	I've not heard of this band.  I wish the radio would play them. 	3	2017-11-09 10:32:06.531414-05	8	166	\N	2017-11-09 10:32:06.531425-05
165	Okay this one looks good as well.	3	2017-11-09 10:32:06.562401-05	15	168	\N	2017-11-09 10:32:06.562412-05
166	I would listen to this when I want to. 	4	2017-11-09 10:32:06.591807-05	17	168	\N	2017-11-09 10:32:06.591818-05
167	Tornado are too powerful	1	2017-11-09 10:32:06.621325-05	1	169	\N	2017-11-09 10:32:06.621336-05
168	Not a fan.  Scary and destructive.	1	2017-11-09 10:32:06.651885-05	4	169	\N	2017-11-09 10:32:06.651896-05
169	Kicks up a lot of dust and makes the dothraki less effective	1	2017-11-09 10:32:06.68196-05	3	169	\N	2017-11-09 10:32:06.68199-05
170	Don't be a child.  Its a fine enough place. 	5	2017-11-09 10:32:06.712029-05	17	173	\N	2017-11-09 10:32:06.712041-05
171	Looks like an egg, was there a chicken first?  	2	2017-11-09 10:32:06.743025-05	13	173	\N	2017-11-09 10:32:06.743036-05
172	Not really feeling the vibes.	4	2017-11-09 10:32:06.773904-05	12	174	\N	2017-11-09 10:32:06.773916-05
173	It is too arrogant. 	1	2017-11-09 10:32:06.805831-05	17	174	\N	2017-11-09 10:32:06.805851-05
174	Best time to use when it's hot outside.	4	2017-11-09 10:32:06.838888-05	9	178	\N	2017-11-09 10:32:06.838899-05
175	I ate a seed and a watermelon grew in my belly.  This provided an unlimited supply of food.  Try it and see! 	5	2017-11-09 10:32:06.869907-05	17	178	\N	2017-11-09 10:32:06.869919-05
176	Hilariously ripe and delicioius.	5	2017-11-09 10:32:06.900296-05	3	178	\N	2017-11-09 10:32:06.900307-05
177	The dothraki find these creatures useful though my dragons would prefer them as food. -1 Star for not flying	4	2017-11-09 10:32:06.931323-05	3	180	\N	2017-11-09 10:32:06.931334-05
178	Need this for my neighbourhood.	5	2017-11-09 10:32:06.9623-05	15	186	\N	2017-11-09 10:32:06.962311-05
179	So easy to use that a wolf came to me! It's knee wasn't very bendy though so -1 star.	4	2017-11-09 10:32:06.992651-05	3	186	\N	2017-11-09 10:32:06.992662-05
180	I don't understand how the guy who controls metal doesn't just throw this guy into orbit. 	3	2017-11-09 10:32:07.023521-05	17	187	\N	2017-11-09 10:32:07.023533-05
\.


--
-- Name: ozpcenter_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_review_id_seq', 180, true);


--
-- Data for Name: ozpcenter_screenshot; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_screenshot (id, large_image_id, listing_id, small_image_id, description, "order") FROM stdin;
1	764	1	763	Black and White picture of Two Guitars	0
2	766	2	765	airmail screenshot set 1	0
3	768	2	767	airmail screenshot set 2	1
4	770	3	769	\N	0
5	772	4	771	Not actual photo of alien	0
6	774	5	773	\N	0
7	776	6	775	\N	0
8	778	7	777	\N	0
9	780	8	779	Astrology Software	0
10	782	9	781	\N	0
11	784	10	783	\N	0
12	786	10	785	\N	1
13	788	11	787	\N	0
14	790	12	789	\N	0
15	792	13	791	Invented basketball	0
16	794	14	793	Now that's a fish.	0
17	796	15	795	Can he land a bass?	0
18	798	16	797	\N	0
19	800	17	799	\N	0
20	802	18	801	\N	0
21	804	18	803	X-P	1
22	806	18	805	Kurdt	2
23	808	19	807	\N	0
24	810	20	809	\N	0
25	812	21	811	The real developers tool kit.	0
26	814	22	813	\N	0
27	816	23	815	\N	0
28	818	24	817	There's the meat; get in my belly!!!	0
29	820	25	819	\N	0
30	822	26	821	\N	0
31	824	27	823	\N	0
32	826	28	825	\N	0
33	828	29	827	\N	0
34	830	30	829	\N	0
35	832	31	831	\N	0
36	834	32	833	\N	0
37	836	33	835	\N	0
38	838	33	837	\N	1
39	840	34	839	\N	0
40	842	34	841	\N	1
41	844	34	843	\N	2
42	846	35	845	Chicken and Waffles	0
43	848	35	847	Chicken and Waffles	1
44	850	36	849	\N	0
45	852	37	851	\N	0
46	854	38	853	\N	0
47	856	39	855	\N	0
48	858	40	857	\N	0
49	860	41	859	\N	0
50	862	42	861	\N	0
51	864	43	863	\N	0
52	866	43	865	\N	1
53	868	44	867	Loose diamonds on a white background	0
54	870	44	869	Diamond necklace	1
55	872	44	871	A pendant with diamond and other gem stones	2
56	874	44	873	a diamond on a black background	3
57	876	45	875	Scariest one in history	0
58	878	45	877	\N	1
59	880	46	879	\N	0
60	882	47	881	An example of a dragon	0
61	884	47	883	Dragon footprints	1
62	886	48	885	\N	0
63	888	49	887	\N	0
64	890	50	889	Keyboard	0
65	892	51	891	\N	0
66	894	52	893	\N	0
67	896	53	895	\N	0
68	898	54	897	\N	0
69	900	55	899	\N	0
70	902	56	901	Floppy Disk	0
71	904	56	903	This is the floppy disk drive	1
72	906	57	905	Math Formula	0
73	908	58	907	\N	0
74	910	59	909	\N	0
75	912	60	911	\N	0
76	914	61	913	\N	0
77	916	62	915	\N	0
78	918	63	917	\N	0
79	920	64	919	Map and jaw pictures	0
80	922	65	921	\N	0
81	924	66	923	\N	0
82	926	67	925	Island	0
83	928	67	927	I like turtles	1
84	930	68	929	Cersei	0
85	932	68	931	Tyrion Lannister	1
86	934	68	933	Jamie Lannister	2
87	936	69	935	John Snow 1	0
88	938	69	937	Bran Stark	1
89	940	69	939	Sansa 3	2
90	942	69	941	Arya 4	3
91	944	70	943	Targaryen house sigil	0
92	946	70	945	Daenerys Targaryen with one of her adolescent dragons	1
93	948	71	947	\N	0
94	950	72	949	\N	0
95	952	73	951	\N	0
96	954	74	953	\N	0
97	956	74	955	\N	1
98	958	74	957	\N	2
99	960	74	959	\N	3
100	962	75	961	\N	0
101	964	76	963	\N	0
102	966	76	965	\N	1
103	968	76	967	\N	2
104	970	77	969	\N	0
105	972	78	971	\N	0
106	974	78	973	\N	1
107	976	79	975	\N	0
108	978	80	977	\N	0
109	980	81	979	\N	0
110	982	82	981	\N	0
111	984	83	983	\N	0
112	986	84	985	\N	0
113	988	85	987	\N	0
114	990	86	989	\N	0
115	992	87	991	\N	0
116	994	88	993	Komodo Dragon on a rock	0
117	996	89	995	A ranch	0
118	998	90	997	\N	0
119	1000	91	999	Adults superficially resemble eels in that they have scaleless, elongated bodies, and can range from 13 to 100 cm (5 to 40 inches) in length	0
120	1002	92	1001	Smooth average learning curve graph.	0
121	1004	92	1003	Exponential growth learning curve graph	1
122	1006	92	1005	Exponential rise and fall to a limit learning curve graph	2
123	1008	92	1007	S-Curve or Sigmoid function learning curve graph	3
124	1010	93	1009	White Lightning	0
125	1012	94	1011	\N	0
126	1014	95	1013	\N	0
127	1016	96	1015	\N	0
128	1018	97	1017	\N	0
129	1020	98	1019	\N	0
130	1022	99	1021	\N	0
131	1024	100	1023	\N	0
132	1026	101	1025	\N	0
133	1028	102	1027	\N	0
134	1030	103	1029	\N	0
135	1032	104	1031	\N	0
136	1034	105	1033	When dachshunds get mad	0
137	1036	106	1035	\N	0
138	1038	106	1037	\N	1
139	1040	107	1039	\N	0
140	1042	107	1041	\N	1
141	1044	108	1043	Baboon	0
142	1046	109	1045	\N	0
143	1048	110	1047	\N	0
144	1050	111	1049	MotorcycleHelmet 1	0
145	1052	112	1051	\N	0
146	1054	113	1053	\N	0
147	1056	114	1055	\N	0
148	1058	115	1057	\N	0
149	1060	115	1059	\N	1
150	1062	116	1061	\N	0
151	1064	117	1063	\N	0
152	1066	118	1065	\N	0
153	1068	119	1067	\N	0
154	1070	120	1069	Newspaper	0
155	1072	121	1071	Green Parrot	0
156	1074	121	1073	Red Parrot	1
157	1076	122	1075	birds...	0
158	1078	123	1077	\N	0
159	1080	124	1079	\N	0
160	1082	125	1081	\N	0
161	1084	126	1083	\N	0
162	1086	127	1085	\N	0
163	1088	128	1087	\N	0
164	1090	129	1089	The boxes for the original Gameboy Advance versionsof Pokemon Ruby and Sapphire	0
165	1092	129	1091	The cases for the new 3DS versions Pokemon Omega Ruby and Alpha Sapphire	1
166	1094	129	1093	Animated gif of the gameplay near one of the locations you can fish as well as find and plant berries	2
167	1096	130	1095	\N	0
168	1098	131	1097	\N	0
169	1100	132	1099	\N	0
170	1102	133	1101	\N	0
171	1104	133	1103	\N	1
172	1106	134	1105	\N	0
173	1108	135	1107	\N	0
174	1110	136	1109	example of a ruby	0
175	1112	137	1111	Ruby miner fancy logo	0
176	1114	138	1113	Screenshot of rails development	0
177	1116	139	1115	\N	0
178	1118	140	1117	\N	0
179	1120	141	1119	\N	0
180	1122	141	1121	\N	1
181	1124	142	1123	\N	0
182	1126	143	1125	\N	0
183	1128	143	1127	\N	1
184	1130	144	1129	\N	0
185	1132	145	1131	A sapphire and diamond ring	0
186	1134	146	1133	\N	0
187	1136	147	1135	\N	0
188	1138	148	1137	2016\n\n    CVO Pro Street Breakout (FXSE)\n    CVO Street Glide (FLHXSE)\n    CVO Road Glide Ultra (FLTRUSE)\n    CVO Ultra Limited (FLHTKSE)	0
189	1140	149	1139	Music Sheet	0
190	1142	150	1141	\N	0
191	1144	151	1143	\N	0
192	1146	152	1145	\N	0
193	1148	153	1147	Smart Phone	0
194	1150	154	1149	After a night of snow	0
195	1152	154	1151	Animal in snow	1
196	1154	155	1153	\N	0
197	1156	156	1155	\N	0
198	1158	157	1157	\N	0
199	1160	157	1159	\N	1
200	1162	158	1161	Stop	0
201	1164	159	1163	\N	0
202	1166	160	1165	In single player, these include a story mode, stroke play mode, and match mode, while in multiplayer, Balloon Pop mode replaces the story mode.	0
203	1168	161	1167	\N	0
204	1170	162	1169	\N	0
205	1172	163	1171	\N	0
206	1174	163	1173	Chris	1
207	1176	164	1175	\N	0
208	1178	165	1177	Giant Grouper and Red lionfish	0
209	1180	166	1179	\N	0
210	1182	166	1181	\N	1
211	1184	167	1183	\N	0
212	1186	168	1185	STP	0
213	1188	168	1187	\N	1
214	1190	169	1189	Tornado Destruction	0
215	1192	170	1191	\N	0
216	1194	170	1193	\N	1
217	1196	171	1195	\N	0
218	1198	172	1197	\N	0
219	1200	173	1199	\N	0
220	1202	174	1201	\N	0
221	1204	175	1203	Modern Violin	0
222	1206	176	1205	\N	0
223	1208	177	1207	Voodoo 1	0
224	1210	178	1209	Slices of watermelon	0
225	1212	179	1211	\N	0
226	1214	180	1213	White Horse	0
227	1216	180	1215	\N	1
228	1218	181	1217	\N	0
229	1220	182	1219	\N	0
230	1222	183	1221	\N	0
231	1224	184	1223	\N	0
232	1226	185	1225	WitchDoctor 1	0
233	1228	185	1227	WitchDoctor 2	1
234	1230	186	1229	\N	0
235	1232	186	1231	\N	1
236	1234	187	1233	\N	0
237	1236	188	1235	Writing down on a piece of paper	0
\.


--
-- Name: ozpcenter_screenshot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_screenshot_id_seq', 237, true);


--
-- Data for Name: ozpcenter_subscription; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_subscription (id, entity_type, entity_id, target_profile_id) FROM stdin;
\.


--
-- Name: ozpcenter_subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_subscription_id_seq', 1, false);


--
-- Data for Name: ozpcenter_tag; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpcenter_tag (id, name) FROM stdin;
1	demo
2	example
3	acoustic
4	classical
5	concert
6	guitar
7	instrument
8	spanish
9	string
10	strings
11	wooded
12	demo_tag
13	tag_0
14	hardware
15	Aliens
16	Space
17	history
18	maps
19	navigation
20	bad guys
21	ethics
22	organizational
23	social
24	hocus pocus
25	horoscope
26	Planets
27	baltimore
28	football
29	maryland
30	ravens
31	bbq
32	food
33	meat
34	sause
35	Basketball
36	NBA
37	Sports
38	bass
39	fish
40	mike
41	learning
42	work
43	xlure
44	avengers
45	x-men
46	Grunge
47	rail
48	transport
49	booze
50	buzz
51	drink
52	good
53	hangover
54	character
55	USDA
56	brisket
57	smoked
58	steak
59	Architecture
60	Buildings
61	business
62	insurance
63	risk
64	managment
65	process
66	Kevin Smith
67	cake
68	yum
69	chicken
70	waffles
71	Comedy
72	Movie
73	m$
74	microsoft
75	paperclip
76	arrow
77	bow
78	hunting
79	sport
80	merc
81	automation
82	desktop
83	efficiency
84	virtualization
85	carbon
86	chocolate
87	diamond
88	gem
89	gemstone
90	jewelry
91	white
92	Animals
93	Dead
94	Extinct
95	Reptiles
96	book
97	fantasy
98	imaginary
99	legend
100	mythology
101	car
102	driving
103	toll
104	music
105	sound
106	wood
107	wooden
108	keyboard
109	piano
110	recording
111	synthesizer
112	beer
113	pencil
114	bikes
115	games
116	nes
117	auto
118	automobile
119	about
120	don't
121	it
122	talk
123	Memory
124	Old
125	Storage
126	chalk
127	conceptual
128	handwritten
129	math
130	physics
131	science
132	text
133	writing
134	software
135	record
136	vinyl
137	clock
138	time
139	shark
140	CVO
141	davidson
142	harley
143	motorcycle
144	Expensive
145	Travel
146	Vacation
147	House Lannister
148	casterly rock
149	cersei
150	game of thrones
151	got
152	jaime
153	joffrey
154	tyrion
155	Starks
156	arya
157	bran
158	catelyn
159	direwolf
160	direwolves
161	jon
162	king in the north
163	ned
164	red wedding
165	rickon
166	sansa
167	winter is coming
168	daenerys
169	dany
170	dragon
171	fire and blood
172	mother of dragons
173	targaryen
174	codex
175	encyclopedia
176	free
177	brainstorm
178	collaborate
179	intelligent
180	funny
181	meme
182	pictures
183	Avengers
184	protein
185	images
186	tool
187	Mammal
188	Science
189	Lizard
190	Monitor
191	Reptile
192	Cows
193	Lit
194	Ranch
195	experience
196	self improvement
197	discharge
198	electrostatic
199	lightning
200	sky
201	storm
202	thunder
203	thunderstorm
204	weather
205	zeus
206	mammal
207	positioning
208	game
209	Dogs
210	comics
211	monkey
212	alchohol
213	fire water
214	homemade
215	white lightning
216	language
217	morse code
218	sos
219	bike
220	vehicle
221	movie
222	tv
223	Video games
224	video games
225	computer
226	connection
227	electronic
228	equipment
229	internet
230	person
231	rack
232	wire
233	facts
234	information
235	journal
236	journalism
237	journalist
238	news
239	newspaper
240	office
241	paper
242	press
243	animal
244	avian
245	bird
246	feathers
247	parrot
248	zygodactyl
249	pacific
250	parrotlet
251	small
252	smallest
253	brand
254	cellphone
255	contemporary
256	desk
257	display
258	electronics
259	headphone
260	indoors
261	mobile phone
262	monitor
263	mouse
264	organized
265	pc
266	screen
267	sony
268	table
269	technology
270	watch
271	wireless
272	Phentolamine
273	video game
274	antique
275	black-and-white
276	grand
277	musical
278	NOT A PLANET
279	game freak
280	gotta catch 'em all
281	nintendo
282	pocket monsters
283	pokemon
284	mail
285	agile
286	pm
287	pmo
288	scrum
289	transportation
290	red
291	ruby
292	stone
293	programming
294	rails
295	ror
296	developer
297	development
298	framework
299	text editor
300	Video Games
301	boat
302	boats
303	racing
304	sail
305	sea
306	yacht
307	yummy
308	water
309	blue
310	satellite
311	Harley
312	Screamin Eagle
313	close-up
314	note
315	notes
316	electric
317	plane
318	cellular
319	communication
320	contacts
321	device
322	modern
323	phone
324	smartphone
325	Cold
326	Weather
327	flower
328	audio
329	equalizer
330	fader
331	mixer
332	mixing
333	panel
334	studio
335	stop
336	club
337	golf
338	speed
339	Music
340	Soundgarden
341	clamp
342	nut
343	classifier
344	Pearl Jam
345	STP
346	disaster
347	force
348	natural
349	nature
350	powerful
351	tornado
352	wind
353	bug
354	classic
355	violin
356	magic
357	Food
358	Fruit
359	Fruits
360	equestrian
361	horse
362	pasture
363	wildlife
364	video Games
365	data
366	info
367	research
368	test
369	doc
370	doctor
371	medicine
372	notebook
373	pen
\.


--
-- Name: ozpcenter_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpcenter_tag_id_seq', 373, true);


--
-- Data for Name: ozpiwc_dataresource; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY ozpiwc_dataresource (id, key, entity, content_type, username, pattern, permissions, version) FROM stdin;
\.


--
-- Name: ozpiwc_dataresource_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('ozpiwc_dataresource_id_seq', 1, false);


--
-- Data for Name: profile_listing; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY profile_listing (id, listing_id, profile_id) FROM stdin;
2006	1	1
2007	2	5
2008	3	4
2009	4	9
2010	5	15
2011	6	17
2012	7	13
2013	7	5
2014	8	4
2015	9	12
2016	10	4
2017	11	13
2018	12	12
2019	13	9
2020	14	4
2021	14	13
2022	15	13
2023	16	17
2024	17	15
2025	18	4
2026	18	5
2027	19	17
2028	20	15
2029	21	13
2030	22	4
2031	23	6
2032	24	4
2033	24	13
2034	25	9
2035	26	4
2036	26	5
2037	27	5
2038	28	15
2039	29	15
2040	30	5
2041	31	4
2042	32	6
2043	33	4
2044	34	4
2045	34	13
2046	35	4
2047	36	4
2048	37	4
2049	38	5
2050	39	4
2051	40	4
2052	40	13
2053	41	17
2054	42	17
2055	43	5
2056	44	5
2057	45	9
2058	46	4
2059	47	2
2060	47	3
2061	48	4
2062	49	1
2063	50	1
2064	51	4
2065	52	4
2066	53	4
2067	54	4
2068	55	4
2069	56	9
2070	57	1
2071	58	5
2072	59	15
2073	60	4
2074	61	15
2075	62	4
2076	63	4
2077	63	13
2078	64	1
2079	65	4
2080	65	13
2081	66	5
2082	67	9
2083	68	1
2084	69	1
2085	70	3
2086	71	4
2087	72	4
2088	73	1
2089	74	4
2090	74	5
2091	75	15
2092	76	4
2093	77	17
2094	78	4
2095	78	1
2096	79	12
2097	80	4
2098	81	17
2099	82	5
2100	83	12
2101	84	4
2102	85	4
2103	86	15
2104	87	1
2105	88	3
2106	89	9
2107	90	4
2108	91	1
2109	92	3
2110	93	1
2111	94	1
2112	95	5
2113	96	5
2114	97	5
2115	98	4
2116	99	15
2117	100	17
2118	101	4
2119	102	15
2120	103	4
2121	104	4
2122	105	9
2123	106	4
2124	107	4
2125	108	1
2126	109	13
2127	110	4
2128	111	4
2129	112	15
2130	113	4
2131	114	4
2132	115	4
2133	116	15
2134	117	15
2135	118	12
2136	119	1
2137	120	1
2138	121	1
2139	122	13
2140	123	4
2141	124	1
2142	125	4
2143	126	4
2144	126	1
2145	126	15
2146	127	1
2147	128	12
2148	129	3
2149	130	15
2150	131	4
2151	132	4
2152	133	2
2153	133	13
2154	133	5
2155	134	15
2156	135	17
2157	136	5
2158	137	5
2159	138	21
2160	139	15
2161	140	4
2162	141	4
2163	142	1
2164	143	1
2165	143	13
2166	144	4
2167	145	5
2168	146	15
2169	147	12
2170	148	13
2171	149	1
2172	150	15
2173	151	4
2174	152	8
2175	152	10
2176	153	1
2177	154	9
2178	155	4
2179	156	1
2180	157	4
2181	157	13
2182	158	4
2183	159	4
2184	160	13
2185	161	4
2186	162	12
2187	163	4
2188	164	4
2189	165	1
2190	166	4
2191	167	4
2192	168	4
2193	169	1
2194	170	4
2195	171	15
2196	172	4
2197	173	12
2198	174	12
2199	175	1
2200	176	4
2201	177	4
2202	177	13
2203	178	9
2204	179	4
2205	180	1
2206	181	4
2207	182	4
2208	183	4
2209	184	13
2210	184	5
2211	185	4
2212	185	13
2213	186	1
2214	187	17
2215	188	1
\.


--
-- Name: profile_listing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('profile_listing_id_seq', 2215, true);


--
-- Data for Name: stewarded_agency_profile; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY stewarded_agency_profile (id, profile_id, agency_id) FROM stdin;
121	4	5
122	4	6
123	4	1
124	4	7
125	4	8
126	4	9
127	5	1
128	6	1
129	6	3
130	7	2
131	7	4
132	8	3
\.


--
-- Name: stewarded_agency_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('stewarded_agency_profile_id_seq', 132, true);


--
-- Data for Name: tag_listing; Type: TABLE DATA; Schema: public; Owner: ozp_user
--

COPY tag_listing (id, listing_id, tag_id) FROM stdin;
5302	1	3
5303	1	4
5304	1	5
5305	1	6
5306	1	7
5307	1	8
5308	1	9
5309	1	10
5310	1	11
5311	2	1
5312	2	12
5313	2	2
5314	2	13
5315	3	14
5316	4	15
5317	4	16
5318	5	17
5319	5	18
5320	5	19
5321	6	20
5322	7	21
5323	7	22
5324	7	23
5325	8	24
5326	8	25
5327	9	26
5328	10	27
5329	10	28
5330	10	29
5331	10	30
5332	11	31
5333	11	32
5334	11	33
5335	11	34
5336	12	26
5337	13	35
5338	13	36
5339	13	37
5340	14	38
5341	14	39
5342	14	40
5343	15	38
5344	15	39
5345	15	41
5346	15	42
5347	15	43
5348	16	44
5349	16	45
5350	17	18
5351	17	19
5352	18	46
5353	19	45
5354	20	47
5355	20	48
5356	21	49
5357	21	50
5358	21	51
5359	21	52
5360	21	53
5361	22	54
5362	23	1
5363	23	12
5364	23	2
5365	24	55
5366	24	31
5367	24	56
5368	24	33
5369	24	57
5370	24	58
5371	25	59
5372	25	60
5373	26	61
5374	26	62
5375	26	63
5376	27	64
5377	27	65
5378	27	63
5379	28	48
5380	29	19
5381	30	1
5382	30	12
5383	31	66
5384	32	1
5385	32	12
5386	33	32
5387	34	67
5388	34	39
5389	34	52
5390	34	68
5391	35	69
5392	35	32
5393	35	70
5394	36	71
5395	36	66
5396	36	72
5397	37	66
5398	37	72
5399	38	1
5400	38	12
5401	39	73
5402	39	74
5403	39	75
5404	40	76
5405	40	77
5406	40	78
5407	40	79
5408	41	45
5409	42	80
5410	43	81
5411	43	82
5412	43	83
5413	43	84
5414	44	85
5415	44	86
5416	44	87
5417	44	88
5418	44	89
5419	44	90
5420	44	91
5421	45	92
5422	45	93
5423	45	94
5424	45	95
5425	46	96
5426	47	97
5427	47	98
5428	47	99
5429	47	100
5430	48	101
5431	48	102
5432	48	103
5433	49	6
5434	49	7
5435	49	104
5436	49	105
5437	49	10
5438	49	106
5439	49	107
5440	50	7
5441	50	108
5442	50	104
5443	50	109
5444	50	110
5445	50	111
5446	51	112
5447	52	113
5448	53	114
5449	53	115
5450	53	116
5451	54	117
5452	54	118
5453	54	101
5454	55	119
5455	55	120
5456	55	121
5457	55	122
5458	56	123
5459	56	124
5460	56	125
5461	57	126
5462	57	127
5463	57	128
5464	57	41
5465	57	129
5466	57	130
5467	57	131
5468	57	132
5469	57	133
5470	58	1
5471	58	12
5472	59	18
5473	60	134
5474	61	18
5475	61	19
5476	62	104
5477	62	135
5478	62	136
5479	63	137
5480	63	138
5481	64	39
5482	64	131
5483	64	139
5484	65	140
5485	65	141
5486	65	142
5487	65	143
5488	66	1
5489	66	12
5490	67	144
5491	67	145
5492	67	146
5493	68	147
5494	68	148
5495	68	149
5496	68	150
5497	68	151
5498	68	152
5499	68	153
5500	68	154
5501	69	155
5502	69	156
5503	69	157
5504	69	158
5505	69	159
5506	69	160
5507	69	150
5508	69	151
5509	69	161
5510	69	162
5511	69	163
5512	69	164
5513	69	165
5514	69	166
5515	69	167
5516	70	168
5517	70	169
5518	70	170
5519	70	171
5520	70	150
5521	70	151
5522	70	172
5523	70	173
5524	71	174
5525	72	112
5526	73	175
5527	73	176
5528	74	177
5529	74	178
5530	75	179
5531	75	48
5532	76	180
5533	76	181
5534	76	182
5535	77	183
5536	78	46
5537	79	26
5538	80	66
5539	81	45
5540	82	1
5541	82	12
5542	83	26
5543	84	184
5544	85	185
5545	85	182
5546	86	18
5547	86	19
5548	86	186
5549	87	187
5550	87	188
5551	88	189
5552	88	190
5553	88	191
5554	89	192
5555	89	193
5556	89	194
5557	90	112
5558	91	39
5559	91	131
5560	92	195
5561	92	41
5562	92	196
5563	93	197
5564	93	198
5565	93	199
5566	93	200
5567	93	201
5568	93	202
5569	93	203
5570	93	204
5571	93	205
5572	94	206
5573	94	131
5574	95	1
5575	95	12
5576	96	1
5577	96	12
5578	97	1
5579	97	12
5580	98	54
5581	99	207
5582	100	20
5583	101	66
5584	102	18
5585	103	54
5586	104	208
5587	105	209
5588	106	210
5589	107	104
5590	108	1
5591	108	12
5592	108	206
5593	108	211
5594	109	212
5595	109	49
5596	109	213
5597	109	214
5598	109	215
5599	110	216
5600	110	217
5601	110	218
5602	111	219
5603	111	143
5604	111	220
5605	112	219
5606	112	101
5607	113	221
5608	113	222
5609	114	223
5610	115	224
5611	116	18
5612	116	19
5613	117	18
5614	117	19
5615	118	26
5616	119	225
5617	119	226
5618	119	227
5619	119	228
5620	119	229
5621	119	230
5622	119	231
5623	119	232
5624	120	61
5625	120	233
5626	120	234
5627	120	235
5628	120	236
5629	120	237
5630	120	238
5631	120	239
5632	120	240
5633	120	241
5634	120	242
5635	121	243
5636	121	244
5637	121	245
5638	121	246
5639	121	247
5640	121	248
5641	122	249
5642	122	247
5643	122	250
5644	122	251
5645	122	252
5646	123	113
5647	124	253
5648	124	61
5649	124	254
5650	124	225
5651	124	226
5652	124	255
5653	124	256
5654	124	257
5655	124	258
5656	124	259
5657	124	260
5658	124	229
5659	124	108
5660	124	261
5661	124	262
5662	124	263
5663	124	240
5664	124	264
5665	124	265
5666	124	266
5667	124	267
5668	124	268
5669	124	269
5670	124	270
5671	124	271
5672	125	272
5673	126	208
5674	126	273
5675	127	274
5676	127	275
5677	127	276
5678	127	7
5679	127	104
5680	127	277
5681	127	109
5682	127	106
5683	127	107
5684	128	278
5685	129	279
5686	129	280
5687	129	281
5688	129	282
5689	129	283
5690	129	273
5691	130	18
5692	130	19
5693	131	284
5694	132	54
5695	133	285
5696	133	286
5697	133	287
5698	133	288
5699	134	289
5700	135	45
5701	136	88
5702	136	89
5703	136	90
5704	136	290
5705	136	291
5706	136	292
5707	137	293
5708	137	294
5709	137	295
5710	137	291
5711	138	296
5712	138	297
5713	138	298
5714	138	293
5715	138	294
5716	138	295
5717	138	291
5718	138	134
5719	139	18
5720	139	19
5721	139	134
5722	140	299
5723	141	300
5724	142	301
5725	142	302
5726	142	303
5727	142	304
5728	142	305
5729	142	306
5730	143	39
5731	143	307
5732	144	308
5733	145	309
5734	145	88
5735	145	89
5736	145	90
5737	145	292
5738	146	18
5739	146	19
5740	146	310
5741	147	26
5742	148	140
5743	148	311
5744	148	312
5745	148	219
5746	148	143
5747	149	96
5748	149	313
5749	149	104
5750	149	314
5751	149	315
5752	149	241
5753	150	316
5754	150	47
5755	150	48
5756	151	317
5757	152	1
5758	152	12
5759	153	61
5760	153	254
5761	153	318
5762	153	319
5763	153	226
5764	153	320
5765	153	321
5766	153	257
5767	153	322
5768	153	323
5769	153	324
5770	153	271
5771	154	325
5772	154	326
5773	155	327
5774	156	328
5775	156	329
5776	156	330
5777	156	331
5778	156	332
5779	156	104
5780	156	333
5781	156	105
5782	156	334
5783	157	58
5784	158	335
5785	159	112
5786	160	336
5787	160	337
5788	160	338
5789	161	96
5790	162	26
5791	163	46
5792	163	339
5793	163	340
5794	164	341
5795	164	342
5796	165	343
5797	165	1
5798	166	46
5799	166	344
5800	167	79
5801	168	46
5802	168	345
5803	169	346
5804	169	347
5805	169	348
5806	169	349
5807	169	350
5808	169	351
5809	169	204
5810	169	352
5811	170	101
5812	171	18
5813	171	19
5814	171	134
5815	172	243
5816	172	353
5817	173	26
5818	174	26
5819	175	77
5820	175	354
5821	175	4
5822	175	7
5823	175	104
5824	175	105
5825	175	10
5826	175	355
5827	175	106
5828	175	107
5829	176	224
5830	177	356
5831	178	357
5832	178	358
5833	178	359
5834	179	112
5835	180	243
5836	180	360
5837	180	361
5838	180	206
5839	180	362
5840	180	91
5841	180	363
5842	181	243
5843	182	224
5844	183	364
5845	184	365
5846	184	366
5847	184	367
5848	184	368
5849	185	369
5850	185	370
5851	185	371
5852	186	206
5853	186	131
5854	187	45
5855	188	372
5856	188	241
5857	188	373
5858	188	133
\.


--
-- Name: tag_listing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ozp_user
--

SELECT pg_catalog.setval('tag_listing_id_seq', 5858, true);


--
-- Name: agency_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY agency_profile
    ADD CONSTRAINT agency_profile_pkey PRIMARY KEY (id);


--
-- Name: agency_profile_profile_id_agency_id_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY agency_profile
    ADD CONSTRAINT agency_profile_profile_id_agency_id_key UNIQUE (profile_id, agency_id);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: category_listing_listing_id_category_id_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY category_listing
    ADD CONSTRAINT category_listing_listing_id_category_id_key UNIQUE (listing_id, category_id);


--
-- Name: category_listing_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY category_listing
    ADD CONSTRAINT category_listing_pkey PRIMARY KEY (id);


--
-- Name: contact_listing_listing_id_contact_id_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY contact_listing
    ADD CONSTRAINT contact_listing_listing_id_contact_id_key UNIQUE (listing_id, contact_id);


--
-- Name: contact_listing_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY contact_listing
    ADD CONSTRAINT contact_listing_pkey PRIMARY KEY (id);


--
-- Name: corsheaders_corsmodel_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY corsheaders_corsmodel
    ADD CONSTRAINT corsheaders_corsmodel_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_3bb28cb8ea571a60_uniq; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_3bb28cb8ea571a60_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: intent_listing_listing_id_intent_id_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY intent_listing
    ADD CONSTRAINT intent_listing_listing_id_intent_id_key UNIQUE (listing_id, intent_id);


--
-- Name: intent_listing_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY intent_listing
    ADD CONSTRAINT intent_listing_pkey PRIMARY KEY (id);


--
-- Name: listing_activity_change_detai_listingactivity_id_changedeta_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY listing_activity_change_detail
    ADD CONSTRAINT listing_activity_change_detai_listingactivity_id_changedeta_key UNIQUE (listingactivity_id, changedetail_id);


--
-- Name: listing_activity_change_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY listing_activity_change_detail
    ADD CONSTRAINT listing_activity_change_detail_pkey PRIMARY KEY (id);


--
-- Name: notification_profile_notification_id_profile_id_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY notification_profile
    ADD CONSTRAINT notification_profile_notification_id_profile_id_key UNIQUE (notification_id, profile_id);


--
-- Name: notification_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY notification_profile
    ADD CONSTRAINT notification_profile_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_agency_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_agency
    ADD CONSTRAINT ozpcenter_agency_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_agency_short_name_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_agency
    ADD CONSTRAINT ozpcenter_agency_short_name_key UNIQUE (short_name);


--
-- Name: ozpcenter_agency_title_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_agency
    ADD CONSTRAINT ozpcenter_agency_title_key UNIQUE (title);


--
-- Name: ozpcenter_applicationlibraryentry_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_applicationlibraryentry
    ADD CONSTRAINT ozpcenter_applicationlibraryentry_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_category_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_category
    ADD CONSTRAINT ozpcenter_category_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_category_title_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_category
    ADD CONSTRAINT ozpcenter_category_title_key UNIQUE (title);


--
-- Name: ozpcenter_changedetail_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_changedetail
    ADD CONSTRAINT ozpcenter_changedetail_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_contact_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_contact
    ADD CONSTRAINT ozpcenter_contact_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_contacttype_name_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_contacttype
    ADD CONSTRAINT ozpcenter_contacttype_name_key UNIQUE (name);


--
-- Name: ozpcenter_contacttype_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_contacttype
    ADD CONSTRAINT ozpcenter_contacttype_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_docurl_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_docurl
    ADD CONSTRAINT ozpcenter_docurl_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_image_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_image
    ADD CONSTRAINT ozpcenter_image_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_image_uuid_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_image
    ADD CONSTRAINT ozpcenter_image_uuid_key UNIQUE (uuid);


--
-- Name: ozpcenter_imagetype_name_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_imagetype
    ADD CONSTRAINT ozpcenter_imagetype_name_key UNIQUE (name);


--
-- Name: ozpcenter_imagetype_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_imagetype
    ADD CONSTRAINT ozpcenter_imagetype_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_intent_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_intent
    ADD CONSTRAINT ozpcenter_intent_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_listing_current_rejection_id_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_listing
    ADD CONSTRAINT ozpcenter_listing_current_rejection_id_key UNIQUE (current_rejection_id);


--
-- Name: ozpcenter_listing_last_activity_id_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_listing
    ADD CONSTRAINT ozpcenter_listing_last_activity_id_key UNIQUE (last_activity_id);


--
-- Name: ozpcenter_listing_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_listing
    ADD CONSTRAINT ozpcenter_listing_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_listing_unique_name_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_listing
    ADD CONSTRAINT ozpcenter_listing_unique_name_key UNIQUE (unique_name);


--
-- Name: ozpcenter_listingactivity_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_listingactivity
    ADD CONSTRAINT ozpcenter_listingactivity_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_listingtype_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_listingtype
    ADD CONSTRAINT ozpcenter_listingtype_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_listingtype_title_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_listingtype
    ADD CONSTRAINT ozpcenter_listingtype_title_key UNIQUE (title);


--
-- Name: ozpcenter_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_notification
    ADD CONSTRAINT ozpcenter_notification_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_notificationmailbox_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_notificationmailbox
    ADD CONSTRAINT ozpcenter_notificationmailbox_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_profile_dn_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_profile
    ADD CONSTRAINT ozpcenter_profile_dn_key UNIQUE (dn);


--
-- Name: ozpcenter_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_profile
    ADD CONSTRAINT ozpcenter_profile_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_profile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_profile
    ADD CONSTRAINT ozpcenter_profile_user_id_key UNIQUE (user_id);


--
-- Name: ozpcenter_recommendationfeedback_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_recommendationfeedback
    ADD CONSTRAINT ozpcenter_recommendationfeedback_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_recommendationsentry_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_recommendationsentry
    ADD CONSTRAINT ozpcenter_recommendationsentry_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_review_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_review
    ADD CONSTRAINT ozpcenter_review_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_screenshot_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_screenshot
    ADD CONSTRAINT ozpcenter_screenshot_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_subscription
    ADD CONSTRAINT ozpcenter_subscription_pkey PRIMARY KEY (id);


--
-- Name: ozpcenter_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_tag
    ADD CONSTRAINT ozpcenter_tag_name_key UNIQUE (name);


--
-- Name: ozpcenter_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpcenter_tag
    ADD CONSTRAINT ozpcenter_tag_pkey PRIMARY KEY (id);


--
-- Name: ozpiwc_dataresource_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpiwc_dataresource
    ADD CONSTRAINT ozpiwc_dataresource_pkey PRIMARY KEY (id);


--
-- Name: ozpiwc_dataresource_username_75d088372482b805_uniq; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY ozpiwc_dataresource
    ADD CONSTRAINT ozpiwc_dataresource_username_75d088372482b805_uniq UNIQUE (username, key);


--
-- Name: profile_listing_listing_id_profile_id_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY profile_listing
    ADD CONSTRAINT profile_listing_listing_id_profile_id_key UNIQUE (listing_id, profile_id);


--
-- Name: profile_listing_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY profile_listing
    ADD CONSTRAINT profile_listing_pkey PRIMARY KEY (id);


--
-- Name: stewarded_agency_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY stewarded_agency_profile
    ADD CONSTRAINT stewarded_agency_profile_pkey PRIMARY KEY (id);


--
-- Name: stewarded_agency_profile_profile_id_agency_id_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY stewarded_agency_profile
    ADD CONSTRAINT stewarded_agency_profile_profile_id_agency_id_key UNIQUE (profile_id, agency_id);


--
-- Name: tag_listing_listing_id_tag_id_key; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY tag_listing
    ADD CONSTRAINT tag_listing_listing_id_tag_id_key UNIQUE (listing_id, tag_id);


--
-- Name: tag_listing_pkey; Type: CONSTRAINT; Schema: public; Owner: ozp_user; Tablespace: 
--

ALTER TABLE ONLY tag_listing
    ADD CONSTRAINT tag_listing_pkey PRIMARY KEY (id);


--
-- Name: agency_profile_169fc544; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX agency_profile_169fc544 ON agency_profile USING btree (agency_id);


--
-- Name: agency_profile_83a0eb3f; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX agency_profile_83a0eb3f ON agency_profile USING btree (profile_id);


--
-- Name: auth_group_name_3ad1a0e7949f9d2a_like; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX auth_group_name_3ad1a0e7949f9d2a_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX auth_user_groups_0e939a4f ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX auth_user_groups_e8701ad4 ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_8373b171 ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_e8701ad4 ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6129fcc871f48a65_like; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX auth_user_username_6129fcc871f48a65_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: category_listing_a5acdb6c; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX category_listing_a5acdb6c ON category_listing USING btree (listing_id);


--
-- Name: category_listing_b583a629; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX category_listing_b583a629 ON category_listing USING btree (category_id);


--
-- Name: contact_listing_6d82f13d; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX contact_listing_6d82f13d ON contact_listing USING btree (contact_id);


--
-- Name: contact_listing_a5acdb6c; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX contact_listing_a5acdb6c ON contact_listing USING btree (listing_id);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_221fa7b1ed1d672_like; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX django_session_session_key_221fa7b1ed1d672_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: intent_listing_a5acdb6c; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX intent_listing_a5acdb6c ON intent_listing USING btree (listing_id);


--
-- Name: intent_listing_a5d69478; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX intent_listing_a5d69478 ON intent_listing USING btree (intent_id);


--
-- Name: listing_activity_change_detail_528f1dff; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX listing_activity_change_detail_528f1dff ON listing_activity_change_detail USING btree (listingactivity_id);


--
-- Name: listing_activity_change_detail_e27da002; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX listing_activity_change_detail_e27da002 ON listing_activity_change_detail USING btree (changedetail_id);


--
-- Name: notification_profile_53fb5b6b; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX notification_profile_53fb5b6b ON notification_profile USING btree (notification_id);


--
-- Name: notification_profile_83a0eb3f; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX notification_profile_83a0eb3f ON notification_profile USING btree (profile_id);


--
-- Name: ozpcenter_agency_fe6647e8; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_agency_fe6647e8 ON ozpcenter_agency USING btree (icon_id);


--
-- Name: ozpcenter_agency_short_name_62a59e53d907f0d4_like; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_agency_short_name_62a59e53d907f0d4_like ON ozpcenter_agency USING btree (short_name varchar_pattern_ops);


--
-- Name: ozpcenter_agency_title_6c9b52be0bc95bf3_like; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_agency_title_6c9b52be0bc95bf3_like ON ozpcenter_agency USING btree (title varchar_pattern_ops);


--
-- Name: ozpcenter_applicationlibraryentry_5e7b1936; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_applicationlibraryentry_5e7b1936 ON ozpcenter_applicationlibraryentry USING btree (owner_id);


--
-- Name: ozpcenter_applicationlibraryentry_a5acdb6c; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_applicationlibraryentry_a5acdb6c ON ozpcenter_applicationlibraryentry USING btree (listing_id);


--
-- Name: ozpcenter_category_title_3c384c9cb9c4c4cf_like; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_category_title_3c384c9cb9c4c4cf_like ON ozpcenter_category USING btree (title varchar_pattern_ops);


--
-- Name: ozpcenter_contact_b4a73b95; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_contact_b4a73b95 ON ozpcenter_contact USING btree (contact_type_id);


--
-- Name: ozpcenter_contacttype_name_72b5054300884f0c_like; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_contacttype_name_72b5054300884f0c_like ON ozpcenter_contacttype USING btree (name varchar_pattern_ops);


--
-- Name: ozpcenter_docurl_a5acdb6c; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_docurl_a5acdb6c ON ozpcenter_docurl USING btree (listing_id);


--
-- Name: ozpcenter_image_bba883bb; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_image_bba883bb ON ozpcenter_image USING btree (image_type_id);


--
-- Name: ozpcenter_image_uuid_af31bd52ef50d54_like; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_image_uuid_af31bd52ef50d54_like ON ozpcenter_image USING btree (uuid varchar_pattern_ops);


--
-- Name: ozpcenter_imagetype_name_5a7e3660d70b4bd7_like; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_imagetype_name_5a7e3660d70b4bd7_like ON ozpcenter_imagetype USING btree (name varchar_pattern_ops);


--
-- Name: ozpcenter_intent_fe6647e8; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_intent_fe6647e8 ON ozpcenter_intent USING btree (icon_id);


--
-- Name: ozpcenter_listing_169fc544; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_listing_169fc544 ON ozpcenter_listing USING btree (agency_id);


--
-- Name: ozpcenter_listing_2d32ca62; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_listing_2d32ca62 ON ozpcenter_listing USING btree (small_icon_id);


--
-- Name: ozpcenter_listing_55d22161; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_listing_55d22161 ON ozpcenter_listing USING btree (listing_type_id);


--
-- Name: ozpcenter_listing_6ea97d1f; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_listing_6ea97d1f ON ozpcenter_listing USING btree (required_listings_id);


--
-- Name: ozpcenter_listing_7d6976c7; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_listing_7d6976c7 ON ozpcenter_listing USING btree (large_banner_icon_id);


--
-- Name: ozpcenter_listing_bf208909; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_listing_bf208909 ON ozpcenter_listing USING btree (banner_icon_id);


--
-- Name: ozpcenter_listing_fb492c13; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_listing_fb492c13 ON ozpcenter_listing USING btree (large_icon_id);


--
-- Name: ozpcenter_listing_unique_name_168ca3eb4e50a421_like; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_listing_unique_name_168ca3eb4e50a421_like ON ozpcenter_listing USING btree (unique_name varchar_pattern_ops);


--
-- Name: ozpcenter_listingactivity_4f331e2f; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_listingactivity_4f331e2f ON ozpcenter_listingactivity USING btree (author_id);


--
-- Name: ozpcenter_listingactivity_a5acdb6c; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_listingactivity_a5acdb6c ON ozpcenter_listingactivity USING btree (listing_id);


--
-- Name: ozpcenter_listingtype_title_7477e6bbc02b457_like; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_listingtype_title_7477e6bbc02b457_like ON ozpcenter_listingtype USING btree (title varchar_pattern_ops);


--
-- Name: ozpcenter_notification_169fc544; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_notification_169fc544 ON ozpcenter_notification USING btree (agency_id);


--
-- Name: ozpcenter_notification_4f331e2f; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_notification_4f331e2f ON ozpcenter_notification USING btree (author_id);


--
-- Name: ozpcenter_notification_a5acdb6c; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_notification_a5acdb6c ON ozpcenter_notification USING btree (listing_id);


--
-- Name: ozpcenter_notification_dffc4713; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_notification_dffc4713 ON ozpcenter_notification USING btree (entity_id);


--
-- Name: ozpcenter_notificationmailbox_14c1d39e; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_notificationmailbox_14c1d39e ON ozpcenter_notificationmailbox USING btree (target_profile_id);


--
-- Name: ozpcenter_notificationmailbox_53fb5b6b; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_notificationmailbox_53fb5b6b ON ozpcenter_notificationmailbox USING btree (notification_id);


--
-- Name: ozpcenter_profile_dn_1e55d9f07a0f6de3_like; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_profile_dn_1e55d9f07a0f6de3_like ON ozpcenter_profile USING btree (dn varchar_pattern_ops);


--
-- Name: ozpcenter_recommendationfeedback_093698ee; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_recommendationfeedback_093698ee ON ozpcenter_recommendationfeedback USING btree (target_listing_id);


--
-- Name: ozpcenter_recommendationfeedback_14c1d39e; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_recommendationfeedback_14c1d39e ON ozpcenter_recommendationfeedback USING btree (target_profile_id);


--
-- Name: ozpcenter_recommendationsentry_14c1d39e; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_recommendationsentry_14c1d39e ON ozpcenter_recommendationsentry USING btree (target_profile_id);


--
-- Name: ozpcenter_review_4334f859; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_review_4334f859 ON ozpcenter_review USING btree (review_parent_id);


--
-- Name: ozpcenter_review_4f331e2f; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_review_4f331e2f ON ozpcenter_review USING btree (author_id);


--
-- Name: ozpcenter_review_a5acdb6c; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_review_a5acdb6c ON ozpcenter_review USING btree (listing_id);


--
-- Name: ozpcenter_screenshot_2e890d9b; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_screenshot_2e890d9b ON ozpcenter_screenshot USING btree (small_image_id);


--
-- Name: ozpcenter_screenshot_42efd8fd; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_screenshot_42efd8fd ON ozpcenter_screenshot USING btree (large_image_id);


--
-- Name: ozpcenter_screenshot_a5acdb6c; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_screenshot_a5acdb6c ON ozpcenter_screenshot USING btree (listing_id);


--
-- Name: ozpcenter_subscription_14c1d39e; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_subscription_14c1d39e ON ozpcenter_subscription USING btree (target_profile_id);


--
-- Name: ozpcenter_subscription_89111891; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_subscription_89111891 ON ozpcenter_subscription USING btree (entity_type);


--
-- Name: ozpcenter_subscription_dffc4713; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_subscription_dffc4713 ON ozpcenter_subscription USING btree (entity_id);


--
-- Name: ozpcenter_subscription_entity_type_3a0213f84034746b_like; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_subscription_entity_type_3a0213f84034746b_like ON ozpcenter_subscription USING btree (entity_type varchar_pattern_ops);


--
-- Name: ozpcenter_tag_name_71ff1c32f5c4dd55_like; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX ozpcenter_tag_name_71ff1c32f5c4dd55_like ON ozpcenter_tag USING btree (name varchar_pattern_ops);


--
-- Name: profile_listing_83a0eb3f; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX profile_listing_83a0eb3f ON profile_listing USING btree (profile_id);


--
-- Name: profile_listing_a5acdb6c; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX profile_listing_a5acdb6c ON profile_listing USING btree (listing_id);


--
-- Name: stewarded_agency_profile_169fc544; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX stewarded_agency_profile_169fc544 ON stewarded_agency_profile USING btree (agency_id);


--
-- Name: stewarded_agency_profile_83a0eb3f; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX stewarded_agency_profile_83a0eb3f ON stewarded_agency_profile USING btree (profile_id);


--
-- Name: tag_listing_76f094bc; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX tag_listing_76f094bc ON tag_listing USING btree (tag_id);


--
-- Name: tag_listing_a5acdb6c; Type: INDEX; Schema: public; Owner: ozp_user; Tablespace: 
--

CREATE INDEX tag_listing_a5acdb6c ON tag_listing USING btree (listing_id);


--
-- Name: D0a6d12d6bad1898cbfd9ebc8cd9cea7; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY listing_activity_change_detail
    ADD CONSTRAINT "D0a6d12d6bad1898cbfd9ebc8cd9cea7" FOREIGN KEY (listingactivity_id) REFERENCES ozpcenter_listingactivity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D56abefc45441b6879bb42098ebd6977; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_listing
    ADD CONSTRAINT "D56abefc45441b6879bb42098ebd6977" FOREIGN KEY (current_rejection_id) REFERENCES ozpcenter_listingactivity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D6fbd0237223db863d6e6c8e30fe2e01; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_listing
    ADD CONSTRAINT "D6fbd0237223db863d6e6c8e30fe2e01" FOREIGN KEY (last_activity_id) REFERENCES ozpcenter_listingactivity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: agency_prof_profile_id_4b89dee6750cfae8_fk_ozpcenter_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY agency_profile
    ADD CONSTRAINT agency_prof_profile_id_4b89dee6750cfae8_fk_ozpcenter_profile_id FOREIGN KEY (profile_id) REFERENCES ozpcenter_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: agency_profil_agency_id_1ee8a860e9b219e6_fk_ozpcenter_agency_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY agency_profile
    ADD CONSTRAINT agency_profil_agency_id_1ee8a860e9b219e6_fk_ozpcenter_agency_id FOREIGN KEY (agency_id) REFERENCES ozpcenter_agency(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_content_type_id_100c1f664bb767bc_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_content_type_id_100c1f664bb767bc_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissio_group_id_10297e644d483925_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_group_id_10297e644d483925_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permission_id_436bf4629d4dcbd9_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permission_id_436bf4629d4dcbd9_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_11dfab2bae0f9c53_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_11dfab2bae0f9c53_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_user_id_4599617763fb2ca8_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_4599617763fb2ca8_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_u_permission_id_32220a7f5f2cfd3_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_u_permission_id_32220a7f5f2cfd3_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permiss_user_id_407ebf86b4cc8714_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permiss_user_id_407ebf86b4cc8714_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: category__category_id_7fd27aafbb32dea6_fk_ozpcenter_category_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY category_listing
    ADD CONSTRAINT category__category_id_7fd27aafbb32dea6_fk_ozpcenter_category_id FOREIGN KEY (category_id) REFERENCES ozpcenter_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: category_li_listing_id_494e3812b4a2182d_fk_ozpcenter_listing_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY category_listing
    ADD CONSTRAINT category_li_listing_id_494e3812b4a2182d_fk_ozpcenter_listing_id FOREIGN KEY (listing_id) REFERENCES ozpcenter_listing(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: contact_lis_contact_id_33e112809e32f46d_fk_ozpcenter_contact_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY contact_listing
    ADD CONSTRAINT contact_lis_contact_id_33e112809e32f46d_fk_ozpcenter_contact_id FOREIGN KEY (contact_id) REFERENCES ozpcenter_contact(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: contact_lis_listing_id_164cff37001eaa2e_fk_ozpcenter_listing_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY contact_listing
    ADD CONSTRAINT contact_lis_listing_id_164cff37001eaa2e_fk_ozpcenter_listing_id FOREIGN KEY (listing_id) REFERENCES ozpcenter_listing(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djan_content_type_id_3c3ef0e568e26cdd_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT djan_content_type_id_3c3ef0e568e26cdd_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_6d87a2e462904f8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_6d87a2e462904f8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: intent_list_listing_id_6f2b3bec74fc90d5_fk_ozpcenter_listing_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY intent_listing
    ADD CONSTRAINT intent_list_listing_id_6f2b3bec74fc90d5_fk_ozpcenter_listing_id FOREIGN KEY (listing_id) REFERENCES ozpcenter_listing(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: intent_listin_intent_id_59a0121a93878b08_fk_ozpcenter_intent_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY intent_listing
    ADD CONSTRAINT intent_listin_intent_id_59a0121a93878b08_fk_ozpcenter_intent_id FOREIGN KEY (intent_id) REFERENCES ozpcenter_intent(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: li_changedetail_id_fd6468c1e1ba59f_fk_ozpcenter_changedetail_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY listing_activity_change_detail
    ADD CONSTRAINT li_changedetail_id_fd6468c1e1ba59f_fk_ozpcenter_changedetail_id FOREIGN KEY (changedetail_id) REFERENCES ozpcenter_changedetail(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: n_notification_id_728ef0c61308d908_fk_ozpcenter_notification_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY notification_profile
    ADD CONSTRAINT n_notification_id_728ef0c61308d908_fk_ozpcenter_notification_id FOREIGN KEY (notification_id) REFERENCES ozpcenter_notification(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: notificatio_profile_id_408e4bac9578be38_fk_ozpcenter_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY notification_profile
    ADD CONSTRAINT notificatio_profile_id_408e4bac9578be38_fk_ozpcenter_profile_id FOREIGN KEY (profile_id) REFERENCES ozpcenter_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: o_notification_id_11017721d5367eb4_fk_ozpcenter_notification_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_notificationmailbox
    ADD CONSTRAINT o_notification_id_11017721d5367eb4_fk_ozpcenter_notification_id FOREIGN KEY (notification_id) REFERENCES ozpcenter_notification(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: o_required_listings_id_1fb9c100517c3efd_fk_ozpcenter_listing_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_listing
    ADD CONSTRAINT o_required_listings_id_1fb9c100517c3efd_fk_ozpcenter_listing_id FOREIGN KEY (required_listings_id) REFERENCES ozpcenter_listing(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oz_contact_type_id_27df93faff156276_fk_ozpcenter_contacttype_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_contact
    ADD CONSTRAINT oz_contact_type_id_27df93faff156276_fk_ozpcenter_contacttype_id FOREIGN KEY (contact_type_id) REFERENCES ozpcenter_contacttype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oz_listing_type_id_1ade0a1022e7748b_fk_ozpcenter_listingtype_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_listing
    ADD CONSTRAINT oz_listing_type_id_1ade0a1022e7748b_fk_ozpcenter_listingtype_id FOREIGN KEY (listing_type_id) REFERENCES ozpcenter_listingtype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozp_large_banner_icon_id_1d379fbb0165932f_fk_ozpcenter_image_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_listing
    ADD CONSTRAINT ozp_large_banner_icon_id_1d379fbb0165932f_fk_ozpcenter_image_id FOREIGN KEY (large_banner_icon_id) REFERENCES ozpcenter_image(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpc_target_listing_id_266e5d53fffcd4b8_fk_ozpcenter_listing_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_recommendationfeedback
    ADD CONSTRAINT ozpc_target_listing_id_266e5d53fffcd4b8_fk_ozpcenter_listing_id FOREIGN KEY (target_listing_id) REFERENCES ozpcenter_listing(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpc_target_profile_id_3b31a68e9d6def4d_fk_ozpcenter_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_subscription
    ADD CONSTRAINT ozpc_target_profile_id_3b31a68e9d6def4d_fk_ozpcenter_profile_id FOREIGN KEY (target_profile_id) REFERENCES ozpcenter_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpc_target_profile_id_4d9e39e5871311bf_fk_ozpcenter_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_recommendationfeedback
    ADD CONSTRAINT ozpc_target_profile_id_4d9e39e5871311bf_fk_ozpcenter_profile_id FOREIGN KEY (target_profile_id) REFERENCES ozpcenter_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpc_target_profile_id_5324f38bfca6bbb4_fk_ozpcenter_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_recommendationsentry
    ADD CONSTRAINT ozpc_target_profile_id_5324f38bfca6bbb4_fk_ozpcenter_profile_id FOREIGN KEY (target_profile_id) REFERENCES ozpcenter_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpce_target_profile_id_ab3d8ead83f0aea_fk_ozpcenter_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_notificationmailbox
    ADD CONSTRAINT ozpce_target_profile_id_ab3d8ead83f0aea_fk_ozpcenter_profile_id FOREIGN KEY (target_profile_id) REFERENCES ozpcenter_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcen_image_type_id_3ecbf22799e02043_fk_ozpcenter_imagetype_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_image
    ADD CONSTRAINT ozpcen_image_type_id_3ecbf22799e02043_fk_ozpcenter_imagetype_id FOREIGN KEY (image_type_id) REFERENCES ozpcenter_imagetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcen_review_parent_id_125c3a9fc5ce3907_fk_ozpcenter_review_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_review
    ADD CONSTRAINT ozpcen_review_parent_id_125c3a9fc5ce3907_fk_ozpcenter_review_id FOREIGN KEY (review_parent_id) REFERENCES ozpcenter_review(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter__large_icon_id_7d60b34d6c3e194d_fk_ozpcenter_image_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_listing
    ADD CONSTRAINT ozpcenter__large_icon_id_7d60b34d6c3e194d_fk_ozpcenter_image_id FOREIGN KEY (large_icon_id) REFERENCES ozpcenter_image(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter__small_icon_id_70bd9d22b0948367_fk_ozpcenter_image_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_listing
    ADD CONSTRAINT ozpcenter__small_icon_id_70bd9d22b0948367_fk_ozpcenter_image_id FOREIGN KEY (small_icon_id) REFERENCES ozpcenter_image(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter_a_listing_id_78946b421dcbfdd5_fk_ozpcenter_listing_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_applicationlibraryentry
    ADD CONSTRAINT ozpcenter_a_listing_id_78946b421dcbfdd5_fk_ozpcenter_listing_id FOREIGN KEY (listing_id) REFERENCES ozpcenter_listing(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter_agency_icon_id_42b4fc78a6233c78_fk_ozpcenter_image_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_agency
    ADD CONSTRAINT ozpcenter_agency_icon_id_42b4fc78a6233c78_fk_ozpcenter_image_id FOREIGN KEY (icon_id) REFERENCES ozpcenter_image(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter_app_owner_id_1b61eb254a69a969_fk_ozpcenter_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_applicationlibraryentry
    ADD CONSTRAINT ozpcenter_app_owner_id_1b61eb254a69a969_fk_ozpcenter_profile_id FOREIGN KEY (owner_id) REFERENCES ozpcenter_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter_banner_icon_id_724815a528fc6007_fk_ozpcenter_image_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_listing
    ADD CONSTRAINT ozpcenter_banner_icon_id_724815a528fc6007_fk_ozpcenter_image_id FOREIGN KEY (banner_icon_id) REFERENCES ozpcenter_image(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter_d_listing_id_4d5ec50f0fac3266_fk_ozpcenter_listing_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_docurl
    ADD CONSTRAINT ozpcenter_d_listing_id_4d5ec50f0fac3266_fk_ozpcenter_listing_id FOREIGN KEY (listing_id) REFERENCES ozpcenter_listing(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter_intent_icon_id_53f8844a993980d3_fk_ozpcenter_image_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_intent
    ADD CONSTRAINT ozpcenter_intent_icon_id_53f8844a993980d3_fk_ozpcenter_image_id FOREIGN KEY (icon_id) REFERENCES ozpcenter_image(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter_l_listing_id_122c842e2d665b98_fk_ozpcenter_listing_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_listingactivity
    ADD CONSTRAINT ozpcenter_l_listing_id_122c842e2d665b98_fk_ozpcenter_listing_id FOREIGN KEY (listing_id) REFERENCES ozpcenter_listing(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter_large_image_id_4e37ca3a8330c9ee_fk_ozpcenter_image_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_screenshot
    ADD CONSTRAINT ozpcenter_large_image_id_4e37ca3a8330c9ee_fk_ozpcenter_image_id FOREIGN KEY (large_image_id) REFERENCES ozpcenter_image(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter_li_author_id_15a428411ff26033_fk_ozpcenter_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_listingactivity
    ADD CONSTRAINT ozpcenter_li_author_id_15a428411ff26033_fk_ozpcenter_profile_id FOREIGN KEY (author_id) REFERENCES ozpcenter_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter_lis_agency_id_282cdcde18915b2a_fk_ozpcenter_agency_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_listing
    ADD CONSTRAINT ozpcenter_lis_agency_id_282cdcde18915b2a_fk_ozpcenter_agency_id FOREIGN KEY (agency_id) REFERENCES ozpcenter_agency(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter_n_listing_id_1c5f36fd90c53d9e_fk_ozpcenter_listing_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_notification
    ADD CONSTRAINT ozpcenter_n_listing_id_1c5f36fd90c53d9e_fk_ozpcenter_listing_id FOREIGN KEY (listing_id) REFERENCES ozpcenter_listing(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter_not_agency_id_645ae0916a31fe19_fk_ozpcenter_agency_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_notification
    ADD CONSTRAINT ozpcenter_not_agency_id_645ae0916a31fe19_fk_ozpcenter_agency_id FOREIGN KEY (agency_id) REFERENCES ozpcenter_agency(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter_not_author_id_b2ff68e780ddcc9_fk_ozpcenter_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_notification
    ADD CONSTRAINT ozpcenter_not_author_id_b2ff68e780ddcc9_fk_ozpcenter_profile_id FOREIGN KEY (author_id) REFERENCES ozpcenter_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter_profile_user_id_35487f2c30450d57_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_profile
    ADD CONSTRAINT ozpcenter_profile_user_id_35487f2c30450d57_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter_r_listing_id_318213e659d0c78e_fk_ozpcenter_listing_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_review
    ADD CONSTRAINT ozpcenter_r_listing_id_318213e659d0c78e_fk_ozpcenter_listing_id FOREIGN KEY (listing_id) REFERENCES ozpcenter_listing(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter_rev_author_id_133309ec8b0d2a7_fk_ozpcenter_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_review
    ADD CONSTRAINT ozpcenter_rev_author_id_133309ec8b0d2a7_fk_ozpcenter_profile_id FOREIGN KEY (author_id) REFERENCES ozpcenter_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter_s_listing_id_28d3c9716b9119f5_fk_ozpcenter_listing_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_screenshot
    ADD CONSTRAINT ozpcenter_s_listing_id_28d3c9716b9119f5_fk_ozpcenter_listing_id FOREIGN KEY (listing_id) REFERENCES ozpcenter_listing(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ozpcenter_small_image_id_1306d2c5359f7472_fk_ozpcenter_image_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY ozpcenter_screenshot
    ADD CONSTRAINT ozpcenter_small_image_id_1306d2c5359f7472_fk_ozpcenter_image_id FOREIGN KEY (small_image_id) REFERENCES ozpcenter_image(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profile_lis_listing_id_5ba9cfcaf1d5efc1_fk_ozpcenter_listing_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY profile_listing
    ADD CONSTRAINT profile_lis_listing_id_5ba9cfcaf1d5efc1_fk_ozpcenter_listing_id FOREIGN KEY (listing_id) REFERENCES ozpcenter_listing(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profile_lis_profile_id_154cb7a8a7a265bc_fk_ozpcenter_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY profile_listing
    ADD CONSTRAINT profile_lis_profile_id_154cb7a8a7a265bc_fk_ozpcenter_profile_id FOREIGN KEY (profile_id) REFERENCES ozpcenter_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stewarded_a_profile_id_497430da780f1d55_fk_ozpcenter_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY stewarded_agency_profile
    ADD CONSTRAINT stewarded_a_profile_id_497430da780f1d55_fk_ozpcenter_profile_id FOREIGN KEY (profile_id) REFERENCES ozpcenter_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stewarded_age_agency_id_466a180e6346a213_fk_ozpcenter_agency_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY stewarded_agency_profile
    ADD CONSTRAINT stewarded_age_agency_id_466a180e6346a213_fk_ozpcenter_agency_id FOREIGN KEY (agency_id) REFERENCES ozpcenter_agency(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tag_listing_listing_id_7c6488d302b891fb_fk_ozpcenter_listing_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY tag_listing
    ADD CONSTRAINT tag_listing_listing_id_7c6488d302b891fb_fk_ozpcenter_listing_id FOREIGN KEY (listing_id) REFERENCES ozpcenter_listing(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tag_listing_tag_id_9e93413ca4e31fe_fk_ozpcenter_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: ozp_user
--

ALTER TABLE ONLY tag_listing
    ADD CONSTRAINT tag_listing_tag_id_9e93413ca4e31fe_fk_ozpcenter_tag_id FOREIGN KEY (tag_id) REFERENCES ozpcenter_tag(id) DEFERRABLE INITIALLY DEFERRED;


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

