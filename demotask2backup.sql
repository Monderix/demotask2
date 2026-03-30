--
-- PostgreSQL database dump
--

\restrict d23GDgUkmg3BrBJ8BkKqaDt1YXN0jV313X6bjtW51Lpjz8JgXnNjPE928k5OLwW

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2026-03-30 21:14:52

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
-- TOC entry 221 (class 1259 OID 25160)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    category_pk character varying(155)
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 25175)
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
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 224
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 218 (class 1259 OID 25151)
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
-- TOC entry 220 (class 1259 OID 25157)
-- Name: manufacturers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manufacturers (
    id integer NOT NULL,
    manufacturer_pk character varying(155)
);


ALTER TABLE public.manufacturers OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25170)
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
-- TOC entry 5005 (class 0 OID 0)
-- Dependencies: 223
-- Name: manufacturers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manufacturers_id_seq OWNED BY public.manufacturers.id;


--
-- TOC entry 217 (class 1259 OID 25148)
-- Name: measurement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.measurement (
    id integer NOT NULL,
    measurement_pk character varying(55)
);


ALTER TABLE public.measurement OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 25163)
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
-- TOC entry 5006 (class 0 OID 0)
-- Dependencies: 222
-- Name: measurment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.measurment_id_seq OWNED BY public.measurement.id;


--
-- TOC entry 237 (class 1259 OID 25231)
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
-- TOC entry 236 (class 1259 OID 25230)
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
-- TOC entry 5007 (class 0 OID 0)
-- Dependencies: 236
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- TOC entry 235 (class 1259 OID 25224)
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
-- TOC entry 234 (class 1259 OID 25223)
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
-- TOC entry 5008 (class 0 OID 0)
-- Dependencies: 234
-- Name: orders_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_items_id_seq OWNED BY public.orders_items.id;


--
-- TOC entry 227 (class 1259 OID 25196)
-- Name: pickup_points; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pickup_points (
    id integer NOT NULL,
    pickup_point_address character varying(255)
);


ALTER TABLE public.pickup_points OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 25195)
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
-- TOC entry 5009 (class 0 OID 0)
-- Dependencies: 226
-- Name: pickup_points_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pickup_points_id_seq OWNED BY public.pickup_points.id;


--
-- TOC entry 219 (class 1259 OID 25154)
-- Name: providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.providers (
    id integer NOT NULL,
    provider_pk character varying(155)
);


ALTER TABLE public.providers OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 25184)
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
-- TOC entry 5010 (class 0 OID 0)
-- Dependencies: 225
-- Name: providers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.providers_id_seq OWNED BY public.providers.id;


--
-- TOC entry 231 (class 1259 OID 25210)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    role_name character varying(155)
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 25209)
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
-- TOC entry 5011 (class 0 OID 0)
-- Dependencies: 230
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 233 (class 1259 OID 25217)
-- Name: status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status (
    id integer NOT NULL,
    status_name character varying(55)
);


ALTER TABLE public.status OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 25216)
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
-- TOC entry 5012 (class 0 OID 0)
-- Dependencies: 232
-- Name: status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.status_id_seq OWNED BY public.status.id;


--
-- TOC entry 229 (class 1259 OID 25203)
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
-- TOC entry 228 (class 1259 OID 25202)
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
-- TOC entry 5013 (class 0 OID 0)
-- Dependencies: 228
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4794 (class 2604 OID 25176)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 4793 (class 2604 OID 25171)
-- Name: manufacturers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers ALTER COLUMN id SET DEFAULT nextval('public.manufacturers_id_seq'::regclass);


--
-- TOC entry 4791 (class 2604 OID 25164)
-- Name: measurement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measurement ALTER COLUMN id SET DEFAULT nextval('public.measurment_id_seq'::regclass);


--
-- TOC entry 4800 (class 2604 OID 25234)
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- TOC entry 4799 (class 2604 OID 25227)
-- Name: orders_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_items ALTER COLUMN id SET DEFAULT nextval('public.orders_items_id_seq'::regclass);


--
-- TOC entry 4795 (class 2604 OID 25199)
-- Name: pickup_points id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points ALTER COLUMN id SET DEFAULT nextval('public.pickup_points_id_seq'::regclass);


--
-- TOC entry 4792 (class 2604 OID 25185)
-- Name: providers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.providers ALTER COLUMN id SET DEFAULT nextval('public.providers_id_seq'::regclass);


--
-- TOC entry 4797 (class 2604 OID 25213)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4798 (class 2604 OID 25220)
-- Name: status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status ALTER COLUMN id SET DEFAULT nextval('public.status_id_seq'::regclass);


--
-- TOC entry 4796 (class 2604 OID 25206)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4982 (class 0 OID 25160)
-- Dependencies: 221
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, category_pk) FROM stdin;
1	Корма для кошек
2	Корма для собак
3	Наполнители
4	Игрушки
5	Клетки и переноски
6	Амуниция
7	Гигиена
8	Аксессуары
9	Лакомства
10	Домики и лежанки
11	Миски и поилки
12	Корма для птиц
13	Корма для грызунов
14	Средства защиты
15	Корма для рыб
16	Корма для рептилий
17	Витамины
\.


--
-- TOC entry 4979 (class 0 OID 25151)
-- Dependencies: 218
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.items (article, item_name, measurement_fk, cost, provider_fk, manufacturer_fk, category_fk, discount, quantity, description, picture) FROM stdin;
Z001	Корм Royal Canin Sterilised	1	1200	1	1	1	5	20	Сухой корм для стерилизованных кошек. сбалансированный состав	rc_sterilised.jpg
Z002	Корм Purina Pro Plan Puppy	1	950	2	2	2	10	15	Для щенков крупных пород. с курицей и рисом	proplan_puppy.jpg
Z003	Наполнитель CatsBest комкующийся	2	450	1	3	3	0	8	Древесный. 5 л. комкующийся. без пыли	catsbest_5l.jpg
Z004	Игрушка-мышь с кошачьей мятой	3	180	3	4	4	20	30	Интерактивная. с натуральной мятой. пищалка	mouse_catnip.jpg
Z005	Клетка Ferplast два яруса	3	2500	1	5	5	15	5	Для хорьков и крыс. 60×40×50 см	ferplast_2floor.jpg
Z006	Поводок Hunter нейлоновый	3	600	4	6	6	7	12	Длина 2 м. ширина 2.5 см. карабин	hunter_leash.jpg
Z007	Корм Hill's i/d Low Fat	1	1400	2	7	2	12	10	Диетический. для собак с чувствительным пищеварением	hills_id_lowfat.jpg
Z008	Шампунь Beaphar с ромашкой	4	320	1	8	7	0	25	Для собак и кошек. 250 мл	beaphar_chamomile.jpg
Z009	Когтеточка настенная 50 см	3	990	3	4	8	18	7	Сизаль. самоклеящаяся основа	kogtetochka_50.jpg
Z010	Лакомство GimCat подушечки	2	150	4	9	9	0	40	Витаминные подушечки с таурином. 50 г	gimcat_treats.jpg
Z011	Корм Acana Pacifica	1	1650	5	10	2	8	9	Беззерновой. с сельдью и камбалой	acana_pacifica.jpg
Z012	Корм Orijen Original	1	1850	5	11	1	5	6	Высокобелковый. 85% мяса	orijen_original.jpg
Z013	Наполнитель Zeolit силикагель	2	890	1	12	3	10	4	Силикагелевый. 3.8 л. абсорбирует запах	zeolit_38l.jpg
Z014	Домик для кошек мягкий	3	1300	3	13	10	5	2	Синтепон. съёмный чехол. 45×45 см	trixie_bed.jpg
Z015	Миска двойная Ferplast	3	490	1	5	11	0	18	Нержавеющая сталь. 0.5+0.5 л	ferplast_bowl.jpg
Z016	Корм для попугаев Prestige	2	320	4	14	12	0	14	Зерновая смесь для средних попугаев. 1 кг	prestige_parrot.jpg
Z017	Переноска для грызунов	3	750	1	15	5	12	3	Пластик. с ручкой. 25×15×20 см	savic_carrier.jpg
Z018	Расческа-пуходерка	3	220	6	13	7	0	22	С металлическими зубчиками. антистатик	trixie_slicker.jpg
Z019	Корм для хомяков Little One	2	180	2	16	13	0	30	Зерновая смесь с витаминами. 400 г	versele_laga_hamster.jpg
Z020	Ошейник от блох Beaphar	3	350	6	8	14	7	11	Для кошек. длительность 8 месяцев	beaphar_collar.jpg
Z021	Лакомство для собак Pedigree Dentastix	2	280	4	17	9	10	45	7 палочек. для чистки зубов	dentastix.jpg
Z022	Игрушка-колокольчик для попугая	3	90	3	4	4	0	60	Акрил. с бубенцом	bell_toy.jpg
Z023	Корм для аквариумных рыб TetraMin	4	430	1	18	15	5	17	Хлопья для всех тропических рыб. 100 мл	tetra_min.jpg
Z024	Спрей для ухода за шерстью	4	380	5	19	7	20	8	Кондиционер без смывания. 200 мл	ivsb_spray.jpg
Z025	Бюстгальтер для собак (послеопер.)	3	950	6	13	6	15	0	Фиксирующий. для стерилизованных сук. размер S	trixie_postop.jpg
Z026	Трава для кошек в горшке	3	180	1	14	8	0	12	Овес. 10 см. свежая зелень	cat_grass.jpg
Z027	Подстилка впитывающая	2	350	4	20	7	0	25	60×60 см. 5 шт. многослойная	smarttail_mat.jpg
Z028	Корм для черепах Reptomin	5	290	1	18	16	0	9	Гранулы для водных черепах. 250 мл	tetra_reptomin.jpg
Z029	Поводок-рулетка Flexi	3	1400	4	21	6	25	0	Автоматическая. до 5 м. для собак до 25 кг	flexi_tape.jpg
Z030	Витамины для хорьков	2	320	6	8	17	10	6	Паста с витаминами. 50 г	beaphar_ferret.jpg
\.


--
-- TOC entry 4981 (class 0 OID 25157)
-- Dependencies: 220
-- Data for Name: manufacturers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.manufacturers (id, manufacturer_pk) FROM stdin;
1	Royal Canin
2	Purina
3	CatsBest
4	Фабрика игрушек
5	Ferplast
6	Hunter
7	Hill's
8	Beaphar
9	GimCat
10	Acana
11	Orijen
12	ЗооМаркет
13	Trixie
14	Vitakraft
15	Savic
16	Versele-Laga
17	Pedigree
18	Tetra
19	Iv San Bernard
20	Умный хвост
21	Flexi
\.


--
-- TOC entry 4978 (class 0 OID 25148)
-- Dependencies: 217
-- Data for Name: measurement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.measurement (id, measurement_pk) FROM stdin;
1	кг
2	упак
3	шт
4	флакон
5	банка
\.


--
-- TOC entry 4998 (class 0 OID 25231)
-- Dependencies: 237
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, order_date, delivery_date, pickup_point, client_full_name, pickup_code, status_fk) FROM stdin;
1	2026-02-01 00:00:00	2026-02-08 00:00:00	5	10	1001	1
2	2026-02-03 00:00:00	2026-02-10 00:00:00	12	11	1002	1
3	2026-02-05 00:00:00	2026-02-12 00:00:00	8	12	1003	1
4	2026-02-07 00:00:00	2026-02-14 00:00:00	21	13	1004	1
5	2026-02-09 00:00:00	2026-02-16 00:00:00	15	14	1005	1
6	2026-02-11 00:00:00	2026-02-18 00:00:00	3	15	1006	1
7	2026-02-13 00:00:00	2026-02-20 00:00:00	27	16	1007	1
8	2026-02-15 00:00:00	2026-02-22 00:00:00	9	1	1008	1
9	2026-02-17 00:00:00	2026-02-24 00:00:00	18	2	1009	2
10	2026-02-19 00:00:00	2026-02-26 00:00:00	30	3	1010	2
11	2026-02-21 00:00:00	2026-02-28 00:00:00	11	4	1011	2
12	2026-02-23 00:00:00	2026-03-02 00:00:00	22	5	1012	2
13	2026-02-25 00:00:00	2026-03-04 00:00:00	14	6	1013	3
14	2026-02-27 00:00:00	2026-03-06 00:00:00	7	7	1014	1
15	2026-03-01 00:00:00	2026-03-08 00:00:00	19	8	1015	2
16	2026-03-03 00:00:00	2026-03-10 00:00:00	25	9	1016	2
17	2026-03-05 00:00:00	2026-03-12 00:00:00	2	10	1017	1
18	2026-03-07 00:00:00	2026-03-14 00:00:00	31	11	1018	1
19	2026-03-09 00:00:00	2026-03-16 00:00:00	16	12	1019	3
20	2026-03-11 00:00:00	2026-03-18 00:00:00	24	13	1020	2
\.


--
-- TOC entry 4996 (class 0 OID 25224)
-- Dependencies: 235
-- Data for Name: orders_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders_items (id, order_id, article_fk, quantity) FROM stdin;
1	1	Z001	1
2	1	Z004	2
3	1	Z009	1
4	2	Z002	2
5	2	Z007	1
6	3	Z005	1
7	3	Z025	1
8	4	Z003	3
9	4	Z008	1
10	4	Z013	1
11	5	Z006	2
12	5	Z029	1
13	6	Z010	5
14	6	Z021	2
15	7	Z011	1
16	7	Z012	1
17	8	Z014	1
18	8	Z018	1
19	9	Z015	2
20	9	Z019	3
21	10	Z016	2
22	10	Z022	3
23	11	Z017	1
24	11	Z023	1
25	12	Z020	1
26	12	Z026	1
27	12	Z030	1
28	13	Z024	2
29	13	Z028	1
30	14	Z001	2
31	14	Z002	1
32	14	Z004	1
33	15	Z009	2
34	15	Z025	1
35	16	Z005	1
36	16	Z006	1
37	16	Z029	1
38	17	Z007	2
39	17	Z008	1
40	18	Z013	1
41	18	Z027	2
42	19	Z011	1
43	19	Z012	1
44	20	Z021	3
45	20	Z022	2
46	20	Z026	1
\.


--
-- TOC entry 4988 (class 0 OID 25196)
-- Dependencies: 227
-- Data for Name: pickup_points; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pickup_points (id, pickup_point_address) FROM stdin;
1	394000. г. Воронеж. ул. Ленина. 12
2	394018. г. Воронеж. пр. Революции. 24
3	394019. г. Воронеж. ул. Плехановская. 33
4	394020. г. Воронеж. ул. Кольцовская. 41
5	394021. г. Воронеж. Московский пр.. 88
6	394026. г. Воронеж. ул. Владимира Невского. 15
7	394028. г. Воронеж. ул. Хользунова. 56
8	394029. г. Воронеж. ул. 9 Января. 117
9	394030. г. Воронеж. ул. Остужева. 22
10	394033. г. Воронеж. Ленинский пр.. 105
11	394034. г. Воронеж. ул. Димитрова. 79
12	394036. г. Воронеж. ул. Броневая. 3
13	394038. г. Воронеж. ул. Перевёрткина. 31
14	394040. г. Воронеж. ул. Ростовская. 48
15	394042. г. Воронеж. ул. Антонова-Овсеенко. 27
16	394043. г. Воронеж. ул. Шишкова. 64
17	394045. г. Воронеж. ул. Беговая. 5
18	394047. г. Воронеж. ул. Героев Сибиряков. 73
19	394049. г. Воронеж. ул. Транспортная. 59
20	394051. г. Воронеж. ул. Олеко Дундича. 18
21	394053. г. Воронеж. ул. Минская. 42
22	394055. г. Воронеж. ул. 20 лет Октября. 96
23	394056. г. Воронеж. ул. Фридриха Энгельса. 61
24	394057. г. Воронеж. ул. Карла Маркса. 84
25	394058. г. Воронеж. ул. Степана Разина. 37
26	394059. г. Воронеж. ул. Софьи Перовской. 11
27	394061. г. Воронеж. ул. Пирогова. 50
28	394062. г. Воронеж. Бульвар Победы. 29
29	394063. г. Воронеж. ул. Генерала Лизюкова. 43
30	394064. г. Воронеж. ул. Маршала Жукова. 6
31	394065. г. Воронеж. ул. Южно-Моравская. 19
32	394066. г. Воронеж. ул. Перевёрткина. 14
33	394068. г. Воронеж. ул. Ленинградская. 52
34	394070. г. Воронеж. ул. Машиностроителей. 38
35	394071. г. Воронеж. ул. 45 Стрелковой Дивизии. 101
36	394075. г. Воронеж. ул. Краснознамённая. 22
\.


--
-- TOC entry 4980 (class 0 OID 25154)
-- Dependencies: 219
-- Data for Name: providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.providers (id, provider_pk) FROM stdin;
1	ЗооПром
2	КормЦентр
3	ИП Иванов
4	ЗооТрейд
5	ЗооЛюкс
6	ВетСнаб
\.


--
-- TOC entry 4992 (class 0 OID 25210)
-- Dependencies: 231
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, role_name) FROM stdin;
1	Администратор
2	Менеджер
3	Авторизированный клиент
\.


--
-- TOC entry 4994 (class 0 OID 25217)
-- Dependencies: 233
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.status (id, status_name) FROM stdin;
1	Завершен
2	Новый
3	Отменен
\.


--
-- TOC entry 4990 (class 0 OID 25203)
-- Dependencies: 229
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, role_fk, full_name, login, password) FROM stdin;
1	1	Воронцова Екатерина Дмитриевна	admin.vrn1@zoovoronezh.ru	aDm4nV
2	1	Кораблёв Андрей Игоревич	korablev.a@zoo36.ru	K9rB7s
3	1	Соболева Ирина Викторовна	soboleva.iv@vetvrn.ru	3xYpLq
4	1	Мещеряков Денис Алексеевич	meshcher@zooadmin.ru	M8sWzP
5	2	Ткачёва Светлана Петровна	tkacheva.sp@zoo36.ru	tK5fN2
6	2	Жилин Сергей Владимирович	zhilin.sv@mail36.ru	JlN9wQ
7	2	Панина Ольга Юрьевна	panina.oy@tutanota.com	oP4xR8
8	2	Родионов Павел Сергеевич	rodionov.ps@yahoo.com	RdS7jK
9	2	Швецова Наталья Ильинична	shvetsova.ni@outlook.com	nW3zM6
10	3	Барсукова Татьяна Владимировна	barsukova.tv@mail.ru	tB9kL2
11	3	Головин Михаил Олегович	golovin.mo@gmail.com	gH6xP4
12	3	Долгова Елена Викторовна	dolgova.ev@yandex.ru	eD8sR1
13	3	Еремин Артём Павлович	eremin.ap@tutanota.com	aE4nM7
14	3	Журавлева Алина Сергеевна	zhuravleva.as@mail.com	zA9cF3
15	3	Завьялов Иван Николаевич	zavyalov.in@yahoo.com	iV5rB2
16	3	Исаева Кристина Романовна	isaeva.kr@outlook.com	kR7yT6
17	1	Иван Иванович Ивановвв	1	1
18	2	manager	2	2
19	3	client	3	3
\.


--
-- TOC entry 5014 (class 0 OID 0)
-- Dependencies: 224
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, false);


--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 223
-- Name: manufacturers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.manufacturers_id_seq', 1, false);


--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 222
-- Name: measurment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.measurment_id_seq', 1, false);


--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 236
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 21, true);


--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 234
-- Name: orders_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_items_id_seq', 49, true);


--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 226
-- Name: pickup_points_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pickup_points_id_seq', 1, false);


--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 225
-- Name: providers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.providers_id_seq', 1, false);


--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 230
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 232
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.status_id_seq', 1, false);


--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 228
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 16, true);


--
-- TOC entry 4804 (class 2606 OID 25194)
-- Name: items Items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT "Items_pkey" PRIMARY KEY (article);


--
-- TOC entry 4810 (class 2606 OID 25181)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4808 (class 2606 OID 25183)
-- Name: manufacturers manufacturers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers
    ADD CONSTRAINT manufacturers_pkey PRIMARY KEY (id);


--
-- TOC entry 4802 (class 2606 OID 25169)
-- Name: measurement measurment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measurement
    ADD CONSTRAINT measurment_pkey PRIMARY KEY (id);


--
-- TOC entry 4820 (class 2606 OID 25229)
-- Name: orders_items orders_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_items
    ADD CONSTRAINT orders_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4822 (class 2606 OID 25236)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4812 (class 2606 OID 25201)
-- Name: pickup_points pickup_points_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points
    ADD CONSTRAINT pickup_points_pkey PRIMARY KEY (id);


--
-- TOC entry 4806 (class 2606 OID 25190)
-- Name: providers providers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.providers
    ADD CONSTRAINT providers_pkey PRIMARY KEY (id);


--
-- TOC entry 4816 (class 2606 OID 25215)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4818 (class 2606 OID 25222)
-- Name: status status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- TOC entry 4814 (class 2606 OID 25208)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4823 (class 2606 OID 25252)
-- Name: items Items_category_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT "Items_category_fk_fkey" FOREIGN KEY (category_fk) REFERENCES public.categories(id) NOT VALID;


--
-- TOC entry 4824 (class 2606 OID 25247)
-- Name: items Items_manufacturer_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT "Items_manufacturer_fk_fkey" FOREIGN KEY (manufacturer_fk) REFERENCES public.manufacturers(id) NOT VALID;


--
-- TOC entry 4825 (class 2606 OID 25237)
-- Name: items Items_measurement_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT "Items_measurement_fk_fkey" FOREIGN KEY (measurement_fk) REFERENCES public.measurement(id) NOT VALID;


--
-- TOC entry 4826 (class 2606 OID 25242)
-- Name: items Items_provider_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT "Items_provider_fk_fkey" FOREIGN KEY (provider_fk) REFERENCES public.providers(id) NOT VALID;


--
-- TOC entry 4830 (class 2606 OID 25267)
-- Name: orders orders_client_full_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_client_full_name_fkey FOREIGN KEY (client_full_name) REFERENCES public.users(id) NOT VALID;


--
-- TOC entry 4828 (class 2606 OID 25277)
-- Name: orders_items orders_items_article_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_items
    ADD CONSTRAINT orders_items_article_fk_fkey FOREIGN KEY (article_fk) REFERENCES public.items(article) NOT VALID;


--
-- TOC entry 4829 (class 2606 OID 25272)
-- Name: orders_items orders_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_items
    ADD CONSTRAINT orders_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) NOT VALID;


--
-- TOC entry 4831 (class 2606 OID 25282)
-- Name: orders orders_pickup_point_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pickup_point_fkey FOREIGN KEY (pickup_point) REFERENCES public.pickup_points(id) NOT VALID;


--
-- TOC entry 4832 (class 2606 OID 25262)
-- Name: orders orders_status_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_status_fk_fkey FOREIGN KEY (status_fk) REFERENCES public.status(id) NOT VALID;


--
-- TOC entry 4827 (class 2606 OID 25257)
-- Name: users users_role_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_fk_fkey FOREIGN KEY (role_fk) REFERENCES public.roles(id) NOT VALID;


-- Completed on 2026-03-30 21:14:52

--
-- PostgreSQL database dump complete
--

\unrestrict d23GDgUkmg3BrBJ8BkKqaDt1YXN0jV313X6bjtW51Lpjz8JgXnNjPE928k5OLwW

