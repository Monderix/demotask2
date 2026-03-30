--
-- PostgreSQL database dump
--

\restrict fa4on7yTYzHi04EqftHrbrRCSXA07ILl7HuE4lPsc8VYhowflli69CPZeAUnk50

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    category_pk character varying(155)
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.items (
    article character varying(155) NOT NULL,
    item_name character varying(255),
    measurement_fk integer,
    cost integer,
    provider_fk integer,
    manufacturer_fk integer,
    category_fk integer,
    discount integer,
    quantity integer,
    description character varying(255),
    picture character varying(255)
);


ALTER TABLE public.items OWNER TO postgres;

--
-- Name: manufacturers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manufacturers (
    id integer NOT NULL,
    manufacturer_pk character varying(155)
);


ALTER TABLE public.manufacturers OWNER TO postgres;

--
-- Name: manufacturers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.manufacturers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.manufacturers_id_seq OWNER TO postgres;

--
-- Name: manufacturers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manufacturers_id_seq OWNED BY public.manufacturers.id;


--
-- Name: measurement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.measurement (
    id integer NOT NULL,
    measurement_pk character varying(55)
);


ALTER TABLE public.measurement OWNER TO postgres;

--
-- Name: measurment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.measurment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.measurment_id_seq OWNER TO postgres;

--
-- Name: measurment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.measurment_id_seq OWNED BY public.measurement.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    order_date timestamp without time zone,
    delivery_date timestamp without time zone,
    pickup_point integer,
    client_full_name integer,
    pickup_code integer,
    status_fk integer
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: orders_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders_items (
    id integer NOT NULL,
    order_id integer,
    article_fk character varying(155),
    quantity integer
);


ALTER TABLE public.orders_items OWNER TO postgres;

--
-- Name: orders_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_items_id_seq OWNER TO postgres;

--
-- Name: orders_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_items_id_seq OWNED BY public.orders_items.id;


--
-- Name: pickup_points; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pickup_points (
    id integer NOT NULL,
    pickup_point_address character varying(255)
);


ALTER TABLE public.pickup_points OWNER TO postgres;

--
-- Name: pickup_points_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pickup_points_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pickup_points_id_seq OWNER TO postgres;

--
-- Name: pickup_points_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pickup_points_id_seq OWNED BY public.pickup_points.id;


--
-- Name: providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.providers (
    id integer NOT NULL,
    provider_pk character varying(155)
);


ALTER TABLE public.providers OWNER TO postgres;

--
-- Name: providers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.providers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.providers_id_seq OWNER TO postgres;

--
-- Name: providers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.providers_id_seq OWNED BY public.providers.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    role_name character varying(155)
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status (
    id integer NOT NULL,
    status_name character varying(55)
);


ALTER TABLE public.status OWNER TO postgres;

--
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.status_id_seq OWNER TO postgres;

--
-- Name: status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.status_id_seq OWNED BY public.status.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    role_fk integer,
    full_name character varying(155),
    login character varying(155),
    password character varying(155)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: manufacturers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers ALTER COLUMN id SET DEFAULT nextval('public.manufacturers_id_seq'::regclass);


--
-- Name: measurement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measurement ALTER COLUMN id SET DEFAULT nextval('public.measurment_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: orders_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_items ALTER COLUMN id SET DEFAULT nextval('public.orders_items_id_seq'::regclass);


--
-- Name: pickup_points id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points ALTER COLUMN id SET DEFAULT nextval('public.pickup_points_id_seq'::regclass);


--
-- Name: providers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.providers ALTER COLUMN id SET DEFAULT nextval('public.providers_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status ALTER COLUMN id SET DEFAULT nextval('public.status_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories VALUES (1, 'Корма для кошек');
INSERT INTO public.categories VALUES (2, 'Корма для собак');
INSERT INTO public.categories VALUES (3, 'Наполнители');
INSERT INTO public.categories VALUES (4, 'Игрушки');
INSERT INTO public.categories VALUES (5, 'Клетки и переноски');
INSERT INTO public.categories VALUES (6, 'Амуниция');
INSERT INTO public.categories VALUES (7, 'Гигиена');
INSERT INTO public.categories VALUES (8, 'Аксессуары');
INSERT INTO public.categories VALUES (9, 'Лакомства');
INSERT INTO public.categories VALUES (10, 'Домики и лежанки');
INSERT INTO public.categories VALUES (11, 'Миски и поилки');
INSERT INTO public.categories VALUES (12, 'Корма для птиц');
INSERT INTO public.categories VALUES (13, 'Корма для грызунов');
INSERT INTO public.categories VALUES (14, 'Средства защиты');
INSERT INTO public.categories VALUES (15, 'Корма для рыб');
INSERT INTO public.categories VALUES (16, 'Корма для рептилий');
INSERT INTO public.categories VALUES (17, 'Витамины');


--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.items VALUES ('Z001', 'Корм Royal Canin Sterilised', 1, 1200, 1, 1, 1, 5, 20, 'Сухой корм для стерилизованных кошек. сбалансированный состав', 'rc_sterilised.jpg');
INSERT INTO public.items VALUES ('Z002', 'Корм Purina Pro Plan Puppy', 1, 950, 2, 2, 2, 10, 15, 'Для щенков крупных пород. с курицей и рисом', 'proplan_puppy.jpg');
INSERT INTO public.items VALUES ('Z003', 'Наполнитель CatsBest комкующийся', 2, 450, 1, 3, 3, 0, 8, 'Древесный. 5 л. комкующийся. без пыли', 'catsbest_5l.jpg');
INSERT INTO public.items VALUES ('Z004', 'Игрушка-мышь с кошачьей мятой', 3, 180, 3, 4, 4, 20, 30, 'Интерактивная. с натуральной мятой. пищалка', 'mouse_catnip.jpg');
INSERT INTO public.items VALUES ('Z005', 'Клетка Ferplast два яруса', 3, 2500, 1, 5, 5, 15, 5, 'Для хорьков и крыс. 60×40×50 см', 'ferplast_2floor.jpg');
INSERT INTO public.items VALUES ('Z006', 'Поводок Hunter нейлоновый', 3, 600, 4, 6, 6, 7, 12, 'Длина 2 м. ширина 2.5 см. карабин', 'hunter_leash.jpg');
INSERT INTO public.items VALUES ('Z007', 'Корм Hill''s i/d Low Fat', 1, 1400, 2, 7, 2, 12, 10, 'Диетический. для собак с чувствительным пищеварением', 'hills_id_lowfat.jpg');
INSERT INTO public.items VALUES ('Z008', 'Шампунь Beaphar с ромашкой', 4, 320, 1, 8, 7, 0, 25, 'Для собак и кошек. 250 мл', 'beaphar_chamomile.jpg');
INSERT INTO public.items VALUES ('Z009', 'Когтеточка настенная 50 см', 3, 990, 3, 4, 8, 18, 7, 'Сизаль. самоклеящаяся основа', 'kogtetochka_50.jpg');
INSERT INTO public.items VALUES ('Z010', 'Лакомство GimCat подушечки', 2, 150, 4, 9, 9, 0, 40, 'Витаминные подушечки с таурином. 50 г', 'gimcat_treats.jpg');
INSERT INTO public.items VALUES ('Z011', 'Корм Acana Pacifica', 1, 1650, 5, 10, 2, 8, 9, 'Беззерновой. с сельдью и камбалой', 'acana_pacifica.jpg');
INSERT INTO public.items VALUES ('Z012', 'Корм Orijen Original', 1, 1850, 5, 11, 1, 5, 6, 'Высокобелковый. 85% мяса', 'orijen_original.jpg');
INSERT INTO public.items VALUES ('Z013', 'Наполнитель Zeolit силикагель', 2, 890, 1, 12, 3, 10, 4, 'Силикагелевый. 3.8 л. абсорбирует запах', 'zeolit_38l.jpg');
INSERT INTO public.items VALUES ('Z014', 'Домик для кошек мягкий', 3, 1300, 3, 13, 10, 5, 2, 'Синтепон. съёмный чехол. 45×45 см', 'trixie_bed.jpg');
INSERT INTO public.items VALUES ('Z015', 'Миска двойная Ferplast', 3, 490, 1, 5, 11, 0, 18, 'Нержавеющая сталь. 0.5+0.5 л', 'ferplast_bowl.jpg');
INSERT INTO public.items VALUES ('Z016', 'Корм для попугаев Prestige', 2, 320, 4, 14, 12, 0, 14, 'Зерновая смесь для средних попугаев. 1 кг', 'prestige_parrot.jpg');
INSERT INTO public.items VALUES ('Z017', 'Переноска для грызунов', 3, 750, 1, 15, 5, 12, 3, 'Пластик. с ручкой. 25×15×20 см', 'savic_carrier.jpg');
INSERT INTO public.items VALUES ('Z018', 'Расческа-пуходерка', 3, 220, 6, 13, 7, 0, 22, 'С металлическими зубчиками. антистатик', 'trixie_slicker.jpg');
INSERT INTO public.items VALUES ('Z019', 'Корм для хомяков Little One', 2, 180, 2, 16, 13, 0, 30, 'Зерновая смесь с витаминами. 400 г', 'versele_laga_hamster.jpg');
INSERT INTO public.items VALUES ('Z020', 'Ошейник от блох Beaphar', 3, 350, 6, 8, 14, 7, 11, 'Для кошек. длительность 8 месяцев', 'beaphar_collar.jpg');
INSERT INTO public.items VALUES ('Z021', 'Лакомство для собак Pedigree Dentastix', 2, 280, 4, 17, 9, 10, 45, '7 палочек. для чистки зубов', 'dentastix.jpg');
INSERT INTO public.items VALUES ('Z022', 'Игрушка-колокольчик для попугая', 3, 90, 3, 4, 4, 0, 60, 'Акрил. с бубенцом', 'bell_toy.jpg');
INSERT INTO public.items VALUES ('Z023', 'Корм для аквариумных рыб TetraMin', 4, 430, 1, 18, 15, 5, 17, 'Хлопья для всех тропических рыб. 100 мл', 'tetra_min.jpg');
INSERT INTO public.items VALUES ('Z024', 'Спрей для ухода за шерстью', 4, 380, 5, 19, 7, 20, 8, 'Кондиционер без смывания. 200 мл', 'ivsb_spray.jpg');
INSERT INTO public.items VALUES ('Z025', 'Бюстгальтер для собак (послеопер.)', 3, 950, 6, 13, 6, 15, 0, 'Фиксирующий. для стерилизованных сук. размер S', 'trixie_postop.jpg');
INSERT INTO public.items VALUES ('Z026', 'Трава для кошек в горшке', 3, 180, 1, 14, 8, 0, 12, 'Овес. 10 см. свежая зелень', 'cat_grass.jpg');
INSERT INTO public.items VALUES ('Z027', 'Подстилка впитывающая', 2, 350, 4, 20, 7, 0, 25, '60×60 см. 5 шт. многослойная', 'smarttail_mat.jpg');
INSERT INTO public.items VALUES ('Z028', 'Корм для черепах Reptomin', 5, 290, 1, 18, 16, 0, 9, 'Гранулы для водных черепах. 250 мл', 'tetra_reptomin.jpg');
INSERT INTO public.items VALUES ('Z029', 'Поводок-рулетка Flexi', 3, 1400, 4, 21, 6, 25, 0, 'Автоматическая. до 5 м. для собак до 25 кг', 'flexi_tape.jpg');
INSERT INTO public.items VALUES ('Z030', 'Витамины для хорьков', 2, 320, 6, 8, 17, 10, 6, 'Паста с витаминами. 50 г', 'beaphar_ferret.jpg');


--
-- Data for Name: manufacturers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.manufacturers VALUES (1, 'Royal Canin');
INSERT INTO public.manufacturers VALUES (2, 'Purina');
INSERT INTO public.manufacturers VALUES (3, 'CatsBest');
INSERT INTO public.manufacturers VALUES (4, 'Фабрика игрушек');
INSERT INTO public.manufacturers VALUES (5, 'Ferplast');
INSERT INTO public.manufacturers VALUES (6, 'Hunter');
INSERT INTO public.manufacturers VALUES (7, 'Hill''s');
INSERT INTO public.manufacturers VALUES (8, 'Beaphar');
INSERT INTO public.manufacturers VALUES (9, 'GimCat');
INSERT INTO public.manufacturers VALUES (10, 'Acana');
INSERT INTO public.manufacturers VALUES (11, 'Orijen');
INSERT INTO public.manufacturers VALUES (12, 'ЗооМаркет');
INSERT INTO public.manufacturers VALUES (13, 'Trixie');
INSERT INTO public.manufacturers VALUES (14, 'Vitakraft');
INSERT INTO public.manufacturers VALUES (15, 'Savic');
INSERT INTO public.manufacturers VALUES (16, 'Versele-Laga');
INSERT INTO public.manufacturers VALUES (17, 'Pedigree');
INSERT INTO public.manufacturers VALUES (18, 'Tetra');
INSERT INTO public.manufacturers VALUES (19, 'Iv San Bernard');
INSERT INTO public.manufacturers VALUES (20, 'Умный хвост');
INSERT INTO public.manufacturers VALUES (21, 'Flexi');


--
-- Data for Name: measurement; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.measurement VALUES (1, 'кг');
INSERT INTO public.measurement VALUES (2, 'упак');
INSERT INTO public.measurement VALUES (3, 'шт');
INSERT INTO public.measurement VALUES (4, 'флакон');
INSERT INTO public.measurement VALUES (5, 'банка');


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orders VALUES (1, '2026-02-01 00:00:00', '2026-02-08 00:00:00', 5, 10, 1001, 1);
INSERT INTO public.orders VALUES (2, '2026-02-03 00:00:00', '2026-02-10 00:00:00', 12, 11, 1002, 1);
INSERT INTO public.orders VALUES (3, '2026-02-05 00:00:00', '2026-02-12 00:00:00', 8, 12, 1003, 1);
INSERT INTO public.orders VALUES (4, '2026-02-07 00:00:00', '2026-02-14 00:00:00', 21, 13, 1004, 1);
INSERT INTO public.orders VALUES (5, '2026-02-09 00:00:00', '2026-02-16 00:00:00', 15, 14, 1005, 1);
INSERT INTO public.orders VALUES (6, '2026-02-11 00:00:00', '2026-02-18 00:00:00', 3, 15, 1006, 1);
INSERT INTO public.orders VALUES (7, '2026-02-13 00:00:00', '2026-02-20 00:00:00', 27, 16, 1007, 1);
INSERT INTO public.orders VALUES (8, '2026-02-15 00:00:00', '2026-02-22 00:00:00', 9, 1, 1008, 1);
INSERT INTO public.orders VALUES (9, '2026-02-17 00:00:00', '2026-02-24 00:00:00', 18, 2, 1009, 2);
INSERT INTO public.orders VALUES (10, '2026-02-19 00:00:00', '2026-02-26 00:00:00', 30, 3, 1010, 2);
INSERT INTO public.orders VALUES (11, '2026-02-21 00:00:00', '2026-02-28 00:00:00', 11, 4, 1011, 2);
INSERT INTO public.orders VALUES (12, '2026-02-23 00:00:00', '2026-03-02 00:00:00', 22, 5, 1012, 2);
INSERT INTO public.orders VALUES (13, '2026-02-25 00:00:00', '2026-03-04 00:00:00', 14, 6, 1013, 3);
INSERT INTO public.orders VALUES (14, '2026-02-27 00:00:00', '2026-03-06 00:00:00', 7, 7, 1014, 1);
INSERT INTO public.orders VALUES (15, '2026-03-01 00:00:00', '2026-03-08 00:00:00', 19, 8, 1015, 2);
INSERT INTO public.orders VALUES (16, '2026-03-03 00:00:00', '2026-03-10 00:00:00', 25, 9, 1016, 2);
INSERT INTO public.orders VALUES (17, '2026-03-05 00:00:00', '2026-03-12 00:00:00', 2, 10, 1017, 1);
INSERT INTO public.orders VALUES (18, '2026-03-07 00:00:00', '2026-03-14 00:00:00', 31, 11, 1018, 1);
INSERT INTO public.orders VALUES (19, '2026-03-09 00:00:00', '2026-03-16 00:00:00', 16, 12, 1019, 3);
INSERT INTO public.orders VALUES (20, '2026-03-11 00:00:00', '2026-03-18 00:00:00', 24, 13, 1020, 2);


--
-- Data for Name: orders_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orders_items VALUES (1, 1, 'Z001', 1);
INSERT INTO public.orders_items VALUES (2, 1, 'Z004', 2);
INSERT INTO public.orders_items VALUES (3, 1, 'Z009', 1);
INSERT INTO public.orders_items VALUES (4, 2, 'Z002', 2);
INSERT INTO public.orders_items VALUES (5, 2, 'Z007', 1);
INSERT INTO public.orders_items VALUES (6, 3, 'Z005', 1);
INSERT INTO public.orders_items VALUES (7, 3, 'Z025', 1);
INSERT INTO public.orders_items VALUES (8, 4, 'Z003', 3);
INSERT INTO public.orders_items VALUES (9, 4, 'Z008', 1);
INSERT INTO public.orders_items VALUES (10, 4, 'Z013', 1);
INSERT INTO public.orders_items VALUES (11, 5, 'Z006', 2);
INSERT INTO public.orders_items VALUES (12, 5, 'Z029', 1);
INSERT INTO public.orders_items VALUES (13, 6, 'Z010', 5);
INSERT INTO public.orders_items VALUES (14, 6, 'Z021', 2);
INSERT INTO public.orders_items VALUES (15, 7, 'Z011', 1);
INSERT INTO public.orders_items VALUES (16, 7, 'Z012', 1);
INSERT INTO public.orders_items VALUES (17, 8, 'Z014', 1);
INSERT INTO public.orders_items VALUES (18, 8, 'Z018', 1);
INSERT INTO public.orders_items VALUES (19, 9, 'Z015', 2);
INSERT INTO public.orders_items VALUES (20, 9, 'Z019', 3);
INSERT INTO public.orders_items VALUES (21, 10, 'Z016', 2);
INSERT INTO public.orders_items VALUES (22, 10, 'Z022', 3);
INSERT INTO public.orders_items VALUES (23, 11, 'Z017', 1);
INSERT INTO public.orders_items VALUES (24, 11, 'Z023', 1);
INSERT INTO public.orders_items VALUES (25, 12, 'Z020', 1);
INSERT INTO public.orders_items VALUES (26, 12, 'Z026', 1);
INSERT INTO public.orders_items VALUES (27, 12, 'Z030', 1);
INSERT INTO public.orders_items VALUES (28, 13, 'Z024', 2);
INSERT INTO public.orders_items VALUES (29, 13, 'Z028', 1);
INSERT INTO public.orders_items VALUES (30, 14, 'Z001', 2);
INSERT INTO public.orders_items VALUES (31, 14, 'Z002', 1);
INSERT INTO public.orders_items VALUES (32, 14, 'Z004', 1);
INSERT INTO public.orders_items VALUES (33, 15, 'Z009', 2);
INSERT INTO public.orders_items VALUES (34, 15, 'Z025', 1);
INSERT INTO public.orders_items VALUES (35, 16, 'Z005', 1);
INSERT INTO public.orders_items VALUES (36, 16, 'Z006', 1);
INSERT INTO public.orders_items VALUES (37, 16, 'Z029', 1);
INSERT INTO public.orders_items VALUES (38, 17, 'Z007', 2);
INSERT INTO public.orders_items VALUES (39, 17, 'Z008', 1);
INSERT INTO public.orders_items VALUES (40, 18, 'Z013', 1);
INSERT INTO public.orders_items VALUES (41, 18, 'Z027', 2);
INSERT INTO public.orders_items VALUES (42, 19, 'Z011', 1);
INSERT INTO public.orders_items VALUES (43, 19, 'Z012', 1);
INSERT INTO public.orders_items VALUES (44, 20, 'Z021', 3);
INSERT INTO public.orders_items VALUES (45, 20, 'Z022', 2);
INSERT INTO public.orders_items VALUES (46, 20, 'Z026', 1);


--
-- Data for Name: pickup_points; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pickup_points VALUES (1, '394000. г. Воронеж. ул. Ленина. 12');
INSERT INTO public.pickup_points VALUES (2, '394018. г. Воронеж. пр. Революции. 24');
INSERT INTO public.pickup_points VALUES (3, '394019. г. Воронеж. ул. Плехановская. 33');
INSERT INTO public.pickup_points VALUES (4, '394020. г. Воронеж. ул. Кольцовская. 41');
INSERT INTO public.pickup_points VALUES (5, '394021. г. Воронеж. Московский пр.. 88');
INSERT INTO public.pickup_points VALUES (6, '394026. г. Воронеж. ул. Владимира Невского. 15');
INSERT INTO public.pickup_points VALUES (7, '394028. г. Воронеж. ул. Хользунова. 56');
INSERT INTO public.pickup_points VALUES (8, '394029. г. Воронеж. ул. 9 Января. 117');
INSERT INTO public.pickup_points VALUES (9, '394030. г. Воронеж. ул. Остужева. 22');
INSERT INTO public.pickup_points VALUES (10, '394033. г. Воронеж. Ленинский пр.. 105');
INSERT INTO public.pickup_points VALUES (11, '394034. г. Воронеж. ул. Димитрова. 79');
INSERT INTO public.pickup_points VALUES (12, '394036. г. Воронеж. ул. Броневая. 3');
INSERT INTO public.pickup_points VALUES (13, '394038. г. Воронеж. ул. Перевёрткина. 31');
INSERT INTO public.pickup_points VALUES (14, '394040. г. Воронеж. ул. Ростовская. 48');
INSERT INTO public.pickup_points VALUES (15, '394042. г. Воронеж. ул. Антонова-Овсеенко. 27');
INSERT INTO public.pickup_points VALUES (16, '394043. г. Воронеж. ул. Шишкова. 64');
INSERT INTO public.pickup_points VALUES (17, '394045. г. Воронеж. ул. Беговая. 5');
INSERT INTO public.pickup_points VALUES (18, '394047. г. Воронеж. ул. Героев Сибиряков. 73');
INSERT INTO public.pickup_points VALUES (19, '394049. г. Воронеж. ул. Транспортная. 59');
INSERT INTO public.pickup_points VALUES (20, '394051. г. Воронеж. ул. Олеко Дундича. 18');
INSERT INTO public.pickup_points VALUES (21, '394053. г. Воронеж. ул. Минская. 42');
INSERT INTO public.pickup_points VALUES (22, '394055. г. Воронеж. ул. 20 лет Октября. 96');
INSERT INTO public.pickup_points VALUES (23, '394056. г. Воронеж. ул. Фридриха Энгельса. 61');
INSERT INTO public.pickup_points VALUES (24, '394057. г. Воронеж. ул. Карла Маркса. 84');
INSERT INTO public.pickup_points VALUES (25, '394058. г. Воронеж. ул. Степана Разина. 37');
INSERT INTO public.pickup_points VALUES (26, '394059. г. Воронеж. ул. Софьи Перовской. 11');
INSERT INTO public.pickup_points VALUES (27, '394061. г. Воронеж. ул. Пирогова. 50');
INSERT INTO public.pickup_points VALUES (28, '394062. г. Воронеж. Бульвар Победы. 29');
INSERT INTO public.pickup_points VALUES (29, '394063. г. Воронеж. ул. Генерала Лизюкова. 43');
INSERT INTO public.pickup_points VALUES (30, '394064. г. Воронеж. ул. Маршала Жукова. 6');
INSERT INTO public.pickup_points VALUES (31, '394065. г. Воронеж. ул. Южно-Моравская. 19');
INSERT INTO public.pickup_points VALUES (32, '394066. г. Воронеж. ул. Перевёрткина. 14');
INSERT INTO public.pickup_points VALUES (33, '394068. г. Воронеж. ул. Ленинградская. 52');
INSERT INTO public.pickup_points VALUES (34, '394070. г. Воронеж. ул. Машиностроителей. 38');
INSERT INTO public.pickup_points VALUES (35, '394071. г. Воронеж. ул. 45 Стрелковой Дивизии. 101');
INSERT INTO public.pickup_points VALUES (36, '394075. г. Воронеж. ул. Краснознамённая. 22');


--
-- Data for Name: providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.providers VALUES (1, 'ЗооПром');
INSERT INTO public.providers VALUES (2, 'КормЦентр');
INSERT INTO public.providers VALUES (3, 'ИП Иванов');
INSERT INTO public.providers VALUES (4, 'ЗооТрейд');
INSERT INTO public.providers VALUES (5, 'ЗооЛюкс');
INSERT INTO public.providers VALUES (6, 'ВетСнаб');


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.roles VALUES (1, 'Администратор');
INSERT INTO public.roles VALUES (2, 'Менеджер');
INSERT INTO public.roles VALUES (3, 'Авторизированный клиент');


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.status VALUES (1, 'Завершен');
INSERT INTO public.status VALUES (2, 'Новый');
INSERT INTO public.status VALUES (3, 'Отменен');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 1, 'Воронцова Екатерина Дмитриевна', 'admin.vrn1@zoovoronezh.ru', 'aDm4nV');
INSERT INTO public.users VALUES (2, 1, 'Кораблёв Андрей Игоревич', 'korablev.a@zoo36.ru', 'K9rB7s');
INSERT INTO public.users VALUES (3, 1, 'Соболева Ирина Викторовна', 'soboleva.iv@vetvrn.ru', '3xYpLq');
INSERT INTO public.users VALUES (4, 1, 'Мещеряков Денис Алексеевич', 'meshcher@zooadmin.ru', 'M8sWzP');
INSERT INTO public.users VALUES (5, 2, 'Ткачёва Светлана Петровна', 'tkacheva.sp@zoo36.ru', 'tK5fN2');
INSERT INTO public.users VALUES (6, 2, 'Жилин Сергей Владимирович', 'zhilin.sv@mail36.ru', 'JlN9wQ');
INSERT INTO public.users VALUES (7, 2, 'Панина Ольга Юрьевна', 'panina.oy@tutanota.com', 'oP4xR8');
INSERT INTO public.users VALUES (8, 2, 'Родионов Павел Сергеевич', 'rodionov.ps@yahoo.com', 'RdS7jK');
INSERT INTO public.users VALUES (9, 2, 'Швецова Наталья Ильинична', 'shvetsova.ni@outlook.com', 'nW3zM6');
INSERT INTO public.users VALUES (10, 3, 'Барсукова Татьяна Владимировна', 'barsukova.tv@mail.ru', 'tB9kL2');
INSERT INTO public.users VALUES (11, 3, 'Головин Михаил Олегович', 'golovin.mo@gmail.com', 'gH6xP4');
INSERT INTO public.users VALUES (12, 3, 'Долгова Елена Викторовна', 'dolgova.ev@yandex.ru', 'eD8sR1');
INSERT INTO public.users VALUES (13, 3, 'Еремин Артём Павлович', 'eremin.ap@tutanota.com', 'aE4nM7');
INSERT INTO public.users VALUES (14, 3, 'Журавлева Алина Сергеевна', 'zhuravleva.as@mail.com', 'zA9cF3');
INSERT INTO public.users VALUES (15, 3, 'Завьялов Иван Николаевич', 'zavyalov.in@yahoo.com', 'iV5rB2');
INSERT INTO public.users VALUES (16, 3, 'Исаева Кристина Романовна', 'isaeva.kr@outlook.com', 'kR7yT6');
INSERT INTO public.users VALUES (17, 1, 'Иван Иванович Ивановвв', '1', '1');
INSERT INTO public.users VALUES (18, 2, 'manager', '2', '2');
INSERT INTO public.users VALUES (19, 3, 'client', '3', '3');


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, false);


--
-- Name: manufacturers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.manufacturers_id_seq', 1, false);


--
-- Name: measurment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.measurment_id_seq', 1, false);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 21, true);


--
-- Name: orders_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_items_id_seq', 49, true);


--
-- Name: pickup_points_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pickup_points_id_seq', 1, false);


--
-- Name: providers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.providers_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.status_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 16, true);


--
-- Name: items Items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT "Items_pkey" PRIMARY KEY (article);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: manufacturers manufacturers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers
    ADD CONSTRAINT manufacturers_pkey PRIMARY KEY (id);


--
-- Name: measurement measurment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measurement
    ADD CONSTRAINT measurment_pkey PRIMARY KEY (id);


--
-- Name: orders_items orders_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_items
    ADD CONSTRAINT orders_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: pickup_points pickup_points_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points
    ADD CONSTRAINT pickup_points_pkey PRIMARY KEY (id);


--
-- Name: providers providers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.providers
    ADD CONSTRAINT providers_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: status status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: items Items_category_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT "Items_category_fk_fkey" FOREIGN KEY (category_fk) REFERENCES public.categories(id) NOT VALID;


--
-- Name: items Items_manufacturer_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT "Items_manufacturer_fk_fkey" FOREIGN KEY (manufacturer_fk) REFERENCES public.manufacturers(id) NOT VALID;


--
-- Name: items Items_measurement_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT "Items_measurement_fk_fkey" FOREIGN KEY (measurement_fk) REFERENCES public.measurement(id) NOT VALID;


--
-- Name: items Items_provider_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT "Items_provider_fk_fkey" FOREIGN KEY (provider_fk) REFERENCES public.providers(id) NOT VALID;


--
-- Name: orders orders_client_full_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_client_full_name_fkey FOREIGN KEY (client_full_name) REFERENCES public.users(id) NOT VALID;


--
-- Name: orders_items orders_items_article_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_items
    ADD CONSTRAINT orders_items_article_fk_fkey FOREIGN KEY (article_fk) REFERENCES public.items(article) NOT VALID;


--
-- Name: orders_items orders_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_items
    ADD CONSTRAINT orders_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) NOT VALID;


--
-- Name: orders orders_pickup_point_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pickup_point_fkey FOREIGN KEY (pickup_point) REFERENCES public.pickup_points(id) NOT VALID;


--
-- Name: orders orders_status_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_status_fk_fkey FOREIGN KEY (status_fk) REFERENCES public.status(id) NOT VALID;


--
-- Name: users users_role_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_fk_fkey FOREIGN KEY (role_fk) REFERENCES public.roles(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

\unrestrict fa4on7yTYzHi04EqftHrbrRCSXA07ILl7HuE4lPsc8VYhowflli69CPZeAUnk50

