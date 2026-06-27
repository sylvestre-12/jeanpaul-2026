--
-- PostgreSQL database dump
--

\restrict rPJfj6cIxVmASikUnbRmJ4iUzrsPS7Wm6cfSh9A5Tapu5vcDRZ8F6mlSROFw40K

-- Dumped from database version 16.10
-- Dumped by pg_dump version 16.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- Name: Language; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Language" AS ENUM (
    'EN',
    'FR',
    'RW'
);


ALTER TYPE public."Language" OWNER TO postgres;

--
-- Name: QuestionType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."QuestionType" AS ENUM (
    'NORMAL',
    'SHORT'
);


ALTER TYPE public."QuestionType" OWNER TO postgres;

--
-- Name: Role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Role" AS ENUM (
    'ADMIN',
    'USER'
);


ALTER TYPE public."Role" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: LoginHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."LoginHistory" (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."LoginHistory" OWNER TO postgres;

--
-- Name: LoginHistory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."LoginHistory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."LoginHistory_id_seq" OWNER TO postgres;

--
-- Name: LoginHistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."LoginHistory_id_seq" OWNED BY public."LoginHistory".id;


--
-- Name: OTP; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OTP" (
    id integer NOT NULL,
    code text NOT NULL,
    "userId" integer NOT NULL,
    "expiresAt" timestamp(3) without time zone NOT NULL,
    used boolean DEFAULT false NOT NULL
);


ALTER TABLE public."OTP" OWNER TO postgres;

--
-- Name: OTP_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."OTP_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."OTP_id_seq" OWNER TO postgres;

--
-- Name: OTP_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."OTP_id_seq" OWNED BY public."OTP".id;


--
-- Name: Option; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Option" (
    id integer NOT NULL,
    "isCorrect" boolean NOT NULL,
    "questionId" integer NOT NULL
);


ALTER TABLE public."Option" OWNER TO postgres;

--
-- Name: OptionTranslation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OptionTranslation" (
    id integer NOT NULL,
    language public."Language" NOT NULL,
    text text NOT NULL,
    "optionId" integer NOT NULL
);


ALTER TABLE public."OptionTranslation" OWNER TO postgres;

--
-- Name: OptionTranslation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."OptionTranslation_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."OptionTranslation_id_seq" OWNER TO postgres;

--
-- Name: OptionTranslation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."OptionTranslation_id_seq" OWNED BY public."OptionTranslation".id;


--
-- Name: Option_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Option_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Option_id_seq" OWNER TO postgres;

--
-- Name: Option_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Option_id_seq" OWNED BY public."Option".id;


--
-- Name: Question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Question" (
    id integer NOT NULL,
    type public."QuestionType" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    image text,
    number integer NOT NULL
);


ALTER TABLE public."Question" OWNER TO postgres;

--
-- Name: QuestionImage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."QuestionImage" (
    id integer NOT NULL,
    url text NOT NULL,
    "questionId" integer NOT NULL
);


ALTER TABLE public."QuestionImage" OWNER TO postgres;

--
-- Name: QuestionImage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."QuestionImage_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."QuestionImage_id_seq" OWNER TO postgres;

--
-- Name: QuestionImage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."QuestionImage_id_seq" OWNED BY public."QuestionImage".id;


--
-- Name: QuestionTranslation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."QuestionTranslation" (
    id integer NOT NULL,
    language public."Language" NOT NULL,
    text text NOT NULL,
    "questionId" integer NOT NULL,
    explanation text
);


ALTER TABLE public."QuestionTranslation" OWNER TO postgres;

--
-- Name: QuestionTranslation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."QuestionTranslation_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."QuestionTranslation_id_seq" OWNER TO postgres;

--
-- Name: QuestionTranslation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."QuestionTranslation_id_seq" OWNED BY public."QuestionTranslation".id;


--
-- Name: Question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Question_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Question_id_seq" OWNER TO postgres;

--
-- Name: Question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Question_id_seq" OWNED BY public."Question".id;


--
-- Name: Result; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Result" (
    id integer NOT NULL,
    score integer NOT NULL,
    "userId" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    total integer NOT NULL
);


ALTER TABLE public."Result" OWNER TO postgres;

--
-- Name: Result_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Result_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Result_id_seq" OWNER TO postgres;

--
-- Name: Result_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Result_id_seq" OWNED BY public."Result".id;


--
-- Name: Test; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Test" (
    id integer NOT NULL,
    title text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    duration integer
);


ALTER TABLE public."Test" OWNER TO postgres;

--
-- Name: Test_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Test_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Test_id_seq" OWNER TO postgres;

--
-- Name: Test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Test_id_seq" OWNED BY public."Test".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    phone text NOT NULL,
    email text,
    password text NOT NULL,
    role public."Role" DEFAULT 'USER'::public."Role" NOT NULL,
    approved boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    name text,
    "lastLogin" timestamp(3) without time zone,
    profile text,
    language public."Language" DEFAULT 'EN'::public."Language" NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: UserAnswer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserAnswer" (
    id integer NOT NULL,
    "resultId" integer NOT NULL,
    "questionId" integer NOT NULL,
    "optionId" integer NOT NULL
);


ALTER TABLE public."UserAnswer" OWNER TO postgres;

--
-- Name: UserAnswer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UserAnswer_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."UserAnswer_id_seq" OWNER TO postgres;

--
-- Name: UserAnswer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UserAnswer_id_seq" OWNED BY public."UserAnswer".id;


--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_id_seq" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: _TestQuestions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_TestQuestions" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_TestQuestions" OWNER TO postgres;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: LoginHistory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LoginHistory" ALTER COLUMN id SET DEFAULT nextval('public."LoginHistory_id_seq"'::regclass);


--
-- Name: OTP id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OTP" ALTER COLUMN id SET DEFAULT nextval('public."OTP_id_seq"'::regclass);


--
-- Name: Option id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Option" ALTER COLUMN id SET DEFAULT nextval('public."Option_id_seq"'::regclass);


--
-- Name: OptionTranslation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OptionTranslation" ALTER COLUMN id SET DEFAULT nextval('public."OptionTranslation_id_seq"'::regclass);


--
-- Name: Question id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Question" ALTER COLUMN id SET DEFAULT nextval('public."Question_id_seq"'::regclass);


--
-- Name: QuestionImage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionImage" ALTER COLUMN id SET DEFAULT nextval('public."QuestionImage_id_seq"'::regclass);


--
-- Name: QuestionTranslation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionTranslation" ALTER COLUMN id SET DEFAULT nextval('public."QuestionTranslation_id_seq"'::regclass);


--
-- Name: Result id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Result" ALTER COLUMN id SET DEFAULT nextval('public."Result_id_seq"'::regclass);


--
-- Name: Test id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Test" ALTER COLUMN id SET DEFAULT nextval('public."Test_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Name: UserAnswer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserAnswer" ALTER COLUMN id SET DEFAULT nextval('public."UserAnswer_id_seq"'::regclass);


--
-- Data for Name: LoginHistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."LoginHistory" (id, "userId", "createdAt") FROM stdin;
\.


--
-- Data for Name: OTP; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OTP" (id, code, "userId", "expiresAt", used) FROM stdin;
4	328554	4	2026-04-29 11:42:06.372	f
9	415527	1	2026-04-29 11:59:55.739	f
10	555546	4	2026-05-08 13:24:09.374	f
11	826805	4	2026-05-08 13:26:03.984	t
12	868156	4	2026-05-11 07:24:45.936	f
13	791134	4	2026-05-11 07:26:01.998	f
14	920463	4	2026-05-11 07:27:03.028	t
15	274744	4	2026-05-14 20:25:47.826	t
16	813441	4	2026-05-18 19:19:40.137	t
17	584483	4	2026-05-20 13:23:55.817	t
18	686996	4	2026-05-20 15:00:39.545	t
19	615088	4	2026-06-11 09:00:29.799	t
20	769490	4	2026-06-16 16:11:41.459	t
21	269322	4	2026-06-17 10:20:52.117	t
22	473379	4	2026-06-17 10:55:51.381	t
23	920618	4	2026-06-17 19:11:40.134	t
24	821782	4	2026-06-18 21:02:40.361	t
25	631710	4	2026-06-18 21:30:00.746	t
26	896771	4	2026-06-18 22:13:54.285	t
27	543548	4	2026-06-20 10:44:17.575	t
\.


--
-- Data for Name: Option; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Option" (id, "isCorrect", "questionId") FROM stdin;
5	f	2
6	f	2
7	f	2
8	t	2
9	f	3
10	f	3
11	t	3
12	f	3
13	f	4
14	f	4
15	t	4
16	f	4
21	f	1
22	f	1
23	t	1
24	f	1
25	f	5
26	f	5
27	f	5
28	t	5
29	f	6
30	f	6
31	t	6
32	f	6
33	f	7
34	f	7
35	t	7
36	f	7
37	f	8
38	f	8
39	f	8
40	t	8
41	f	9
42	f	9
43	t	9
44	f	9
45	f	10
46	f	10
47	t	10
48	f	10
49	f	11
50	t	11
51	f	11
52	f	11
53	f	12
54	f	12
55	t	12
56	f	12
57	f	13
58	f	13
59	f	13
60	t	13
61	f	14
62	t	14
63	f	14
64	f	14
65	f	15
66	f	15
67	t	15
68	f	15
69	f	16
70	f	16
71	t	16
72	f	16
73	f	17
74	f	17
75	f	17
76	t	17
77	f	18
78	f	18
79	f	18
80	t	18
81	f	19
82	t	19
83	f	19
84	f	19
85	f	20
86	f	20
87	f	20
88	t	20
89	f	21
90	f	21
91	f	21
92	t	21
93	f	22
94	f	22
95	f	22
96	t	22
97	f	23
98	f	23
99	t	23
100	f	23
101	f	24
102	f	24
103	f	24
104	t	24
105	f	25
106	f	25
107	t	25
108	f	25
109	f	26
110	f	26
111	f	26
112	t	26
113	f	27
114	f	27
115	t	27
116	f	27
117	f	28
118	f	28
119	f	28
120	t	28
121	f	29
122	f	29
123	t	29
124	f	29
125	f	30
126	f	30
127	f	30
128	t	30
129	f	31
130	f	31
131	f	31
132	t	31
133	f	32
134	f	32
135	f	32
136	t	32
137	f	33
138	f	33
139	f	33
140	t	33
141	f	34
142	f	34
143	t	34
144	f	34
145	f	35
146	f	35
147	f	35
148	t	35
149	t	36
150	f	36
151	f	36
152	f	36
153	t	37
154	f	37
155	f	37
156	f	37
157	f	38
158	f	38
159	t	38
160	f	38
161	f	39
162	f	39
163	t	39
164	f	39
165	f	40
166	f	40
167	f	40
168	t	40
169	t	41
170	f	41
171	f	41
172	f	41
173	f	42
174	f	42
175	t	42
176	f	42
177	f	43
178	f	43
179	t	43
180	f	43
181	f	44
182	f	44
183	t	44
184	f	44
185	f	45
186	f	45
187	t	45
188	f	45
189	f	46
190	f	46
191	f	46
192	t	46
193	f	47
194	t	47
195	f	47
196	f	47
197	f	48
198	f	48
199	t	48
200	f	48
205	f	49
206	t	49
207	f	49
208	f	49
209	f	50
210	f	50
211	t	50
212	f	50
213	f	51
214	f	51
215	t	51
216	f	51
217	f	52
218	t	52
219	f	52
220	f	52
221	f	53
222	f	53
223	f	53
224	t	53
225	f	54
226	t	54
227	f	54
228	f	54
229	f	55
230	t	55
231	f	55
232	f	55
233	t	56
234	f	56
235	f	56
236	f	56
237	f	57
238	f	57
239	t	57
240	f	57
241	t	58
242	t	58
243	f	58
244	f	58
245	t	59
246	f	59
247	f	59
248	f	59
249	t	60
250	t	60
251	f	60
252	f	60
253	f	61
254	t	61
255	f	61
256	f	61
257	f	62
258	t	62
259	f	62
260	f	62
261	f	63
262	f	63
263	t	63
264	f	63
265	f	64
266	t	64
267	f	64
268	f	64
269	t	65
270	f	65
271	f	65
272	f	65
273	t	66
274	f	66
275	f	66
276	f	66
277	f	67
278	t	67
279	f	67
280	f	67
281	t	68
282	f	68
283	f	68
284	f	68
285	f	69
286	f	69
287	t	69
288	f	69
289	t	70
290	f	70
291	f	70
292	f	70
293	f	71
294	f	71
295	f	71
296	t	71
297	f	72
298	f	72
299	t	72
300	f	72
301	t	73
302	f	73
303	f	73
304	f	73
305	f	74
306	f	74
307	t	74
308	f	74
309	t	75
310	f	75
311	f	75
312	f	75
313	f	76
314	f	76
315	t	76
316	f	76
317	f	77
318	t	77
319	f	77
320	f	77
321	f	78
322	f	78
323	t	78
324	f	78
325	t	79
326	f	79
327	f	79
328	f	79
329	f	80
330	f	80
331	t	80
332	f	80
333	f	81
334	f	81
335	t	81
336	f	81
337	f	82
338	f	82
339	t	82
340	f	82
341	f	83
342	f	83
343	f	83
344	t	83
345	f	84
346	f	84
347	f	84
348	t	84
349	f	85
350	f	85
351	f	85
352	t	85
353	f	86
354	f	86
355	t	86
356	f	86
357	f	87
358	f	87
359	f	87
360	t	87
361	f	88
362	f	88
363	t	88
364	f	88
365	f	89
366	t	89
367	f	89
368	f	89
369	f	90
370	f	90
371	t	90
372	f	90
373	f	91
374	t	91
375	f	91
376	f	91
377	f	92
378	f	92
379	f	92
380	t	92
381	t	93
382	f	93
383	f	93
384	f	93
385	f	94
386	t	94
387	f	94
388	f	94
389	f	95
390	t	95
391	f	95
392	f	95
393	t	96
394	t	96
395	t	96
396	f	96
397	f	97
398	t	97
399	f	97
400	f	97
401	f	98
402	f	98
403	t	98
404	f	98
405	f	99
406	f	99
407	t	99
408	f	99
409	t	100
410	f	100
411	f	100
412	f	100
413	f	101
414	f	101
415	t	101
416	f	101
417	t	102
418	f	102
419	f	102
420	f	102
421	f	103
422	t	103
423	f	103
424	f	103
425	f	104
426	f	104
427	t	104
428	f	104
429	f	105
430	t	105
431	f	105
432	f	105
433	f	106
434	t	106
435	f	106
436	f	106
437	f	107
438	f	107
439	t	107
440	f	107
441	f	108
442	t	108
443	f	108
444	f	108
445	f	109
446	f	109
447	t	109
448	f	109
449	f	110
450	f	110
451	f	110
452	t	110
453	f	111
454	f	111
455	t	111
456	f	111
457	f	112
458	f	112
459	t	112
460	f	112
461	f	113
462	f	113
463	t	113
464	f	113
465	f	114
466	f	114
467	t	114
468	f	114
469	f	115
470	f	115
471	t	115
472	f	115
473	t	116
474	f	116
475	f	116
476	f	116
477	t	117
478	f	117
479	f	117
480	f	117
481	t	118
482	f	118
483	f	118
484	f	118
485	f	119
486	f	119
487	t	119
488	f	119
489	f	120
490	f	120
491	t	120
492	f	120
493	f	121
494	f	121
495	t	121
496	f	121
497	f	122
498	t	122
499	f	122
500	f	122
501	t	123
502	f	123
503	f	123
504	f	123
505	t	124
506	f	124
507	f	124
508	f	124
509	t	125
510	f	125
511	f	125
512	f	125
513	t	126
514	f	126
515	f	126
516	f	126
517	f	127
518	t	127
519	f	127
520	f	127
521	f	128
522	t	128
523	f	128
524	f	128
525	t	129
526	f	129
527	f	129
528	f	129
529	t	130
530	f	130
531	f	130
532	f	130
533	f	131
534	f	131
535	t	131
536	f	131
537	f	132
538	f	132
539	f	132
540	t	132
541	f	133
542	f	133
543	t	133
544	f	133
545	f	134
546	f	134
547	t	134
548	f	134
549	f	135
550	f	135
551	f	135
552	t	135
553	f	136
554	t	136
555	f	136
556	f	136
557	f	137
558	t	137
559	f	137
560	f	137
561	f	138
562	t	138
563	f	138
564	f	138
1218	t	302
1219	f	302
1929	f	281
1930	f	281
569	f	139
570	f	139
571	t	139
572	f	139
573	f	140
574	f	140
575	t	140
576	f	140
577	f	141
578	f	141
579	t	141
580	f	141
581	t	142
582	f	142
583	f	142
584	f	142
585	f	143
586	f	143
587	t	143
588	f	143
589	f	144
590	t	144
591	f	144
592	f	144
593	f	145
594	t	145
595	f	145
596	f	145
597	f	146
598	f	146
599	t	146
600	f	146
601	f	147
602	f	147
603	t	147
604	f	147
605	f	148
606	t	148
607	f	148
608	f	148
609	f	149
610	t	149
611	f	149
612	f	149
613	t	150
614	f	150
615	f	150
616	f	150
617	f	151
618	f	151
619	f	151
620	t	151
621	f	152
622	f	152
623	f	152
624	t	152
625	f	153
626	t	153
627	f	153
628	f	153
629	f	154
630	f	154
631	t	154
632	f	154
633	f	155
634	f	155
635	f	155
636	t	155
637	f	156
638	f	156
639	f	156
640	t	156
641	f	157
642	f	157
643	f	157
644	t	157
645	f	158
646	f	158
647	t	158
648	f	158
649	f	159
650	f	159
651	t	159
652	f	159
653	f	160
654	t	160
655	f	160
656	f	160
657	f	161
658	f	161
659	t	161
660	f	161
661	f	162
662	t	162
663	f	162
664	f	162
665	f	163
666	t	163
667	f	163
668	f	163
669	f	164
670	f	164
671	t	164
672	f	164
673	f	165
674	t	165
675	f	165
676	f	165
677	f	166
678	f	166
679	t	166
680	f	166
681	f	167
682	f	167
683	t	167
684	f	167
685	t	168
686	f	168
687	f	168
688	f	168
689	f	169
690	f	169
691	t	169
692	f	169
693	f	170
694	f	170
695	t	170
696	f	170
697	t	171
698	f	171
699	f	171
700	f	171
701	f	172
702	f	172
703	t	172
704	f	172
705	f	173
706	f	173
707	t	173
708	f	173
709	t	174
710	f	174
711	f	174
712	f	174
713	t	175
714	f	175
715	f	175
716	f	175
717	t	176
718	f	176
719	f	176
720	f	176
721	f	177
722	t	177
723	f	177
724	f	177
725	t	178
726	f	178
727	f	178
728	f	178
729	t	179
730	f	179
731	f	179
732	f	179
733	f	180
734	f	180
735	t	180
736	f	180
737	f	181
738	f	181
739	t	181
740	f	181
741	f	182
742	f	182
743	t	182
744	f	182
745	t	183
746	f	183
747	f	183
748	f	183
1931	t	281
1932	f	281
753	f	185
754	f	185
755	t	185
756	f	185
757	t	186
758	f	186
759	f	186
760	f	186
761	f	187
762	f	187
763	t	187
764	f	187
765	f	188
766	t	188
767	f	188
768	f	188
769	f	189
770	f	189
771	t	189
772	f	189
773	f	190
774	f	190
775	t	190
776	f	190
777	t	191
778	f	191
779	f	191
780	f	191
781	f	192
782	f	192
783	t	192
784	f	192
785	t	193
786	f	193
787	f	193
788	f	193
789	f	194
790	t	194
791	f	194
792	f	194
1933	t	282
1934	f	282
1935	f	282
1936	f	282
797	f	196
798	f	196
799	t	196
800	f	196
801	f	197
802	f	197
803	t	197
804	f	197
1969	f	198
1970	t	198
1971	f	198
1972	f	198
1977	f	205
1978	t	205
1979	f	205
1980	f	205
817	f	201
818	f	201
819	f	201
820	t	201
821	f	202
822	f	202
823	t	202
824	f	202
841	f	207
842	f	207
843	t	207
844	f	207
2173	f	395
2174	f	395
2175	f	395
2176	t	395
2177	f	394
2178	t	394
2179	f	394
2180	f	394
2201	t	401
2202	f	401
2203	f	401
2204	f	401
2205	f	402
2206	f	402
2207	t	402
2208	f	402
2209	f	403
2210	f	403
2211	t	403
2212	f	403
2213	f	404
2214	t	404
2215	f	404
2216	f	404
2221	f	407
2222	t	407
2223	f	407
2224	f	407
2225	f	409
2226	t	409
2227	f	409
2228	f	409
2237	f	427
2238	t	427
2239	f	427
2240	f	427
2257	t	416
2258	f	416
2259	f	416
2260	f	416
2261	f	417
2262	f	417
2263	t	417
2264	f	417
2285	f	422
2286	f	422
937	f	231
938	f	231
2287	t	422
2288	f	422
2289	t	423
2290	f	423
2291	f	423
2292	f	423
2293	t	424
2294	f	424
2295	f	424
2296	f	424
2297	f	425
2298	f	425
2299	t	425
2300	f	425
2313	f	430
2314	t	430
2315	f	430
2316	f	430
2337	t	433
2338	f	433
2339	f	433
2340	f	433
2345	f	434
2346	f	434
2347	f	434
2348	t	434
2353	f	435
2354	f	435
2355	t	435
2356	f	435
2361	f	436
2362	f	436
2363	f	436
2364	t	436
2369	t	437
2370	f	437
2371	f	437
2372	f	437
2377	f	438
2378	t	438
2379	f	438
2380	f	438
2385	f	439
2386	f	439
2387	f	439
2388	t	439
2393	f	440
2394	t	440
2395	f	440
2396	f	440
2401	t	441
2402	f	441
2403	f	441
2404	f	441
939	f	231
940	t	231
941	t	232
942	f	232
943	f	232
944	f	232
945	f	233
946	f	233
947	t	233
948	f	233
949	t	234
950	t	234
951	t	234
952	f	234
1937	t	284
1938	f	284
1939	f	284
1940	f	284
957	f	236
958	t	236
959	f	236
960	f	236
1941	t	290
1942	f	290
1943	f	290
1944	f	290
1953	f	184
1954	f	184
1955	t	184
1956	f	184
1981	t	237
1982	f	237
1983	f	237
1984	f	237
1997	f	337
1998	t	337
1999	f	337
2000	f	337
2001	t	379
2002	f	379
2003	f	379
2004	f	379
2153	f	390
2154	f	390
2155	f	390
2156	t	390
2157	f	391
2158	t	391
2159	f	391
2160	f	391
2161	f	392
2162	f	392
2163	t	392
2164	f	392
2165	f	393
2166	f	393
2167	t	393
2168	f	393
1045	t	258
1046	f	258
1047	f	258
1048	f	258
1049	f	259
1050	f	259
1051	t	259
1052	f	259
1053	f	260
1054	t	260
1055	f	260
1056	f	260
1057	f	261
1058	f	261
1059	t	261
1060	f	261
1061	t	262
1062	f	262
1063	f	262
1064	f	262
1065	f	263
1066	t	263
1067	f	263
1068	f	263
1069	f	264
1070	t	264
1071	f	264
1072	f	264
1073	f	265
1074	f	265
1075	f	265
1076	t	265
1077	f	266
1078	t	266
1079	f	266
1080	f	266
1081	f	267
1082	f	267
1083	t	267
1084	f	267
1085	t	268
1086	f	268
1087	f	268
1088	f	268
1089	f	269
1090	t	269
1091	f	269
1092	f	269
1093	f	270
1094	t	270
2181	t	396
2182	f	396
2183	f	396
2184	f	396
2185	f	397
2186	f	397
2187	f	397
2188	t	397
2189	t	398
2190	f	398
2191	f	398
2192	f	398
2193	f	399
2194	t	399
2195	f	399
2196	f	399
2197	t	400
2198	f	400
2199	f	400
2200	f	400
2217	f	406
2218	f	406
2219	t	406
2220	f	406
2241	f	410
2242	f	410
2243	t	410
2244	f	410
2245	t	411
2246	f	411
2247	f	411
2248	f	411
2249	f	412
2250	f	412
2251	t	412
2252	f	412
2253	t	415
2254	f	415
2255	f	415
2256	f	415
2269	f	428
2270	t	428
2271	f	428
2272	f	428
2273	f	419
2274	t	419
2275	f	419
2276	f	419
2277	t	420
2278	f	420
2279	f	420
2280	f	420
2281	f	421
2282	f	421
2283	f	421
2284	t	421
2305	f	429
2306	f	429
2307	f	429
2308	t	429
2321	f	431
2322	f	431
2323	t	431
2324	f	431
2329	f	432
2330	t	432
2331	f	432
2332	f	432
1945	f	306
1946	f	306
1947	f	306
1948	t	306
1957	f	199
1958	t	199
1959	f	199
1960	f	199
1961	f	200
1962	t	200
1150	f	285
1151	t	285
1152	f	285
1153	f	285
1154	f	286
1155	t	286
1156	f	286
1157	f	286
1158	f	287
1159	t	287
1160	f	287
1161	f	287
1162	f	288
1163	f	288
1164	f	288
1165	t	288
1166	t	289
1167	f	289
1168	f	289
1169	f	289
1174	t	291
1175	f	291
1176	f	291
1177	f	291
1178	f	292
1179	t	292
1180	f	292
1181	f	292
1182	t	293
1183	f	293
1184	f	293
1185	f	293
1963	f	200
1964	f	200
1985	t	283
1986	f	283
1190	f	295
1191	t	295
1192	f	295
1193	f	295
1194	f	296
1195	t	296
1196	f	296
1197	f	296
1198	f	297
1199	f	297
1200	t	297
1201	f	297
1202	f	298
1203	t	298
1204	f	298
1205	f	298
1206	f	299
1207	t	299
1208	f	299
1209	f	299
1210	t	300
1211	f	300
1212	f	300
1213	f	300
1214	f	301
1215	f	301
1216	t	301
1217	f	301
1220	f	302
1221	f	302
1222	f	303
1223	t	303
1224	f	303
1225	f	303
1226	f	304
1227	f	304
1228	f	304
1229	t	304
1230	f	305
1231	f	305
1232	t	305
1233	f	305
1242	f	308
1243	t	308
1244	f	308
1245	f	308
1246	t	309
1247	f	309
1248	f	309
1249	f	309
1250	t	310
1251	f	310
1252	f	310
1253	f	310
1254	f	311
1255	f	311
1256	t	311
1257	f	311
1258	f	312
1259	t	312
1260	t	312
1261	f	312
1262	f	313
1263	t	313
1264	f	313
1265	f	313
1266	f	314
1267	f	314
1268	f	314
1269	t	314
1270	f	315
1271	t	315
1272	f	315
1273	f	315
1274	f	316
1275	f	316
1276	f	316
1277	t	316
1278	t	317
1279	f	317
1280	f	317
1281	f	317
1282	t	318
1283	f	318
1284	f	318
1285	f	318
1286	f	319
1287	t	319
1288	f	319
1289	f	319
1290	f	320
1291	t	320
1292	f	320
1293	f	320
1294	f	321
1295	f	321
1296	f	321
1297	t	321
1298	f	322
1299	t	322
1300	f	322
1301	f	322
1302	f	323
1303	t	323
1304	f	323
1305	f	323
1306	f	324
1307	t	324
1308	f	324
1309	f	324
1310	f	325
1987	f	283
1988	f	283
2005	f	384
2006	f	384
2007	f	384
2008	t	384
1311	f	325
1312	f	325
1313	t	325
1314	f	326
1315	f	326
1316	t	326
1317	f	326
1318	f	327
1319	f	327
1320	t	327
1321	f	327
1322	t	328
1323	f	328
1324	f	328
1325	f	328
1326	f	329
1327	t	329
1328	f	329
1329	f	329
1330	f	330
1331	t	330
1332	f	330
1333	f	330
1334	f	331
1335	f	331
1336	t	331
1337	f	331
1342	t	333
1343	f	333
1344	f	333
1345	f	333
1346	f	334
1347	f	334
1348	t	334
1349	f	334
1350	t	335
1351	f	335
1352	f	335
1353	f	335
1354	f	336
1355	f	336
1356	t	336
1357	f	336
1362	t	338
1363	f	338
1364	f	338
1365	f	338
1366	f	339
1367	t	339
1368	f	339
1369	f	339
1370	t	340
1371	f	340
1372	f	340
1373	f	340
1374	f	341
1375	t	341
1376	f	341
1377	f	341
1378	t	342
1379	f	342
1380	f	342
1381	f	342
1382	f	343
1383	f	343
1384	t	343
1385	f	343
1386	f	344
1387	t	344
1388	f	344
1389	f	344
1390	t	345
1391	f	345
1392	f	345
1393	f	345
1394	f	346
1395	f	346
1396	t	346
1397	f	346
1398	t	347
1399	f	347
1400	f	347
1401	f	347
1402	t	348
1403	f	348
1404	f	348
1405	f	348
1406	f	349
1407	f	349
1408	f	349
1409	t	349
1410	t	350
1411	f	350
1412	f	350
1413	f	350
1414	f	351
1415	t	351
1416	f	351
1417	f	351
1418	f	352
1419	t	352
1420	f	352
1421	f	352
1422	f	353
1423	f	353
1424	t	353
1425	f	353
1426	t	354
1427	f	354
1428	f	354
1429	f	354
1430	f	355
1431	f	355
1432	t	355
1433	f	355
1434	t	356
1435	f	356
1436	f	356
1437	f	356
1438	f	357
1439	f	357
1440	t	357
1441	f	357
1442	f	358
1443	f	358
1444	t	358
1445	f	358
1446	f	359
1447	t	359
1448	f	359
1449	f	359
1450	f	360
1451	f	360
1452	t	360
1453	f	360
1454	f	361
1455	t	361
1456	f	361
1457	f	361
1458	f	362
1459	f	362
1460	t	362
1461	f	362
1462	f	363
1463	t	363
1464	f	363
1465	f	363
1466	f	364
1467	f	364
1468	t	364
1469	f	364
1470	t	365
1471	f	365
1472	f	365
1473	f	365
1474	f	366
1475	f	366
1476	t	366
1477	f	366
1478	t	367
1479	f	367
1480	f	367
1481	f	367
1482	t	368
1483	f	368
1484	f	368
1485	f	368
1486	t	369
1487	f	369
1488	f	369
1489	f	369
1490	f	370
1491	t	370
1492	f	370
1493	f	370
1494	f	371
1495	f	371
1496	t	371
1497	f	371
1498	f	372
1499	t	372
1500	f	372
1501	f	372
1502	t	373
1503	f	373
1504	f	373
1505	f	373
1506	f	374
1507	f	374
1508	f	374
1509	t	374
1510	f	375
1511	f	375
1512	t	375
1513	f	375
1618	f	388
1619	f	388
1620	f	388
1621	t	388
1622	t	387
1623	f	387
1624	f	387
1625	f	387
1626	f	386
1627	t	386
1628	f	386
1629	f	386
1642	f	389
1643	t	389
1644	f	389
1645	f	389
1650	t	294
1651	f	294
1652	f	294
1653	f	294
1658	f	383
1659	t	383
1660	f	383
1661	f	383
1666	t	381
1667	f	381
1668	f	381
1669	f	381
1670	t	380
1671	f	380
1672	f	380
1673	f	380
1678	t	378
1679	f	378
1680	f	378
1681	f	378
1682	f	195
1683	f	195
1684	f	195
1685	f	195
1686	t	203
1687	f	203
1688	f	203
1689	f	203
1690	f	206
1691	f	206
1692	f	206
1693	t	206
1698	f	208
1699	f	208
1700	t	208
1701	f	208
1706	f	209
1707	t	209
1708	f	209
1709	f	209
1710	t	210
1711	f	210
1712	f	210
1713	f	210
1722	f	212
1723	f	212
1724	t	212
1725	f	212
1726	f	213
1727	t	213
1728	f	213
1729	f	213
1730	f	214
1731	f	214
1732	f	214
1733	t	214
1734	f	215
1735	t	215
1736	f	215
1737	f	215
1738	t	216
1739	f	216
1740	f	216
1741	f	216
1742	t	217
1743	f	217
1744	f	217
1745	f	217
1746	t	218
1747	f	218
1748	f	218
1749	f	218
1750	t	219
1751	f	219
1752	f	219
1753	f	219
1754	f	220
1755	t	220
1756	f	220
1757	f	220
1758	f	221
1759	t	221
1760	f	221
1761	f	221
1766	f	222
1767	f	222
1768	t	222
1769	f	222
1770	f	223
1771	t	223
1772	f	223
1773	f	223
1774	f	224
1775	t	224
1776	f	224
1777	f	224
1778	f	225
1779	f	225
1780	f	225
1781	t	225
1782	t	226
1783	f	226
1784	f	226
1785	f	226
1790	f	227
1791	f	227
1792	t	227
1793	f	227
1794	f	228
1795	f	228
1796	t	228
1797	f	228
1798	f	229
1799	f	229
1800	t	229
1801	f	229
1802	f	230
1803	f	230
1804	t	230
1805	f	230
1806	f	235
1807	t	235
1808	f	235
1809	f	235
1810	t	238
1811	f	238
1812	f	238
1813	f	238
1814	t	239
1815	f	239
1816	f	239
1817	f	239
1818	t	240
1819	f	240
1820	f	240
1821	f	240
1822	f	241
1823	f	241
1824	f	241
1825	t	241
1826	f	242
1827	f	242
1828	f	242
1829	t	242
1830	f	243
1831	t	243
1832	f	243
1833	f	243
1834	t	244
1835	f	244
1836	f	244
1837	f	244
1838	f	245
1839	t	245
1840	f	245
1841	f	245
1842	f	246
1843	t	246
1844	f	246
1845	f	246
1846	f	247
1847	f	247
1848	t	247
1849	f	247
1850	t	248
1851	f	248
1852	f	248
1853	f	248
1854	f	249
1855	t	249
1856	f	249
1857	f	249
1858	t	250
1859	f	250
1860	f	250
1861	f	250
1862	f	251
1863	f	251
1864	f	251
1865	t	251
1866	t	252
1867	f	252
1868	f	252
1869	f	252
1870	t	253
1871	f	253
1872	f	253
1873	f	253
1874	f	254
1875	f	254
1876	f	254
1877	t	254
1878	f	255
1879	f	255
1880	t	255
1881	f	255
1882	f	256
1883	f	256
1884	t	256
1885	f	256
1886	f	257
1887	f	257
1888	t	257
1889	f	257
1890	f	271
1891	t	271
1892	f	271
1893	f	271
1894	f	272
1895	f	272
1896	f	272
1897	f	273
1898	t	273
1899	f	273
1900	f	273
1901	f	274
1902	f	274
1903	t	274
1904	f	274
1905	t	275
1906	f	275
1907	f	275
1908	f	275
1909	f	276
1910	f	276
1911	f	276
1912	t	276
1913	t	277
1914	f	277
1915	f	277
1916	f	277
1917	f	278
1918	t	278
1919	f	278
1920	f	278
1921	f	279
1922	f	279
1923	t	279
1924	f	279
1925	f	280
1926	f	280
1927	f	280
1928	t	280
1965	f	204
1966	f	204
1967	t	204
1968	f	204
1989	f	332
1990	f	332
1991	f	332
1992	t	332
2409	f	442
2410	t	442
2411	f	442
2412	f	442
2421	f	443
2422	t	443
2423	f	443
2424	f	443
2429	t	444
2430	f	444
2431	f	444
2432	f	444
\.


--
-- Data for Name: OptionTranslation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OptionTranslation" (id, language, text, "optionId") FROM stdin;
13	RW	Abanyamaguru	5
14	EN	Pedestrians	5
15	FR	Piétons	5
16	RW	Ibinyabiziga bigendera ku biziga bibiri	6
17	EN	Two wheel vehicles	6
18	FR	Véhicules à deux roues	6
19	RW	A na B ni ibisubizo by’ukuri	7
20	EN	A and B both are correct	7
21	FR	A et B sont de bonnes réponses	7
22	RW	Ibisubizo byose nibyo	8
23	EN	All responses are correct	8
24	FR	Toutes les réponses sont correctes	8
25	RW	Igisate cy’umuhanda abayobozi bagomba gukurikira	9
26	EN	The traffic lane that drivers must follow	9
27	FR	La bande de circula on que les conducteurs doivent suivre	9
28	RW	Ahegereye umurongo ukomeje	10
29	EN	Approach of a con nuous line	10
30	FR	L’approche d’une ligne con nue	10
31	RW	Igabanurwa ry’umubare w’ibisate by’umuhanda mu cyerekezo bajyamo	11
32	EN	Reduc on of the number of traffi lanes which may be used in the direc on followed	11
33	FR	La réduc on des nombres des bandes de circula on pouvant être u lisées dans les sens suivi	11
34	RW	A na C nibyo	12
35	EN	A and C are both correct	12
36	FR	A et C sont de bonnes réponses	12
37	RW	Biteganye	13
38	EN	In parallel lines	13
39	FR	En files parallèles	13
40	RW	Ku murongo umwe	14
41	EN	On one line	14
42	FR	En file unique	14
43	RW	A na B nibyo	15
44	EN	A and B are both correct	15
45	FR	A and B sont correctes	15
46	RW	Nta gisubizo cy’ukuri kirimo	16
47	EN	None	16
48	FR	Toutes les réponses sont fausses	16
61	RW	Umuyobozi	21
62	EN	A driver	21
63	FR	Un conducteur	21
64	RW	Umuherekeza	22
65	EN	A conveyor	22
66	FR	Un convoyeur	22
67	RW	A na B ni ibisubizo by’ukuri	23
68	EN	A and B are correct	23
69	FR	A et B sont de bonnes réponses	23
70	RW	Nta gisubizo cy’ukuri kirimo	24
71	EN	No correct answer	24
72	FR	Aucune de réponses n’est correctes	24
73	RW	Ibinyabiziga bigenewe gutwara abagenzi rusange	25
74	EN	Vehicles for public transport	25
75	FR	Les véhicules des nés au transport de personnes en commun	25
76	RW	Ibinyabiziga bigenewe gutwara ibintu biretoni 3.5	26
77	EN	Vehicles for transport of goods which carrying capacity exceed 3.5 tones	26
78	FR	Les véhicules des nés au transport des marchandises dont la charge est supérieure à 3.5 tonnes	26
79	RW	Ibinyabiziga bigenewe kwigisha gutwara	27
80	EN	Vehicles for driving school	27
81	FR	Les véhicules d’autoécole	27
82	RW	Nta gisubizo cy’ukuri kirimo	28
83	EN	None	28
84	FR	Pas de bonne réponse	28
85	RW	cm75	29
86	EN	75 cm	29
87	FR	75 cm	29
88	RW	cm125	30
89	EN	125 cm	30
90	FR	125 cm	30
91	RW	cm265	31
92	EN	265 cm	31
93	FR	265 cm	31
94	RW	Nta gisubizo cy’ukuri	32
95	EN	No correct answer	32
96	FR	Aucune de réponses n’est correctes réponse	32
97	RW	Ibifite umutambiko umwe uhuza imipira	33
98	EN	Vehicles with one axle	33
99	FR	les véhicules à un essieu	33
100	RW	Ibifite imitambiko ibiri ikurikiranye mu bugari bwayo	34
101	EN	Vehicles with two axles placed in the con nua on one of the other	34
102	FR	les véhicules à deux essieux placés dans les prolongements l’un de l’autre	34
103	RW	Makuzungu	35
104	EN	Semi-trailer	35
105	FR	semi-remorque	35
106	RW	Nta gisubizo cy’ukuri	36
107	EN	No correct answer	36
108	FR	toutes les réponses sont fausses	36
109	RW	Ahatarengeje metero 1 imbere cyangwa inyuma y’ikinyabiziga gihagaze akanya gato cyangwa kanini :	37
110	EN	At less than 1meter either before or behind another vehicle at stop or in parking	37
111	FR	A moins d’un mètre devant que derrière un autre véhicule à l’arrêt au en sta onnement	37
112	RW	Ahantu hari ibimenyetso bibuza byabugenewe	38
113	EN	Where appropriate prohibi on signals are placed	38
114	FR	Aux endroits comportant des signaux d’interdic on appropriés	38
115	RW	Aho abanyamaguru banyura mu muhanda ngo bakikire inkomyi	39
116	EN	At places where pedestrians must walk on the roadway to pass round an obstacle	39
117	FR	Aux endroits oύ les piétons doivent emprunter la chaussée pour contourner un obstacle	39
118	RW	Ibisubizo byose nibyo	40
119	EN	All answer arecorrect	40
120	FR	Toutes les réponses sont justes	40
121	RW	Mu ruhande rw’iburyo gusa	41
122	EN	The right side only	41
123	FR	Sur la côte droite seulement	41
124	RW	Igihe cyose ni ibumoso	42
125	EN	Every me on the le side	42
126	FR	Toutes fois à gauche	42
127	RW	Iburyo iyo unyura ku nyamaswa	43
128	EN	The right side only to overtake an animal	43
129	FR	A droite si on dépasse un animal	43
130	RW	Nta gisubizo cy’ukuri kirimo	44
131	EN	No correct answer	44
132	FR	Aucune de réponses n’est correctes réponse n’est juste	44
133	RW	Burenga toni 1	45
134	EN	Weight exceeds 1 tone	45
135	FR	Dépassant 1 Tone	45
136	RW	Burenga toni 2	46
137	EN	Weight exceeds 2tones	46
138	FR	Dépassant 2 Tone	46
139	RW	Burenga toni 24	47
140	EN	Weight exceeds 24tones	47
141	FR	Dépassant24Tones	47
142	RW	Nta gisubizo cy’ukuri kirimo	48
143	EN	No correct answer	48
144	FR	Aucune de réponses n’est correctes	48
145	RW	Km50	49
146	EN	50km/h	49
147	FR	50km/h	49
148	RW	Km40	50
149	EN	40km/h	50
150	FR	40km/h	50
151	RW	Km30	51
152	EN	30km/h	51
153	FR	30km/h	51
154	RW	Nta gisubizo cy’ukuri kirimo	52
155	EN	None	52
156	FR	Aucune de réponses n’est correctes	52
157	RW	Umuvuduko w’abanyamaguru	53
158	EN	The speed of the pedestrians	53
159	FR	La vitesse de piétons	53
160	RW	Ubugari bw’umuhanda	54
161	EN	The width of the road	54
162	FR	La largeur de la route	54
163	RW	Umubare w’abanyamaguru	55
164	EN	The number of pedestrians	55
165	FR	Le nombre de piétons	55
166	RW	Nta gisubizo cy’ukuri kirimo	56
167	EN	No correct answer	56
168	FR	Aucune de réponses n’est correctes réponse n’est juste	56
169	RW	Amatara ndanga	57
170	EN	Side lights	57
171	FR	Feux de posi on	57
172	RW	Amatara ari imbere mu modoka	58
173	EN	Internal ligh ng	58
174	FR	l’éclairage intérieur	58
175	RW	Amatara ndangaburambarare	59
176	EN	Gauge light	59
177	FR	feu d’encombrement	59
178	RW	Ibisubizo byose nibyo	60
179	EN	All answers are correct	60
180	FR	toutes les réponses sont justes	60
181	RW	Km25	61
182	EN	25km/h	61
183	FR	25km/h	61
184	RW	Km70	62
185	EN	70km/h	62
186	FR	70km/h	62
187	RW	Km40	63
188	EN	40km/h	63
189	FR	40km/h	63
190	RW	Nta gisubizo cy’ukuri kirimo	64
191	EN	No correct answer	64
192	FR	Aucune de réponses n’est correctes réponse n’est juste	64
193	RW	Feri y’urugendo	65
194	EN	Service brake	65
195	FR	Frein de service	65
196	RW	Feri yo guhagarara umwanya munini	66
197	EN	Parking brake	66
198	FR	Frein de sta onnement	66
199	RW	Feri yo gutabara	67
200	EN	Emergency braking	67
201	FR	Frein de secours	67
202	RW	Nta gisubizo cy’ukuri kirimo	68
203	EN	No correct answer	68
204	FR	Aucune de réponses n’est correctes réponse n’est juste	68
205	RW	2	69
206	EN	2	69
207	FR	2	69
208	RW	3	70
209	EN	3	70
210	FR	3	70
211	RW	1	71
212	EN	1	71
213	FR	1	71
214	RW	Nta gisubizo cy’ukuri kirimo	72
215	EN	No correct answer	72
216	FR	Aucune de réponses n’est correctes réponse n’est juste	72
217	RW	Iyo umuhanda umurikiye umuyobozi abasha kureba muri metero 20	73
218	EN	A roadway ligh ng is con nuous and sufficient to permit the driver to see dis nctly up to a distance of 20m	73
219	FR	Lorsque l’éclairage de la chaussée est con nue et suffisant pour perme re au conducteur de voir dis nctement jusqu’à 20m	73
220	RW	Iyo ikinyabiziga kigiye kubisikana n’ibindi	74
221	EN	When a vehicle is going to cross another	74
222	FR	Lorsque le véhicule va en croiser un autre	74
223	RW	Iyo ari mu nsisiro	75
224	EN	In agglomera on	75
225	FR	Dans une aggloméra on	75
226	RW	Ibisubizo byose ni ukuri	76
227	EN	All responses are correct	76
228	FR	Toutes les réponses sont justes	76
229	RW	Itara ndangamubyimba	77
230	EN	Size light	77
231	FR	Feu de gabarit	77
232	RW	Itara ryerekana icyerekezo	78
233	EN	Indicator light	78
234	FR	Feu indicateur de direc on	78
235	RW	Itara ndangaburumbarare	79
236	EN	Gauge light	79
237	FR	Feux d’encombrement	79
238	RW	Ibisubizo byose ni ukuri	80
239	EN	All responses are correct	80
240	FR	Toutes les réponses sont justes	80
241	RW	cm25	81
242	EN	25 cm	81
243	FR	25 cm	81
244	RW	cm125	82
245	EN	125 cm	82
246	FR	125 cm	82
247	RW	cm45	83
248	EN	45 cm	83
249	FR	45 cm	83
250	RW	Nta gisubizo cy’ukuri kirimo	84
251	EN	No correct answer	84
252	FR	Aucune de réponses n’est correctes réponse n’est juste	84
253	RW	Ni itara ry’icyatsi rishyirwa imbere ku kinyabiziga	85
254	EN	The green light placed at the front	85
255	FR	Le feu vert fixé à l’avant	85
256	RW	Ni itara ry’icyatsi rishyirwa ibumoso	86
257	EN	The green light placed at le	86
258	FR	Le feu vert fixé à gauche	86
259	RW	Ni itara ry’umuhondo rishyirwa inyuma	87
260	EN	The yellow light placed at behind of the vehicle	87
261	FR	Le feu jaune fixé derrière le véhicule	87
262	RW	A na C ni ibisubizo by’ukuri	88
263	EN	A and C are the right answers	88
264	FR	A et C sont les bonnes réponses	88
265	RW	Amatara abiri ashyirwa inyuma	89
266	EN	behind of the vehicle	89
267	FR	derrière le véhicule	89
268	RW	Amatara abiri ashyirwa imbere	90
269	EN	in front of the vehicle	90
270	FR	à l’avant du véhicule	90
271	RW	Rimwe rishyirwa imbere irindi inyuma	91
272	EN	one is placed in front and the other at the back of the vehicle	91
273	FR	l'un à l’avant et l'autre à l'arrière du véhicule	91
274	RW	b na c ni ibisubizo by’ukuri	92
275	EN	b and c are the right answers	92
276	FR	b et c sont les bonne réponses	92
277	RW	Metero 100 ku manywa na metero 20 mu ijoro	93
278	EN	100 m by day light and 20meters night	93
279	FR	100 m le jour et 20 m la nuit	93
280	RW	Metero 150 ku manywa na metero50 mu ijoro	94
281	EN	150 m by day light and 50 metersnight	94
282	FR	150 m le jour et 50 m la nuit	94
283	RW	Metero 200 ku manywa na metero100 mu ijoro	95
284	EN	200 m by day light and 100metersnight	95
285	FR	200 m le jour et 100 m la nuit	95
286	RW	Nta gisubizo cy’ukuri kirimo	96
287	EN	None of them are correct	96
288	FR	Aucune de réponses n’est correctes	96
289	RW	Metero 100	97
290	EN	100 m	97
291	FR	100 m	97
292	RW	Metero 200	98
293	EN	200 m	98
294	FR	200 m	98
295	RW	Metero 50	99
296	EN	50 m	99
297	FR	50 m	99
298	RW	Metero 150	100
299	EN	150 m	100
300	FR	150 m	100
301	RW	Ku binyabiziga by’ingabo bijya ahatarenga km25	101
302	EN	Military vehicles in circulation within a maximum radius of 25km	101
303	FR	Les véhicules militaires en circulation dans un rayon maximum de 25km	101
304	RW	Ibinyabiziga bihinga	102
305	EN	Agricultural vehicles	102
306	FR	Les véhicules agricoles	102
307	RW	Ibinyabiziga bya police	103
308	EN	Vehicles of national police	103
309	FR	les véhicules de la police national	103
310	RW	Nta gisubizo cy’ukuri kirimo	104
311	EN	None of them is correct	104
312	FR	Aucune de réponses n’est correctes	104
313	RW	Ahanyurwa n’ibinyamitende	105
314	EN	Bicycles and mopeds	105
315	FR	Le passage pour les bicyclettes et cyclomoteur	105
316	RW	Ahanyurwa n’amagare na velomoteri	106
317	EN	Wheel barrows	106
318	FR	Le passage pour les brouettes	106
319	RW	Ahanyurwa n’ingorofani	107
320	EN	Cycles	107
321	FR	Le passage pour les cycles	107
322	RW	Nta gisubizo cy’ukuri kirimo	108
323	EN	None of them is correct	108
324	FR	Aucune de réponses n’est correctes	108
325	RW	Igare	109
326	EN	A bicycle	109
327	FR	Bicyclette	109
328	RW	Velomoteri	110
329	EN	A scooter	110
330	FR	Cyclomoteur	110
331	RW	Ipikipiki ifite akanyabiziga kuruhande	111
332	EN	A motorcycle with side car	111
333	FR	Motocyclette	111
334	RW	byose ni ibisubizo by’ukuri	112
335	EN	All answers are correct	112
336	FR	Toutes les réponses sont correctes	112
337	RW	Imyaka 10	113
338	EN	10 years	113
339	FR	10ans	113
340	RW	Imyaka 12	114
341	EN	12 years	114
342	FR	12ans	114
343	RW	Imyaka 7	115
344	EN	7 years	115
345	FR	7ans	115
346	RW	Ntagisubizo cy’ukuri kirimo	116
347	EN	None of them is correct	116
348	FR	Aucune de réponses n’est correctes	116
349	RW	Ubuso ni umweru	117
350	EN	White surface	117
351	FR	La surface en couleur blanche	117
352	RW	Ikirango ni umutuku n’umukara	118
353	EN	Symbol is red and black	118
354	FR	Le symbole en rouge et noir	118
355	RW	Ikirango ni umweru n’umukara	119
356	EN	Symbol is black	119
357	FR	Le symbole en branche et noir	119
358	RW	Nta gisubizo cy’ukuri kirimo	120
359	EN	None of the answers is correct	120
360	FR	Aucune de réponses n’est correctes	120
361	RW	Iyo nta cyapa cyo gutambuka mbere gihari	121
362	EN	When there is no road signal for priority	121
363	FR	lorsqu’il n’y a pas de signaux de priorité	121
364	RW	Iyo ikimenyetso kimurika cyagenewe ibinyabiziga kidakora	122
365	EN	When the traffic lights intended for vehicle do not work properly	122
366	FR	lorsque la signalisation lumineuse ne fonctionne pas	122
367	RW	A na B ni ibisubizo by’ukuri	123
368	EN	A and B are correct	123
369	FR	A et B sont correctes	123
370	RW	Nta gisubizo cy’ukuri	124
371	EN	None of the answers is correct	124
372	FR	Aucune de réponses n’est correctes	124
373	RW	Hakurikijwe icyerekezo abagenzi bireba baganamo	125
374	EN	Following the direction of the vehicle concerned.	125
375	FR	La direction suivie par les conducteurs qu’ils concernent	125
376	RW	Hakurikijwe icyo ibyo bimenyetso bigamije kwerekana	126
377	EN	Following the nature of things they do indicate	126
378	FR	La nature de ce qu’ils indiquent	126
379	RW	Kugirango birusheho kugaragara neza	127
380	EN	Where their visibility is best ensured for the users	127
381	FR	Ou leur visibilité est le mieux assurée	127
382	RW	Ibisubizo byose ni ukuri	128
383	EN	All answers are correct	128
384	FR	Toutes les réponses sont correctes	128
385	RW	Kuri buri nzira	129
386	EN	On each roadway	129
387	FR	Sur chaque voie	129
388	RW	Hagati y’amasangano	130
389	EN	In the middle of the cross-road	130
390	FR	Au centre du carrefour	130
391	RW	Iburyo bw’amasangano	131
392	EN	On the right of cross-roads	131
393	FR	À droite du carrefour	131
394	RW	a na b ni ibisubizo by’ ukuri	132
395	EN	a and b are correct answers	132
396	FR	a et b sont des bonnes réponses	132
397	RW	Ibumoso babona ibara ritukura gusa	133
398	EN	They see red reflectors on the left only	133
399	FR	Ils voient à gauche seulement les rouges	133
400	RW	Iburyo babona icunga rihishije gusa	134
401	EN	On the right they see orange only	134
402	FR	À droite ils voient seulement orange	134
403	RW	Ibumoso babona umuhondo gusa	135
404	EN	On the left they see yellow only	135
405	FR	À gauche ils voient seulement jaune	135
406	RW	Nta gisubizo cy’ukuri kirimo	136
407	EN	None of the answers is correct	136
408	FR	Aucune de réponses n’est correcte	136
409	RW	Ibinyabiziga bitwara abagenzi muri rusange	137
410	EN	Public transport vehicles	137
411	FR	Véhicules de transport en commun	137
412	RW	Ibinyabiziga bitwara ibintu birengeje toni 3.5	138
413	EN	Goods vehicles over 3.5 tons	138
414	FR	Véhicules de marchandises plus de 3.5 tonnes	138
415	RW	Ibinyabiziga byigisha gutwara	139
416	EN	Driving school vehicles	139
417	FR	Véhicules d’auto-école	139
418	RW	Ibisubizo byose ni ukuri	140
419	EN	All answers are correct	140
420	FR	Toutes les réponses sont justes	140
421	RW	Ubururu	141
422	EN	Blue	141
423	FR	Bleu	141
424	RW	umweru	142
425	EN	White	142
426	FR	Blanc	142
427	RW	Umutuku	143
428	EN	Red	143
429	FR	Rouge	143
430	RW	Nta gisubizo cy’ukuri kirimo	144
431	EN	None of the answers is correct	144
432	FR	Aucune de réponses n’est correcte	144
433	RW	Ibyapa biyobora n’ibitegeka	145
434	EN	Indication and obligation signs	145
435	FR	Signaux d’indication et d’obligation	145
436	RW	Ibyapa biburira n’ibitegeka	146
437	EN	Danger and obligation signs	146
438	FR	Signaux de danger et d’obligation	146
439	RW	Ibyapa bibuza n’ibitegeka	147
440	EN	Prohibition and obligation signs	147
441	FR	Signaux d’interdiction et d’obligation	147
442	RW	Nta gisubizo cy’ukuri kirimo	148
443	EN	None of the answers is correct	148
444	FR	Aucune de réponses n’est correcte	148
445	RW	Feri y’urugendo	149
446	EN	Service brake	149
447	FR	Frein de service	149
448	RW	Feri yo gutabara	150
449	EN	Emergency brake	150
450	FR	Frein de secours	150
451	RW	Feri yo guhagarara umwanya munini	151
452	EN	Parking brake	151
453	FR	Frein de stationnement	151
454	RW	Nta gisubizo cy’ukuri kirimo	152
455	EN	None of the answers is correct	152
456	FR	Aucune de réponses n’est correcte	152
457	RW	Agatambaro gatukura cm 50	153
458	EN	A red cloth of 0.50m	153
459	FR	Un tissu rouge de 0.50m	153
460	RW	Itara risa n’icunga rihishije	154
461	EN	Orange light	154
462	FR	Feu orange	154
463	RW	Icyapa cyera cya cm 20	155
464	EN	White panel 0.20m	155
465	FR	Panneau blanc 0.20m	155
466	RW	Nta gisubizo cy’ukuri kirimo	156
467	EN	None of the answers is correct	156
468	FR	Aucune de réponses n’est correcte	156
469	RW	Toni 10	157
470	EN	10 tons	157
471	FR	10 tonnes	157
472	RW	Toni 12	158
473	EN	12 tons	158
474	FR	12 tonnes	158
475	RW	Toni 16	159
476	EN	16 tons	159
477	FR	16 tonnes	159
478	RW	Toni 24	160
479	EN	24 tons	160
480	FR	24 tonnes	160
481	RW	cm 30 ku bugari bw’icyo kinyabiziga	161
482	EN	0.30m extra width	161
483	FR	0.30m de plus	161
484	RW	Metero 2.5 ntarengwa	162
485	EN	Maximum 2.5m	162
486	FR	Maximum 2.5m	162
487	RW	A na B ni ibisubizo by’ukuri	163
488	EN	A and B are correct	163
489	FR	A et B sont correctes	163
490	RW	Nta gisubizo cy’ukuri kirimo	164
491	EN	None of the answers is correct	164
492	FR	Aucune de réponses n’est correcte	164
493	RW	Hafi y’iteme ahari umuhanda ufunganye	165
494	EN	Near a bridge with narrow road	165
495	FR	À l’approche d’un pont	165
496	RW	Hafi y’abanyamaguru banyura	166
497	EN	Near pedestrian crossing	166
498	FR	Passage pour piétons	166
499	RW	Hafi y’ibice by’umuhanda bimeze nabi	167
500	EN	Near dangerous road sections	167
501	FR	Parties de route dangereuses	167
502	RW	Ibi bisubizo byose ni ukuri	168
503	EN	All answers are correct	168
504	FR	Toutes les réponses sont justes	168
505	RW	Km 60 mu isaha	169
506	EN	60 km/h	169
507	FR	60 km/h	169
508	RW	Km 40 mu isaha	170
509	EN	40 km/h	170
510	FR	40 km/h	170
511	RW	Km 25 mu isaha	171
512	EN	25 km/h	171
513	FR	25 km/h	171
514	RW	Km20 mu isaha	172
515	EN	20 km/h	172
516	FR	20 km/h	172
517	RW	Km 60 mu isaha	173
518	EN	60 km/h	173
519	FR	60 km/h	173
520	RW	Km 40 mu isaha	174
521	EN	40 km/h	174
522	FR	40 km/h	174
523	RW	Km 75 mu isaha	175
524	EN	75 km/h	175
525	FR	75 km/h	175
526	RW	Km20 mu isaha	176
527	EN	20 km/h	176
528	FR	20 km/h	176
529	RW	Imbere y’ahantu hinjirwa hakasohokerwa n’abantu benshi	177
530	EN	In front of entrances and exits of public passages	177
531	FR	Devant les entrées et les sor es des passages publics	177
532	RW	Mu muhanda aho ugabanyijemo ibisate bigaragazwa n’imirongo idacagaguye	178
533	EN	On the roadway at places divided by continuous marks	178
534	FR	Sur la chaussée divisée par des marques continues	178
535	RW	A na B ni ibisubizo by’ukuri	179
536	EN	A and B are both correct	179
537	FR	A et B sont justes	179
538	RW	Nta gisubizo cy’ukuri kirimo	180
539	EN	None of the answer is correct	180
540	FR	Aucune de réponses n’est correcte	180
541	RW	Imbere ni itara ry’umuhondo ritwariwe ibumoso	181
542	EN	Front yellow light on left side	181
543	FR	À l’avant feu jaune à gauche	181
544	RW	Inyuma ni itara ryera ritwariwe ibumoso	182
545	EN	Rear white light on left side	182
546	FR	À l’arrière feu blanc à gauche	182
547	RW	A na B ni ibisubizo by’ukuri	183
548	EN	A and B are correct	183
549	FR	A et B sont correctes	183
550	RW	Nta gisubizo cy’ukuri kirimo	184
551	EN	None of the answer is correct	184
552	FR	Aucune de réponses n’est correcte	184
553	RW	Hari amategeko yihariye yerekanwa n’ibimenyetso	185
554	EN	There are special rules shown by signals	185
555	FR	Il y a des règles spéciales signalées	185
556	RW	Iyo badatatanye kandi bayobowe n’umwarimu	186
557	EN	When in groups under supervision	186
558	FR	Lorsqu’ils sont groupés et dirigés	186
559	RW	Iyo hatari amategeko yihariye yerekanwa n’ibimenyetso	187
560	EN	When there is no special regulation shown by signals	187
561	FR	Lorsqu’il n’y a pas de réglementation spéciale signalée	187
562	RW	Ibisubizo byose ni ukuri	188
563	EN	All answers are correct	188
564	FR	Toutes réponses sont justes	188
565	RW	Mu nsisiro gusa	189
566	EN	In built-up areas only	189
567	FR	Dans les agglomérations seulement	189
568	RW	Ahegereye inyamaswa zikurura	190
569	EN	Approaching mounted animals only	190
570	FR	À l’approche des animaux de selle seulement	190
571	RW	Hafi y’amatungo	191
572	EN	Approaching only livestock	191
573	FR	À l’approche du bétail seulement	191
574	RW	Nta gisubizo cy’ukuri kirimo	192
575	EN	None of the answers is correct	192
576	FR	Aucune des réponses n’est correcte	192
577	RW	Romoruki ifite feri y’urugendo	193
578	EN	Trailer provided with service brake	193
579	FR	Remorque munie d’un frein de service	193
580	RW	Romoruki idafite feri y’urugendo	194
581	EN	Trailer not provided with service brake	194
582	FR	Remorque non munie d’un frein de service	194
583	RW	Romoruki itarenza kg 750	195
584	EN	Trailer not exceeding 750 kg	195
585	FR	Remorque ne dépassant pas 750 kg	195
586	RW	Nta gisubizo cy’ukuri kirimo	196
587	EN	None of the answers is correct	196
588	FR	Aucune des réponses n’est correcte	196
589	RW	Metero 3	197
590	EN	3 meters	197
591	FR	3 mètres	197
592	RW	Metero 2 na cm 50	198
593	EN	2.50 meters	198
594	FR	2,50 mètres	198
595	RW	Metero 2 na cm 10	199
596	EN	2.10 meters	199
597	FR	2,10 mètres	199
598	RW	Metero 2	200
599	EN	2 meters	200
600	FR	2 mètres	200
613	RW	Cm 30	205
614	EN	30 cm	205
615	FR	30 cm	205
616	RW	Cm 40	206
617	EN	40 cm	206
618	FR	40 cm	206
619	RW	Cm 50	207
620	EN	50 cm	207
621	FR	50 cm	207
622	RW	Metero 1 na cm 55	208
623	EN	1.55 m	208
624	FR	1,55 m	208
625	RW	itara ndangamubyimba	209
626	EN	size light	209
627	FR	feux de gabarit	209
628	RW	itara ndangaburumbarare	210
629	EN	gauge light	210
630	FR	feux d’encombrement	210
631	RW	itara ribonesha icyapa kiranga numero y’ikinyabiziga inyuma	211
632	EN	the back number plate lighting	211
633	FR	feux d’éclairage du signe d’immatriculation arrière	211
634	RW	A na B byose nibyo	212
635	EN	A and B are correct	212
636	FR	A et B sont juste	212
637	RW	m1 na cm 50	213
638	EN	1.50m	213
639	FR	1.50m	213
640	RW	m1 na cm 75	214
641	EN	1.75m	214
642	FR	1.75m	214
643	RW	m 1 na cm 90	215
644	EN	1.90m	215
645	FR	1.90m	215
646	RW	m2 na cm 10	216
647	EN	2.10m	216
648	FR	2.10m	216
649	RW	igihe kigenda ahamanuka	217
650	EN	when it is on slow down	217
651	FR	s’il circule sur descente	217
652	RW	igihe gikuruwe n’ikindi kinyabiziga	218
653	EN	when it is trailed by another vehicle	218
654	FR	s’il est pris en remorque par un autre véhicule	218
655	RW	igihe gifite feri y’urugendo	219
656	EN	when it has the service brake	219
657	FR	s’il est muni de frein de service	219
658	RW	ibisubizo byose ni byo	220
659	EN	all answers are correct	220
660	FR	toutes les réponses sont justes	220
661	RW	inkombe mpimbano z’umuhanda	221
662	EN	its fictitious border	221
663	FR	le bord fictif de la chaussée	221
664	RW	ahahagararwa umwanya muto n’umun	222
665	EN	area reserved for stop and parking vehicles	222
666	FR	l’espace réservé pour l’arrêt et stationnement	222
667	RW	ahanyura abayobozi b’amagare	223
668	EN	cycle lanes	223
669	FR	le passage que les conducteurs de bicyclettes doivent utiliser	223
670	RW	nta gisubizo cy’ukuri kirimo	224
671	EN	none of the answers is correct	224
672	FR	aucune de réponses n’est correcte	224
673	RW	hafi y’inguni y’ibumoso bw’ikinyabiziga	225
674	EN	at left border of vehicle	225
675	FR	à proximité du bord gauche du véhicule	225
676	RW	inyuma hafi y’impera y’iburyo bw’ikinyabiziga	226
677	EN	at the back right edge of vehicle	226
678	FR	à l’arrière et à proximité droite du véhicule	226
679	RW	inyuma ahegereye inguni y’iburyo	227
680	EN	at the back near the right	227
681	FR	à l’arrière et à proximité droite du véhicule	227
682	RW	nta gisubizo cy’ukuri kirimo	228
683	EN	none of the answer is correct	228
684	FR	aucune de réponses n’est correcte	228
685	RW	ibinyabiziga bifite umuvuduko nibura w km 60 mu isaha	229
686	EN	motor vehicle likely to move above 60km per hour	229
687	FR	60 km à l’heure	229
688	RW	ibinyabiziga bishobora kurenza km 40 mu isaha	230
689	EN	motor vehicle likely to move above 40km per hour	230
690	FR	40 km à l’heure	230
691	RW	ibinyabiziga bishobora kurenza km 30 mu isaha	231
692	EN	motor vehicle likely to move above 30km per hour	231
693	FR	30 km à l’heure	231
694	RW	ibinyabiziga bishobora kurenza km 25 mu isaha	232
695	EN	motor vehicle likely to move above 25km per hour	232
696	FR	25 km à l’heure	232
697	RW	m 1.25	233
698	EN	1.25m	233
699	FR	1.25m	233
700	RW	cm 30	234
701	EN	30cm	234
702	FR	30cm	234
703	RW	cm 75	235
704	EN	75cm	235
705	FR	75cm	235
706	RW	nta gisubizo cy’ukuri kirimo	236
707	EN	none of the answer is correct	236
708	FR	aucune de réponses n’est correcte	236
709	RW	ibinyabiziga bifite ubugari burenga m 2.10	237
710	EN	vehicles wider than 2.10m	237
711	FR	véhicules dont la largeur est supérieure à 2.10m	237
712	RW	ibinyabiziga bya police y’igihugu	238
713	EN	national police vehicles	238
714	FR	véhicules de la police nationale	238
715	RW	ibinyabiziga ndakumirwa	239
716	EN	priority vehicles	239
717	FR	véhicules prioritaires	239
718	RW	ibisubizo byose ni ukuri	240
719	EN	all answers are correct	240
720	FR	toutes réponses sont justes	240
721	RW	kutarenza umuvuduko wa km 20 mu isaha	241
722	EN	do not exceed 20km/h	241
723	FR	ne dépassent pas 20km/h	241
724	RW	uburebure bwabyo butarengeje m 6	242
725	EN	length does not exceed 6m	242
726	FR	longueur n’excède pas 6m	242
727	RW	uburebure ntarengwa burenga m 8	243
728	EN	maximum length exceeds 8m	243
729	FR	longueur maximale n’excède pas 8m	243
730	RW	nta gisubizo cy’ukuri kirimo	244
731	EN	none of the answers is correct	244
732	FR	aucune de réponses n’est correcte	244
733	RW	itara ryera cyangwa ry’umuhondo cyangwa risa n’icunga rihishije riri inyuma ya romoruki	245
734	EN	white, yellow or orange light fixed at the back of the trailer	245
735	FR	feu blanc, jaune ou orange fixé à l’arrière de la remorque	245
736	RW	itara ry’icyatsi cyangwa ry’umuhondo cyangwa risa n’icunga	246
737	EN	green or yellow or orange light at the back	246
738	FR	feu vert ou jaune ou orange	246
739	RW	A na B ni ibisubizo by’ukuri	247
740	EN	A and B are correct answers	247
741	FR	A et B sont justes	247
742	RW	nta gisubizo cy’ukuri kirimo	248
743	EN	none of the answers is correct	248
744	FR	aucune de réponses n’est correcte	248
745	RW	inyuma ni m 3 na cm 50	249
746	EN	back 3.50m	249
747	FR	à l’arrière 3.50m	249
748	RW	imbere ni m 1 na cm 70	250
749	EN	front 1.70m	250
750	FR	à l’avant 1.70m	250
751	RW	A na B ni ibisubizo by’ukuri	251
752	EN	A and B are correct answers	251
753	FR	A et B sont justes	251
754	RW	nta gisubizo cy’ukuri kirimo	252
755	EN	none of the answer is correct	252
756	FR	aucune de réponses n’est correcte	252
757	RW	itara ritukura cyangwa akagarurarumuri ku mutuku ku manywa	253
758	EN	red light and red reflector by day	253
759	FR	feu rouge ou catadioptre rouge le jour	253
760	RW	agatambaro gatukura gafite nibura cm 50 z’uruhande mu ijoro	254
761	EN	red cloth of 50cm at night	254
762	FR	morceau d’étoffe rouge de 50cm la nuit	254
763	RW	itara ry’umuhondo cyangwa akagarurarumuri k’umuhondo	255
764	EN	yellow light and reflector	255
765	FR	feu jaune ou catadioptre jaune	255
766	RW	nta gisubizo cy’ukuri kirimo	256
767	EN	none of the answers is correct	256
768	FR	aucune de réponses n’est correcte	256
769	RW	m 2.50	257
770	EN	2.50m	257
771	FR	2.50m	257
772	RW	m 2.75	258
773	EN	2.75m	258
774	FR	2.75m	258
775	RW	m 3	259
776	EN	3m	259
777	FR	3m	259
778	RW	nta gisubizo cy’ukuri kirimo	260
779	EN	none of the answers is correct	260
780	FR	aucune de réponses n’est correctes	260
781	RW	toni 20	261
782	EN	20 tones	261
783	FR	20 tonnes	261
784	RW	toni 16	262
785	EN	16 tones	262
786	FR	16 tonnes	262
787	RW	toni 12	263
788	EN	12 tones	263
789	FR	12 tonnes	263
790	RW	toni 10	264
791	EN	10 tones	264
792	FR	10 tonnes	264
793	RW	umuhondo	265
794	EN	yellow	265
795	FR	jaune	265
796	RW	icyatsi kibisi	266
797	EN	green	266
798	FR	verte	266
799	RW	umweru	267
800	EN	white	267
801	FR	blanche	267
802	RW	umutuku	268
803	EN	red	268
804	FR	rouge	268
805	RW	m11	269
806	EN	11 m	269
807	FR	11 m	269
808	RW	m10	270
809	EN	10 m	270
810	FR	10 m	270
811	RW	m7	271
812	EN	7 m	271
813	FR	7 m	271
814	RW	nta gisubizo cy’ukuri kirimo	272
815	EN	none of the answers is correct	272
816	FR	aucune de réponses n’est correctes	272
817	RW	feri yo guhagarara umwanya munini	273
818	EN	parking brake	273
819	FR	frein de sta onnement	273
820	RW	feri y’urugendo	274
821	EN	service brake	274
822	FR	frein de service	274
823	RW	feri yo gutabara	275
824	EN	emergency braking	275
825	FR	frein de secour	275
826	RW	nta gisubizo cy’ukuri kirimo	276
827	EN	none of the answers is correct	276
828	FR	aucune de réponses n’est correctes	276
829	RW	umweru	277
830	EN	white	277
831	FR	blanche	277
832	RW	umuhondo	278
833	EN	yellow	278
834	FR	jaune	278
835	RW	umutuku	279
836	EN	red	279
837	FR	rouge	279
838	RW	nta gisubizo cy’ukuri kirimo	280
839	EN	none of the answers is correct	280
840	FR	aucune de réponses n’est correctes	280
841	RW	ipikipiki idafite akanyabiziga ku ruhande	281
842	EN	moped	281
843	FR	vélomoteur	281
844	RW	velomoteri	282
845	EN	motorbike without a side car	282
846	FR	motocycle e sans side car	282
847	RW	amava ri y’ifasi	283
848	EN	motor vehicles used as hackney carriage	283
849	FR	les voitures de place	283
850	RW	nta gisubizo cy’ukuri kirimo	284
851	EN	none of the answers is correct	284
852	FR	aucune de réponses n’est correctes	284
853	RW	m200	285
854	EN	200 m	285
855	FR	200 m	285
856	RW	m100	286
857	EN	100 m	286
858	FR	100 m	286
859	RW	m85	287
860	EN	85 m	287
861	FR	85 m	287
862	RW	nta gisubizo cy’ukuri kirimo	288
863	EN	none of the answers is correct	288
864	FR	aucune de réponses n’est correctes	288
865	RW	km 10 mu isaha	289
866	EN	10km/h	289
867	FR	10 km / h	289
868	RW	km 20 mu isaha	290
869	EN	20km/h	290
870	FR	20 km / h	290
871	RW	km 30 mu isaha	291
872	EN	30km/h	291
873	FR	30 km / h	291
874	RW	nta gisubizo cy’ukuri kirimo	292
875	EN	none of the answers is correct	292
876	FR	aucune de réponses n’est correctes	292
877	RW	ku mihanda y’icyerekezo kimwe hose	293
878	EN	on the road of one way	293
879	FR	sur toutes les chaussées à sens unique	293
880	RW	mu ruhande ruteganye n’urwo ikindi kinyabiziga gihagazemo	294
881	EN	on the side opposite to where another vehicle is already at stop or in parking	294
882	FR	du côté oppose à celui oύ un véhicule est déjà à l’arrêt ou en sta onnement	294
883	RW	ku mihanda ibisikanirwamo	295
884	EN	on the road ways where the traffic is performed in two direc on	295
885	FR	sur les chaussées oύ la circula on se fait dans les deux sens	295
886	RW	ibisubizo byose nibyo	296
887	EN	all answers are correct	296
888	FR	toutes les réponses sont justes	296
889	RW	amatara magufi	297
890	EN	head lights	297
891	FR	Les feux de croissement	297
892	RW	amatara ndangaburumbarare	298
893	EN	gauge lights	298
894	FR	les feux de gabarit	298
895	RW	amatara yo guhagarara umwanya munini	299
896	EN	parking lights	299
897	FR	les feux de stationnement	299
898	RW	nta gisubizo cy’ukuri kirimo	300
899	EN	none of the answers is correct	300
900	FR	Aucune de réponses n’est correctes	300
901	RW	imbere itara ryera n’inyuma itara ry’umuhondo	301
902	EN	front white light and rear yellow light	301
903	FR	feu blanc à l’avant et feu jaune à l’arrière	301
904	RW	inyuma itara ry’umuhondo gusa	302
905	EN	rear yellow light only	302
906	FR	feu jaune à l’arrière seulement	302
907	RW	A na B ni ibisubizo by’ukuri	303
908	EN	A and B are correct	303
909	FR	A et B sont justes	303
910	RW	nta gisubizo cy’ukuri kirimo	304
911	EN	none of the answers is correct	304
912	FR	aucune de réponses n’est correcte	304
913	RW	cm 20	305
914	EN	20cm	305
915	FR	20 cm	305
916	RW	cm 30	306
917	EN	30cm	306
918	FR	30 cm	306
919	RW	cm 50	307
920	EN	50cm	307
921	FR	50 cm	307
922	RW	cm 60	308
923	EN	60cm	308
924	FR	60 cm	308
925	RW	ahagereye inguni y’ibumoso y’ikinyabiziga	309
926	EN	to the left border of the vehicle	309
927	FR	à proximité du bord gauche du véhicule	309
928	RW	ahagereye inguni y’iburyo bw’ikinyabiziga	310
929	EN	to the right border of the vehicle	310
930	FR	à proximité du bord droit du véhicule	310
931	RW	inyuma kandi y’impera y’ibumoso bw’ikinyabiziga	311
932	EN	at the back and near the left end of vehicle	311
933	FR	à l’arrière tout près de l’extrémité gauche du véhicule	311
934	RW	nta gisubizo cy’ukuri kirimo	312
935	EN	there is no correct answer	312
936	FR	aucune de réponses n’est correcte	312
937	RW	amatara kamenabihu	313
938	EN	fog lights	313
939	FR	feux de brouillard	313
940	RW	amatara yo gusubira inyuma	314
941	EN	reversing lights	314
942	FR	feux de marche arrière	314
943	RW	A na B ni ibisubizo by’ukuri	315
944	EN	A and B are both correct	315
945	FR	A et B sont justes	315
946	RW	nta gisubizo cy’ukuri kirimo	316
947	EN	none of the answers is correct	316
948	FR	aucune de réponses n’est correcte	316
949	RW	metero 100	317
950	EN	100m	317
951	FR	100 m	317
952	RW	metero 150	318
953	EN	150m	318
954	FR	150 m	318
955	RW	metero 200	319
956	EN	200m	319
957	FR	200 m	319
958	RW	nta gisubizo cy’ukuri kirimo	320
959	EN	none of the answers is correct	320
960	FR	aucune de réponses n’est correcte	320
961	RW	metero 200	321
962	EN	200m	321
963	FR	200 m	321
964	RW	metero 150	322
965	EN	150m	322
966	FR	150 m	322
967	RW	metero 100	323
968	EN	100m	323
969	FR	100 m	323
970	RW	metero 50	324
971	EN	50m	324
972	FR	50 m	324
973	RW	metero 150 kugeza kuri 200	325
974	EN	150 to 200m	325
975	FR	150 à 200m	325
976	RW	metero 100 kugeza kuri 150	326
977	EN	100 to 150m	326
978	FR	100 à 150m	326
979	RW	metero 50 kugeza kuri 100	327
980	EN	50 to 100m	327
981	FR	50 à 100m	327
982	RW	nta gisubizo cy’ukuri kirimo	328
983	EN	none of the answers is correct	328
984	FR	aucune de réponses n’est correcte	328
985	RW	iburyo ibara ritukura cyangwa icunga rihishije	329
986	EN	right side red or orange reflectors	329
987	FR	à droite rouge ou orange	329
988	RW	ibumoso ibara ryera	330
989	EN	left white reflectors	330
990	FR	à gauche blanc	330
991	RW	A na B ni ibisubizo by’ukuri	331
992	EN	A and B are correct	331
993	FR	A et B sont justes	331
994	RW	nta gisubizo cy’ukuri kirimo	332
995	EN	none of the answers is correct	332
996	FR	aucune de réponses n’est correcte	332
997	RW	igihe traffic ari nyinshi	333
998	EN	when traffic is heavy	333
999	FR	circulation intense	333
1000	RW	aho kunyuranaho bibujijwe	334
1001	EN	where overtaking is forbidden	334
1002	FR	dépassement interdit	334
1003	RW	A na B ni ibisubizo by’ukuri	335
1004	EN	A and B are correct	335
1005	FR	A et B sont justes	335
1006	RW	nta gisubizo cy’ukuri kirimo	336
1007	EN	none of the answers is correct	336
1008	FR	aucune de réponses n’est correcte	336
1009	RW	amatara y’imbere aba yera cyangwa ari umuhondo	337
1010	EN	the front lights are white or yellows	337
1011	FR	les feux avant sont blancs ou jaunes	337
1012	RW	ayinyuma aba atukura cyangwa asa n’icunga rihishije	338
1013	EN	the back lights are red or orange	338
1014	FR	les feux arrière sont rouges ou orange	338
1015	RW	A na B ni ibisubizo by’ukuri	339
1016	EN	A and B are both correct	339
1017	FR	A et B sont justes	339
1018	RW	ayinyuma aba asa n’icunga rihishije	340
1019	EN	the back lights are orange	340
1020	FR	les feux arrière sont orange	340
1021	RW	ibinyabiziga ndakumirwa	341
1022	EN	priority vehicles	341
1023	FR	les véhicules prioritaires	341
1024	RW	ibinyabiziga bikora ku mihanda	342
1025	EN	vehicles assigned to road maintenance	342
1026	FR	les véhicules affectés à l’entretien du réseau routier	342
1027	RW	ibinyabiziga bifite ubugari burenze m 2.10	343
1028	EN	vehicles with width exceeding 2.10m	343
1029	FR	les véhicules dont la largeur est supérieure à 2.10m	343
1030	RW	A na B ni ibisubizo by’ukuri	344
1031	EN	A and B are both correct	344
1032	FR	A et B sont justes	344
1033	RW	umweru n’umukara	345
1034	EN	white and black	345
1035	FR	blancs et noire	345
1036	RW	umutuku n’umukara	346
1037	EN	red and black	346
1038	FR	rouge et noir	346
1039	RW	ubururu	347
1040	EN	blue	347
1041	FR	bleue	347
1042	RW	A na B ni ibisubizo by’ukuri	348
1043	EN	A and B are both correct	348
1044	FR	A et B sont justes	348
1045	RW	umukara	349
1046	EN	black	349
1047	FR	noire	349
1048	RW	umweru	350
1049	EN	white	350
1050	FR	blanche	350
1051	RW	ubururu	351
1052	EN	blue	351
1053	FR	bleu	351
1054	RW	umutuku	352
1055	EN	red	352
1056	FR	rouge	352
1057	RW	amapikipiki	353
1058	EN	motorcycle	353
1059	FR	motocycles	353
1060	RW	velomoteri	354
1061	EN	moped	354
1062	FR	cyclomoteurs	354
1063	RW	ibinyabiziga bigendeshwa na moteri bidapakiye	355
1064	EN	motor vehicles unloaded	355
1065	FR	véhicules automoteurs à vide	355
1066	RW	nta gisubizo cy’ukuri kirimo	356
1067	EN	none of the answers is correct	356
1068	FR	aucune de réponses n’est correcte	356
1069	RW	itara rimwe cyangwa menshi yera	357
1070	EN	one or many white lights	357
1071	FR	un ou plusieurs feux blancs	357
1072	RW	amatara menshi y’umuhondo	358
1073	EN	many yellow lights	358
1074	FR	plusieurs feux jaunes	358
1075	RW	amatara menshi asa n’icunga rihishije	359
1076	EN	many orange lights	359
1077	FR	plusieurs feux oranges	359
1078	RW	ibisubizo byose nibyo	360
1079	EN	all answers are correct	360
1080	FR	toutes les réponses sont correctes	360
1081	RW	umweru cyangwa umuhondo imbere	361
1082	EN	white or yellow front	361
1083	FR	blanc ou jaune à l’avant	361
1084	RW	umutuku cyangwa umuhondo inyuma	362
1085	EN	red or yellow rear	362
1086	FR	rouge ou jaune à l’arrière	362
1087	RW	A na B ni ibisubizo by’ukuri	363
1088	EN	A and B are both correct	363
1089	FR	A et B sont justes	363
1090	RW	nta gisubizo cy’ukuri kirimo	364
1091	EN	none of the answers is correct	364
1092	FR	aucune de réponses n’est correcte	364
1093	RW	m 50 nibura	365
1094	EN	50m	365
1095	FR	50 m	365
1096	RW	m 100	366
1097	EN	100m	366
1098	FR	100 m	366
1099	RW	m 150	367
1100	EN	150m	367
1101	FR	150 m	367
1102	RW	m 200 nibura	368
1103	EN	200m	368
1104	FR	200 m	368
1105	RW	guhagararwamo umwanya muto gusa	369
1106	EN	stopping only	369
1107	FR	l’arrêt seulement	369
1108	RW	guhagararwamo umwanya munini gusa	370
1109	EN	parking only	370
1110	FR	le stationnement seulement	370
1111	RW	guhagararwamo umwanya muto n’umunini	371
1112	EN	stopping and parking	371
1113	FR	l’arrêt et le stationnement	371
1114	RW	nta gisubizo cy’ukuri kirimo	372
1115	EN	none of the answers is correct	372
1116	FR	aucune de réponses n’est correcte	372
1117	RW	imirongo yera irombereje idacagaguye gusa	373
1118	EN	continuous white lines only	373
1119	FR	les lignes blanches longitudinales continues seulement	373
1120	RW	imirongo yera irombereje idacagaguye n’icagaguye	374
1121	EN	continuous and broken longitudinal white lines	374
1122	FR	les lignes blanches longitudinales continues et discontinues	374
1123	RW	imirongo icagaguye n’idacagaguye ibangikanye	375
1124	EN	parallel continuous and broken lines	375
1125	FR	les lignes parallèles continues et discontinues	375
1126	RW	nta gisubizo cy’ukuri kirimo	376
1127	EN	none of the answers is correct	376
1128	FR	aucune de réponses n’est correcte	376
1129	RW	imbere ni itara ryera	377
1130	EN	in front, by a white light	377
1131	FR	à l’avant par le feu blanc	377
1132	RW	imbere ni itara ry’umuhondo cyangwa risa n’icunga rihishije	378
1133	EN	in front, by a yellow or orange light	378
1134	FR	à l’avant par le feu jaune ou orange	378
1135	RW	inyuma ni itara ritukura	379
1136	EN	at the back, by red light	379
1137	FR	à l’arrière par le feu rouge	379
1138	RW	ibisubizo byose ni ukuri	380
1139	EN	all answers are correct	380
1140	FR	toutes les réponses sont correctes	380
1141	RW	m 1	381
1142	EN	one meter wide band	381
1143	FR	1m	381
1144	RW	m 2	382
1145	EN	two meters wide band	382
1146	FR	2m	382
1147	RW	m 0.5	383
1148	EN	0.50 meter wide band	383
1149	FR	0.50m	383
1150	RW	nta gisubizo cy’ukuri kirimo	384
1151	EN	none of the answers is correct	384
1152	FR	aucune de réponses n’est correcte	384
1153	RW	ubururu	385
1154	EN	blue	385
1155	FR	bleu	385
1156	RW	umweru	386
1157	EN	white	386
1158	FR	blanche	386
1159	RW	umutuku	387
1160	EN	red	387
1161	FR	rouge	387
1162	RW	nta gisubizo cy’ukuri kirimo	388
1163	EN	none of the answers is correct	388
1164	FR	aucune de réponses n’est correcte	388
1165	RW	umukara n’umutuku	389
1166	EN	black and red	389
1167	FR	noire et rouge	389
1168	RW	umukara n’umweru	390
1169	EN	black and white	390
1170	FR	noire et blanche	390
1171	RW	umweru n’umutuku	391
1172	EN	white and blue	391
1173	FR	blanche et bleue	391
1174	RW	nta gisubizo cy’ukuri kirimo	392
1175	EN	none of the answers is correct	392
1176	FR	aucune de réponses n’est correcte	392
1177	RW	umuyobozi	393
1178	EN	the driver	393
1179	FR	conducteur	393
1180	RW	umugenzi wicaye ku ntebe y’imbere	394
1181	EN	the passenger occupying the front seat	394
1182	FR	passager occupant le siège avant du véhicule	394
1183	RW	ishobora no kugira imikandara kuzindi ntebe z’inyuma	395
1184	EN	it can also have belts on rear seats	395
1185	FR	il peut également avoir des ceintures sur les autres sièges arrière	395
1186	RW	ibisubizo byose ni ukuri	396
1187	EN	all answers are correct	396
1188	FR	toutes les réponses sont justes	396
1189	RW	police y’igihugu	397
1190	EN	National Police	397
1191	FR	police nationale	397
1192	RW	minisitiri ushinzwe gutwara abantu n’ibintu	398
1193	EN	the minister entrusted with transport or his delegate	398
1194	FR	le ministre ayant les transports à ses attributions ou son délégué	398
1195	RW	minisitiri w’ingabo	399
1196	EN	minister of defense	399
1197	FR	ministre de défense	399
1198	RW	ikigo cy’igihugu gishinzwe imisoro n’amahoro	400
1199	EN	tax department	400
1200	FR	service des impôts	400
1201	RW	imbere itara ryera cyangwa icunga rihishije	401
1202	EN	front white or orange light	401
1203	FR	feu blanc ou orange à l’avant	401
1204	RW	inyuma itara ritukura cyangwa umuhondo	402
1205	EN	rear red or yellow light	402
1206	FR	feu rouge ou jaune à l’arrière	402
1207	RW	A na B ni ibisubizo by’ukuri	403
1208	EN	A and B are both correct	403
1209	FR	A et B sont justes	403
1210	RW	nta gisubizo cy’ukuri kirimo	404
1211	EN	none of the answers is correct	404
1212	FR	aucune de réponses n’est correcte	404
1213	RW	ibinyabiziga bya police biherekeranyije	405
1214	EN	vehicle of Rwanda national police	405
1215	FR	les véhicules de la police nationale	405
1216	RW	ibinyabiziga by’abasirikare mu nsisiro	406
1217	EN	military vehicles forming a convoy in built-up areas	406
1218	FR	les véhicules militaires formant un convoi dans les agglomérations	406
1219	RW	A na B ni ibisubizo by’ukuri	407
1220	EN	A and B are both correct	407
1221	FR	A et B sont justes	407
1222	RW	nta gisubizo cy’ukuri kirimo	408
1223	EN	none of the answers is correct	408
1224	FR	aucune de réponses n’est correcte	408
1225	RW	umuherekeza w’ikinyabiziga cya kabiri	409
1226	EN	the second vehicle must be accompanied by a conveyor	409
1227	FR	un convoyeur doit accompagner le second véhicule	409
1228	RW	abaherekeza babiri	410
1229	EN	two conveyors	410
1230	FR	deux convoyeurs	410
1231	RW	A na B ni ibisubizo by’ukuri	411
1232	EN	A and B are both correct	411
1233	FR	A et B sont justes	411
1234	RW	nta gisubizo cy’ukuri kirimo	412
1235	EN	none of the answers is correct	412
1236	FR	aucune de réponses n’est correcte	412
1237	RW	ibinyabiziga bigendwamo n’abana	413
1238	EN	baby cars	413
1239	FR	voiture d’enfants	413
1240	RW	ibinyabiziga bigendwamo n’abamugaye	414
1241	EN	wheel chairs	414
1242	FR	voiture d’infirmes	414
1243	RW	A na B ni ibisubizo by’ukuri	415
1244	EN	A and B are both correct	415
1245	FR	A et B sont justes	415
1246	RW	nta gisubizo cy’ukuri kirimo	416
1247	EN	none of the answers is correct	416
1248	FR	aucune de réponses n’est correcte	416
1249	RW	ubururu, umweru n’umutuku	417
1250	EN	blue, white and red	417
1251	FR	bleu, blanc et rouge	417
1252	RW	umukara, umweru n’umuhondo	418
1253	EN	black, white and yellow	418
1254	FR	noir, blanc et jaune	418
1255	RW	icyatsi kibisi, umuhondo n’ikirango cy’umukara	419
1256	EN	green, yellow with black symbol	419
1257	FR	vert, jaune avec symbole noir	419
1258	RW	nta gisubizo cy’ukuri kirimo	420
1259	EN	none of the answers is correct	420
1260	FR	aucune de réponses n’est correcte	420
1261	RW	umweru n’umukara	421
1262	EN	white and black	421
1263	FR	blanc et noir	421
1264	RW	umweru n’umutuku	422
1265	EN	white and red	422
1266	FR	blanc et rouge	422
1267	RW	umweru n’umuhondo	423
1268	EN	white and yellow	423
1269	FR	blanc et jaune	423
1270	RW	nta gisubizo cy’ukuri kirimo	424
1271	EN	none of the answers is correct	424
1272	FR	aucune de réponses n’est correcte	424
1273	RW	icyapa cyera cya mpande enye 0.30m	425
1274	EN	white square panel of 0.30m	425
1275	FR	panneau blanc carré de 0.30m	425
1276	RW	uruzitiro ku mpera y’iburyo	426
1277	EN	barrier placed on the right side	426
1278	FR	barrière placée à droite	426
1279	RW	A na B ni ibisubizo by’ukuri	427
1280	EN	A and B are both correct	427
1281	FR	A et B sont justes	427
1282	RW	nta gisubizo cy’ukuri kirimo	428
1283	EN	none of the answers is correct	428
1284	FR	aucune de réponses n’est correcte	428
1285	RW	ubururu n’umweru	429
1286	EN	blue and white	429
1287	FR	bleu et blanc	429
1288	RW	umuzenguruko w’umutuku, umweru n’umukara	430
1289	EN	red, white surface with black symbol	430
1290	FR	rouge, blanc avec symbole noir	430
1291	RW	umutuku, umweru n’umukara	431
1292	EN	red, white and black	431
1293	FR	rouge, blanc et noir	431
1294	RW	nta gisubizo cy’ukuri kirimo	432
1295	EN	none of the answers is correct	432
1296	FR	aucune de réponses n’est correcte	432
1297	RW	mpandeshatu, umweru n’umukara	433
1298	EN	triangle, white and black	433
1299	FR	triangle, blanc et noir	433
1300	RW	mpandenye, ubururu n’umweru	434
1301	EN	square, blue and white	434
1302	FR	carré, bleu et blanc	434
1303	RW	uruziga rw’ubururu n’umweru	435
1304	EN	circle, blue and white	435
1305	FR	cercle, bleu et blanc	435
1306	RW	nta gisubizo cy’ukuri kirimo	436
1307	EN	none of the answers is correct	436
1308	FR	aucune de réponses n’est correcte	436
1309	RW	150m	437
1310	EN	150m	437
1311	FR	150m	437
1312	RW	50m	438
1313	EN	50m	438
1314	FR	50m	438
1315	RW	20m	439
1316	EN	20m	439
1317	FR	20m	439
1318	RW	10m	440
1319	EN	10m	440
1320	FR	10m	440
1321	RW	umweru n’umukara	441
1322	EN	white and black	441
1323	FR	blanc et noir	441
1324	RW	umweru n’umuhondo	442
1325	EN	white and yellow	442
1326	FR	blanc et jaune	442
1327	RW	ubuso bw’umweru gusa	443
1328	EN	white surface only	443
1329	FR	surface blanche uniquement	443
1330	RW	nta gisubizo cy’ukuri kirimo	444
1331	EN	none of the answers is correct	444
1332	FR	aucune de réponses n’est correcte	444
1333	RW	kugenda gahoro cyane	445
1334	EN	abnormally low speed	445
1335	FR	vitesse anormalement réduite	445
1336	RW	gukorera feri gitunguranye	446
1337	EN	sudden braking	446
1338	FR	freinage brusque	446
1339	RW	A na B ni ibisubizo by’ukuri	447
1340	EN	A and B are both correct	447
1341	FR	A et B sont justes	447
1342	RW	nta gisubizo cy’ukuri kirimo	448
1343	EN	none of the answers is correct	448
1344	FR	aucune de réponses n’est correcte	448
1345	RW	itara ryera inyuma	449
1346	EN	white rear light	449
1347	FR	feu blanc arrière	449
1348	RW	itara ry’umuhondo inyuma	450
1349	EN	yellow rear light	450
1350	FR	feu jaune arrière	450
1351	RW	itara risa n’icunga inyuma	451
1352	EN	orange rear light	451
1353	FR	feu orange arrière	451
1354	RW	ibisubizo byose ni ukuri	452
1355	EN	all answers are correct	452
1356	FR	toutes les réponses sont justes	452
1357	RW	umuhanda umurikiwe neza	453
1358	EN	well-lit road	453
1359	FR	chaussée bien éclairée	453
1360	RW	ikinyabiziga kiri imbere m100	454
1361	EN	vehicle within 100m ahead	454
1362	FR	véhicule à moins de 100m	454
1363	RW	A na B ni ibisubizo by’ukuri	455
1364	EN	A and B are both correct	455
1365	FR	A et B sont justes	455
1366	RW	nta gisubizo cy’ukuri kirimo	456
1367	EN	none of the answers is correct	456
1368	FR	aucune de réponses n’est correcte	456
1369	RW	gushaka umuherekeza	457
1370	EN	look for a conveyor	457
1371	FR	chercher un convoyeur	457
1372	RW	gukurura ikinyabiziga cye	458
1373	EN	pull his vehicle	458
1374	FR	tirer son véhicule	458
1375	RW	A na B ni ibisubizo by’ukuri	459
1376	EN	A and B are both correct	459
1377	FR	A et B sont justes	459
1378	RW	nta gisubizo cy’ukuri kirimo	460
1379	EN	none of the answers is correct	460
1380	FR	aucune de réponses n’est correcte	460
1381	RW	mu kaboko k’iburyo	461
1382	EN	on the right side	461
1383	FR	à droite	461
1384	RW	ahegereye akayira k’abanyamaguru	462
1385	EN	close to the pavement	462
1386	FR	près du trottoir	462
1387	RW	A na B ni ibisubizo by’ukuri	463
1388	EN	A and B are both correct	463
1389	FR	A et B sont justes	463
1390	RW	nta gisubizo cy’ukuri kirimo	464
1391	EN	none of the answers is correct	464
1392	FR	aucune de réponses n’est correcte	464
1393	RW	velomoteri	465
1394	EN	bicycles	465
1395	FR	cyclomoteur	465
1396	RW	ipikipiki idafite akanyabiziga	466
1397	EN	motorcycle without side car	466
1398	FR	motocyclette sans side-car	466
1399	RW	A na B ni ibisubizo by’ukuri	467
1400	EN	A and B are both correct	467
1401	FR	A et B sont justes	467
1402	RW	nta gisubizo cy’ukuri kirimo	468
1403	EN	none of the answers is correct	468
1404	FR	aucune de réponses n’est correcte	468
1405	RW	abahagarara igihe bambuka	469
1406	EN	pedestrians who stop while crossing	469
1407	FR	piétons qui s’arrêtent en traversant	469
1408	RW	udutsiko tw’abantu benshi	470
1409	EN	large groups of pedestrians	470
1410	FR	grands groupes de piétons	470
1411	RW	A na B ni ibisubizo by’ukuri	471
1412	EN	A and B are both correct	471
1413	FR	A et B sont justes	471
1414	RW	nta gisubizo cy’ukuri kirimo	472
1415	EN	none of the answers is correct	472
1416	FR	aucune de réponses n’est correcte	472
1417	RW	utarengeje m50	473
1418	EN	maximum 50m	473
1419	FR	50m maximum	473
1420	RW	utarengeje m100	474
1421	EN	maximum 100m	474
1422	FR	100m maximum	474
1423	RW	utarengeje m150	475
1424	EN	maximum 150m	475
1425	FR	150m maximum	475
1426	RW	nta gisubizo cy’ukuri kirimo	476
1427	EN	none of the answers is correct	476
1428	FR	aucune de réponses n’est correcte	476
1429	RW	m200	477
1430	EN	200m	477
1431	FR	200m	477
1432	RW	m250	478
1433	EN	250m	478
1434	FR	250m	478
1435	RW	m300	479
1436	EN	300m	479
1437	FR	300m	479
1438	RW	nta gisubizo cy’ukuri kirimo	480
1439	EN	none of the answers is correct	480
1440	FR	aucune de réponses n’est correcte	480
1441	RW	irangi ry’umuhondo ngarurarumuri	481
1442	EN	reflective yellow	481
1443	FR	jaune réfléchissant	481
1444	RW	irangi ry’umweru ngarurarumuri	482
1445	EN	reflective white	482
1446	FR	blanc réfléchissant	482
1447	RW	irangi risa n’icunga rihishije	483
1448	EN	reflective orange	483
1449	FR	orange réfléchissant	483
1450	RW	nta gisubizo cy’ukuri kirimo	484
1451	EN	none of the answers is correct	484
1452	FR	aucune de réponses n’est correcte	484
1453	RW	udushundu ku nziga	485
1454	EN	wheel protrusions	485
1455	FR	saillies	485
1456	RW	iminyururu irwanya ubunyerere	486
1457	EN	anti-skid chains	486
1458	FR	chaînes antidérapantes	486
1459	RW	A na B ni ibisubizo by’ukuri	487
1460	EN	A and B are both correct	487
1461	FR	A et B sont justes	487
1462	RW	nta gisubizo cy’ukuri kirimo	488
1463	EN	none of the answers is correct	488
1464	FR	aucune de réponses n’est correcte	488
1465	RW	m4	489
1466	EN	4m	489
1467	FR	4m	489
1468	RW	m3.50	490
1469	EN	3.50m	490
1470	FR	3.50m	490
1471	RW	m3	491
1472	EN	3m	491
1473	FR	3m	491
1474	RW	nta gisubizo cy’ukuri kirimo	492
1475	EN	none of the answers is correct	492
1476	FR	aucune de réponses n’est correcte	492
1477	RW	toni 10	493
1478	EN	10 tonnes	493
1479	FR	10 tonnes	493
1480	RW	toni 16	494
1481	EN	16 tonnes	494
1482	FR	16 tonnes	494
1483	RW	toni 24	495
1484	EN	24 tonnes	495
1485	FR	24 tonnes	495
1486	RW	nta gisubizo cy’ukuri kirimo	496
1487	EN	none of the answers is correct	496
1488	FR	aucune de réponses n’est correcte	496
1489	RW	kare ifite ubuso bw’ibara ryera	497
1490	EN	square with white surface	497
1491	FR	carré blanc	497
1492	RW	urukiramende rufite ubuso bw’ibara ryera	498
1493	EN	rectangle with white surface	498
1494	FR	rectangle blanc	498
1495	RW	mpandeshatu ifite umuzenguruko utukura	499
1496	EN	triangle with red perimeter	499
1497	FR	triangle à contour rouge	499
1498	RW	nta gisubizo cy’ukuri kirimo	500
1499	EN	none of the answers is correct	500
1500	FR	aucune réponse correcte	500
1501	RW	m100	501
1502	EN	100m	501
1503	FR	100m	501
1504	RW	m50	502
1505	EN	50m	502
1506	FR	50m	502
1507	RW	m40	503
1508	EN	40m	503
1509	FR	40m	503
1510	RW	nta gisubizo cy’ukuri kirimo	504
1511	EN	none of the answers is correct	504
1512	FR	aucune réponse correcte	504
1513	RW	mu minsi cumi n’itanu	505
1514	EN	15 days	505
1515	FR	15 jours	505
1516	RW	mu kwezi kumwe	506
1517	EN	one month	506
1518	FR	un mois	506
1519	RW	mu mezi abiri	507
1520	EN	two months	507
1521	FR	deux mois	507
1522	RW	nta gisubizo cy’ukuri kirimo	508
1523	EN	none of the answers is correct	508
1524	FR	aucune réponse correcte	508
1525	RW	ntacyo bihindura ku mategeko y’imbere	509
1526	EN	it does not modify priority rules	509
1527	FR	ne modifie pas les règles de priorité	509
1528	RW	bitanga uburenganzira bwo gutambuka mbere	510
1529	EN	it gives priority	510
1530	FR	donne la priorité	510
1531	RW	ibinyabiziga binini nibyo bitambuka mbere	511
1532	EN	large vehicles have priority	511
1533	FR	les grands véhicules ont la priorité	511
1534	RW	nta gisubizo cy’ukuri kirimo	512
1535	EN	none of the answers is correct	512
1536	FR	aucune réponse correcte	512
1537	RW	velomoteri	513
1538	EN	moped	513
1539	FR	cyclomoteur	513
1540	RW	ipikipiki ifite akanyabiziga	514
1541	EN	motorbike with side car	514
1542	FR	moto avec side-car	514
1543	RW	igare	515
1544	EN	bicycle	515
1545	FR	bicyclette	515
1546	RW	nta gisubizo cy’ukuri kirimo	516
1547	EN	none of the answers is correct	516
1548	FR	aucune réponse correcte	516
1549	RW	m100	517
1550	EN	100m	517
1551	FR	100m	517
1552	RW	m75	518
1553	EN	75m	518
1554	FR	75m	518
1555	RW	m25	519
1556	EN	25m	519
1557	FR	25m	519
1558	RW	nta gisubizo cy’ukuri kirimo	520
1559	EN	none of the answers is correct	520
1560	FR	aucune réponse correcte	520
1561	RW	amatara abiri atukura	521
1562	EN	two red lights	521
1563	FR	deux feux rouges	521
1564	RW	amatara y’umuhondo cyangwa icunga rihishije ku mpande	522
1565	EN	yellow or orange lights at sides	522
1566	FR	feux jaunes ou orange latéraux	522
1567	RW	A na B ni ibisubizo by’ukuri	523
1568	EN	A and B are both correct	523
1569	FR	A et B sont justes	523
1570	RW	nta gisubizo cy’ukuri kirimo	524
1571	EN	none of the answers is correct	524
1572	FR	aucune réponse correcte	524
1573	RW	guhagarara gusa	525
1574	EN	stopping only	525
1575	FR	arrêt seulement	525
1814	EN	Weight exceeds 1tones	605
1576	RW	guhagarara no guhagarika imodoka igihe kirekire	526
1577	EN	stopping and parking	526
1578	FR	arrêt et stationnement	526
1579	RW	ku modoka nini gusa	527
1580	EN	for heavy vehicles only	527
1581	FR	pour camions seulement	527
1582	RW	nta gisubizo cy’ukuri kirimo	528
1583	EN	none of the answers is correct	528
1584	FR	aucune réponse correcte	528
1585	RW	imashini zihinga	529
1586	EN	farming equipment	529
1587	FR	machines agricoles	529
1588	RW	ibinyabiziga bitwara ibintu byaka umuriro	530
1589	EN	vehicles carrying flammable goods	530
1590	FR	véhicules inflammables	530
1591	RW	A na B ni ibisubizo by’ukuri	531
1592	EN	A and B are both correct	531
1593	FR	A et B sont justes	531
1594	RW	nta gisubizo cy’ukuri kirimo	532
1595	EN	none of the answers is correct	532
1596	FR	aucune réponse correcte	532
1597	RW	inyuma: m3	533
1598	EN	rear: 3m	533
1599	FR	arrière: 3m	533
1600	RW	imbere: m2.70	534
1601	EN	front: 2.70m	534
1602	FR	avant: 2.70m	534
1603	RW	A na B ni ibisubizo by’ukuri	535
1604	EN	A and B are correct	535
1605	FR	A et B sont justes	535
1606	RW	nta gisubizo cy’ukuri kirimo	536
1607	EN	none of the answers is correct	536
1608	FR	aucune réponse correcte	536
1609	RW	ibinyabiziga bya police	537
1610	EN	police vehicles	537
1611	FR	véhicules de police	537
1612	RW	ibinyabiziga bihinga	538
1613	EN	agricultural vehicles	538
1614	FR	véhicules agricoles	538
1615	RW	imashini zubaka imihanda	539
1616	EN	road construction machines	539
1617	FR	engins de construction routière	539
1618	RW	ibisubizo byose ni ukuri	540
1619	EN	all answers are correct	540
1620	FR	toutes les réponses sont justes	540
1621	RW	m50	541
1622	EN	50m	541
1623	FR	50m	541
1624	RW	m35	542
1625	EN	35m	542
1626	FR	35m	542
1627	RW	m25	543
1628	EN	25m	543
1629	FR	25m	543
1630	RW	nta gisubizo cy’ukuri	544
1631	EN	none of the answers is correct	544
1632	FR	aucune réponse correcte	544
1633	RW	amatara abiri imbere n’inyuma	545
1634	EN	two front and rear lights	545
1635	FR	deux feux avant et arrière	545
1636	RW	utugarurarumuri tubiri	546
1637	EN	two reflectors	546
1638	FR	deux catadioptres	546
1639	RW	A na B ni ibisubizo by’ukuri	547
1640	EN	A and B are correct	547
1641	FR	A et B sont justes	547
1642	RW	nta gisubizo cy’ukuri kirimo	548
1643	EN	none of the answers is correct	548
1644	FR	aucune réponse correcte	548
1645	RW	mu masangano gusa	549
1646	EN	at junction only	549
1647	FR	aux carrefours seulement	549
1648	RW	hagati y’aho bishyizwe n’inkomane ikurikira	550
1649	EN	between placement and next junction	550
1650	FR	entre l’emplacement et la prochaine intersection	550
1651	RW	hakurikijwe intera	551
1652	EN	according to distance	551
1653	FR	selon la distance	551
1654	RW	B na C ni ibisubizo by’ukuri	552
1655	EN	B and C are correct	552
1656	FR	B et C sont correctes	552
1657	RW	ubururu, umweru, umutuku	553
1658	EN	blue, white, red	553
1659	FR	bleu, blanc, rouge	553
1660	RW	umweru, umukara, ubururu	554
1661	EN	white, black, blue	554
1662	FR	blanc, noir, bleu	554
1663	RW	umutuku, umweru, umukara	555
1664	EN	red, white, black	555
1665	FR	rouge, blanc, noir	555
1666	RW	nta gisubizo cy’ukuri kirimo	556
1667	EN	none of the answers is correct	556
1668	FR	aucune réponse correcte	556
1669	RW	ubuso umweru, ikimenyetso ubururu	557
1670	EN	white background, blue symbol	557
1671	FR	fond blanc, symbole bleu	557
1672	RW	ubuso ubururu, ikimenyetso umweru	558
1673	EN	blue background, white symbol	558
1674	FR	fond bleu, symbole blanc	558
1675	RW	ubuso ubururu, umweru n’umukara	559
1676	EN	blue background, white and black symbol	559
1677	FR	fond bleu, symbole blanc et noir	559
1678	RW	nta gisubizo cy’ukuri kirimo	560
1679	EN	none of the answers is correct	560
1680	FR	aucune réponse correcte	560
1681	RW	guhagarara gusa birabujijwe	561
1682	EN	stopping only is prohibited	561
1683	FR	arrêt seulement interdit	561
1684	RW	guhagarara n’iparikingi birabujijwe	562
1685	EN	stopping and parking are prohibited	562
1686	FR	arrêt et stationnement interdits	562
1687	RW	biremewe	563
1688	EN	allowed	563
1689	FR	autorisé	563
1690	RW	nta gisubizo cy’ukuri kirimo	564
1691	EN	none	564
1692	FR	aucune	564
4601	EN	a)	1806
4602	FR	a)	1806
4603	RW	a)	1806
4604	EN	(b)	1807
4605	FR	(b)	1807
4606	RW	(b)	1807
4607	EN	c)	1808
4608	FR	c)	1808
1705	RW	inyuma m3.40	569
1706	EN	rear 3.40m	569
1707	FR	arrière 3.40m	569
1708	RW	imbere m2.50	570
1709	EN	front 2.50m	570
1710	FR	avant 2.50m	570
1711	RW	A na B ni ibisubizo by’ukuri	571
1712	EN	A and B are correct	571
1713	FR	A et B sont justes	571
1714	RW	nta gisubizo cy’ukuri kirimo	572
1715	EN	none of the answers is correct	572
1716	FR	aucune réponse correcte	572
1717	RW	toni 10	573
1718	EN	10 tones	573
1719	FR	10 tonnes	573
1720	RW	toni 16	574
1721	EN	16 tones	574
1722	FR	16 tonnes	574
1723	RW	toni 24	575
1724	EN	24 tones	575
1725	FR	24 tonnes	575
1726	RW	toni 53	576
1727	EN	53 tones	576
1728	FR	53 tonnes	576
1729	RW	agatambaro gatukura gafite nibura cm 50 z’uruhande	577
1730	EN	a red piece of cloth measuring at least 0.5m by side	577
1731	FR	un morceau d’étoffe de couleur rouge d’au moins 0.50m de côté	577
1732	RW	itara risa n’icunga rihishije rigaragara mu mbavu igihe ikibizirikanyije kimuritswe	578
1733	EN	an orange colored light laterally visible, unless fastening is enlightened	578
1734	FR	un feu de couleur orange visible latéralement à moins que l’a ache ne soit éclairée	578
1735	RW	A na B ni ibisubizo by’ukuri	579
1736	EN	A and B are both the correct answers	579
1737	FR	A et B sont justes	579
1738	RW	nta gisubizo cy’ukuri kirimo	580
1739	EN	none of the answers is correct	580
1740	FR	aucune de réponses n’est correcte	580
1741	RW	nijoro igihe ijuru rikeye nibura muri m 200	581
1742	EN	at night, by fine weather, at a minimum distance of 200m	581
1743	FR	la nuit, par atmosphère limpide, à une distance minimum de 200m	581
1744	RW	ku manywa igihe cy’umucyo nibura muri m50	582
1745	EN	by daylight , by sunny weather, at a minimum distance of 50m	582
1746	FR	le jour, par temps ensoleillé, à une distance minimum de 50m	582
1747	RW	nijoro nibura muri m 100 igihe ijuru rikeye	583
1748	EN	at night, at a minimum distance of 200m , by fine weather	583
1749	FR	la nuit, à une distance minimum de 100m, par atmosphère limpide	583
1750	RW	nta gisubizo cy’ukuri kirimo	584
1751	EN	none of the answers is correct	584
1752	FR	aucune de réponses n’est correcte	584
1753	RW	imitako	585
1754	EN	unnecessary ornaments	585
1755	FR	des ornements	585
1756	RW	ibintu bifite imigongo cyangwa ibirenga ku mubyimba kandi bishobora gutera ibyago abandi bagenzi	586
1757	EN	accessories as presen ng heaps or protrusions which can cons tute a danger for other users of the public way	586
1758	FR	des accessories présentant des arêtes ou des saillies non indispensables et suscep ble de cons tuer un danger pour les autres usagers de la voie publique	586
1759	RW	A na B ni ibisubizo by’ukuri	587
1760	EN	A and B are both the correct answers	587
1761	FR	A et B sont justes	587
1762	RW	nta gisubizo cy’ukuri kirimo	588
1763	EN	none of the answers is correct	588
1764	FR	aucune de réponses n’est correcte	588
1765	RW	mu minsi 5	589
1766	EN	5 days	589
1767	FR	5 jours	589
1768	RW	mu minsi 8	590
1769	EN	8 days	590
1770	FR	8 jours	590
1771	RW	mu minsi 15	591
1772	EN	15 days	591
1773	FR	15 jours	591
1774	RW	nta gisubizo cy’ukuri kirimo	592
1775	EN	none of the answers is correct	592
1776	FR	aucune de réponses n’est correcte	592
1777	RW	mu ruhande rw’iburyo gusa	593
1778	EN	the right side only	593
1779	FR	sur la côte droite seulement	593
1780	RW	igihe cyose ni ibumoso	594
1781	EN	every me on the le side	594
1782	FR	toutes fois à gauche	594
1783	RW	iburyo iyo unyura ku nyamaswa	595
1784	EN	the right side only to overtake an animal	595
1785	FR	A droite si on depasse un animal	595
1786	RW	nta gisubizo cy’ukuri kirimo	596
1787	EN	none of the answers is correct	596
1788	FR	Aucune de réponses n’est correcte	596
1789	RW	kunyura mu nzira z’impande z’abanyamaguru	597
1790	EN	to move to the verges	597
1791	FR	emprunter les accotements de plain pied	597
1792	RW	guhagarara aho bageze	598
1793	EN	to stop	598
1794	FR	stoper	598
1795	RW	koroherana	599
1796	EN	facilitate each other’s passage	599
1797	FR	se faciliter mutuellement le passage	599
1798	RW	gukuraho inkomyi	600
1799	EN	to remove danger	600
1800	FR	eviter le danger	600
1801	RW	umuvuduko w’abanyamaguru	601
1802	EN	the speed of the pedestrians	601
1803	FR	la vitesse de piétons	601
1804	RW	ubugari bw’umuhanda	602
1805	EN	the width of the road	602
1806	FR	la largeur de la route	602
1807	RW	umubare w’abanyamaguru	603
1808	EN	the numbers of pedestrians	603
1809	FR	le nombre de piétons	603
1810	RW	nta gisubizo cy’ukuri kirimo	604
1811	EN	no correct answer	604
1812	FR	Aucune de réponses n’est correcte reponse n’est juste	604
1813	RW	burenga toni 1	605
1815	FR	1 Tone	605
1816	RW	burenga toni 2	606
1817	EN	Weight exceeds 2tones	606
1818	FR	2Tones	606
1819	RW	burenga toni 24	607
1820	EN	Weight exceeds 24 tones	607
1821	FR	24Tones	607
1822	RW	nta gisubizo cy’ukuri kirimo	608
1823	EN	No correct answer	608
1824	FR	Aucune de réponses n’est correcte	608
1825	RW	km 25	609
1826	EN	25km/h	609
1827	FR	25km/h	609
1828	RW	km 70	610
1829	EN	70km/h	610
1830	FR	70km/h	610
1831	RW	km 40	611
1832	EN	40km/h	611
1833	FR	40km/h	611
1834	RW	nta gisubizo cy’ukuri kirimo	612
1835	EN	no correct answer	612
1836	FR	Aucune de réponses n’est correcte	612
1837	RW	km 50	613
1838	EN	50km/h	613
1839	FR	50km/h	613
1840	RW	km 40	614
1841	EN	40km/h	614
1842	FR	40km/h	614
1843	RW	km 30	615
1844	EN	30km/h	615
1845	FR	30km/h	615
1846	RW	nta gisubizo cy’ukuri kirimo	616
1847	EN	none	616
1848	FR	Aucune de réponses n’est correcte	616
1849	RW	mu duhanda tw’abanyamagare	617
1850	EN	on the cycle track	617
1851	FR	sur les pistes cyclables	617
1852	RW	mu duhanda twagenewe velomoteri	618
1853	EN	the parts of the road way delineated especially for the passage of drivers	618
1854	FR	sur les par es de la chaussée délimitées spécialement pour le passage des conducteurs	618
1855	RW	A na B ni ibisubizo by’ukuri	619
1856	EN	A and B are the correct answers	619
1857	FR	A et B sont justes	619
1858	RW	ibisubizo byose ni ukuri	620
1859	EN	all answers are correct	620
1860	FR	toutes les reponses sont justes	620
1861	RW	iyo umuhanda umurikiwe umuyobozi abash kureba muri m 200	621
1862	EN	a roadway ligh ng is con nuous and sufficient to permit the driver to see dis nctly up to a distance of about 200m	621
1863	FR	lorsque l’éclairage de la chaussé est con nu et suffisant pour perme re au conducteur de voir dis ctement jusqu’à une distance d’environ 20m	621
1864	RW	iyo ikinyabiziga kigiye kubisikana nikindi	622
1865	EN	when a vehicle is going to cross another	622
1866	FR	lorsque le véhicule va en croiser un autre	622
1867	RW	iyo ari mu nsisiro	623
1868	EN	on agglomera on	623
1869	FR	dans les agglomera ons	623
1870	RW	ibisubizo byose nibyo	624
1871	EN	All answers are correct	624
1872	FR	toutes réponses sont justes	624
1873	RW	cm 25	625
1874	EN	75 cm	625
1875	FR	25 cm	625
1876	RW	cm 125	626
1877	EN	125cm	626
1878	FR	125 cm	626
1879	RW	cm 45	627
1880	EN	45cm	627
1881	FR	45 cm	627
1882	RW	nta gisubizo cy’ukuri kirimo	628
1883	EN	none of the answers is correct	628
1884	FR	aucune de réponses n’est correcte	628
1885	RW	feri y’urugendo	629
1886	EN	in service braking	629
1887	FR	frein de service	629
1888	RW	feri yo guhagarara	630
1889	EN	parking brakes	630
1890	FR	frein de sta onnement	630
1891	RW	feri yo gutabara	631
1892	EN	emergency braking	631
1893	FR	frein de secours	631
1894	RW	Nta gisubizo cy’ukuri kirimo	632
1895	EN	none of the answers is correct	632
1896	FR	aucune de réponses n’est correcte de ces réponses n’est juste	632
1897	RW	iyo bireba feri y’urugendo	633
1898	EN	when uncoupled works on the service braking	633
1899	FR	lorsque la désacouplement porte sur le frein de service	633
1900	RW	iyo kurekurana ari ibyakanya gato	634
1901	EN	when uncoupling is only temporary	634
1902	FR	si le désaccouplement est seulement momentané	634
1903	RW	iyo bireba feri yo guhagarara umwanya muni ubwo kurekurana bikaba bidashoboka bidakozwe n'umuyobozi	635
1904	EN	where for the parking, brakes uncoupling is not possible without the ac on of the driver	635
1905	FR	lorsqu’il porte sur le frein de sta onnement et que le désaccouplement n'est pas possible sans l'ac on du conducteur	635
1906	RW	byose ni ibisubizo by’ukuri	636
1907	EN	all answers are correct	636
1908	FR	toutes ces réponses sont justes	636
1909	RW	itara ndangamubyimba	637
1910	EN	size light	637
1911	FR	Feu de gabarit	637
1912	RW	itara ryerekana icyerekezo	638
1913	EN	indicator light	638
1914	FR	feu indicateur de direc on	638
1915	RW	itara ndangaburumbarare	639
1916	EN	gauge light	639
1917	FR	feu d’encombrement	639
1918	RW	ibisubizo byose ni ukuri	640
1919	EN	all responses are correct	640
1920	FR	Toutes les reponses sont justes	640
1921	RW	ku nguni y’iburyo y’ikinyabiziga	641
1922	EN	to the right border of the vehicle	641
1923	FR	A proximité du bord droit du véhicule	641
1924	RW	ku gice cy’inyuma ku kinyabiziga	642
1925	EN	at the back of vehicle	642
1926	FR	A l’arrière du véhicule	642
1927	RW	ahegereye inguni y’ibumoso y’ikinyabiziga	643
1928	EN	near the le end of the vehicle	643
1929	FR	tout près de l’extremité gauche du véhicule	643
1930	RW	ibisubizo byose ni ukuri	644
1931	EN	all answers are correct	644
1932	FR	toutes les reponses sont justes	644
1933	RW	2	645
1934	EN	2	645
1935	FR	2	645
1936	RW	3	646
1937	EN	3	646
1938	FR	3	646
1939	RW	1	647
1940	EN	1	647
1941	FR	1	647
1942	RW	nta gisubizo cy’ukuri kirimo	648
1943	EN	non correct answer	648
1944	FR	aucune de réponses n’est correcte	648
1945	RW	ibinyabiziga bidapakiye kdi bitajya birenza umuvuduko wa km 25 mu isaha ahateganye	649
1946	EN	the vehicles the speed of which unloaded, cannot exceed 25km per hour	649
1947	FR	les véhicules dont la vitesse, à vide et en palier, ne peut dépasser 25 km à l’heure	649
1948	RW	ibinyabiziga bya police bijya ahatarenga km 25 uvuye aho biba	650
1949	EN	the vehicles for RNP when they are in traffic within a maximum radius of 25km	650
1950	FR	les véhicules de la police na onale lorsqu’ils sont mis en circula on dans un rayon maximum de 25km de la ferme	650
1951	RW	A na B ni ibisubizo by’ukuri	651
1952	EN	A and B are both correct	651
1953	FR	A et B sont justes	651
1954	RW	nta gisubizo cy’ukuri kirimo	652
1955	EN	none of the answers is correct	652
1956	FR	aucune de réponses n’est correcte de ces réponses n’est juste	652
1957	RW	ku binyabiziga by’ingabo	653
1958	EN	Military vehicles	653
1959	FR	les véhicules militaires	653
1960	RW	ibinyabiziga bihinga iyo bigendeshwa mu karere katarenga km 25 uvuye aho ziba	654
1961	EN	Agricultural vehicles when they are in traffic within a maximum radius of 25km	654
1962	FR	les véhicules agricoles en circulation dans un rayon maximum de 25km	654
1963	RW	ibinyabiziga bya police	655
1964	EN	the vehicles of national police	655
1965	FR	les véhicules de la police nationale	655
1966	RW	nta gisubizo cy’ukuri kirimo	656
1967	EN	no correct answer	656
1968	FR	aucune de réponses n’est correcte	656
1969	RW	ahanyurwa n’amagare na velomoteri	657
1970	EN	bicycles and mopeds	657
1971	FR	le passage pour les bicyclettes et cyclomoteur	657
1972	RW	ahanyurwa n’ingorofani n’ibinyamitende	658
1973	EN	the barrows and cycles	658
1974	FR	le passage pour les brouettes et cycles	658
1975	RW	ahanyurwa n’abanyamaguru	659
1976	EN	Pedestrians’ crossings	659
1977	FR	le passage pour les piétons	659
1978	RW	nta gisubizo cy’ukuri kirimo	660
1979	EN	None of the answers is correct.	660
1980	FR	aucune de réponses n’est correcte	660
1981	RW	imyaka 10	661
1982	EN	10 years	661
1983	FR	10ans	661
1984	RW	imyaka 12	662
1985	EN	12 years	662
1986	FR	12ans	662
1987	RW	imyaka 7	663
1988	EN	7 years	663
1989	FR	7ans	663
1990	RW	nta gisubizocy’ukuri kirimo	664
1991	EN	no correct answer	664
1992	FR	aucune de réponses n’est correcte	664
1993	RW	ibyumweru bibiri	665
1994	EN	2weeks	665
1995	FR	un délai de 2 semaines	665
1996	RW	amezi abiri	666
1997	EN	2months	666
1998	FR	2 mois	666
1999	RW	ukwezi kumwe	667
2000	EN	1month	667
2001	FR	1 moins	667
2002	RW	nta gisubizo cy’ukuri kirimo	668
2003	EN	there is no correct answer	668
2004	FR	aucune de réponses n’est correcte de ces réponses n’est juste	668
2005	RW	babona gusa ibumoso bwabo ibyibara ryera	669
2006	EN	they see on their left the white reflectors only	669
2007	FR	ils ne voient à leur gauche que ceux de couleur blanche	669
2008	RW	iburyo babona iby’ibara ritukura cyangwa n’icunga rihishije gusa	670
2009	EN	on their right they see only the red or orange reflectors	670
2010	FR	ils ne voient à leur droite que ceux de couleur rouge ou orange	670
2011	RW	A na B ni ibisubizo by’ukuri	671
2012	EN	A and B are the correct answers	671
2013	FR	A et B sont justes	671
2014	RW	nta gisubizo cy’ukuri kirimo	672
2015	EN	none of the answers is correct	672
2016	FR	aucune de réponses n’est correcte	672
2017	RW	umukara	673
2018	EN	black	673
2019	FR	noire	673
2020	RW	umweru	674
2021	EN	white	674
2022	FR	blanche	674
2023	RW	umutuku	675
2024	EN	red	675
2025	FR	rouge	675
2026	RW	nta gisubizo cy’ukuri kirimo	676
2027	EN	none of the answers is correct	676
2028	FR	aucune de réponses n’est correcte de ces réponses n’est juste	676
2029	RW	50 m	677
2030	EN	50m	677
2031	FR	50 m	677
2032	RW	120 m	678
2033	EN	120m	678
2034	FR	120 m	678
2035	RW	150 m	679
2036	EN	150m	679
2037	FR	150 m	679
2038	RW	nta gisubizo cy’ukuri kirimo	680
2039	EN	none of them	680
2040	FR	aucune de réponses n’est correcte	680
2041	RW	agatambaro gatukura kuri cm 50 z’umuhanda	681
2042	EN	a red piece of cloth measuring a minimum 0.50m by side	681
2043	FR	par un morceau d’étoffe de couleur rouge de 0.05m minimum de côté	681
2044	RW	ikimenyetso cy’itara risa n’icunga rihishije	682
2045	EN	an orange colored light laterally visible	682
2046	FR	par un feu de couleur orange	682
2047	RW	icyapa cyera cya mpande enye zingana gifite cm 30 kuri buri ruhande	683
2048	EN	a square white panel of at least 0.30m by side	683
2049	FR	par un panneau blanc carré d’au moins 0.30m	683
2050	RW	nta gisubizo cy’ukuri kirimo	684
2051	EN	none these	684
2052	FR	aucune de réponses n’est correcte de ces reponse n’est juste	684
2053	RW	toni 12	685
2054	EN	12 tones	685
2055	FR	20 tonnes	685
2056	RW	toni 16	686
2057	EN	16 tones	686
2058	FR	16 tonnes	686
2059	RW	toni 10	687
2060	EN	10 tones	687
2061	FR	10 tonnes	687
2062	RW	nta gisubizo cy’ukuri kirimo	688
2063	EN	none of the answers is correct	688
2064	FR	aucune de réponses n’est correcte de ces réponses n’est juste	688
2065	RW	toni 10	689
2066	EN	10 tones	689
2067	FR	10 tonnes	689
2068	RW	toni 12	690
2069	EN	12 tones	690
2070	FR	12 tonnes	690
2071	RW	toni 15	691
2072	EN	15 tones	691
2073	FR	15 tonnes	691
2074	RW	nta gisubizo cy’ukuri kirimo	692
2075	EN	none of the answers is correct	692
2076	FR	aucune de réponses n’est correcte	692
2077	RW	km 70 mu isaha	693
2078	EN	70 km/h	693
2079	FR	70 km/h	693
2080	RW	km 40 mu isaha	694
2081	EN	40 km/h	694
2082	FR	40 km/h	694
2083	RW	km 25 mu isaha	695
2084	EN	25 km/h	695
2085	FR	25 km/h	695
2086	RW	km20 mu isaha	696
2087	EN	20 km/h	696
2088	FR	20 km/h	696
2089	RW	km 20 mu isaha	697
2090	EN	20 km/h	697
2091	FR	20 km/h	697
2092	RW	km 40 mu isaha	698
2093	EN	40 km/h	698
2094	FR	40 km/h	698
2095	RW	km 35 mu isaha	699
2096	EN	35 km/h	699
2097	FR	35 km/h	699
2098	RW	nta gisubizo cy’ukuri kirimo	700
2099	EN	none of the answers is correct	700
2100	FR	aucune de réponses n’est correcte	700
2101	RW	A	701
2102	EN	A	701
2103	FR	A	701
2104	RW	B	702
2105	EN	B	702
2106	FR	B	702
2107	RW	A na B ni ibisubizo by’ukuri	703
2108	EN	A and B are both correct	703
2109	FR	A et B sont justes	703
2110	RW	nta gisubizo cy’ukuri kirimo	704
2111	EN	none of the answers is correct	704
2112	FR	aucune de réponses n’est correcte	704
2113	RW	A	705
2114	EN	A	705
2115	FR	A	705
2116	RW	B	706
2117	EN	B	706
2118	FR	B	706
2119	RW	A na B ni ibisubizo by’ukuri	707
2120	EN	A and B are correct	707
2121	FR	A et B sont correctes	707
2122	RW	nta gisubizo cy’ukuri kirimo	708
2123	EN	none of the answers is correct	708
2124	FR	aucune de réponses n’est correcte	708
2125	RW	mu nsisiro cyangwa ahandi hose	709
2126	EN	inside as well as outside built-up areas	709
2127	FR	dans les agglomérations aussi bien qu’en dehors de celles-ci	709
2128	RW	ahegereye inyamaswa zikurura	710
2129	EN	approaching mounted animals only	710
2130	FR	à l’approche des animaux de trait seulement	710
2131	RW	hafi y’amatungo	711
2132	EN	approaching only livestock	711
2133	FR	à l’approche de bétail seulement	711
2134	RW	nta gisubizo cy’ukuri kirimo	712
2135	EN	none of the answers is correct	712
2136	FR	aucune de réponses n’est correcte	712
2137	RW	metero 3	713
2138	EN	3m	713
2139	FR	3m	713
2140	RW	metero 2 na cm 50	714
2141	EN	2.50m	714
2142	FR	2.50m	714
2143	RW	metero 1 na cm 10	715
2144	EN	1.10m	715
2145	FR	1.10m	715
2146	RW	nta gisubizo cy’ukuri kirimo	716
2147	EN	none of the answers is correct	716
2148	FR	aucune de réponses n’est correcte	716
2149	RW	cm 30	717
2150	EN	30cm	717
2151	FR	30cm	717
2152	RW	cm 20	718
2153	EN	20 cm	718
2154	FR	20 cm	718
2155	RW	cm 50	719
2156	EN	50cm	719
2157	FR	50cm	719
2158	RW	nta gisubizo cy’ukuri kirimo	720
2159	EN	none of the answers is correct	720
2160	FR	aucune de réponses n’est correcte	720
2161	RW	m1 na cm 50	721
2162	EN	1.50m	721
2163	FR	1.50m	721
2164	RW	m1 na cm 75	722
2165	EN	1.75m	722
2166	FR	1.75m	722
2167	RW	m1 na cm 80	723
2168	EN	1.80m	723
2169	FR	1.80m	723
2170	RW	nta gisubizo cy’ukuri kirimo	724
2171	EN	none of the answers is correct	724
2172	FR	aucune de réponses n’est correcte	724
2173	RW	hafi y’inguni y’ibumoso bw’ikinyabiziga	725
2174	EN	near the left edge of the vehicle	725
2175	FR	à proximité du bord gauche du véhicule	725
2176	RW	inyuma hafi y’impera y’ibumoso	726
2177	EN	at the back near the left edge of the vehicle	726
2178	FR	à l’arrière et à proximité gauche du véhicule	726
2179	RW	inyuma hafi y’inguni y’iburyo	727
2180	EN	at the back near the right side	727
2181	FR	à l’arrière et à proximité droite du véhicule	727
2182	RW	nta gisubizo cy’ukuri kirimo	728
2183	EN	none of the answers is correct	728
2184	FR	aucune de réponses n’est correcte	728
2185	RW	m 1.25	729
2186	EN	1.25m	729
2187	FR	1.25m	729
2188	RW	cm 30	730
2189	EN	30cm	730
2190	FR	30cm	730
2191	RW	cm 75	731
2192	EN	75cm	731
2193	FR	75cm	731
2194	RW	nta gisubizo cy’ukuri kirimo	732
2195	EN	none of the answers is correct	732
2196	FR	aucune de réponses n’est correcte	732
2197	RW	Kwitaba cyangwa guhagarara ako kanya	733
2198	EN	Respond or stop immediately	733
2199	FR	Répondre ou s’arrêter immédiatement	733
2200	RW	Kutayitaba	734
2201	EN	Ignore it	734
2202	FR	L’ignorer	734
2203	RW	Gushyira imodoka iruhande ukayitaba	735
2204	EN	Pull up at the nearest kerb and answer the phone call	735
2205	FR	Se ranger au bord de la route et répondre au téléphone	735
2206	RW	B na C ni ibisubizo by’ukuri	736
2207	EN	B and C are correct answers	736
2208	FR	B et C sont correctes	736
2209	RW	Kwitaba cyangwa guhagarara ako kanya	737
2210	EN	Respond or stop immediately	737
2211	FR	Répondre ou s’arrêter immédiatement	737
2212	RW	Kutayitaba	738
2213	EN	Ignore it	738
2214	FR	L’ignorer	738
2215	RW	Gushyira imodoka iruhande ukayitaba	739
2216	EN	Pull up at the nearest kerb and answer the phone call	739
2217	FR	Se ranger au bord de la route et répondre au téléphone	739
2218	RW	B na C ni ibisubizo by’ukuri	740
2219	EN	B and C are correct answers	740
2220	FR	B et C sont correctes	740
2221	RW	Gutanga ikimenyetso cy’ukuboko no gukoresha amatara ndangacyerekezo	741
2222	EN	Give arm signal and use indicators	741
2223	FR	Donner un signal au bras et utiliser les indicateurs	741
2224	RW	Kugenzura niba bemerewe guhindura icyerekezo	742
2225	EN	Check if U-turn is allowed	742
2226	FR	Vérifier si le demi-tour est autorisé	742
2227	RW	A na B ni ibisubizo by’ukuri	743
2228	EN	A and B are correct	743
2229	FR	A et B sont correctes	743
2230	RW	Nta gisubizo cy’ukuri kirimo	744
2231	EN	None of the answers is correct	744
2232	FR	Aucune de réponses n’est correcte	744
2233	RW	Nyuma y’ikona cyangwa ahantu hatagaragara neza	745
2234	EN	Just after a bend or in an unsafe place	745
2235	FR	Juste après un virage ou dans un endroit dangereux	745
2236	RW	Mu muhanda w’icyerekezo kimwe	746
2237	EN	In a one-way street	746
2238	FR	Dans une rue à sens unique	746
2239	RW	Ku muhanda wa km 30/h	747
2240	EN	On a 30 km/h road	747
2241	FR	Sur une route à 30 km/h	747
2242	RW	Nta gisubizo cy’ukuri kirimo	748
2243	EN	None of the answers is correct	748
2244	FR	Aucune de réponses n’est correcte	748
4609	RW	c)	1808
4610	EN	d)	1809
4611	FR	d)	1809
4612	RW	d)	1809
4613	EN	pedestrian	1810
4614	FR	Piéton	1810
4615	RW	Umunyamaguru	1810
4616	EN	driver	1811
4617	FR	Conducteur	1811
4618	RW	Umuyobozi w’ikinyabiziga	1811
4619	EN	passenger	1812
4620	FR	Passager	1812
2257	RW	Bituma ubasha gukata ikorosi vuba	753
2258	EN	You’ll be able to corner more quickly	753
2259	FR	Vous pourrez prendre les virages plus rapidement	753
2260	RW	Bifasha rumoruke guhagarara byoroshye	754
2261	EN	You’ll help the trailer stop more easily	754
2262	FR	Vous aiderez la remorque à s’arrêter plus facilement	754
2263	RW	Bifasha umuyobozi wa rumoruke kukubona mu ndorerwamo	755
2264	EN	It helps the driver see you in their mirrors	755
2265	FR	Cela aide le conducteur à vous voir dans ses rétroviseurs	755
2266	RW	Bikurinda umuyaga	756
2267	EN	You’ll keep out of the wind better	756
2268	FR	Vous serez mieux à l’abri du vent	756
2269	RW	Guhagarara hanyuma ugasohoka gahoro gahoro witonze kugeza ubonye neza	757
2270	EN	Stop and then move forward slowly and carefully until you can see clearly	757
2271	FR	S’arrêter puis avancer lentement et prudemment jusqu’à avoir une bonne visibilité	757
2272	RW	Kwihuta kugira ngo ubone aho uca	758
2273	EN	Move quickly to see and block traffic	758
2274	FR	Avancer rapidement pour bloquer la circulation	758
2275	RW	Gutegereza abanyamaguru kukwereka igihe cyiza	759
2276	EN	Wait for pedestrians to guide you	759
2277	FR	Attendre que les piétons vous guident	759
4621	RW	Umugenzi	1812
4622	EN	a and b are correct	1813
4623	FR	A et b sont correctes	1813
2278	RW	Guhindura icyerekezo ako kanya	760
2279	EN	Turn around immediately	760
2280	FR	Faire demi-tour immédiatement	760
2281	RW	Gucuranga umuziki cyane	761
2282	EN	Play loud music	761
2283	FR	Mettre de la musique forte	761
2284	RW	Kwihuta kugirango usoze vuba	762
2285	EN	Drive faster to finish sooner	762
2286	FR	Conduire plus vite pour finir plus tôt	762
2287	RW	Kuva ku muhanda munini ugahagarara ahantu hatekanye	763
2288	EN	Leave the motorway and stop in a safe place	763
2289	FR	Quitter l’autoroute et s’arrêter dans un endroit sûr	763
2290	RW	Nta gisubizo cy’ukuri kirimo	764
2291	EN	None of the answers is correct	764
2292	FR	Aucune de réponses n’est correcte	764
2293	RW	Kugirango akerekanamuvuduko kagaragare neza	765
2294	EN	To make your dials easier to see	765
2295	FR	Pour mieux voir vos cadrans	765
2296	RW	Kugirango abandi bakubone neza	766
2297	EN	So others can see you more easily	766
2298	FR	Pour que les autres puissent mieux vous voir	766
2299	RW	Kugira ngo ujyane n’abandi bayobozi	767
2300	EN	To blend with other drivers	767
2301	FR	Pour vous mêler aux autres conducteurs	767
2302	RW	Kuko amatara yo ku muhanda ari kwaka	768
2303	EN	Because street lights are on	768
2304	FR	Parce que les lampadaires sont allumés	768
2305	RW	Kuvuza ihoni igihe umunyuraho	769
2306	EN	Sound your horn while passing	769
2307	FR	Klaxonner en dépassant	769
2308	RW	Kumwegera cyane igihe umunyuraho	770
2309	EN	Stay close when passing	770
2310	FR	Rester proche en dépassant	770
2311	RW	Gusiga umwanya uhagije igihe umunyuraho	771
2312	EN	Leave sufficient space when overtaking	771
2313	FR	Laisser un espace suffisant en dépassant	771
2314	RW	Kugabanya umuvuduko mbere yo kunyura	772
2315	EN	Change down before passing	772
2316	FR	Rétrograder avant de dépasser	772
2317	RW	Kureba mu kirahure cy’uruhande	773
2318	EN	Look in the side mirror	773
2319	FR	Regarder dans le rétroviseur	773
2320	RW	Gufungura umuryango ureba inyuma	774
2321	EN	Open the door to look behind	774
2322	FR	Ouvrir la porte pour regarder derrière	774
2323	RW	Gukoresha indorerwamo zose ziboneka	775
2324	EN	Use all mirrors available	775
2325	FR	Utiliser tous les rétroviseurs	775
2326	RW	Gusaba umuntu kukuyobora hanze	776
2327	EN	Ask someone outside to guide you	776
2328	FR	Demander à quelqu’un de vous guider	776
2329	RW	Kugihigamira ako kanya ndetse byaba ngombwa ugahagarara	777
2330	EN	Pull over as soon as it is safe to do so	777
2331	FR	Vous devez vous arrêter dès que vous pouvez le faire en toute sécurité	777
2332	RW	Kongera umuvuduko kugirango ugisige	778
2333	EN	Accelerate hard to get away from it	778
2334	FR	Accélérer fortement pour s’en sortir	778
2335	RW	Kugumana umuvuduko wari ufite	779
2336	EN	Maintain your speed and course	779
2337	FR	Maintenir votre vitesse et votre trajectoire	779
2338	RW	Guhagarara bitunguranye mu muhanda	780
2339	EN	Brake harshly and stop in the road	780
2340	FR	Freiner brutalement et s’arrêter sur la route	780
2341	RW	Kwemerera abandi bayobozi b’ibinyabiziga kugutambukaho	781
2342	EN	To allow other drivers to pass you	781
2343	FR	Permettre aux autres conducteurs de vous dépasser	781
2344	RW	Kugirango ubone neza ikindi cyerekezo ushyira gufata	782
2345	EN	To get a better view of the road you are joining	782
2346	FR	Pour mieux voir la route que vous rejoignez	782
2347	RW	Kugirango ufashe abandi bakoresha umuhanda kumenya icyo ushaka gukora	783
2348	EN	To help other road users know what you intend to do	783
2349	FR	Pour aider les autres usagers à comprendre votre intention	783
2350	RW	Kwemerera abandi kugutambuka ibumoso	784
2351	EN	To allow drivers to pass you on the left	784
2352	FR	Permettre aux conducteurs de vous dépasser à gauche	784
2353	RW	Kugabanya umuvuduko ukareka akagenda	785
2354	EN	Slow down and let the trailer turn	785
2355	FR	Ralentir et laisser tourner la remorque	785
2356	RW	Gukomeza iburyo bwawe	786
2357	EN	Continue keeping to the right	786
2358	FR	Continuer à droite	786
2359	RW	Kumunyuraho iburyo	787
2360	EN	Overtake on the right	787
2361	FR	Dépasser à droite	787
2362	RW	Kugumana umuvuduko no kumuvugiriza ihoni	788
2363	EN	Maintain speed and sound horn	788
2364	FR	Maintenir la vitesse et klaxonner	788
2365	RW	Kureka abakuze n’abafite ubumuga gusa	789
2366	EN	Give way only to elderly and disabled	789
2367	FR	Laisser seulement les personnes âgées et handicapées	789
2368	RW	Kugabanya umuvuduko witegura guhagarara	790
2369	EN	Slow down and prepare to stop	790
2370	FR	Ralentir et se préparer à s’arrêter	790
2371	RW	Gukoresha amatara abamenyesha kwambuka	791
2372	EN	Use headlights to indicate they can cross	791
2373	FR	Utiliser les phares pour indiquer qu’ils peuvent traverser	791
2374	RW	Kubereka kwambuka	792
2375	EN	Wave them to cross	792
2376	FR	Leur faire signe de traverser	792
4624	RW	A na b ni ibisubizo by’ukuri	1813
4841	EN	take the wounded out of the vehicles	1886
5054	EN	No entry	1957
4625	EN	Danger	1814
4626	FR	Un danger	1814
4627	RW	ibyago	1814
4628	EN	Prohibi on	1815
4629	FR	Une interdic on	1815
4630	RW	ibibujijwe	1815
4631	EN	Obliga on	1816
4632	FR	Une obliga on	1816
2389	RW	Amatara yo kubisikana na kamena-bihu	797
2390	EN	Main headlights and fog lights	797
2391	FR	Feux de croisement et feux de brouillard	797
2392	RW	Amatara kamena-bihu y’imbere	798
2393	EN	Front fog lights	798
2394	FR	Feux de brouillard avant	798
2395	RW	Amatara yo kubisikana	799
2396	EN	Dipped headlights	799
2397	FR	Feux de croisement	799
2398	RW	Amatara kamena-bihu y’inyuma	800
2399	EN	Rear fog lights	800
2400	FR	Feux de brouillard arrière	800
2401	RW	Feri idakora neza	801
2402	EN	Brakes do not work well	801
2403	FR	Les freins ne fonctionnent pas bien	801
2404	RW	Uhumishwa n’amatara y’abandi	802
2405	EN	You are dazzled by headlights	802
2406	FR	Vous êtes ébloui par les phares	802
2407	RW	Biragoye kubona ikiri imbere	803
2408	EN	It is more difficult to see ahead	803
2409	FR	Il est plus difficile de voir devant	803
2410	RW	Moteri itinda gushyuha	804
2411	EN	Engine takes longer to warm up	804
2412	FR	Le moteur met plus de temps à chauffer	804
4633	RW	ibitegetswe	1816
4634	EN	None of the answ ers is correct	1817
4635	FR	Aucune de réponses n’est correctes	1817
4636	RW	ntagisubizo cy’ukuri kirimo	1817
4637	EN	Right of way	1818
4638	FR	Voie prioritaire	1818
4639	RW	uburenganzira bwo gutambuka mbere	1818
4640	EN	Priority at the Next cross road	1819
4641	FR	Priorité au prochain carrefour	1819
4642	RW	uburenganzira bwo gutambuka mbere mu yandi masangano y’umuhanda akwegereye	1819
4643	EN	Danger at the Next cross road	1820
4644	FR	Danger au prochain carrefour	1820
4645	RW	ibyago imbere mu masangano y’umuhanda ukwegereye	1820
4646	EN	a and b are correct	1821
4647	FR	A et b sont corrects	1821
4648	RW	a na b ni ibisubizo by’ukuri	1821
4649	EN	No entry for pedestrians	1822
4650	FR	Interdit l’accès aux piétons	1822
4651	RW	N hanyurwa n’abanyamaguru	1822
4652	EN	Announces a pedestrian street	1823
4653	FR	Annonce une rue piétonne	1823
4654	RW	Akayira kabanyamaguru	1823
4655	EN	Announces a pedestrian crossing	1824
4656	FR	Annonce un passage pour piétons	1824
4657	RW	Aho abanayamaguru bambukira	1824
4658	EN	b and c are correct	1825
4659	FR	B et c sont correctes	1825
4660	RW	B na c ni ibisubizo by’ukuri	1825
4661	EN	70 km/h	1826
4662	FR	70 km/h	1826
4663	RW	70 km/h	1826
4664	EN	50 km/h	1827
4665	FR	50 km/h	1827
4666	RW	50 km/h	1827
4667	EN	40 km/h	1828
4668	FR	40 km/h	1828
2449	RW	Ku ruhande rw’ibumoso gusa	817
2450	EN	On the left-hand side only	817
2451	FR	Sur le côté gauche seulement	817
2452	RW	Kunyuranaho ntibyemewe	818
2453	EN	Overtaking is not allowed	818
2454	FR	Le dépassement n’est pas autorisé	818
2455	RW	Gusa ku ruhande rw’iburyo	819
2456	EN	Only on the right-hand side	819
2457	FR	Seulement sur le côté droit	819
2458	RW	Ku ruhande rw’ibumoso cyangwa iburyo	820
2459	EN	On either the right or left side	820
2460	FR	À droite ou à gauche	820
2461	RW	Umuyobozi w’ikinyamitende	821
2462	EN	A motorcyclist	821
2463	FR	Un motocycliste	821
2464	RW	Umunyamaguru	822
2465	EN	A pedestrian	822
2466	FR	Un piéton	822
2467	RW	Umukozi ubifitiye ububasha	823
2468	EN	A qualified/authorized officer	823
2469	FR	Un agent qualifié	823
2470	RW	Umuyobozi wa bisi	824
2471	EN	A bus driver	824
2472	FR	Un chauffeur de bus	824
4669	RW	40 km/h	1828
4670	EN	80 km/h	1829
4671	FR	80 km/h	1829
4672	RW	80 km/h	1829
4673	EN	A hotel	1830
4674	FR	Un hôtel	1830
4675	RW	Hoteli	1830
4676	EN	A hospital	1831
4677	FR	Un établissement sanitaire	1831
4678	RW	Ibitaro	1831
4679	EN	A helicopter landing zone	1832
4680	FR	Une zone d’a errissage pour hélicoptère	1832
5922	EN	It is allowed, below the signal.	2257
5923	FR	C'est autorisé, en deçà du signal.	2257
5924	RW	beremewe munsi yicyi cyapa	2257
5925	EN	It is allowed in part, beyond the signal.	2258
5926	FR	C'est autorisé en partie, au-delà du signal.	2258
5927	RW	beremewe imbere y'icyi cyapa	2258
5928	EN	It is forbidden, both below and beyond the signal.	2259
5929	FR	C'est interdit, aussi bien en deçà qu'au-delà du signal.	2259
5930	RW	birabujijwe imbere n'inuma yicyi cyapa	2259
5931	EN	None of the answer is correct	2260
4681	RW	Ahagenewe kugwa kajugujugu	1832
4682	EN	b et c sont corrects	1833
4683	FR	b et c sont corrects	1833
4684	RW	B na c ni ibisubizo by’ukuri	1833
4842	FR	sor r les blesses des véhicules	1886
5932	FR	Aucune de réponse n'est correcte	2260
5933	RW	ntagisubizo cy'ukuri	2260
5934	EN	Yield to all heavy goods vehicles.	2261
5935	FR	Cédez le passage à tous les poids lourds.	2261
5936	RW	Tanga inzira ku binyabiziga binini	2261
5937	EN	Slow down and stop for pedestrians.	2262
5938	FR	Ralentissez et arrêtez-vous pour les piétons.	2262
5939	RW	Gabanya umuvuduko uhe inzira abanyamaguru.	2262
4685	EN	an area reserved for stopping and parking	1834
4686	FR	Une zone réservée à l’arrêt et au sta onnement	1834
4687	RW	ahagenewe guhagarara umwanya munini	1834
4688	EN	a pedestrian zone	1835
4689	FR	Une zone réservée aux piétons	1835
4690	RW	ahagenewe abanayamaguru	1835
4691	EN	Cycle track	1836
4692	FR	Une piste cyclable	1836
4693	RW	ahagenewe inzira y’ibinyamitende	1836
4694	EN	a and b are correct	1837
4695	FR	a et b sont correctes	1837
4696	RW	a na b ni ibisubizo by’ukuri	1837
2521	RW	Umuvuduko ntarengwa wemewe	841
2522	EN	Speed limit applies	841
2523	FR	Limite de vitesse	841
2524	RW	Iherezo ry’ibibujijwe	842
2525	EN	End of restrictions	842
2526	FR	Fin des restrictions	842
2527	RW	Birabujijwe guhagarara	843
2528	EN	No parking	843
2529	FR	Stationnement interdit	843
2530	RW	Nta gisubizo cy’ukuri kirimo	844
2531	EN	None of the answers is correct	844
2532	FR	Aucune réponse correcte	844
4697	EN	On the right	1838
4698	FR	Par la droite	1838
4699	RW	iburyo	1838
4700	EN	On the le	1839
4701	FR	Par la gauche	1839
4702	RW	ibumoso	1839
4703	EN		1840
4704	FR		1840
4705	RW		1840
4706	EN	None of the answers is correct	1841
4707	FR	Aucune de réponses n’est correctes	1841
4708	RW	nta gisubizo cy’ukuri kirimo	1841
4843	RW	gusohora inkomere mu kinyabiziga	1886
4844	EN	give them to drink	1887
4845	FR	leur donner à boire	1887
4846	RW	kubaha icyo kunywa	1887
4847	EN	report the accident and no fy the rescue	1888
4848	FR	signaler l’accident et aver r les secours	1888
4849	RW	ku menyesha impanuka no guubutabazi	1888
4850	EN	no correct answer	1889
4851	FR	Aucune de réponses n’est correctes	1889
4852	RW	nta gisubizo cy’ukuri kirimo	1889
4946	EN	Accelerate and complete the turn	1921
4947	FR	Accélérer et terminer le virage	1921
4948	RW	Ongera umuvuduko kugirango usoze ikoni	1921
4949	EN	Proceed, as the green light is about to come on	1922
4950	FR	Con nuez, car le feu vert est sur le point de s'allumer.	1922
4951	RW	Komeza kuko itara ry’icyatsi rigiye kwaka.	1922
4952	EN	Stop, unless it is not safe	1923
4953	FR	arrêtez, sauf si ce n'est pas sûr.	1923
4954	RW	Hagarara niba utateza ibyago	1923
4955	EN	Con nue with care being ready to stop if the light turns to red	1924
4956	FR	Con nuez avec précau on en étant prêt à vous arrêter si le voyant devient rouge	1924
4957	RW	Komeza ubwitonzi witegura guhagarara mugihe itara rihindutse umutuku	1924
4958	EN	The reversing driver will stop when he sees the motorcyclist.	1925
4959	FR	Le conducteur en marche arrière s'arrête lorsqu'il voit le motocycliste.	1925
4960	RW	Umuyobozi wikinyabiziga gisubira inyuma azahagarara nabona umuyobozi w’ ikinyabimitende ibiri	1925
4961	EN	The motorcyclist may beckon the reversing driver to stop.	1926
4962	FR	Le motocycliste peut demander au conducteur qui fait marche arrière de s’immobiliser.	1926
4963	RW	Umuyobozi w’ ikinyamitende ibiri ashobora gusaba umuyobozi w’ ikinyabiziga gisubira inyuma guhagarara	1926
4964	EN	The brake-lights may go off and the car con nue reversing.	1927
4965	FR	Les feux de freinage peuvent s’éteindre et la voiture con nue à faire marche arrière.	1927
4966	RW	Amatara yoguhagarara ashobora kuzima ikinyabiziga gikomeza gusubira inyuma	1927
4967	EN	The motorcyclist may suddenly brake.	1928
4968	FR	Le motocycliste peut freiner brusquement.	1928
4969	RW	Umuyobozi w’ ikinyamitende ashobora guhagarara bitunguranye	1928
4970	EN	Proceed between both pedestrians.	1929
4971	FR	Avancez entre les deux piétons.	1929
4972	RW	Gukomeza hagati y’ abanyamaguru babiri	1929
4973	EN	Sound the horn, and accelerate to proceed promptly.	1930
4974	FR	Sonne le klaxon et accélérez pour procéder rapidement.	1930
4975	RW	kuvuza ihoni akongera umuvuduko	1930
4976	EN	Wait and allow both pedestrians to cross.	1931
4977	FR	Attendez et laissez les deux piétons traverser.	1931
4978	RW	Guhagarara akareka abany amaguru bakambuka	1931
4979	EN	Allow one pedestrian to cross, and then proceed as there should be room to clear the junction.	1932
4980	FR	Laissez un piéton traverser, puis continuez car il devrait y avoir de la place pour dégager la bretelle.	1932
4981	RW	Reka umunyamaguru umwe atambuke ubone umwanya wogutambuka	1932
5018	EN	On the right-hand side of the road	1945
5019	FR	Sur le côté droit de la route	1945
5020	RW	Ku ruhande rw’iburyo rw’umuhanda	1945
5021	EN	Just right of the center of the road	1946
5022	FR	Juste à droite du centre de la route	1946
5023	RW	Hafi y’iburyo bw’umurongo wo hagati w’umuhanda	1946
5024	EN	Either side of the road	1947
5025	FR	N'importe quel côté de la route	1947
5026	RW	Ku ruhande urwo ari rwo rwose rw’umuhanda	1947
5055	FR	Accès interdit	1957
4709	EN	of any vehicle	1842
4710	FR	De tout véhicule	1842
4711	RW	ku binyabiziga byose	1842
4712	EN	of any motor vehicle	1843
4713	FR	De tout véhicule à moteur	1843
4714	RW	ku binyabiziga byose bifite moteri	1843
4715	EN	of any vehicle with engine apart from tho with two wheels with side car	1844
4716	FR	De tous les véhicules à moteur autres que ceux à deux roues sans side-car	1844
4717	RW	kubinyabiziga byose uretse ibinyamite ibiri n’amapikipiki adafite akanyabiziga ko kuruhande	1844
4718	EN	no correct answer	1845
4719	FR	Aucune de réponses n’est correctes	1845
4720	RW	nta gisubizo cy’ukuri kirimo	1845
4721	EN	yes	1846
4722	FR	Oui	1846
4723	RW	yego	1846
4724	EN	yes, by giving way to pedestrians	1847
4725	FR	Oui, en cédant le passage aux piétons	1847
4726	RW	yego ariko utanga inzira kubanyamaguru	1847
4727	EN	yes, by giving way to oncoming drivers	1848
4728	FR	Oui, en cédant le passage aux conducteurs venant en sens inverse	1848
4729	RW	yego utanga inzira kubandi bayobozi b’ibinyabizaga baturutse mukindi cyerekezo	1848
4730	EN	no	1849
4731	FR	Non	1849
4732	RW	oya	1849
4733	EN	Before each turn	1850
4734	FR	Avant chaque virage	1850
4735	RW	Mbere ya buri koni	1850
4736	EN	In every turn	1851
4737	FR	Dans chaque virage	1851
4738	RW	Muri buri koni	1851
4739	EN	After each turn	1852
4740	FR	Après chaque virage	1852
4741	RW	Nyuma ya buri koni	1852
4742	EN	no correct answer	1853
4743	FR	Aucune de réponses n’est correctes	1853
4744	RW	Nta gisubizo cy’ukuri kirimo	1853
4853	EN	Proceed as the boy is on the footpath.	1890
4854	FR	Continuez comme le garçon est sur le trottoir.	1890
4855	RW	Ikomereze nkaho ataragera mu nzira nyabagendwa	1890
4856	EN	Be prepared for the boy stepping off at any moment without paying attention to your vehicle	1891
4857	FR	Préparez-vous à ce que le garçon parte à tout moment sans faire attention à votre véhicule	1891
4858	RW	Itegure kureka uwo mwana w’umuhungu atambuke, kuko ashobora kwinjira mu muhanda atitaye ku kinyabiziga cyawe	1891
4859	EN	Slow down and let the boy cross the road.	1892
4860	FR	Ralentissez et laissez le garçon traverser la route.	1892
4861	RW	Gabanya umuvuduko ureke uwo mwana yambuke	1892
4862	EN	Proceed as the boy is on the footpath.	1893
4863	FR	Continuez comme le garçon est sur le trottoir.	1893
4864	RW	Komeza nkaho uwo mwana akiri mu nzira y’abanyamaguru	1893
4865	EN	Continue to drive fast because pedestrians have to wait	1894
4866	FR	Continuer à rouler vite car les piétons doivent attendre	1894
4867	RW	Gukomeza agendera ku muvuduko uri hejuru, mu gihe umunyamaguru ategereje	1894
4868	EN	Maintain your speed because pedestrians have not stepped on to the crossing	1895
4869	FR	Maintenez votre vitesse car les piétons ne sont pas encore engagés sur le passage	1895
4870	RW	Kuguma ku muvuduko yari afite mu gihe umunyamaguru atarambuka	1895
4871	EN	Sound the horn and continue at the same speed	1896
4872	FR	Faire retentir l’avertisseur sonore et continuer à la même vitesse	1896
4873	RW	Kuvuza ihoni akaguma ku muvuduko yahozeho	1896
4874	EN	You should overtake both vehicles together	1897
4875	FR	Vous devriez dépasser les deux véhicules ensemble	1897
4876	RW	Ugomba kuzinyuraho zombi	1897
4877	EN	The driver's field of view is not good enough to allow safe overtaking	1898
4878	FR	Le champ de vision du conducteur n’est pas suffisant pour permettre un dépassement en toute sécurité	1898
4879	RW	Sibyiza ko yazinyuraho atabasha kureba neza imbere ye	1898
4880	EN	The roadway marking allows overtaking here	1899
4881	FR	Le marquage routier permet de dépasser ici	1899
4882	RW	Ibyapa by’aho ageze n bimwemerera kunyuranaho	1899
4883	EN	Pedestrian crossing ahead	1900
4884	FR	Passage piéton devant	1900
4885	RW	Imbere har’inzira y’abanyamaguru	1900
4982	EN	No, the driver cannot see clearly ahead.	1933
4983	FR	Non, le conducteur ne peut pas voir clairement devant.	1933
4984	RW	Oya, umuyobozi ntashobora kureba imbere neza	1933
4985	EN	Yes, provided the broken line does not become continuous.	1934
4986	FR	Oui, à condition que la ligne brisée ne devienne pas continue.	1934
4987	RW	Yego, kuko umurongo wera ucagaguye udashobora kuba udacagaguye.	1934
4988	EN	Yes, the cyclists will hear your vehicle and thus will get out of the way.	1935
4989	FR	Oui, les cyclistes entendront votre véhicule et s’écarteront ainsi du chemin.	1935
4990	RW	Yego, abanyamagare bazumva imodoka bave munzira	1935
4991	EN	Yes, any oncoming traffic can observe the situation and will get out of the way.	1936
4992	FR	Oui, tout trafic venant en sens inverse peut observer la situation et s’écartera du chemin.	1936
4993	RW	Yego, kuko buri kinyabiziga kiva mukindi cyerekezo gishobora kuguha inzira	1936
5027	EN	On the left-hand side of the road	1948
5028	FR	Sur le côté gauche de la route	1948
5029	RW	Ku ruhande rw’ibumoso rw’umuhanda	1948
5056	RW	Nta kunyura	1957
5057	EN	No parking	1958
5058	FR	Stationnement interdit	1958
5059	RW	Guhagarara birabujijwe	1958
5060	EN	National speed limit	1959
5061	FR	Limite de vitesse nationale	1959
5062	RW	Umuvuduko ntarengwa w’igihugu	1959
5063	EN	School crossing patrol	1960
5064	FR	Patrouille scolaire	1960
5065	RW	Inzira y’abanyeshuri	1960
5066	EN	Overtaking only, never turning right	1961
4745	EN	The signal A19	1854
4746	FR	Le signal A19	1854
4747	RW	Icyapa A19	1854
4748	EN	The signal B5	1855
4749	FR	Le signal B5	1855
4750	RW	Icyapa B5	1855
4751	EN	The signal B6	1856
4752	FR	Le signal B6	1856
4753	RW	Icyapa B6	1856
4754	EN	No correct answer	1857
4755	FR	Aucune de réponses n’est correctes	1857
4756	RW	Ntagisubizo cy’ukuri kirimo	1857
4757	EN	flying gravel	1858
4758	FR	Des projec ons de gravillons	1858
4759	RW	utubuye dutaruka mu muhanda	1858
4760	EN	ruts with risk of aquaplaning	1859
4761	FR	Des ornières avec risqué d’aquaplanage	1859
4762	RW	umuhanda urimo amazi	1859
4763	EN	a slippery road	1860
4764	FR	Une chaussée glissante	1860
4765	RW	umuhanda unyerera	1860
4766	EN	a and b are correct	1861
4767	FR	A et b sont correctes	1861
4768	RW	a na b ni bisubizo by’ukuri	1861
4886	EN	Sound your horn to the cyclist that you intend to turn right	1901
4887	FR	Sonnez votre klaxon au cycliste que vous avez l'intention de tourner à droite	1901
4888	RW	Vuza ihoni umenyesha umunyegare ko ushaka gukatira iburyo	1901
4889	EN	Turn the corner before the cyclist	1902
4890	FR	Tourner le virage avant le cycliste	1902
4891	RW	Kata ikoni mbere y’umunyegare	1902
4892	EN	Allow the cyclist heading straight on to pass	1903
4893	FR	Permettre au cycliste de passer tout droit	1903
4894	RW	Emerera umunyegare akomeze inzira ye	1903
4895	EN	Increase speed to overtake the cyclist before turning	1904
4896	FR	Augmenter la vitesse pour pouvoir tourner avant le cycliste	1904
4897	RW	Ongera umuvuduko kugira ngo umutange	1904
4898	EN	Front and rear fog lights along with dipped headlights	1905
4899	FR	Feux de brouillard avant et arrière avec feux de croisement	1905
4900	RW	Amatara kamenabihu y’imbere n’ay’inyuma hamwe n’amatara magufi	1905
4901	EN	Front and rear fog lights	1906
4902	FR	Feux de brouillard avant et arrière	1906
4903	RW	Amatara kamenabihu y’imbere n’ay’inyuma	1906
4904	EN	Dipped headlights	1907
4905	FR	Feux de croisement	1907
4906	RW	Amatara magufi	1907
4907	EN	Just normal lights	1908
4908	FR	Juste des lumières normales	1908
4909	RW	Urumuri rusanzwe	1908
4910	EN	Both cars	1909
4911	FR	Les deux voitures	1909
4912	RW	Ibinyabiziga byombi	1909
4913	EN	The green car	1910
4914	FR	La voiture verte	1910
4915	RW	Ikinyabiziga cy’icyatsi	1910
4916	EN	The red car	1911
4917	FR	La voiture rouge	1911
4918	RW	Ikinyabiziga cy’umutuku	1911
4919	EN	Neither car	1912
4920	FR	Ni voiture	1912
4921	RW	Nta n’imwe	1912
4922	EN	The driver should not overtake here	1913
4923	FR	Le conducteur ne devrait pas dépasser ici	1913
4924	RW	Aha umuyobozi w’ikinyabiziga ntashobora kumunyuraho	1913
4925	EN	By not crossing the broken white line	1914
4926	FR	En ne franchissant pas la ligne blanche brisée	1914
2809	RW	Uruhushya rwo gutwara ibinyabiziga rugifite agaciro	937
2810	EN	A valid driving license	937
2811	FR	Un permis de conduire valide	937
2812	RW	Ubwishingizi bw’ikinyabiziga bugifite agaciro	938
2813	EN	Proper insurance	938
2814	FR	Assurance automobile valide	938
2815	RW	Icyemezo cy’iyandikwa ry’ikinyabiziga	939
2816	EN	Motor-vehicle registration certificate	939
2817	FR	Certificat d’immatriculation du véhicule	939
2818	RW	Ibisubizo byose nibyo	940
2819	EN	All answers are correct	940
2820	FR	Toutes les réponses sont correctes	940
2821	RW	Nyuma y’umwaka umwe	941
2822	EN	After one year	941
2823	FR	Après un an	941
2824	RW	Nyuma y’imyaka ibiri	942
2825	EN	After two years	942
2826	FR	Après deux ans	942
2827	RW	A na B ni ibisubizo by’ukuri	943
2828	EN	A and B are correct	943
2829	FR	A et B sont corrects	943
2830	RW	Nta gisubizo cy’ukuri kirimo	944
2831	EN	None of the answers is correct	944
2832	FR	Aucune réponse correcte	944
2833	RW	Mu gihe ushaka kuburira abandi bakoresha umuhanda	945
2834	EN	When you want to warn other road users	945
2835	FR	Quand vous voulez avertir les autres usagers de la route	945
2836	RW	Mu gihe ikinyabiziga cyawe gishobora guteza ibyago	946
2837	EN	When your vehicle is causing a temporary obstruction	946
2838	FR	Lorsque votre véhicule provoque une obstruction temporaire	946
2839	RW	A na B ni ibisubizo by’ukuri	947
2840	EN	A and B are correct	947
2841	FR	A et B sont corrects	947
2842	RW	Nta gisubizo cy’ukuri kirimo	948
2843	EN	None of the answers is correct	948
2844	FR	Aucune réponse correcte	948
2845	RW	Kumenya neza niba imbangukiragutabara yahamagawe	949
2846	EN	Make sure that an ambulance is called	949
2847	FR	S’assurer qu’une ambulance est appelée	949
2848	RW	Guhagarika ibinyabiziga bindi no kubasaba ubufasha	950
2849	EN	Stop other vehicles and ask drivers for help	950
2850	FR	Arrêter les autres véhicules et demander de l’aide	950
2851	RW	A na B ni ibisubizo by’ukuri	951
2852	EN	A and B are correct	951
2853	FR	A et B sont corrects	951
2854	RW	Nta gisubizo cy’ukuri kirimo	952
2855	EN	None of the answers is correct	952
2856	FR	Aucune réponse correcte	952
5940	EN	Yield to traffic on the major road.	2263
5941	FR	Céder le passage à la circulation sur la route principale.	2263
5942	RW	Tanga inzira ku binyabiziga bigenda mu muhanda munini wegera	2263
5943	EN	Yield to traffic coming from your right.	2264
5944	FR	Cédez à la circulation venant de votre droite.	2264
5945	RW	Tanga inzira ku ibinyabiziga biturutse iburyo bwawe	2264
2869	RW	Icyemezo cy’iyandikwa ryi ikinyabiziga	957
2870	EN	Vehicle registra on	957
2871	FR	Immatricula on des véhicules	957
2872	RW	Uruhusa rwa burundu rwo gutwara ikinyabiziga	958
2873	EN	Driving license	958
2874	FR	Permis de conduire	958
2875	RW	Uruhushya rwagateganyo	959
2876	EN	Provisional driving license	959
2877	FR	Permis provisoire	959
2878	RW	Imikorere y’ikinyabiziga	960
2879	EN	Vehicle service record	960
2880	FR	Record de service du véhicule	960
6354	EN	Roundabout	2401
6355	FR	Sens giratoire	2401
6356	RW	Aho banyura bazengurutse	2401
6357	EN	The roadway has three bands	2402
6358	FR	La chaussée comporte trois bandes	2402
6359	RW	Cyerekana umuhanda w'ibisate bitatu	2402
6360	EN	Approaching a junction	2403
6361	FR	Approche d'une intersection	2403
6362	RW	Cyerekana ahegereye inkomane	2403
6363	EN	None of the answers is correct	2404
6364	FR	Aucune des réponses n'est correcte.	2404
6365	RW	Ntagisuzo cy'ukuri kirimo	2404
6378	EN	One-way traffic	2409
6379	FR	Sens unique	2409
6380	RW	Hanyurwa mu cyerekezo kimwe	2409
6381	EN	No entry	2410
6382	FR	Accès interdit	2410
6383	RW	Ntihanyurwa	2410
6384	EN	No through road	2411
6385	FR	Route sans issue	2411
6386	RW	Umuhanda udakomeza	2411
6387	EN	None of the answers is correct	2412
6388	FR	Aucune des réponses n'est correcte.	2412
6389	RW	Ntagisuzo cy'ukuri kirimo	2412
6414	EN	The signal D1a	2421
6415	FR	Le signal D1a	2421
6416	RW	Icyapa D1a	2421
6417	EN	The signal E13a	2422
6418	FR	Le signal E13a	2422
6419	RW	Icyapa E13a	2422
6420	EN	The signal C19	2423
6421	FR	Le signal C19	2423
6422	RW	Icyapa C19	2423
6423	EN	The signal C1	2424
6424	FR	Le signal C1	2424
6425	RW	Icyapa C1	2424
5958	EN	Stop, for school crossing ahead.	2269
5959	FR	Arrêtez-vous pour le passage de l'école à venir.	2269
5960	RW	Guhagarara, aho abanyeshuri bambukira	2269
5961	EN	Stop your vehicle.	2270
5962	FR	Arrêtez votre véhicule.	2270
5963	RW	Hagarara akanya gato	2270
5964	EN	Other traffic must give way to you.	2271
5965	FR	L'autre trafic doit céder le passage à vous.	2271
5966	RW	Ibindi binyabiziga bigomba kuguha inzira	2271
5967	EN	Give way to traffic coming from your right.	2272
5968	FR	Cédez le passage à la circulation venant de votre droite.	2272
5969	RW	Gutanga umwanya ku bindi binyabiziga i buryo bwawe	2272
5970	EN	Yield to traffic on the major road.	2273
5971	FR	Cédez le passage à la circulation sur la route principale.	2273
5972	RW	Tanga inzira ku binyabiziga biri mu muhanda munini	2273
5973	EN	Yield to traffic coming from the right.	2274
5974	FR	Céder le passage à la circulation venant de la droite.	2274
5975	RW	Tanga inzira ku binyabiziga biturutse i buryo	2274
5976	EN	Yield to trucks and buses only.	2275
5977	FR	Cédez le passage aux camions et aux bus uniquement.	2275
5978	RW	Tanga inzira ku ma kamyo na za otobisi	2275
5979	EN	All vehicles, except motorcycles, must yield.	2276
5980	FR	Tous les véhicules, à l'exception des motocyclettes, doivent céder le passage.	2276
3133	RW	Tugomba kugabanya umuvuduko	1045
3134	EN	We shall not increase speed	1045
3135	FR	Nous n'augmenterons pas la vitesse.	1045
3136	RW	Tugomba kongera umuvuduko	1046
3137	EN	We can increase speed	1046
3138	FR	Nous pouvons augmenter la vitesse.	1046
3139	RW	Tugomba kongera umuvuduko n’ubwitonzi	1047
3140	EN	We can increase speed with due care	1047
3141	FR	Nous pouvons augmenter la vitesse avec soin.	1047
3142	RW	Nta gisubizo cy’ ukuri kirimo	1048
3143	EN	None of the answers is correct	1048
3144	FR	Aucune de réponses n’est correctes.	1048
3145	RW	Mu biro bya leta	1049
3146	EN	In government office	1049
3147	FR	Dans le bureau du gouvernement	1049
3148	RW	Mu biro bya Polisi	1050
3149	EN	In police sta on	1050
3150	FR	Au poste de police	1050
3151	RW	Igihe utwaye ikinyabiziga	1051
3152	EN	While driving a vehicle	1051
3153	FR	En conduisant un véhicule	1051
3154	RW	Ibisubizo byose ni ukuri	1052
3155	EN	All answers are correct	1052
3156	FR	Toutes les réponses sont correctes	1052
3157	RW	Nta kindi kinyabiziga kinturutse inyuma	1053
3158	EN	No vehicle is approaching from behind	1053
3159	FR	Aucun véhicule ne vient par derrière.	1053
3160	RW	Umuhanda ubona neza, no kwitondera kunyuranaho	1054
3161	EN	The road ahead is clearly visible and it is safe to overtake	1054
3162	FR	La route devant vous est clairement visible et il est prudent de dépasser.	1054
3163	RW	Ikinyabiziga kinturutse imbere gishaka kuguka ibumoso	1055
3164	EN	The vehicle in front is turning left	1055
3165	FR	Le véhicule devant tourne à gauche	1055
3166	RW	Nta gisubizo cy’ukuri	1056
3167	EN	None of the answers is correct	1056
3168	FR	Aucune de réponses n’est correctes	1056
3169	RW	Kongera umuvuduko kugira ngo intera hagati yawe n’ukuri inyuma igumeho	1057
3170	EN	Accelerate to maintain gap behind you	1057
3171	FR	Accélérer pour maintenir l'écart derrière vous.	1057
3172	RW	Fata feri y’urugendo kugira ngo umwerereko ugiye guhagarara	1058
3173	EN	Touch the brakes to show your brake light	1058
3174	FR	Touchez les freins pour afficher votre feu de freinage.	1058
3175	RW	Emerera icyo kinyabiziga kugutambukaho niba imbere ntacyago gihari	1059
3176	EN	Allow the vehicle to overtake, if safe	1059
3177	FR	Perme re au véhicule de dépasser, s'il est en sécurité.	1059
3178	RW	Nta gisubizo cy’ukuri kirimo	1060
3179	EN	None of the answers is correct	1060
3180	FR	Aucune de réponses n’est correctes	1060
3181	RW	Umuyobozi w’ikinyabiziga agomba gufata iyo nkoni nk’icyapa kimumenyesha ko agomba guhagarara	1061
3182	EN	The driver of a vehicle shall consider the white cane as a traffic sign to stop the vehicle	1061
3183	FR	Le conducteur d’un véhicule doit considérer la canne blanche comme un panneau de signalisation pour arrêter les véhicules.	1061
3184	RW	Vuza ihoni ukomeze	1062
3185	EN	Blow the horn and proceed	1062
3186	FR	Sonnez le cor et continuez.	1062
3187	RW	Gabanya nurangiza ukomeze witonze	1063
3188	EN	Slow down and proceed with caution	1063
3189	FR	Ralentissez et avancez avec prudence	1063
3190	RW	Ibisubizo byose ni ukuri	1064
3191	EN	All answers are correct	1064
3192	FR	Toutes les réponses sont correctes	1064
3193	RW	Ni meza kuko atuma ureba kure	1065
3194	EN	Is good because you can see more	1065
3195	FR	C'est bien parce qu'on peut voir plus.	1065
3196	RW	Ni mabi kuko arakugarukira akaguhuma amaso	1066
3197	EN	Is bad because it reflects back and can dazzle	1066
3198	FR	Est mauvais parce qu'il reflète et peut éblouir.	1066
3199	RW	Akwizeza ko abandi bakubona	1067
3200	EN	Make sure others can see you	1067
3201	FR	Assurez-vous que les autres peuvent vous voir.	1067
3202	RW	Nta gisubizo cy’ukuri	1068
3203	EN	None of the answers is correct	1068
3204	FR	Aucune de réponses n’est correctes	1068
3205	RW	Ni bibi ku kinyabiziga cy’imitende ibiri	1069
3206	EN	Dangerous to two wheelers only	1069
3207	FR	Dangereux pour les deux-roues seulement.	1069
3208	RW	Ni bibi igihe cyose	1070
3209	EN	Dangerous to all times	1070
3210	FR	Dangereux à tous les temps.	1070
3211	RW	Ni bibi ku kinyabiziga cy’imitende ine	1071
3212	EN	Dangerous to four-wheelers vehicle	1071
3213	FR	Dangereux pour les véhicules à quatre roues.	1071
3214	RW	Nta gisubizo cy’ukuri	1072
3215	EN	None of the answers is correct	1072
3216	FR	Aucune de réponses n’est correctes	1072
3217	RW	Ahari ibimenyetso bimurika	1073
3218	EN	At red light	1073
3219	FR	Au feu rouges	1073
3220	RW	Igihe utwaye ikinyabiziga Ku muvuduko wa 20km/h	1074
3221	EN	When driving at speed of 20km/h	1074
3222	FR	Lorsque vous conduisez À une vitesse de20km/h	1074
3223	RW	A na B ni ibisubizo by’ukuri	1075
3224	EN	A and B are correct	1075
3225	FR	A et B sont corrects	1075
3226	RW	Nta gisubizo cy’ukuri	1076
3227	EN	None of these	1076
3228	FR	Aucune de réponses n’est correctes	1076
3229	RW	Igihe mu muhanda haga hashushanyijemo umurongo w’umweru ucagaguye.	1077
3230	EN	The road is marked with broken center line in white color	1077
3231	FR	La route est marquée avec une ligne médiane brisée de couleur blanche.	1077
3232	RW	Umuhanda ushushanyijwemo umurongo wera udacagaguye	1078
3233	EN	The road is marked with continuous center line in white color	1078
3234	FR	La route est marquée avec une ligne centrale continue de couleur blanche.	1078
3235	RW	Ikinyabiziga gitwawe ku musozi unyerera	1079
3236	EN	Vehicle is driven on a steep hill	1079
3237	FR	Le véhicule est conduit sur une colline escarpée.	1079
3238	RW	Nta gisubizo cy’ukuri	1080
3239	EN	None of the answers is correct	1080
3240	FR	Aucune de réponses n’est correctes .	1080
3241	RW	Gukomeza ibumoso	1081
3242	EN	Proceed keeping to the left	1081
3243	FR	Continuer en restant à gauche.	1081
3244	RW	Kuzimya ucana amatara maremare n’amagufi kindi	1082
3245	EN	Put the head light in dim and bright alternatively several time	1082
3246	FR	Mettez la lampe frontale à la lumière dans plusieurs jours.	1082
3247	RW	Kuzimya amatara maremare kugeza ikinyabiziga gitambutse	1083
3248	EN	Dim the head light till the vehicle passes	1083
3249	FR	Réduisez le feu de croisement jusqu'à ce que le véhicule passe.	1083
3250	RW	Nta gisubizo cy’ukuri kirimo	1084
3251	EN	None of the answers is correct	1084
3252	FR	Aucune de réponses n’est correctes	1084
3253	RW	Umuyobozi w’ikinyabiziga agomba guhagarara	1085
3254	EN	the driver shall stop the vehicle	1085
3255	FR	le conducteur doit arrêter le véhicule	1085
3256	RW	Umuyobozi w’ikinyabizigaagomba kuvuza ihoni agukomeza	1086
3257	EN	the driver shall proceed blowing the horns	1086
3258	FR	Le conducteur doit continuer en soufflant dans les cornes	1086
3259	RW	Umuyobozi w’ikinyabiziga agomba kugabanya umuvuduko	1087
3260	EN	the driver shall reduce the speed	1087
3261	FR	Le conducteur doit réduire la vitesse	1087
3262	RW	Ibisubizo byose ni ukuri	1088
3263	EN	all answers are correct	1088
3264	FR	Toutes les réponses sont correctes.	1088
3265	RW	Ntugomba kujya mu kindi gice cy’umuhanda	1089
3266	EN	Shall not change track	1089
3267	FR	Ne doit pas changer de voie.	1089
3268	RW	Ushobora kujya mu kindi gice cy’umuhanda bibaye ngombwa	1090
3269	EN	Can charge track if required	1090
3270	FR	Peut changer la voie si nécessaire.	1090
3271	RW	Agomba guhagarika ikinyabiziga	1091
3272	EN	Shall stop the vehicle	1091
3273	FR	Doit arrêter le véhicule	1091
3274	RW	Nta gisubizo cy’ukuri	1092
3275	EN	None of the answers is correct	1092
3276	FR	Aucune de réponses n’est correctes	1092
3277	RW	Ku musigi , ku rusengero, ku rutam	1093
3278	EN	Mosque, church and temple	1093
3279	FR	Mosquée, église et temple	1093
3280	RW	Hafi y’ibitaro	1094
3281	EN	Near hospital	1094
3282	FR	Près de l'hôpital	1094
5981	RW	Ibinyabiziga byose uretse amapikipiki bigomba gutanga inzira	2276
5982	EN	Straight ahead only.	2277
5983	FR	Direction tout droit seulement.	2277
5984	RW	Komeza imbere gusa	2277
5985	EN	Overtaking lane ahead.	2278
5986	FR	Voie de dépassement devant.	2278
5987	RW	Aho kunyuranaho imbere	2278
5988	EN	Parking permitted from this point on.	2279
5989	FR	Parking autorisé à partir de ce moment.	2279
5990	RW	Aho guhagarara umwanya munini	2279
5991	EN	One way street ahead.	2280
5992	FR	Une rue à sens unique devant.	2280
5993	RW	Inzira y' icyerekezo kimwe	2280
5994	EN	Motorway to the left.	2281
5995	FR	Autoroute à gauche.	2281
5996	RW	Umuhanda urombereje w'ibice byinshi ibumoso	2281
5997	EN	Diversion ahead to the left.	2282
5998	FR	Déviation en avant à gauche.	2282
5999	RW	Umuhanda uyoborejwe i bumoso	2282
6000	EN	Traffic from the right has priority.	2283
6001	FR	Le trafic de droite est prioritaire.	2283
6002	RW	Ibinyabiziga biturutse iburyo bifite uburenganzira bwo gutambuka mbere	2283
6003	EN	Turn Left Only.	2284
6004	FR	Tourner à gauche seulement.	2284
6005	RW	Kata i bumoso gusa	2284
6006	EN	Overtake only on the right	2285
6007	FR	Dépasser uniquement à droite	2285
6008	RW	Kunyuranaho bikorerwa i buryo gusa	2285
6009	EN	Diversion ahead to the right.	2286
6010	FR	Déviation vers la droite.	2286
6011	RW	Umuhanda uyoborejwe i buryo	2286
6012	EN	Turn right only.	2287
6013	FR	Tournez à droite seulement.	2287
6014	RW	Kata i buryo gusa	2287
6015	EN	Major road joining from the left.	2288
6016	FR	Route principale rejoignant par la gauche.	2288
6017	RW	Umuhanda munini urasukira i bumoso	2288
6018	EN	Keep to the right of the sign.	2289
6019	FR	Passer à droite du signal.	2289
6020	RW	Genda ugana i buryo bw'icyapa	2289
6021	EN	Turn right ahead.	2290
6022	FR	Tourner à droite devant.	2290
6023	RW	Kata i buryo imbere	2290
6024	EN	Road closed on the left.	2291
6025	FR	Route fermée à gauche.	2291
6026	RW	Umuhanda urafunze i bumoso	2291
6027	EN	One way street to the right.	2292
6028	FR	Rue à sens unique vers la droite.	2292
6029	RW	Umuhanda w'icyerekezo kimwe i buryo	2292
6030	EN	U-turn not permitted.	2293
6031	FR	Interdiction de faire demi-tour.	2293
6032	RW	Birabujijwe guhindukira	2293
6033	EN	Reversing not permitted.	2294
6034	FR	Marche arrière interdite.	2294
6035	RW	Birabujijwe gusubira inyuma	2294
6036	EN	Slippery road ahead.	2295
6037	FR	Route glissante devant.	2295
6038	RW	Umuhanda unyerera imbere	2295
6039	EN	Two-way traffic prohibited.	2296
6040	FR	La circulation dans les deux sens est interdite.	2296
6041	RW	Ntibyemewe kugendera mu byerekezo byombi	2296
6042	EN	Slippery road ahead.	2297
6043	FR	Route glissante devant.	2297
6044	RW	Umuhanda unyerera imbere	2297
6045	EN	Two-way traffic prohibited.	2298
6046	FR	La circulation dans les deux sens est interdite.	2298
6047	RW	Ntibyemewe kugendera mu byerekezo byombi	2298
6048	EN	U-turn not permitted.	2299
6049	FR	Interdiction de faire demi-tour.	2299
6050	RW	Birabujijwe guhindukira	2299
6051	EN	Reversing not permitted.	2300
6052	FR	Marche arrière interdite.	2300
6053	RW	Birabujijwe gusubira inyuma	2300
6438	EN	End of a highway	2429
6439	FR	Fin d'autoroute	2429
6440	RW	Umuhanda urombeje w'ibice byinshi	2429
6441	EN	Crossing onto the opposite carriageway is not allowed.	2430
6442	FR	Le passage sur la chaussée opposée n'est pas autorisé.	2430
6443	RW	Birabujijwe kunyura mu muhanda w'ikindi cyerekezo	2430
6444	EN	No overtaking.	2431
6445	FR	Pas de dépassement.	2431
6446	RW	Birabujijwe kunyuranaho	2431
6447	EN	Stopping under bridge is not allowed.	2432
6448	FR	Il est interdit de s'arrêter sous un pont.	2432
6449	RW	Birabujijwe guhagara ku iteme	2432
6066	EN	Motorway continues for 50 kilometers.	2305
6067	FR	L'autoroute continue sur 50 kilomètres.	2305
6068	RW	Umuhanda urombereje w’ibice byinshi ku birometero 50	2305
6069	EN	Minimum distance between vehicles is 50 meters.	2306
6070	FR	La distance minimale entre les véhicules est de 50 mètres.	2306
6071	RW	Intera nto ntarengwa ya metero 50 hagati y'ibinyabiziga	2306
6072	EN	Minimum speed is 50 km/h.	2307
6073	FR	La vitesse minimale est de 50 km / h.	2307
6074	RW	Umuvuduko urenga ibirometero 50 mu isaha	2307
6075	EN	Maximum speed is 50 km/h.	2308
6076	FR	La vitesse maximale est de 50 km / h.	2308
6077	RW	Umuvuduko ntarengwa ugarukira ku birometero 50 mu isaha	2308
3448	RW	Hagarara utegereze amabwiriza	1150
3449	EN	Stop and await instruc ons.	1150
3450	FR	Arrêtez-vous et a endez les instruc ons.	1150
3451	RW	Umuyobozi w’ikinyabiziga agomba kugabanya umuvuduko ateganya icyago imbere ye	1151
3452	EN	The driver should slow down and expect a hazard up ahead.	1151
3453	FR	Le conducteur devrait ralen r et s'a endre à un danger.	1151
3454	RW	Kukireka, ukagumana umuvuduko ufite ugakomeza	1152
3455	EN	Avoid it, maintain speed and carry on.	1152
3456	FR	Évitez-le, maintenez votre vitesse et con nuez.	1152
3457	RW	Hagarara kuri icyo cyapa cya mpande eshatu mbere yo gukomeza	1153
3458	EN	Stop at the triangle before proceeding.	1153
3459	FR	Arrêtez-vous au triangle avant de con nuer.	1153
3460	RW	Kuvuza ihoni kugirango zihunge	1154
3461	EN	Sound the horn to try get the ca le to move aside.	1154
3462	FR	Sonnez le klaxon pour essayer de faire bouger le bétail.	1154
3463	RW	Umuyobozi w’ikinyabiziga agomba kugabanya umuvuduko zigatambuka	1155
3464	EN	The driver should reduce speed and overtake with care.	1155
3465	FR	Le conducteur doit réduire sa vitesse et dépasser avec précau on.	1155
3466	RW	Kwatsa amatara maremare kugirango utambuke wihuta mu buryo bushoboka bwo	1156
3467	EN	Switch on your headlights and try to pass as quickly as possible.	1156
3468	FR	Allumez vos phares et essayez de passer aussi vite que possible.	1156
3469	RW	Kuvuza ihoni ukanyuraho witonze	1157
3470	EN	Sound the horn and overtake with care.	1157
3471	FR	Sonnez la corne et dépassez avec précau on.	1157
3472	RW	Gukomeza iruhande kuko ufite uburenganzira bwo gukomeza	1158
3473	EN	Drive alongside it because you have right-of-way.	1158
3474	FR	Conduisez à côté parce que vous avez le droit de passage.	1158
3475	RW	Gabanya umuvuduko maze ureke ikomeze	1159
3476	EN	Slow down and allow it to move out.	1159
3477	FR	Ralen ssez et laissez-le sor r.	1159
3478	RW	Gerageza unyureho kugirango atagutinza	1160
3479	EN	Try to get pass it to avoid being delayed.	1160
3480	FR	Essayez de le dépasser pour éviter d'être retardé.	1160
3481	RW	Menyesha umuyobozi wa otobisi aguhe inzira	1161
3482	EN	Signal to the bus driver to let you pass	1161
3483	FR	Signalez au chauffeur de bus de vous laisser passer	1161
3484	RW	Mu gihe ikinyabiziga giturutse mu kindi cyerekezo kitagishoboye kugenda	1162
3485	EN	That the oncoming vehicle is broken down.	1162
3486	FR	Que le véhicule venant en sens inverse est en panne.	1162
3487	RW	Mu gihe ikinyabiziga ndakumirwa giturutse mu kindi cyerekezo	1163
3488	EN	That the oncoming vehicle is an emergency vehicle.	1163
3489	FR	Que le véhicule venant en sens inverse est un véhicule d’urgence.	1163
3490	RW	Mu gihe ikinyabiziga giturutse mu cyindi cyerekezo cy’ihuta	1164
3491	EN	The oncoming vehicle is fast moving.	1164
3492	FR	Le véhicule venant en sens inverse se déplace rapidement.	1164
3493	RW	Kugabanya umuvuduko witegura guhagarara	1165
3494	EN	Slow down and be prepared to stop.	1165
3495	FR	Ralentissez et préparez-vous à vous arrêter.	1165
3496	RW	Gukomezanya umuvuduko warufite	1166
3497	EN	Continue at the same pace.	1166
3498	FR	Continuez au même rythme.	1166
3499	RW	Kujya i buryo	1167
3500	EN	Move to the right.	1167
3501	FR	Déplacer vers la droite	1167
3502	RW	Kujya I bumoso	1168
3503	EN	Move to the left.	1168
3504	FR	Déplacer vers la gauche	1168
3505	RW	Kwongera umuvuduko	1169
3506	EN	Increase your speed.	1169
3507	FR	Augmente ta vitesse.	1169
3520	RW	Guca mu isangano nkaho nta bimenyetso bihari, witonde kandi witegereze ibindi binyabiziga	1174
3521	EN	Treat the junction as an unmarked junction and proceed carefully, watching other traffic	1174
3522	FR	Traitez la jonction comme une intersection non marquée et avancez prudemment en surveillant les autres véhicules	1174
3523	RW	Gukomeza gutwara utitaye ku bandi bakoresha umuhanda	1175
3524	EN	Continue driving without caution	1175
3525	FR	Continuer sans prudence	1175
3526	RW	Guhagarara ku masangano no gutegereza amabwiriza	1176
3527	EN	Stop at the junction and wait for instructions	1176
3528	FR	S'arrêter au carrefour et attendre des instructions	1176
3529	RW	Gucana amatara ndanga cyerekezo no gukomeza	1177
3530	EN	Switch on hazard lights and continue	1177
3531	FR	Allumer les feux de détresse et continuer	1177
3532	RW	Kuvuza ihoni kugirango amatungo atambuke	1178
3533	EN	Sound the horn to move the cattle	1178
3534	FR	Sonnez la corne pour faire bouger le bétail	1178
3535	RW	Kugabanya umuvuduko no gutambukana ubwitonzi	1179
3536	EN	Reduce speed and pass carefully	1179
3537	FR	Ralentir et dépasser avec précaution	1179
3538	RW	Kwatsa amatara maremare no kwihuta	1180
3539	EN	Use full headlights and speed through	1180
3540	FR	Allumer les feux de route et passer vite	1180
3541	RW	Kuvuza ihoni no kwihuta	1181
3542	EN	Honk and speed through	1181
3543	FR	Sonnez et passez rapidement	1181
3544	RW	Kugabanya umuvuduko, kuguma iburyo no kwitonda	1182
3545	EN	Reduce speed, keep right and be careful	1182
3546	FR	Ralentir, rester à droite et être prudent	1182
3547	RW	Kanda clutch no kuvuza ihoni	1183
3548	EN	Press clutch and sound horn	1183
3549	FR	Appuyer sur l’embrayage et klaxonner	1183
3550	RW	Gukomeza umuvuduko usanzwe	1184
3551	EN	Maintain normal speed	1184
3552	FR	Maintenir la vitesse normale	1184
3553	RW	Guhagarara hejuru y’umusozi	1185
3554	EN	Stop at the top of the hill	1185
3555	FR	S’arrêter au sommet de la colline	1185
4769	EN	yes	1862
4770	FR	Oui	1862
4771	RW	yego	1862
4772	EN	yes, except for a long journey	1863
4773	FR	Oui, sauf pour un long trajet	1863
4774	RW	yego usibye urugendo rureru	1863
4775	EN	yes, except for a short trip	1864
4776	FR	Oui, sauf pour un court trajet	1864
4777	RW	yego usibye urugendo rugufi	1864
4778	EN	No	1865
4779	FR	Non	1865
4780	RW	Oya	1865
3568	RW	Kuguma mu mwanya we	1190
3569	EN	Keep position and wait	1190
3570	FR	Garder sa position	1190
3571	RW	Kugabanya umuvuduko no gusiga umwanya uhagije	1191
3572	EN	Reduce speed and leave enough space	1191
3573	FR	Ralentir et laisser de l’espace	1191
3574	RW	Gutegereza undi muyobozi	1192
3575	EN	Wait for the other driver to move	1192
3576	FR	Attendre l’autre conducteur	1192
3577	RW	Gutwara hagati mu muhanda	1193
4781	EN	the signal B3	1866
4782	FR	le signal B3	1866
6090	EN	Public service vehicles prohibited.	2313
6091	FR	Véhicules de service public interdits.	2313
6092	RW	Birabujijwe ku binyabiziga bitwara abakozi ba leta	2313
6093	EN	Parking prohibited.	2314
6094	FR	Parking interdit.	2314
6095	RW	Birabujijwe guhagara umwanya munini	2314
6096	EN	Private vehicles prohibited.	2315
6097	FR	Les véhicules privés sont interdits.	2315
6098	RW	Birabujijwe ku binyabiziga by'abikorera ki giti cyabo	2315
6099	EN	Parking permitted.	2316
6100	FR	Parking autorisé.	2316
3578	EN	Drive in the middle of the road	1193
3579	FR	Conduire au milieu de la route	1193
3580	RW	Kwegera cyane	1194
3581	EN	Drive too close	1194
3582	FR	Coller le véhicule	1194
3583	RW	Kuguma inyuma kugira ngo abandi bashobore kunyuraho	1195
3584	EN	Keep well back to allow others to overtake	1195
3585	FR	Garder une distance pour permettre aux autres de dépasser	1195
3586	RW	Kuguma hagati mu muhanda	1196
3587	EN	Stay in the middle of the road	1196
3588	FR	Rester au milieu de la route	1196
3589	RW	Gusaba abandi kunyuraho	1197
3590	EN	Signal others to overtake	1197
3591	FR	Signaler aux autres de dépasser	1197
3592	RW	Gusa iyo ari ngombwa kuburira ibinyabiziga bikurikiye	1198
3593	EN	Only when it is necessary to warn following traffic	1198
3594	FR	Seulement pour avertir la circulation derrière	1198
3595	RW	Gusa iyo ari ngombwa kuburira abaturuka imbere	1199
3596	EN	Only when it is necessary to warn oncoming traffic	1199
3597	FR	Seulement pour avertir la circulation venant en sens inverse	1199
3598	RW	Igihe cyose gikwiye, kugira ngo ubwire abandi bakoresha umuhanda icyo ugiye gukora	1200
3599	EN	At the appropriate time to inform other road users of your intentions	1200
3600	FR	Au bon moment pour informer les autres usagers de la route de vos intentions	1200
3601	RW	Keretse aho ibimenyetso byo mu muhanda bibitegeka ukundi	1201
3602	EN	Except where road signs indicate otherwise	1201
3603	FR	Sauf si la signalisation routière indique autrement	1201
3604	RW	Bigira ingaruka gusa ku baturuka imbere	1202
3605	EN	Only oncoming traffic is affected	1202
3606	FR	Seulement la circulation venant en sens inverse est affectée	1202
3607	RW	Ntibabona igihe gihagije cyo gukora icyo ibimenyetso bivuze	1203
3608	EN	They may not have enough time to react	1203
3609	FR	Ils peuvent ne pas avoir assez de temps pour réagir	1203
3610	RW	Bihora bibaha igihe gihagije	1204
3611	EN	They always have enough time	1204
3612	FR	Ils ont toujours assez de temps	1204
3613	RW	Nta ngaruka bigira	1205
3614	EN	They are not affected	1205
3615	FR	Ils ne sont pas affectés	1205
3616	RW	Kumujyana ku ruhande rw’umuhanda ako kanya	1206
3617	EN	Move the person to the side of the road	1206
3618	FR	Déplacer la personne sur le côté de la route	1206
3619	RW	Kutamukoraho keretse hari ibyago by’umuriro cyangwa gukomeza gukomereka, ugahamagara ubutabazi	1207
3620	EN	Do not move the person unless there is danger (fire or further injury) and call emergency services	1207
3621	FR	Ne pas déplacer la personne sauf danger et appeler les secours	1207
3622	RW	Kumusaba kwinyeganyeza kugira ngo hamenyekane imvune	1208
3623	EN	Ask the injured person to move to check injuries	1208
3624	FR	Demander à la personne de bouger pour vérifier les blessures	1208
3625	RW	Kumuha icyo kunywa gikonje ako kanya	1209
3626	EN	Give them a cold drink immediately	1209
3627	FR	Donner une boisson froide immédiatement	1209
3628	RW	Kugaragaza aho impanuka yabereye no gukura ibinyabiziga mu muhanda	1210
3629	EN	Mark the position and move vehicles off the road	1210
3630	FR	Marquer la position et déplacer les véhicules	1210
3631	RW	Gutegereza polisi gusa	1211
3632	EN	Wait for the police only	1211
3633	FR	Attendre uniquement la police	1211
3634	RW	Kureka ibinyabiziga aho biri	1212
3635	EN	Leave vehicles where they are	1212
3636	FR	Laisser les véhicules sur place	1212
3637	RW	Guhagarika abandi bose gukomeza	1213
3638	EN	Stop all traffic permanently	1213
3639	FR	Arrêter toute circulation	1213
3640	RW	Gutwara yegera umurongo wo hagati w’umuhanda werekana ibumoso	1214
3641	EN	Drive close to the center line indicating left	1214
3642	FR	Rouler près de la ligne médiane en indiquant à gauche	1214
3643	RW	Gutwara yegera uruhande rw’iburyo rw’umuhanda	1215
3644	EN	Drive close to the right-hand side of the road	1215
3645	FR	Rouler près du côté droit de la route	1215
3646	RW	Gutwara yegera uruhande rw’ibumoso rw’umuhanda	1216
3647	EN	Drive close to the left-hand side of the road	1216
3648	FR	Rouler près du côté gauche de la route	1216
3649	RW	Gutwara hagati mu muhanda	1217
3650	EN	Drive in the middle of the road	1217
3651	FR	Rouler au milieu de la route	1217
3652	RW	Uruhande rw’ibumoso rw’umuhanda (uretse igihe utwaye imashini zihinga cyangwa ibindi binyabiziga by’imirimo)	1218
3653	EN	The left-hand lane (except when driving slow works vehicles such as tractors)	1218
3654	FR	La voie de gauche (sauf en conduite de tracteur ou véhicules de chantier)	1218
3655	RW	Guhitamo uruhande urwo ari rwo rwose wishakiye	1219
3656	EN	Any lane of your choice	1219
3657	FR	Sur l'une ou l'autre voie au choix	1219
3658	RW	Uruhande rw’iburyo rw’umuhanda gusa	1220
3659	EN	The right-hand lane only	1220
3660	FR	La voie de droite uniquement	1220
3661	RW	Gukoresha hagati mu muhanda	1221
3662	EN	Drive in the middle of the road	1221
3663	FR	Rouler au milieu de la route	1221
3664	RW	Gukoresha umurongo urimo ibinyabiziga bike	1222
3665	EN	Drive in the lane with the least traffic	1222
3666	FR	Rouler sur la voie la moins fréquentée	1222
3667	RW	Kugendera mu gice cy’ibumoso, keretse ushaka gusohokera iburyo	1223
3668	EN	Drive in the left-hand lane unless you intend to take a right exit	1223
3669	FR	Rouler dans la voie de gauche sauf si vous prenez une sortie à droite	1223
3670	RW	Kugendera mu gice cy’iburyo gusa keretse ushaka kunyuranaho	1224
3671	EN	Drive in the right-hand lane unless overtaking	1224
3672	FR	Rouler dans la voie de droite sauf pour dépasser	1224
3673	RW	Ntugakoreshe igice cy’iburyo kuko kigenewe ibinyabiziga biremereye gusa	1225
3674	EN	Do not use the right-hand lane because it is reserved for heavy vehicles only	1225
3675	FR	Ne pas utiliser la voie de droite car elle est réservée aux poids lourds	1225
3676	RW	Kwinjira mu masangano utitaye ku bandi bakoresha umuhanda	1226
3677	EN	Drive onto the roundabout without giving way	1226
3678	FR	Entrer dans le rond-point sans céder le passage	1226
3679	RW	Gutanga inzira gusa ku binyabiziga biremereye	1227
3680	EN	Give way only to heavy goods vehicles	1227
3681	FR	Céder le passage uniquement aux poids lourds	1227
3682	RW	Gutanga inzira gusa niba ugiye gusohokera ku isohoka rya kabiri cyangwa rya gatatu	1228
3683	EN	Give way only if taking the second or third exit	1228
3684	FR	Céder le passage seulement si vous prenez la deuxième ou troisième sortie	1228
3685	RW	Gutanga inzira ku binyabiziga byamaze kwinjira mu masangano azenguruka	1229
3686	EN	Give way to traffic already on the roundabout	1229
3687	FR	Céder le passage à la circulation déjà engagée dans le rond-point	1229
3688	RW	Ibumoso gusa	1230
3689	EN	To the left only	1230
3690	FR	À gauche uniquement	1230
3691	RW	Ibumoso gusa igihe ayobowe n’amatara y’umuhanda	1231
3692	EN	To the left only when controlled by traffic lights	1231
3693	FR	À gauche uniquement sous contrôle des feux de circulation	1231
3694	RW	Ibumoso cyangwa iburyo	1232
3695	EN	To the right or left	1232
3696	FR	À droite ou à gauche	1232
3697	RW	Iburyo gusa	1233
3698	EN	To the right only	1233
3699	FR	À droite uniquement	1233
6101	RW	Parikingi	2316
3716	RW	kunyuranaho ibumoso	1242
3717	RW	gutegereza wihanganye	1243
3718	RW	gukomeza vuba	1244
3719	RW	nta gisubizo	1245
3720	RW	kugabanya umuvuduko no gukomeza witonze	1246
3721	RW	gukomeza vuba	1247
3722	RW	kuvuza ihoni	1248
3723	RW	ibisubizo byose	1249
3724	RW	icyemezo cy’iyandikwa ry’ikinyabiziga	1250
3725	RW	inyemezabwishyu y’umusoro	1251
3726	RW	ubwishingizi	1252
3727	RW	ibisubizo byose	1253
3728	RW	biremewe mu bikorera	1254
3729	RW	biremewe nijoro	1255
3730	RW	birabujijwe ku binyabiziga byose bifite moteri	1256
3731	RW	ibisubizo byose	1257
3732	RW	ahamanuka	1258
3733	RW	igihe umuhanda ari mugari	1259
3734	RW	igihe umuyobozi w’imbere amweretse ikimenyetso	1260
3735	RW	nta gisubizo	1261
3736	RW	kuvuza ihoni	1262
3737	RW	gutegereza wihanganye	1263
3738	RW	gukomeza	1264
3739	RW	nta gisubizo	1265
3740	RW	gukuramo uwawe	1266
3741	RW	kwirengagiza	1267
3742	RW	gukomeza kuwukaza	1268
3743	RW	kubibutsa kuwambara	1269
3744	RW	kuvuza ihoni	1270
3745	RW	kugenda buhoro no kwitonda	1271
3746	RW	nta bwitonzi bukenewe	1272
3747	RW	ibisubizo byose	1273
3748	RW	igomba kuba ifunze	1274
3749	RW	umushoferi agomba kuba yicaye	1275
3750	RW	amatara yo guhagarara aguma yaka	1276
3751	RW	ibisubizo byose ni ukuri	1277
3752	RW	Ntugomba kunyuraho ikindi kinyabiziga	1278
3753	RW	Ugomba kunyura ku kindi kinyabiziga	1279
3754	RW	Kunyura uvugije ihoni	1280
3755	RW	Nta gisubizo cy’ukuri	1281
3756	RW	Kucyinyuraho ibumoso	1282
3757	RW	Kucyinyuraho iburyo	1283
3758	RW	Kunyuraho ku ruhande urwo arirwo rwose	1284
3759	RW	Ibisubizo byose	1285
3760	RW	Guhagarara kw’ikinyabiziga	1286
3761	RW	Aho abanyamaguru bambukira	1287
3762	RW	Guha icyerekezo ibinyabiziga	1288
3763	RW	Ibisubizo byose	1289
3764	RW	Kwireba	1290
3765	RW	Kureba ibinyabiziga biri inyuma	1291
3766	RW	Kureba abagenzi bicaye inyuma	1292
3767	RW	Nta gisubizo cy’ukuri	1293
3768	RW	Ingaruka ku binyabiziga	1294
3769	RW	Ingaruka ku bandi bakoresha umuhanda	1295
3770	RW	Ntibagaragara neza ku binyabiziga biri kure	1296
3771	RW	Ibisubizo byose ni ukuri	1297
3772	RW	Biremewe	1298
3773	RW	Ntibyemewe	1299
3774	RW	Biremewe ukoranye ubwitonzi	1300
3775	RW	Ibisubizo byose	1301
3776	RW	Gufungura idirishya gusa	1302
3777	RW	Guhagarara ukaruhuka	1303
3778	RW	Kunanura amaboko gusa	1304
3779	RW	Kongera ubushyuhe mu modoka	1305
3780	RW	Kugendera ku ruhande rw’umuhanda	1306
3781	RW	Kugabanya umuvuduko no gukoresha amatara y’ibyerekezo	1307
3782	RW	Gukoresha amatara yose gusa	1308
3783	RW	Kugendera hagati mu muhanda	1309
3784	RW	Urukiramende rufite umuhondo	1310
3785	RW	Mpande eshatu z’ubururu	1311
3786	RW	Mpande enye z’umukara	1312
3787	RW	Uruziga rufite umutuku	1313
3788	RW	Gukata ibumoso gusa	1314
3789	RW	Gukata iburyo gusa	1315
3790	RW	Guhagarara ku murongo wo guhagarara	1316
3791	RW	Gukomeza imbere gusa	1317
3792	RW	100 m	1318
3793	RW	200 m	1319
3794	RW	150 m	1320
3795	RW	250 m	1321
3796	RW	Iyo ushaka kunyura ku kindi kinyabiziga	1322
3797	RW	Gukatira ibumoso	1323
3798	RW	Guhindukira cyangwa kujya mu kindi gice cy’umuhanda	1324
3799	RW	Ibisubizo byose	1325
3800	RW	Inzira y’abanyamaguru	1326
3801	RW	Agahanda k’amagare	1327
3802	RW	Byombi A na B	1328
3803	RW	Nta gisubizo	1329
3804	RW	Uruziga rutukura	1330
3805	RW	Mpandeshatu itukura ifite ubuso bwera n’ikirango cy’umukara	1331
3806	RW	Mpandeshatu y’ubururu	1332
3807	RW	Uruziga rw’ubururu	1333
3808	RW	Ikinyabiziga kimwe	1334
3809	RW	Ibirenze bibiri bipakiye	1335
3810	RW	Ibirenze bibiri	1336
3811	RW	Byombi B na C	1337
3816	RW	Gutambuka mbere kw’ibinyabiziga biturutse imbere	1342
3817	RW	Guhagarara gusa	1343
3818	RW	Byombi A na B	1344
3819	RW	Nta gisubizo	1345
3820	RW	Umutuku	1346
3821	RW	Ubururu	1347
3822	RW	umweru	1348
3823	RW	Nta gisubizo	1349
3824	RW	Iherezo ry’uburenganzira bwo gutambuka mbere	1350
3825	RW	Gutambuka mbere ku binyabiziga byose	1351
3826	RW	Byombi A na B	1352
3827	RW	Nta gisubizo	1353
3828	RW	Mpandeshatu ifite ubururu	1354
3829	RW	Mpandeshatu ifite umukara	1355
3830	RW	Mpandeshatu ifite umweru	1356
3831	RW	Nta gisubizo	1357
3836	RW	kwegera i ruhande rw'iburyo bw'umuhanda	1362
3837	RW	kongera umuvuduko	1363
3838	RW	guhagarara	1364
3839	RW	a na c ni byo bisubizo by'ukuri	1365
3840	RW	ifungana ry’umuhanda	1366
3841	RW	ifungana ry’umuhanda n’akayira gasa ra umuhanda ibumoso	1367
3842	RW	umuhanda utaringaniye	1368
3843	RW	nta gisubizo cy’ukuri kirimo	1369
3844	RW	ntihanyurwa mu byerekezo byombi	1370
3845	RW	ntihanyurwa n’abandi uretse abahatuye	1371
3846	RW	hanyurwa mu cyerekezo kimwe gusa	1372
3847	RW	nta gisubizo cy’ukuri kirimo	1373
3848	RW	ifungana ry’umuhanda	1374
3849	RW	umuhanda unyerera	1375
3850	RW	umuhanda utaringaniye	1376
3851	RW	nta gisubizo cy’ukuri kirimo	1377
3852	RW	ikoni iburyo	1378
3853	RW	akazamuko gashinze cyane	1379
3854	RW	akamanuko gashobora gutera ibyago	1380
3855	RW	b na c byose ni ukuri	1381
3856	RW	kugendera mu gisate cy’iburyo	1382
3857	RW	kunyuranaho	1383
3858	RW	kugendera mu gisate cy’ibumoso	1384
3859	RW	ibisubizo byose ni byo	1385
3860	RW	ishusho y’uruziga mw’ibara ritukura, ubuso bwera n’ikirango cy’umukara	1386
3861	RW	ishusho ya mpandeshatu mw’ibara ritukura, ubuso bwera n’ikirango cy’umukara	1387
3862	RW	ishusho ya mpandeshatu mw’ibara ritukura, ubuso bw’ubururu n’ikirango cy’umukara	1388
3863	RW	ishusho y’uruziga mw’ibara ritukura, ubuso bw’ubururu n’ikirango cy’umukara	1389
3864	RW	uruziga mu buso bw’ubururu, ishusho y’inka mu ibara ry’umukara	1390
3865	RW	uruziga mu ibara ryera, ishusho y’inka mu ibara ry’ubururu	1391
3866	RW	uruziga mu buso bw’ibara ry’ubururu, ishusho y’inka mu ibara ryera n’ikirango cy’umukara	1392
3867	RW	mpande eshatu mu buso bw’ibara ry’umweru n’ishusho y’inka mu ibara ry’umukara	1393
3868	RW	ishusho y’uruziga, ubuso bw’ubururu, ikiranga cy’umukara	1394
3869	RW	ishusho y’uruziga, ubuso bw’ubururu, ikiranga cy’umweru	1395
3870	RW	ishusho y’uruziga, ubuso bw’umweru, ikiranga cy’umukara	1396
3871	RW	ntagisubizo cy’ukuri kirimo	1397
3872	RW	ishusho mpandeshatu mw’ibara ritukura, ubuso bwera n’ikiranga mu ibara ry’umukara	1398
3873	RW	ishusho mpandeshatu mw’ibara ritukura, ubuso bw’ubururu n’ikiranga mu ibara ry’umukara	1399
3874	RW	ishusho y’uruziga mw’ibara ritukura, ubuso bw’ubururu n’ikiranga mu ibara ry’umukara	1400
3875	RW	ishusho y’uruziga mw’ibara ritukura, ubuso bwera n’ikiranga mu ibara ry’umukara	1401
3876	RW	ishusho mpandeshatu mw’ibara ritukura, ubuso bwera n’ikiranga mu ibara ry’umukara	1402
3877	RW	ishusho mpandeshatu mw’ibara ritukura, ubuso bw’ubururu n’ikiranga mu ibara ry’umukara	1403
3878	RW	ishusho y’uruziga mw’ibara ritukura, ubuso bw’ubururu n’ikiranga mu ibara ry’umukara	1404
3879	RW	ishusho y’uruziga mw’ibara ritukura, ubuso bwera n’ikiranga mu ibara ry’umukara	1405
3880	RW	Mu masangano	1406
3881	RW	Mu bimenyetso bimurika	1407
3882	RW	A na b ni ibisubizo by’ukuri	1408
3883	RW	Nta gisubizo cy’ukuri kirimo	1409
3884	RW	Ko hari icyago	1410
3885	RW	Icyago kidasobanuye ukundi	1411
3886	RW	Imiterere y’icyago gitunguranye	1412
3887	RW	Nta gisubizo cy’ukuri kirimo	1413
3888	RW	Ibitegetswe byihariye gusa	1414
3889	RW	Ubugabanyirizwa cyangwa amarengamategeko rusange cyangwa ibibujijwe ndetse n’ibitegetswe byihariye	1415
3890	RW	A na b ni ibisubizo by’ukuri	1416
3891	RW	Nta gisubizo cy’ukuri kirimo	1417
3892	RW	Mpandeshatu	1418
3893	RW	Uruziga	1419
3894	RW	Urukiramende	1420
3895	RW	Nta gisubizo cy’ukuri kirimo	1421
3896	RW	umweru	1422
3897	RW	umutuku	1423
3898	RW	ubururu n’ikirango cy’umweru	1424
3899	RW	umukara	1425
3900	RW	Ku bakoresha umuhanda bamuturutse imbere	1426
3901	RW	Ku bakoresha umuhanda bose bamuturutse imbere n’inyuma	1427
3902	RW	Ku bakoresha umuhanda bose bamuturutse inyuma	1428
3903	RW	Nta gisubizo cy’ukuri kirimo	1429
3904	RW	Yego	1430
3905	RW	Yego, iyo ufite umuvuduko wa 90km/h	1431
3906	RW	Oya	1432
3907	RW	Nta gisubizo cy’ukuri	1433
3908	RW	Yego	1434
3909	RW	Oya	1435
3910	RW	Yego, ariko bikorewe ibumoso	1436
3911	RW	Nta gisubizo cy’ukuri	1437
3912	RW	Kirambuza gutwara ku muvuduko utarengeje 5km/h	1438
3913	RW	Ntaburenganzira kimpa, mugihe gikurikizwa ku binyabiziga bifite hejuru ya toni 5	1439
3914	RW	Ntacyo bindebaho mugihe bireba gusa zipima toni 5 no kurengaho	1440
3915	RW	Nta gisubizo cy’ukuri kirimo	1441
3916	RW	Yego	1442
3917	RW	Yego, ariko nyuma yo guhagarara	1443
3918	RW	Ntabwo byemewe	1444
3919	RW	Nta gisubizo cy’ukuri kirimo	1445
3920	RW	Nshobora gukomeza nkambuka umuhanda kubera ko uruziro rufunguye	1446
3921	RW	Ngomba guhagarara munsi y’itara ry’umutuku rimyatsa	1447
3922	RW	Ntabwo nakomeza urugendo rwanjye. Ngomba guhita mpagarara	1448
3923	RW	Nta gisubizo cy’ukuri	1449
3924	RW	Kugendera ku muvuduko uri hejuru ya 30km/h	1450
3925	RW	Kutarenza umuvuduko wa 30km/h	1451
3926	RW	Birabujijwe kugendera ku muvuduko uri hejuru ya 30km/h	1452
3927	RW	Nta gisubizo cy’ukuri	1453
3928	RW	Nshobora gukata iburyo	1454
3929	RW	Nshobora gukata ibumoso	1455
3930	RW	Nshobora gukata ibumoso cyangwa iburyo	1456
3931	RW	Nta gisubizo cy’ukuri kirimo	1457
3932	RW	Guhagarara igihe gito kuri iki cyapa cy’umuhanda	1458
3933	RW	Guhagarara ngatanga inzira kuri metero 100 ntaragera kuri iki cyapa	1459
3934	RW	Gutanga inzira nkanahagarara iyo ari ngombwa muri m100 ntaragera kuri iki cyapa	1460
3935	RW	Nta gisubizo cy’ukuri	1461
3936	RW	Mfite uburenganzira bwo gutambuka mbere	1462
3937	RW	Imodoka y’icyatsi ifite uburenganzira bwo gutambuka mbere	1463
3938	RW	Twembi nta burenganzira bwo gutambuka mbere gusa tugomba gutambukana ubwitonzi	1464
3939	RW	Nta gisubizo na kimwe kirimo	1465
3940	RW	Yego, niba ukata ibumoso	1466
3941	RW	Oya niba ukata iburyo	1467
3942	RW	Yego, bitewe n’aho ngana	1468
3943	RW	Nta gisubizo cy’ukuri kirimo	1469
3944	RW	Oya	1470
3945	RW	Yego, nshobora gukata iburyo	1471
3946	RW	Yego, nshobora gukata ibumoso cyangwa iburyo	1472
3947	RW	Yego, nshobora gukata ibumoso gusa	1473
3948	RW	Nshobora kumunyuraho nyuze iburyo	1474
3949	RW	Sinshobora kumunyura	1475
3950	RW	Nshobora kumunyura nciye ibumoso ariko mbonye ko mfite umwanya uhagije	1476
3951	RW	Nta gisubizo cy’ukuri kirimo	1477
3952	RW	Kunyuranaho ku binyabiziga bikururwa n’ibinyabiziga birengeje imitende ibiri ibumoso no kugendera ku muvuduko urengeje 70 km/h	1478
3953	RW	Kunyuranaho ku binyabiziga bikururwa cyangwa ibinyabiziga birengeje imitende ibiri ibumoso	1479
3954	RW	Kugendera hejuru ya 70 km/h	1480
3955	RW	Nta gisubizo cy’ukuri kirimo	1481
3956	RW	Kunyuranaho kubinyabiziga bikururwa nibinyabiziga birengije imitende ibiri ibumoso no kugendera kumuvuduko urengeje 70 km/h	1482
3957	RW	Kunyuranaho kubinyabiziga bikururwa cyangwa ibinyabiziga birengije imitende ibiri ibumoso	1483
3958	RW	kugendera hejuru ya 70 km/h	1484
3959	RW	ntagisubizo cy’ukuri	1485
3960	RW	beremewe munsi yicyi cyapa	1486
3961	RW	beremewe imbere y’icyi cyapa	1487
3962	RW	birabujijwe imbere n’inuma yicyi cyapa	1488
3963	RW	ntagisubizo cy’ukuri	1489
3964	RW	Guhagarara, aho abanyeshuri bambukira	1490
3965	RW	Hagarara akanya gato	1491
3966	RW	Ibindi binyabiziga bigomba kuguha inzira	1492
3967	RW	Gutanga umwanya ku bindi binyabiziga i buryo bwawe	1493
3968	RW	Tanga inzira ku binyabiziga binini	1494
3969	RW	Gabanya umuvuduko uhe inzira abanyamaguru	1495
3970	RW	Tanga inzira ku binyabiziga bigenda mu muhanda munini wegera	1496
3971	RW	Tanga inzira ku ibinyabiziga biturutse iburyo bwawe	1497
3972	RW	Tanga inzira ku binyabiziga biri mu muhanda munini	1498
3973	RW	Tanga inzira ku binyabiziga biturutse iburyo	1499
3974	RW	Tanga inzira ku ma kamyo na za otobisi	1500
3975	RW	Ibinyabiziga byose uretse amapikipiki bigomba gutanga inzira	1501
3976	RW	Komeza imbere gusa	1502
3977	RW	Aho kunyuranaho imbere	1503
3978	RW	Aho guhagarara umwanya munini	1504
3979	RW	Inzira y’ icyerekezo kimwe	1505
4412	EN	No car	1743
3980	RW	Umuhanda urombereje w’ibice byinshi ibumoso	1506
3981	RW	Umuhanda uyoborejwe i bumoso	1507
3982	RW	Ibinyabiziga biturutse iburyo bifite uburenganzira bwo gutambuka mbere	1508
3983	RW	Kata i bumoso gusa	1509
3984	RW	Kunyuranaho bikorerwa i buryo gusa	1510
3985	RW	Umuhanda uyoborejwe i buryo	1511
3986	RW	Kata i buryo gusa	1512
3987	RW	Umuhanda munini urasukira i bumoso	1513
6114	EN	Parking area for cyclists ahead.	2321
6115	FR	Parking pour les cyclistes devant nous.	2321
4783	RW	Icyapa B3	1866
4784	EN	the signal A22a	1867
4785	FR	le signal A22a	1867
4786	RW	Icyapa A22 a	1867
4787	EN	the signal A20	1868
4788	FR	le signal A20	1868
4789	RW	Icyapa A20	1868
4790	EN	all the answers are correct	1869
4791	FR	Toutes les réponses sont justes	1869
4792	RW	Ibisubizo byose ni ukuri	1869
4927	RW	Atarenze umurongo wera ucagaguye	1914
4928	EN	By crossing the broken white line	1915
4929	FR	En franchissant la ligne blanche brisée	1915
4930	RW	Arenze umurongo wera ucagaguye	1915
4931	EN	By not crossing any of the lines	1916
4932	FR	En ne traversant aucune des lignes	1916
4933	RW	Nta kurenga iyi mirongo yombi	1916
4994	EN	Car 1 is in the correct posi on to make the right turn.	1937
4995	FR	La voiture 1 est dans la bonne posi on pour effectuer le virage à droite.	1937
4996	RW	Ikinyabiziga cya mbere kiri mu buryo bwiza bwo gukata ikoni ry’iburyo	1937
4997	EN	Car 2 is in the correct posi on to make the right turn.	1938
4998	FR	La voiture 2 est dans la bonne posi on pour effectuer le virage à droite.	1938
4999	RW	Ikinyabiziga cya kabiri kiri mu buryo bwiza bwo gukata ikoni ry’iburyo	1938
5000	EN	Car 3 is in the correct posi on to make the right turn.	1939
5001	FR	La voiture 3 est dans la bonne posi on pour effectuer le virage à droite.	1939
5002	RW	Ikinyabiziga cya gatatu kiri mu buryo bwiza bwo gukata ikoni ry’iburyo	1939
5003	EN	Car 4 is in the correct posi on to make the right turn.	1940
5004	FR	La voiture 4 est dans la bonne posi on pour effectuer le virage à droite.	1940
5005	RW	Ikinyabiziga cya kane kiri mu buryo bwiza bwo gukata ikoni ry’iburyo	1940
5006	EN	It is prohibited to every driver to cross it.	1941
5007	FR	Interdit à tout conducteur de la franchir	1941
5008	RW	Umuyobozi wese abujijwe kuwurenga	1941
5009	EN	Motorcyclists can overtake.	1942
5010	FR	Les motocyclistes peuvent dépasser.	1942
5011	RW	Abanyamitende bemerewe kunyuranaho	1942
5012	EN	Parking allowed	1943
5013	FR	Parking autorisé	1943
5014	RW	Kuhahagara biremewe	1943
5015	EN	U-turn allowed during daylight hours.	1944
5016	FR	Demi-tour permis pendant la journée.	1944
5017	RW	Guhindukira ku manywa	1944
6116	RW	Aho guhagararwamo n'abanyamagare imbere	2321
6117	EN	Area reserved for children learning to ride bicycles.	2322
6118	FR	Zone réservée aux enfants qui apprennent à faire du vélo.	2322
6119	RW	Aho abana bagenewe kwiga gutwara amagare	2322
6120	EN	Shared cycle/pedestrian track.	2323
6121	FR	piste cyclable / piétonne partagée.	2323
6122	RW	Inzira y'iminyamitende n'abanyamaguru itegetswe	2323
5042	EN	Accelerate hard	1953
5043	FR	Accélérer fortement	1953
5044	RW	Kongera umuvuduko	1953
5045	EN	Maintain speed	1954
5046	FR	Maintenir la vitesse	1954
5047	RW	Kugumana umuvuduko wari uriho	1954
5048	EN	Be ready to stop	1955
5049	FR	Être prêt à s’arrêter	1955
5050	RW	Kwitegura guhagarara	1955
5051	EN	Brake hard	1956
5052	FR	Freiner fortement	1956
5053	RW	Gufata feri cyane	1956
5067	FR	Dépassement seulement, ne jamais tourner à droite	1961
5068	RW	Kunyuranaho gusa, ntugarukure iburyo bwawe	1961
5069	EN	Overtaking or turning left	1962
5070	FR	Dépassement ou tourner à gauche	1962
5071	RW	Kunyuranaho cyangwa kugana ibumoso	1962
5072	EN	Fast-moving traffic only	1963
5073	FR	Circulation rapide seulement	1963
5074	RW	Hemerewe kugenda imodoka zihuta gusa	1963
5075	EN	Turning right only, never overtaking	1964
5076	FR	Tourner à droite seulement, ne pas dépasser	1964
5077	RW	Kugana iburyo gusa utanyuranaho	1964
5078	EN	Option A	1965
5079	FR	Option A	1965
5080	RW	Shusho A	1965
5081	EN	Option B	1966
5082	FR	Option B	1966
5083	RW	Shusho B	1966
5084	EN	Circular shape	1967
5085	FR	Forme circulaire	1967
5086	RW	Shusho C (umuzenguruko/circle)	1967
5087	EN	Option D	1968
5088	FR	Option D	1968
5089	RW	Shusho D	1968
5090	EN	Minimum speed 30 km/h	1969
5091	FR	Vitesse minimale 30 km/h	1969
5092	RW	Umuvuduko ntarengwa 30 km/h	1969
5093	EN	End of compulsory maximum speed limit	1970
5094	FR	Fin de vitesse maximale obligatoire	1970
5095	RW	Iherezo ry’umuvuduko ntarengwa utegetswe	1970
5096	EN	End of minimum speed	1971
5097	FR	Fin de vitesse minimale	1971
5098	RW	Iherezo ry’umuvuduko muto utegetswe	1971
5099	EN	Maximum speed 30 km/h	1972
5100	FR	Vitesse maximale 30 km/h	1972
5101	RW	Umuvuduko uri hejuru 30 km/h	1972
6123	EN	Cyclists must dismount and walk.	2324
6124	FR	Les cyclists doivent descendre et marcher.	2324
6125	RW	Abanyamagare bagomba kuva ku igare bakagendesha amaguru	2324
6138	EN	Maximum permitted weight is 3 tonnes.	2329
6139	FR	Le poids maximum autorisé est de 3 tonnes.	2329
6140	RW	Uburemere ntarengwa bwemewe bwa toni 3	2329
6141	EN	No entry for vehicles carrying goods.	2330
6142	FR	Aucune inscription pour les véhicules transportant des marchandises.	2330
6143	RW	Ntihanyurwa n'ibinyabiziga bigenewe gutwara ibicuruzwa	2330
6144	EN	3 axled vehicles not permitted.	2331
6145	FR	Véhicules à 3 essieux non autorisés.	2331
6146	RW	Ntihanyurwa n'ibinyabiziga bifite imitambiko itatu	2331
6147	EN	Only 3 axled vehicles are permitted.	2332
6148	FR	Seuls les véhicules à 3 essieux sont autorisés.	2332
6149	RW	Hanyurwa n'ibinyabiziga bifite imitambiko itatu gusa	2332
4140	RW	Umuyobozi ashobora kurenga umurongo wera udacagaguye mugihe cyo guhindukira gusa	1618
4141	RW	Umuyobozi w’ikinyabiziga abujijwe kunyuranaho, uretse gusa abayobozi b’ibinyamitende nibo bashobora kurenga umurongo wera udacagaguye	1619
4142	RW	Umuyobozi w’ikinyabiziga abujijwe kunyuranaho arenze umurongo wera udacagaguye	1620
4143	RW	Umuyobozi w’ikinyabiziga ashobora kunyurana mu gihe bitateza icyago	1621
4144	RW	Umuyobozi abujijwe kurenga umurongo wera ucagaguye cyeretse mugihe bitateza icyago	1622
4145	RW	Birabujijwe kunyuranaho	1623
4146	RW	Biremewe kunyuranaho ariko nturenge umurongo wera ucagaguye	1624
4147	RW	Birabujijwe gusubira inyuma	1625
4148	RW	Biremewe kunyuranaho	1626
4149	RW	Umuyobozi abujijwe kukirenga	1627
4150	RW	Wegereye icyapa cyo guhagarara umwanya	1628
4151	RW	Umuhanda ufunganye	1629
4164	RW	Umuyobozi w’ikinyabiziga ashobora kunyurana arenze umurongo wera udacagaguye	1642
4165	RW	Umuyobozi w’ikinyabiziga abujijwe kunyuranaho arenze imirongo yera	1643
4166	RW	Umuyobozi w’ikinyabiziga yemerewe kunyuranaho	1644
4167	RW	Abayobozi b’ibinyamitende gusa bemerewe kunyuranaho barenze umurongo wera udacagaguye	1645
4180	EN	The vehicle may be slow or extra wide	1650
4181	FR	Le véhicule peut être lent ou très large	1650
4182	RW	Hashobora kuba ikinyabiziga gitinda cyangwa gifite ubunini burenze	1650
4183	EN	It is an emergency vehicle	1651
4184	FR	C’est un véhicule d’urgence	1651
4185	RW	Ni ikinyabiziga cy’ubutabazi	1651
4186	EN	It is broken down	1652
4187	FR	En panne	1652
4188	RW	Cyangiritse	1652
4189	EN	It is fast moving	1653
4190	FR	Elle roule vite	1653
4191	RW	Kiragenda cyane	1653
4204	RW	Icyapa D1a	1658
4205	RW	Icyapa E13a	1659
4206	RW	Icyapa C19	1660
4207	RW	Icyapa C1	1661
4213	RW	Aho banyura bazengurutse	1666
4214	RW	Cyerekana umuhanda w'ibisate bitatu	1667
4215	RW	Cyerekana ahegereye inkomane	1668
4216	RW	Ntagisuzo cy’ukuri kirimo	1669
4217	RW	Icyapa B6	1670
4218	RW	Icyapa A19	1671
4219	RW	Icyapa B3	1672
4220	RW	Icyapa A22a	1673
4225	RW	Birabujijwe guhindukira	1678
4226	RW	Birabijijwe gusubira inyuma	1679
4227	RW	Umuhanda unyerera imbere	1680
4228	RW	N byemewe kugendera mu byerekezo byombi	1681
4229	EN	Sign A	1682
4230	FR	Panneau A	1682
4231	RW	Icyapa A	1682
4232	EN	Sign B	1683
4233	FR	Panneau B	1683
4234	RW	Icyapa B	1683
4235	EN	Sign C	1684
4236	FR	Panneau C	1684
4237	RW	Icyapa C	1684
4238	EN	Sign D	1685
4239	FR	Panneau D	1685
4240	RW	Icyapa D	1685
4241	EN	End of all local restrictions on moving vehicles	1686
4242	FR	Fin de toutes les interdictions locales imposées aux véhicules en mouvement	1686
4243	RW	Iherezo ry’ibibuzwa byose mu karere ku binyabiziga bigenda	1686
4244	EN	No parking	1687
4245	FR	Stationnement interdit	1687
4246	RW	Birabujijwe kuhahagarara	1687
4247	EN	Speed limit applies	1688
4248	FR	Limite de vitesse	1688
4249	RW	Umuvuduko ntarengwa wemewe	1688
4250	EN	None of the answers is correct	1689
4251	FR	Aucune réponse correcte	1689
4252	RW	Nta gisubizo cy’ukuri kirimo	1689
4253	EN	Priority road	1690
4254	FR	Priorité de passage	1690
4255	RW	Uburenganzira bwo gutambuka mbere	1690
4256	EN	No motor vehicles	1691
4257	FR	Interdiction des véhicules motorisés	1691
4258	RW	Nta binyabiziga bifite moteri	1691
4259	EN	Two-way traffic	1692
4260	FR	Double sens de circulation	1692
4261	RW	Ibyerekezo bibiri by’umuhanda	1692
4262	EN	No overtaking	1693
4263	FR	Interdiction de dépasser	1693
4264	RW	Birabujijwe kunyuranaho	1693
4277	EN	Ring road	1698
4278	FR	Route de contournement	1698
4279	RW	Umuhanda uzenguruka	1698
4280	EN	Mini-roundabout	1699
4281	FR	Mini rond-point	1699
4282	RW	Igice cy’umuhanda uzenguruka	1699
4283	EN	Roundabout	1700
4284	FR	Sens giratoire	1700
4285	RW	Aho banyura bazengurutse	1700
4286	EN	All answers are correct	1701
4287	FR	Toutes les réponses sont correctes	1701
4288	RW	Ibisubizo byose nibyo	1701
4301	EN	Hump bridge	1706
4302	FR	Pont irrégulier	1706
4303	RW	Iteme ridahoraho	1706
4304	EN	Irregular surface	1707
4305	FR	Profil irrégulier	1707
4306	RW	Umuhanda utaringaniye	1707
4307	EN	Entrance to tunnel	1708
4308	FR	Entrée du tunnel	1708
4309	RW	Umuhanda w’injira mu kuzimu	1708
4310	EN	Soft verges	1709
4311	FR	Doux bords	1709
4312	RW	Ubutaka bworoshye	1709
4313	EN	Lateral winds	1710
4314	FR	Vent latéral	1710
4315	RW	Umuyaga w’intambike	1710
4316	EN	Road noise	1711
4317	FR	Bruit de la route	1711
4318	RW	Urusaku rwo mu muhanda	1711
4319	EN	Airport	1712
4320	FR	Aéroport	1712
4321	RW	Ikibuga cy’indege	1712
4322	EN	All answers are correct	1713
4323	FR	Toutes les réponses sont correctes	1713
4324	RW	Ibisubizo byose nibyo	1713
4349	EN	End of two-way road	1722
4350	FR	Fin de route à deux voies	1722
4351	RW	Iherezo ry’umuhanda w’ibyerekezo bibiri	1722
4352	EN	Tall bridge	1723
4353	FR	Grand pont	1723
4354	RW	Iteme rinini kandi rirerire	1723
4355	EN	Narrowing road	1724
4356	FR	Rétrécissement de la chaussée	1724
4357	RW	Ifungana ry’umuhanda	1724
4358	EN	End of narrow bridge	1725
4359	FR	Bout de pont étroit	1725
4360	RW	Iherezo ry’iteme rifunganye	1725
4361	EN	T-junction	1726
4362	FR	Jonction en T	1726
4363	RW	Isangano rifite ishusho ya T	1726
4364	EN	No through road	1727
4365	FR	Voie sans issue	1727
4366	RW	Inzira idakomeza	1727
4367	EN	Telephone box ahead	1728
4368	FR	Cabine téléphonique	1728
4369	RW	Aho baterefonera	1728
4370	EN	None of the answers is correct	1729
4371	FR	Aucune réponse correcte	1729
4372	RW	Nta gisubizo cy’ukuri	1729
4373	EN	School crossing patrol	1730
4374	FR	Patrouille scolaire	1730
4375	RW	Inzira y’abanyeshuri	1730
4376	EN	No pedestrian allowed	1731
4377	FR	Piétons interdits	1731
4378	RW	Abanyamaguru ntibemerewe	1731
4379	EN	Pedestrian zone no vehicles	1732
4380	FR	Zone piétonne	1732
4381	RW	Agace k’abanyamaguru nta binyabiziga	1732
4382	EN	Approaching a zebra crossing	1733
4383	FR	Annonce d’un passage piéton	1733
4384	RW	Hegereye aho abanyamaguru bambukira	1733
4385	EN	Stop only if traffic is approaching	1734
4386	FR	S’arrêter seulement si le trafic approche	1734
4387	RW	Guhagarara gusa igihe ibinyabiziga bikwegereye	1734
4388	EN	Stop even if the road is clear	1735
4389	FR	S’arrêter même si la route est dégagée	1735
4390	RW	Guhagarara niyo nta kinyabiziga ubona	1735
4391	EN	Stop only if children are waiting	1736
4392	FR	S’arrêter seulement si des enfants attendent	1736
4393	RW	Guhagarara gusa niba hari abana	1736
4394	EN	Stop only if red light is on	1737
4395	FR	S’arrêter seulement si le feu rouge est allumé	1737
4396	RW	Guhagarara gusa iyo itara ritukura ryaka	1737
4397	EN	Approaching a quay, river bank or ferry	1738
4398	FR	Approche d’un quai ou d’un bac	1738
4399	RW	Uguhinguka ku mwaro cyangwa ku nkombe cyangwa icyambu	1738
4400	EN	Steep hill	1739
4401	FR	Colline escarpée	1739
4402	RW	Umusozi ucuramye	1739
4403	EN	Uneven road	1740
4404	FR	Route inégale	1740
4405	RW	Umuhanda utaringaniye	1740
4406	EN	Flooded road	1741
4407	FR	Route inondée	1741
4408	RW	Umuhanda wuzuye amazi	1741
4409	EN	Motorcycles only	1742
4410	FR	Cyclomoteurs seulement	1742
4411	RW	Hanyurwa na velomoteri gusa	1742
4413	FR	Pas de véhicule	1743
4414	RW	Nta modoka	1743
4415	EN	Cars only	1744
4416	FR	Véhicules seulement	1744
4417	RW	Hanyurwa n’imodoka gusa	1744
4418	EN	No motorcycles	1745
4419	FR	Motocyclettes interdites	1745
4420	RW	Nta mapikipiki	1745
4421	EN	Inverted triangle	1746
4422	FR	Triangle inversé	1746
4423	RW	Imirambararo (triangle ihindukiye)	1746
4424	EN	Circle	1747
4425	FR	Cercle	1747
4426	RW	Uruziga	1747
4427	EN	Black circle	1748
4428	FR	Cercle noir	1748
4429	RW	Uruziga rw’umukara	1748
4430	EN	Star shape	1749
4431	FR	Étoile	1749
4432	RW	Inyenyeri	1749
4433	EN	Approaching level crossing with barriers	1750
4434	FR	Passage à niveau avec barrières	1750
4435	RW	Ahegereye amasangano ya gari ya moshi ifite ibipimo	1750
4436	EN	Barriers ahead road	1751
4437	FR	Route barrée devant	1751
4438	RW	Inzira ibambiye imbere	1751
4439	EN	No barrier crossing	1752
4440	FR	Passage sans barrière	1752
4441	RW	Inzira itabambiye	1752
4442	EN	Cattle grid ahead	1753
4443	FR	Barrière à bétail	1753
4444	RW	Ikiraro cy’amatungo	1753
4445	EN	Adverse camber	1754
4446	FR	Cambré indésirable	1754
4447	RW	Umuhanda wubatswe nabi	1754
4448	EN	Dangerous slope	1755
4449	FR	Descente dangereuse	1755
4450	RW	Agacuri kateza ibyago	1755
4451	EN	Uneven road	1756
4452	FR	Route inégale	1756
4453	RW	Umuhanda utaringaniye	1756
4454	EN	Steep climb	1757
4455	FR	Montée à forte inclinaison	1757
4456	RW	Akazamuko gahanamye	1757
4457	EN	Turn left for parking area	1758
4458	FR	Tourner à gauche pour zone de stationnement	1758
4459	RW	Guhindura icyerekezo ibumoso ugana aho bahagarara	1758
4460	EN	No through road	1759
4461	FR	Route sans issue	1759
4462	RW	Umuhanda udakomeza	1759
4463	EN	No entry for traffic turning left	1760
4464	FR	Entrée interdite aux véhicules tournant à gauche	1760
4465	RW	Ntabwo byemewe guhindura icyerekezo ibumoso	1760
4466	EN	Turn left for ferry terminal	1761
4467	FR	Tourner à gauche pour terminal de bac	1761
4468	RW	Guhindura icyerekezo ibumoso ugana ku cyome	1761
4793	EN	yes always	1870
4481	EN	Stop unless turning left	1766
4482	FR	Arrêtez sauf pour tourner à gauche	1766
4483	RW	Hagarara keretse niba ushaka gukata ibumoso	1766
4484	EN	Stop if it is safe	1767
4485	FR	Arrêtez si c’est sûr	1767
4486	RW	Hagarara niba nta byago byaguteza	1767
4487	EN	Prohibition to pass the signal	1768
4488	FR	Interdiction de franchir le signal	1768
4489	RW	Birabujijwe kurenga icyo kimenyetso	1768
4490	EN	Go if your exit is blocked	1769
4491	FR	Avancer si la sortie est bloquée	1769
4492	RW	Wemerewe kugenda niba aho usohokera hafunze	1769
4493	EN	Prepare to go	1770
4494	FR	Préparez-vous à partir	1770
4495	RW	Itegura kugenda	1770
4496	EN	Do not pass the stop line or the signal	1771
4497	FR	Interdiction de franchir la ligne d’arrêt ou le signal	1771
4498	RW	Birabujijwe kurenga umurongo wo guhagarara cyangwa ikimenyetso ubwacyo	1771
4499	EN	A and B are correct	1772
4500	FR	A et B sont corrects	1772
4501	RW	A na B ni ibisubizo by’ukuri	1772
4502	EN	None of the answers is correct	1773
4503	FR	Aucune réponse correcte	1773
4504	RW	Nta gisubizo cy’ukuri kirimo	1773
4505	EN	Prepare to go	1774
4506	FR	Préparez-vous à partir	1774
4507	RW	Kwitegura kugenda	1774
4508	EN	Permission to pass the signal	1775
4509	FR	Autorisation de franchir le signal	1775
4510	RW	Uburenganzira bwo kurenga icyo kimenyetso	1775
4511	EN	Stop if exit is blocked	1776
4512	FR	Arrêt si la sortie est bloquée	1776
4513	RW	Hagarara niba inzira isohoka ifunze	1776
4514	EN	None of the answers is correct	1777
4515	FR	Aucune réponse correcte	1777
4516	RW	Nta gisubizo cy’ukuri kirimo	1777
4517	EN	It is forbidden to cross the line	1778
4518	FR	Interdit de franchir la ligne	1778
4519	RW	Birabujijwe kuwurenga	1778
4520	EN	No stopping allowed	1779
4521	FR	Stationnement interdit	1779
4522	RW	Birabujijwe kuhahagarara	1779
4523	EN	Approaching a hazard	1780
4524	FR	Approche d’un danger	1780
4525	RW	Wegereye ahaguteza ibyago	1780
4526	EN	Overtaking is allowed	1781
4527	FR	Dépassement autorisé	1781
4528	RW	Kunyuranaho byemewe	1781
4529	EN	Two-way traffic	1782
4530	FR	Circulation dans les deux sens	1782
4531	RW	Ukugendera mu muhanda ubisikanirwamo	1782
4532	EN	Two-way traffic prohibited	1783
4533	FR	Circulation à double sens interdite	1783
4534	RW	Ukugendera mu muhanda ubisikanirwamo ntibyemewe	1783
4535	EN	Cyclists area	1784
4536	FR	Zone cyclable	1784
4537	RW	Ahanyura abanyegare	1784
4538	EN	None of the answers is correct	1785
4539	FR	Aucune réponse correcte	1785
4540	RW	Nta gisubizo cy’ukuri kirimo	1785
4794	FR	oui, toujours	1870
4795	RW	Yego buri gihe	1870
4796	EN	yes, when other vehicles follow me	1871
4797	FR	Oui, lorsque d’autres véhicules me suivent	1871
4798	RW	Yego igihe hari ikinyabiziga kinkurikiye	1871
4799	EN	yes, when other vehicles or has more than 2 whe followed me	1872
4800	FR	Oui, lorsque d’autres véhicule a elé ou a plus de 2 roues me suivent	1872
4801	RW	by’imitende ibiri	1872
4802	EN	no, never to overtake a two-wheeler	1873
4803	FR	Non, jamais pour dépasser un deux-roues	1873
4804	RW	Oya nta na rimwe kunyura kubinya by’imitende ibiri	1873
4553	EN	Service area 30 miles ahead	1790
4554	FR	Zone de service 30 miles à venir	1790
4555	RW	Ahatangirwa serivisi	1790
4556	EN	Maximum speed 30 km/h	1791
4557	FR	Vitesse maximale 30 km/h	1791
4558	RW	Umuvuduko munini ni 30 km/h	1791
4559	EN	Minimum speed 30 km/h	1792
4560	FR	Vitesse minimale de 30 km/h	1792
4561	RW	Umuvuduko muto utarengwa utegetswe ni 30 km/h	1792
4562	EN	Lay-by 30 miles ahead	1793
4563	FR	Aire de stationnement 30 miles à venir	1793
4564	RW	Aho ibinyabiziga bihagarara ni imbere muri metero 30	1793
4565	EN	Slippery road ahead	1794
4566	FR	Chaussée glissante	1794
4567	RW	Umuhanda unyerera	1794
4568	EN	Tyres liable to puncture	1795
4569	FR	Pneus susceptibles de crevaison	1795
4570	RW	Amapine ashobora gutoboka	1795
4571	EN	Undefined danger	1796
4572	FR	Danger non défini	1796
4573	RW	Icyago kidafite ibisobanuro	1796
4574	EN	Service area	1797
4575	FR	Zone de service	1797
4576	RW	Ahatangirwa serivisi	1797
4577	EN	Cattle herders ahead	1798
4578	FR	Conducteurs de bétail	1798
4579	RW	Abayobozi b’amatungo imbere	1798
4580	EN	Railway ahead	1799
4581	FR	Chemin de fer	1799
4582	RW	Inzira ya gari ya moshi imbere	1799
4583	EN	Level crossing without gate or barrier	1800
4584	FR	Passage à niveau sans barrière	1800
4585	RW	Ahegereye inzira ya gari ya moshi idafite barrière	1800
4586	EN	Level crossing with barrier	1801
4587	FR	Passage à niveau avec barrière	1801
4588	RW	Inzira ya gari ya moshi ifite barrière	1801
4589	EN	Speed on the major road is derestricted	1802
4590	FR	La vitesse sur la route principale est dérégulée	1802
4591	RW	Umuvuduko mu muhanda munini wavanweho	1802
4592	EN	It’s a busy junction	1803
4593	FR	C'est une intersection très fréquentée	1803
4594	RW	Ni mwisangano ry’umuhanda rikoreshwa cyane	1803
4595	EN	Visibility along the major road-way is limited	1804
4596	FR	La visibilité sur la route principale est limitée	1804
4597	RW	Biragoye kubona neza mu muhanda munini	1804
4598	EN	There are hazard warning lines in the center of the road	1805
4599	FR	Il y a des lignes d'avertissement de danger au centre de la chaussée	1805
4600	RW	Hari imirongo iburira ibyago bitunguranye	1805
4805	EN	yes	1874
4806	FR	Oui	1874
4807	RW	yego	1874
4808	EN	yes, a er a quick blow of horn	1875
4809	FR	Oui, après un bref coup de klaxon	1875
4810	RW	yego nyuma yo kuvuza ihoni	1875
4811	EN	yes, when other vehicles follow me	1876
4812	FR	Oui, lorsque d’autres véhicules me suivent	1876
4813	RW	yego mu gihe nkurikiwe n’ibindi binyabiziga	1876
4814	EN	No	1877
4815	FR	Non	1877
4816	RW	Oya	1877
4817	EN	I can overtake any vehicle if I moderate my speed	1878
4818	FR	Je peux dépasser n’importe quel véhicule si je modère ma vitesse	1878
4819	RW	Nshobora kunyura ku kinyabizigaricyose mu gihe nagabanyije umuvuduko	1878
4820	EN	I can only overtake two-wheeler (bike, cyclo ...)	1879
4821	FR	Je peux dépasser que les deux-roues (vélo, cyclo…)	1879
4822	RW	nshobora kunyura gusa kubinyab by’imitende ibiri	1879
4823	EN	any overtaking by the le is forbidden	1880
4824	FR	Tout dépassement par la gauche est interdit	1880
4825	RW	kunyuranaho ibumoso birabujijwe	1880
4826	EN	a and b are correct	1881
4827	FR	a et b sont corrects	1881
4828	RW	a na b ni ibisubizo by’ukuri	1881
4829	EN	911	1882
4830	FR	911	1882
4831	RW	911	1882
4832	EN	100	1883
4833	FR	100	1883
4834	RW	100	1883
4835	EN	112	1884
4836	FR	112	1884
4837	RW	112	1884
4838	EN	131	1885
4839	FR	131	1885
4840	RW	131	1885
4934	EN	Dazzle the oncoming vehicle with their own full beam	1917
4935	FR	Éblouir le véhicule venant en sens inverse avec leur propre faisceau complet	1917
4936	RW	Humuza ikinyabiziga giturutse mu kindi cyerekezo ucana amatara maremare	1917
4937	EN	Look to the right-hand edge of the roadway and if necessary reduce speed	1918
4938	FR	Regardez au bord droit de la chaussée et réduisez si nécessaire la vitesse	1918
4939	RW	Egera kunkombe y’iburyo bw’umuhanda nibinashoboka ugabanye umuvuduko	1918
4940	EN	Flash the oncoming vehicle	1919
4941	FR	Flasher le véhicule venant en sens inverse	1919
4942	RW	Canira amatara ikinyabiziga kiva mukindi cyerekezo	1919
4943	EN	Accelerate to get out of the dazzle quickly	1920
4944	FR	Accélérez pour sortir du champ de l’éblouissement rapidement	1920
4945	RW	Ongera umuvuduko kugira ngo usohoke mururwo rumuri vuba bishoboka	1920
5114	EN	No motor vehicles sign	1977
5115	FR	Interdiction des véhicules à moteur	1977
5116	RW	Icyapa kibuzanya ibinyabiziga bifite moteri	1977
5117	EN	Option A incorrect	1978
5118	FR	Option A incorrecte	1978
5119	RW	Icyapa A kitari cyo	1978
5120	EN	Option C incorrect	1979
5121	FR	Option C incorrecte	1979
5122	RW	Icyapa C kitari cyo	1979
5123	EN	None of the answers is correct	1980
5124	FR	Aucune réponse correcte	1980
5125	RW	Nta gisubizo cy’ukuri kirimo	1980
5126	EN	5me'tres	1981
5127	FR	5 meters	1981
5128	RW	metero 5	1981
5129	EN	25me'tres	1982
5130	FR	25 meters	1982
5131	RW	metero 25	1982
5132	EN	45me'tres	1983
5133	FR	45 meters	1983
5134	RW	metero 45	1983
5135	EN	100me'tres	1984
5136	FR	100 meters	1984
5137	RW	metero 100	1984
5138	EN	Allow the pedestrian to cross the road.	1985
5139	FR	Perme re au piéton de traverser la route.	1985
5140	RW	Kwemerera abanyamaguru kwambuka umuhanda	1985
5141	EN	Sound your horn and drive on.	1986
5142	FR	Sonnez votre klaxon et con nuez.	1986
5143	RW	Kuvuza ihoni agakomeza	1986
5144	EN	Wait at the zebra crossing un l the van has turned off.	1987
5145	FR	A endez au passage clouté jusqu'à ce que le fourgon soit éteint.	1987
5146	RW	Tengereza munzira y’ abanyamaguru kugeza imidoka izimye	1987
5147	EN	Accelerate quickly before pedestrian cross the road	1988
5148	FR	Accélérer rapidement avant que les piétons traversent la route.	1988
5149	RW	Kongera umuvuduko mbere yuko abanyamaguru bambuka	1988
5150	RW	Aho imihanda ihurira	1989
5151	RW	Inkomane iburyo gusa	1990
5152	RW	Byombi A na B	1991
5153	RW	Nta gisubizo	1992
5158	RW	ifungana ry’umuhanda iburyo	1997
5159	RW	ifungana ry’umuhanda iburyo n'bumoso	1998
5160	RW	akayira gato	1999
5161	RW	nta gisubizo cy’ukuri	2000
5162	RW	Tanga inzira	2001
5163	RW	Icyago	2002
5164	RW	Icyerekezo kimwe	2003
5165	RW	N hanyurwa	2004
5166	EN	End of a highway	2005
5167	FR	Fin d’autoroute	2005
5168	RW	Aho imihanda ihurira	2005
5169	EN	Junc on with a road coming prac cally from the right	2006
5170	FR	Intersec on avec une route débouchanta sur la droite 	2006
5171	RW	Inkomane y’aho  umuhanda umwe urasukira buryo	2006
5172	EN	No through road	2007
5173	FR	Route sans issue	2007
5174	RW	Umuhanda udakomeza	2007
5175	EN	None of the answers is correct	2008
5176	FR	Aucune des réponses n'est correcte	2008
5177	RW	Nta gisubizo kirimo	2008
6162	EN	Junction with compulsory roundabout	2337
6163	FR	Intersection à sens giratoire	2337
6164	RW	Inkomane banyuramo bazengurutse	2337
6165	EN	U-turn permitted ahead.	2338
6166	FR	Demi-tour permis.	2338
6167	RW	Biremewe guhindukira	2338
6168	EN	One-way street ahead.	2339
6169	FR	Rue à sens unique devant.	2339
6170	RW	Inzira y'icyerekezo kimwe imbere	2339
6171	EN	U-turn prohibited ahead.	2340
6172	FR	U-tour interdit en avant.	2340
6173	RW	Birabujijwe guhindukira	2340
6186	EN	The roadway has two bands	2345
6187	FR	La chaussée comporte deux bandes	2345
6188	RW	Umuhanda ugabanijwemo ibisate bibiri	2345
6189	EN	The roadway has four bands	2346
6190	FR	La chaussée comporte quatre bandes	2346
6191	RW	Umuhanda ugabanijwemo ibisate bine	2346
6192	EN	One-way street.	2347
6193	FR	Rue à sens unique.	2347
6194	RW	Inzira y'icyerekezo kimwe	2347
6195	EN	Two-way traffic ahead.	2348
6196	FR	Circulation dans les deux sens.	2348
6197	RW	Ukugendera mu muhanda ubisikanirwamo	2348
6210	EN	River or unprotected quay ahead.	2353
6211	FR	Rivière ou quai non protégé devant vous.	2353
6212	RW	Uguhinguka ku mwaro cyangwa ku nkombe	2353
6213	EN	Uneven road surface to the right.	2354
6214	FR	Chaussée inégale à droite.	2354
6215	RW	Umuhanda utaringaniye i buryo	2354
6216	EN	Dangerous slope.	2355
6217	FR	Descente dangereuse	2355
6218	RW	Akamanuko gashobora gutera ibyago	2355
6219	EN	lane on a bad section of the road	2356
6220	FR	Passage ou la chaussée est en mauvais état	2356
6221	RW	Ahantu umuhanda umeze nabi	2356
6234	EN	Steep climp	2361
6235	FR	Monte à forte inclination	2361
6236	RW	Akazamuko gashinze cyane	2361
6237	EN	Crosswinds ahead.	2362
6238	FR	Vents de travers devant.	2362
6239	RW	Umuyaga w'intambike	2362
6240	EN	Series of bends ahead.	2363
6241	FR	Série de courbes en avant.	2363
6242	RW	Uruhererekane rw'amakoni	2363
6243	EN	Slippery road	2364
6244	FR	Chaussée glissante	2364
6245	RW	Umuhanda unyerera	2364
6258	EN	Steep climp	2369
6259	FR	Monte à forte inclination	2369
6260	RW	Akazamuko gashinze cyane	2369
6261	EN	Uneven road surface to the left.	2370
6262	FR	Surface de la route inégale à gauche.	2370
6263	RW	Umuhanda utaringaniye i bumoso	2370
6264	EN	lane on a bad section of the road	2371
6265	FR	Passage ou la chaussée est en mauvais état	2371
6266	RW	Ahantu umuhanda umeze nabi	2371
6267	EN	Approaching a hump back	2372
6268	FR	Approche de dos d'âne	2372
6269	RW	Ahegereye utununga	2372
6282	EN	Children.	2377
6283	FR	Enfants.	2377
6284	RW	Abana	2377
6285	EN	Pedestrian crossing ahead - prepare to stop.	2378
6286	FR	Passage pour piétons devant vous - préparez-vous à vous arrêter.	2378
6287	RW	Inzira y'abanyamaguru – Itegure guhagarara	2378
6288	EN	Children's play area ahead.	2379
6289	FR	Aire de jeux pour enfants à venir.	2379
6290	RW	Ikibuga cy'imikino cy'abana	2379
6291	EN	Recreation area ahead.	2380
6292	FR	Zone de loisirs à venir.	2380
6293	RW	Ikibuga cy' imyidagaduro	2380
6306	EN	Livestock mart ahead.	2385
6307	FR	Marché à bétail à venir.	2385
6308	RW	Igikomera	2385
6309	EN	Veterinary station ahead.	2386
6310	FR	Poste vétérinaire à venir.	2386
6311	RW	Ivuriro ry'amatungo	2386
6312	EN	Cattle grid ahead.	2387
6313	FR	Grille de bétail à venir.	2387
6314	RW	Uruzitiro rw'amatungo	2387
6315	EN	Cattle crossing	2388
6316	FR	Passage de bétail	2388
6317	RW	Akayira k'amatungo	2388
5610	EN	Service area 30 miles ahead	2153
5611	FR	Zone de service 30 miles à venir	2153
5612	RW	Aho imihanda ihurira	2153
5613	EN	Junction with a road coming from the right	2154
5614	FR	Vitesse maximale 30 km/h	2154
5615	RW	Inkomane y'aho umuhanda umwe urasukira iburyo	2154
5616	EN	a and b are both correct answers	2155
5617	FR	a et b sont les bonnes réponses	2155
5618	RW	a na b ni ibisubizo by'ukuri	2155
5619	EN	none of the answers is correct	2156
5620	FR	aucune réponse n'est correcte	2156
5621	RW	nta gisubizo cy'ukuri kirimo	2156
5622	EN	it is forbidden to overtake other vehicles	2157
5623	FR	Interdiction de dépasser	2157
5624	RW	birabujijwe kunyura ku kindi kinyabiziga	2157
5625	EN	right of way for vehicles moving in the opposite direction	2158
5626	FR	Priorité aux véhicules venant en sens inverse	2158
5627	RW	gutambuka mbere kw'ibinyabiziga bituruka aho ujya	2158
5628	EN	a and b are correct	2159
5629	FR	a et b sont correctes	2159
5630	RW	nta gisubizo cy'ukuri kirimo	2159
5631	EN	none of the answers is correct	2160
5632	FR	Aucune de réponse n'est correctes	2160
5633	RW	nta gisubizo cyukuri kirimo	2160
5634	EN	The end of priority	2161
5635	FR	fin de priorité	2161
5636	RW	iherezo ryo gutambuka mbere	2161
5637	EN	right of way for vehicles moving in the opposite direction	2162
5638	FR	priorité aux véhicules venant en sens inverse	2162
5639	RW	gutambuka mbere kw'ibinyabiziga biturutse imbere aho ujya	2162
5640	EN	right of way before vehicles coming in opposite direction	2163
5641	FR	priorité par rapport aux véhicules venant en sens inverse	2163
5642	RW	gutambuka mbere y'ibinyabiziga biturutse imbere	2163
5643	EN	none of the answer is correct	2164
5644	FR	aucune de réponse n'est correctes	2164
5645	RW	nta gisubizo cy'ukuri kirimo	2164
5646	EN	form of triangle ,blue surface	2165
5647	FR	forme triangulaire, fond bleu	2165
5648	RW	ishusho mpandeshatu ,ubuso ubururu	2165
5649	EN	triangle form, black surface	2166
5650	FR	forme triangulaire, fond noire	2166
5651	RW	ishusho mpandeshatu,ubuso umukara	2166
5652	EN	triangle form, white surface	2167
5653	FR	forme triangulaire, fond blanche	2167
5654	RW	ishusho mpandeshatu,ubuso umweru	2167
5655	EN	none of the answer is correct	2168
5656	FR	aucune de réponse n'est correctes	2168
5657	RW	nta gisubizo cy'ukuri	2168
5670	EN	Narrowing road	2173
5671	FR	rétrécissement de la chaussée	2173
5672	RW	ifungana ry'umuhanda	2173
5673	EN	Narrowing road (as a result of on encroachment upon the left verge of the road)	2174
5674	FR	rétrécissement de la chaussée (par empiétement de l'accotement situé à gauche de la chaussée)	2174
5675	RW	ifungana ry'umuhanda n'akayira gasatira umuhanda i bumoso	2174
5676	EN	Irregular surface	2175
5677	FR	profil irrégulier	2175
5678	RW	umuhanda utaringaniye	2175
5679	EN	None of the answers is correct	2176
5680	FR	aucune de réponse n'est correcte	2176
5681	RW	nta gisubizo cy'ukuri kirimo	2176
5682	EN	narrowing road on the right side	2177
5683	FR	rétrécissement de la chaussée à droite	2177
5684	RW	ifungana ry'umuhanda iburyo	2177
5685	EN	narrowing road as result of an encroachment upon the left verge of the road	2178
5686	FR	rétrécissement de l'accotement situé à gauche de la chaussée	2178
5687	RW	ifungana ry’umuhanda w’akayira gasatira umuhanda ibumoso	2178
5688	EN	a small footpath	2179
5689	FR	un petit sentier	2179
5690	RW	akayira gato	2179
5691	EN	none of the answers is correct	2180
5692	FR	aucune de réponse n'est correctes	2180
5693	RW	nta gisubizo cy'ukuri	2180
5694	EN	No vehicular traffic in both direction	2181
5695	FR	La circulation interdite dans les deux sens	2181
5696	RW	ntihanyurwa mu byerekezo byombi	2181
5697	EN	Only people who reside in that place are supposed to pass	2182
5698	FR	La circulation interdite sauf circulation locale	2182
5699	RW	ntihanyurwa n'abandi uretse abahatuye	2182
5700	EN	Its only one direction	2183
5701	FR	La circulation interdite dans un sens unique	2183
5702	RW	hanyurwa mu cyerekezo kimwe gusa	2183
5703	EN	None of the answers is correct	2184
5704	FR	Aucune de réponses n'est juste	2184
5705	RW	nta gisubizo cy'ukuri kirimo	2184
5706	EN	Narrowing road	2185
5707	FR	Rétrécissement de la chaussée	2185
5708	RW	Ifungana ry'umuhanda	2185
5709	EN	Slippery Road	2186
5710	FR	Chaussée glissante	2186
5711	RW	umuhanda unyerera	2186
5712	EN	Irregular surface	2187
5713	FR	Profil irrégulier	2187
5714	RW	umuhanda utaringaniye	2187
5715	EN	none of the answers is correct	2188
5716	FR	Aucune de réponses n'est correctes	2188
5717	RW	nta gisubizo cy'ukuri kirimo	2188
5718	EN	Corner to the right (approaching a dangerous corner to the right)	2189
5719	FR	Virage dangereux à droite	2189
5720	RW	ikoni iburyo	2189
5721	EN	Steep climb	2190
5722	FR	Montée à forte inclination	2190
5723	RW	akazamuko gashinze cyane	2190
5724	EN	Dangerous slope	2191
5725	FR	Descente dangereuse	2191
5726	RW	akamanuko gashobora gutera ibyago	2191
5727	EN	b and c are correct	2192
5728	FR	B et C sont justes	2192
5729	RW	b na c byose ni ukuri	2192
5730	EN	For all users arriving in front of the agent	2193
5731	FR	Pour tous les usagers arrivant face à l'agent	2193
5732	RW	ku bakoresha umuhanda ba muturutse imbere	2193
5733	EN	For all users, wherever they come from.	2194
5734	FR	Pour tous les usagers, d’où qu’ils viennent.	2194
5735	RW	ku bakoresha umuhanda bose bamuturutse imbere n’inyuma	2194
5736	EN	For all users appearing behind the agent.	2195
5737	FR	Pour tous les usagers apparaissant derrière l'agent.	2195
5738	RW	kubakoresha umuhanda bose bamuturutse inyuma	2195
5739	EN	none of the answer is correct	2196
5740	FR	aucune de réponse n'est correcte	2196
5741	RW	nta gisubizo cy'ukuri kirimo	2196
5742	EN	yes	2197
5743	FR	Oui	2197
5744	RW	yego	2197
5745	EN	yes , if my speed is above 90 km / h	2198
5746	FR	Oui, si ma vitesse est supérieure à 90 km/h	2198
5747	RW	yego, iyo ufite umuvuduko wa 90km/h	2198
5748	EN	No	2199
5749	FR	Non.	2199
5750	RW	oya	2199
5751	EN	none of the answers is correct	2200
5752	FR	Aucune de réponse n'est correcte	2200
5753	RW	ntagisubizo cy'ukuri	2200
5754	EN	Yes.	2201
5755	FR	Oui.	2201
5756	RW	yego.	2201
5757	EN	No	2202
5758	FR	Non	2202
5759	RW	oya	2202
5760	EN	Yes, but to the left	2203
5761	FR	Oui, mais par à gauche	2203
5762	RW	yego bikorewe ibumoso	2203
5763	EN	None of the answers is correct	2204
5764	FR	aucune de réponse n'est correctes	2204
5765	RW	ntagisubizo cy'ukuri	2204
5766	EN	Prohibits me from driving at a speed exceeding 5 km / h.	2205
5767	FR	M'interdit de rouler à une vitesse supérieure à 5 km/h.	2205
5768	RW	kirambuza gutwara ku muvuduko utarengeje 5km/h	2205
5769	EN	Deny me access, because it applies to the vehicle of more than 5 tons.	2206
5770	FR	M'interdit l'accès, car il s'applique au véhicule de plus de 5 tonnes.	2206
5771	RW	ntaburenganzira kimpa, mugihe gikurikizwa ku binyabiziga bifite hejuru y atoni 5	2206
5772	EN	Does not concern me, as it only applies to vehicles of 5 tons and over.	2207
5773	FR	Ne me concerne pas, car il ne s'applique qu'aux véhicules de 5 tonnes et plus.	2207
5774	RW	ntacyo bindebaho mugihe bireba gusa zipima tone 5 no kurengaho.	2207
5775	EN	None of the answers is correct	2208
5776	FR	Aucune de réponse n'est correcte	2208
5777	RW	Ntagisubizo cy'ukuri kirimo	2208
5778	EN	Yes.	2209
5779	FR	Oui.	2209
5780	RW	yego	2209
5781	EN	Yes, but after stopping.	2210
5782	FR	Oui, mais après m’être immobilisé.	2210
5783	RW	yego, ariko nyuma yo guhagarara	2210
5784	EN	no	2211
5785	FR	Non.	2211
5786	RW	ntabwo byemewe	2211
5787	EN	none the answer is correct	2212
5788	FR	aucune de réponse n'est correcte	2212
5789	RW	ntagisubizo cyukuri kirimo	2212
5790	EN	I can still cross this level crossing, because the barriers are not completely lowered.	2213
5791	FR	Je peux encore traverser ce passage à niveau, car les barrières ne sont pas totalement baissées.	2213
5792	RW	nshobora gukomeza nkambuka umuhanda kubera ko uruzitiro rufunguye	2213
5793	EN	I must stop below the flashing red lights.	2214
5794	FR	Je dois m’immobiliser en deçà des feux rouges clignotants.	2214
5795	RW	ngomba guhagarara munsi yitara ry'umutuku rimyatsa	2214
5796	EN	I cannot continue my journey. I have to stop now.	2215
5797	FR	Je ne peux plus poursuivre ma route. Je dois m'arrêter maintenant.	2215
5798	RW	ntabwo nakomeza urugendo rwanjye. Ngomba gihita mpagarara	2215
5799	EN	none of the answer is correct	2216
5800	FR	aucune de réponse n'est correctes	2216
5801	RW	ntagisubizo cy'ukuri	2216
5802	EN	Advised to travel at more than 30 km / h.	2217
5803	FR	Conseillé de circuler à plus de 30 km/h.	2217
5804	RW	Kugendera k’umuvuduko uri hejuru ya 30km/h	2217
5805	EN	Advised not to exceed 30 km / h.	2218
5806	FR	Conseillé de ne pas dépasser les 30 km/h.	2218
5807	RW	kutarenza umuvuduko wa 30km/h	2218
5808	EN	Forbidden to drive more than 30 km / h.	2219
5809	FR	Interdit de circuler à plus de 30 km/h.	2219
5810	RW	I birabujijwe kugendera kumuvuduko uri hejuru ya 30km/h	2219
5811	EN	None of the answer is correct	2220
5812	FR	D.Aucune de réponse n'est correcte	2220
5813	RW	nta gisubizo cyukuri	2220
5814	EN	Then I can turn right.	2221
5815	FR	Ensuite, je pourrai virer à droite.	2221
5816	RW	Nshobora gukata iburyo	2221
5817	EN	Then, I can turn left.	2222
5818	FR	Ensuite, je pourrai virer à gauche.	2222
5819	RW	Nshobora gukata ibumoso	2222
5820	EN	Then, I can turn left or right.	2223
5821	FR	Ensuite, je pourrai virer à gauche ou à droite.	2223
5822	RW	Nshobora gukata ibumoso cyangwa iburyo	2223
5823	EN	None of the answer is correct	2224
5824	FR	Aucune de réponse n’est correcte	2224
5825	RW	Ntagisubizo cy'ukuri kirimo	2224
5826	EN	I have priority.	2225
5827	FR	J'ai la priorité.	2225
5828	RW	mfite uburenganzira bwo gutambuka mbere	2225
5829	EN	The green car has priority.	2226
5830	FR	La voiture verte a la priorité.	2226
5831	RW	imodoka y'icyatsi ifite uburenganzira bwo gutambuka mbere	2226
5832	EN	Neither: we must exercise caution.	2227
5833	FR	Ni l'un ni l'autre: nous devons faire preuve de prudence.	2227
5834	RW	twembi ntaburenganzira bwo gutambuka mbere gusa tugomba gutambukana ubwitonzi	2227
5835	EN	None of the answer is correct	2228
5836	FR	Aucune de réponse n'est correcte	2228
5837	RW	ntagisubizo nakimwe kirimo	2228
5862	EN	Mark a timeout at this road sign.	2237
5863	FR	Marquer un temps d'arrêt à hauteur de ce signal routier.	2237
5864	RW	guhagarara igihe gito kuri icyi cyapa cy'umuhanda	2237
5865	EN	Stop and give way to 100 meters beyond this road sign.	2238
5866	FR	M'immobiliser et céder le passage à 100 mètres au-delà de ce signal routier.	2238
5867	RW	guhagarara ngatanga inzira kuri metero 100 ntaragera kuri icyi cyapa	2238
5868	EN	Give way and stop, if necessary, 100 meters beyond this road sign.	2239
5869	FR	Céder le passage et m'immobiliser, si nécessaire, à 100 mètres au-delà de ce signal routier.	2239
5870	RW	gutanga inzira nkanahagarara iyo ari ngombwa muri m100 ntaragera kuri icyi cyapa	2239
5871	EN	none of the answer is correct	2240
5872	FR	Aucune de réponse n'est correcte	2240
5873	RW	ntagisubizo cy'ukuri	2240
5874	EN	Yes, if you turn right.	2241
5875	FR	Oui, à condition de virer à droite.	2241
5876	RW	yego, niba ukata ibumoso	2241
5877	EN	No, the other car traveling straight ahead has priority.	2242
5878	FR	Non, l'autre voiture qui poursuit sa route en ligne droite a priorité.	2242
5879	RW	Oya niba ukata iburyo	2242
5880	EN	Yes, regardless of my direction.	2243
5881	FR	Oui, quelle que soit ma direction suivie.	2243
5882	RW	yego , bitewe noho ngana	2243
5883	EN	none of the answer is correct	2244
5884	FR	aucune de réponse n'est correcte	2244
5885	RW	ntagisubizo cy'ukuri kirimo	2244
5886	EN	No.	2245
5887	FR	Non.	2245
5888	RW	oya	2245
5889	EN	Yes, and I can turn right.	2246
5890	FR	Oui, et je peux virer à droite.	2246
5891	RW	yago, nshobora gukata iburyo	2246
5892	EN	Yes, and I can turn left as well as right.	2247
5893	FR	Oui, et je peux virer aussi bien à gauche qu'à droite.	2247
5894	RW	yego, nshobora guta ibumoso cyangwa iburyo	2247
5895	EN	Yes, and I can turn left only	2248
5896	FR	Oui, et je peux virer à gauche	2248
5897	RW	yego, nshobora gukata ibumoso gusa	2248
5898	EN	I can, in turn, go past it on the right.	2249
5899	FR	Je peux, à mon tour, le dépasser à droite.	2249
5900	RW	nshobora kumunyuraho nyuze iburyo	2249
5901	EN	I cannot go beyond it.	2250
5902	FR	Je ne peux pas le dépasser.	2250
5903	RW	sinshobora kumunyura	2250
5904	EN	I can, in turn, overtake it on the left, as soon as I have enough space.	2251
5905	FR	Je peux, à mon tour, le dépasser à gauche, dès que je disposerai d'un espace suffisant.	2251
5906	RW	nshobora kumunyura nciye ibumoso ariko mbonye ko mfite umwanya uhagije	2251
5907	EN	none of the answers are correct	2252
5908	FR	Aucune de réponses n'est correcte	2252
5909	RW	Ntagisubizo cy'ukuri kirimo	2252
5910	EN	To overtake harnessed vehicles and vehicles with more than two wheels on the left and drive at more than 70 km / h.	2253
5911	FR	De dépasser les véhicules attelés et les véhicules à plus de 2 roues par la gauche et de rouler à plus de 70 km/h.	2253
5912	RW	Kunyuranaho kubinyabiziga bikururwa nibinyabiziga birengeje imitende ibiri ibumoso no kugendera kumuvuduko urengeje 70 km/h	2253
5913	EN	To overtake a coupled vehicle or a vehicle with more than two wheels to the left.	2254
5914	FR	De dépasser un véhicule attelé ou un véhicule à plus de 2 roues par à gauche.	2254
5915	RW	Kunyuranaho kubinyabiziga bikururwa cyangwa ibinyabiziga birengeje imitende ibiri ibumoso	2254
5916	EN	To travel more than 70 km / h.	2255
5917	FR	De rouler à plus de 70 km/h.	2255
5918	RW	kugendera hejuru ya 70 km/h	2255
5919	EN	none of the answer is correct	2256
5920	FR	aucune de réponse n'est correcte	2256
5921	RW	ntagisubizo cy'ukuri	2256
6330	EN	The Signal C1	2393
6331	FR	Le Signal C1	2393
6332	RW	Icyapa C1	2393
6333	EN	The Signal E14	2394
6334	FR	Le Signal E14	2394
6335	RW	Icyapa E14	2394
6336	EN	The Signal C2a	2395
6337	FR	Le Signal C2a	2395
6338	RW	Icyapa C2a	2395
6339	EN	The Signal B2a	2396
6340	FR	Le Signal B2a	2396
6341	RW	Icyapa B2a	2396
\.


--
-- Data for Name: Question; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Question" (id, type, "createdAt", deleted, image, number) FROM stdin;
2	NORMAL	2026-05-08 19:48:44.456	f	\N	2
3	NORMAL	2026-05-08 19:48:44.479	f	\N	3
4	NORMAL	2026-05-08 19:48:44.502	f	\N	4
1	NORMAL	2026-05-08 19:48:44.404	f	\N	1
5	NORMAL	2026-05-08 19:48:44.526	f	\N	5
6	NORMAL	2026-05-08 19:52:57.284	f	\N	6
7	NORMAL	2026-05-08 19:52:57.317	f	\N	7
8	NORMAL	2026-05-08 19:52:57.336	f	\N	8
9	NORMAL	2026-05-08 19:52:57.354	f	\N	9
10	NORMAL	2026-05-08 19:52:57.372	f	\N	10
11	NORMAL	2026-05-08 19:56:53.097	f	\N	11
12	NORMAL	2026-05-08 19:56:53.137	f	\N	12
13	NORMAL	2026-05-08 19:56:53.153	f	\N	13
14	NORMAL	2026-05-08 19:56:53.168	f	\N	14
15	NORMAL	2026-05-08 19:56:53.183	f	\N	15
16	NORMAL	2026-05-08 19:56:53.199	f	\N	16
17	NORMAL	2026-05-08 19:56:53.214	f	\N	17
18	NORMAL	2026-05-08 19:56:53.229	f	\N	18
19	NORMAL	2026-05-08 19:56:53.243	f	\N	19
20	NORMAL	2026-05-08 19:56:53.258	f	\N	20
21	NORMAL	2026-05-08 20:09:18.923	f	\N	21
22	NORMAL	2026-05-08 20:09:18.982	f	\N	22
23	NORMAL	2026-05-08 20:09:19	f	\N	23
24	NORMAL	2026-05-08 20:09:19.016	f	\N	24
25	NORMAL	2026-05-08 20:09:19.032	f	\N	25
26	NORMAL	2026-05-08 20:09:19.05	f	\N	26
27	NORMAL	2026-05-08 20:09:19.067	f	\N	27
28	NORMAL	2026-05-08 20:09:19.084	f	\N	28
29	NORMAL	2026-05-08 20:09:19.101	f	\N	29
30	NORMAL	2026-05-08 20:09:19.119	f	\N	30
31	NORMAL	2026-05-08 20:22:30.648	f	\N	31
32	NORMAL	2026-05-08 20:22:30.679	f	\N	32
33	NORMAL	2026-05-08 20:22:30.695	f	\N	33
34	NORMAL	2026-05-08 20:22:30.711	f	\N	34
35	NORMAL	2026-05-08 20:22:30.725	f	\N	35
36	NORMAL	2026-05-08 20:22:30.739	f	\N	36
37	NORMAL	2026-05-08 20:22:30.753	f	\N	37
38	NORMAL	2026-05-08 20:22:30.766	f	\N	38
39	NORMAL	2026-05-08 20:22:30.778	f	\N	39
40	NORMAL	2026-05-08 20:22:30.791	f	\N	40
41	NORMAL	2026-05-08 20:28:42.216	f	\N	41
42	NORMAL	2026-05-08 20:28:42.256	f	\N	42
43	NORMAL	2026-05-08 20:28:42.272	f	\N	43
44	NORMAL	2026-05-08 20:28:42.287	f	\N	44
45	NORMAL	2026-05-08 20:28:42.303	f	\N	45
46	NORMAL	2026-05-08 20:44:32.937	f	\N	46
47	NORMAL	2026-05-08 20:44:32.987	f	\N	47
48	NORMAL	2026-05-08 20:44:33.012	f	\N	48
49	NORMAL	2026-05-08 20:44:33.043	f	\N	49
50	NORMAL	2026-05-08 20:53:08.263	f	\N	50
51	NORMAL	2026-05-08 20:53:08.309	f	\N	51
52	NORMAL	2026-05-08 20:53:08.328	f	\N	52
53	NORMAL	2026-05-08 20:53:08.347	f	\N	53
54	NORMAL	2026-05-08 20:53:08.366	f	\N	54
55	NORMAL	2026-05-08 20:53:08.384	f	\N	55
56	NORMAL	2026-05-08 20:53:08.405	f	\N	56
57	NORMAL	2026-05-08 20:53:08.424	f	\N	57
58	NORMAL	2026-05-08 20:53:08.442	f	\N	58
59	NORMAL	2026-05-08 20:53:08.463	f	\N	59
60	NORMAL	2026-05-08 20:53:08.48	f	\N	60
61	NORMAL	2026-05-08 20:53:08.5	f	\N	61
62	NORMAL	2026-05-08 21:01:27.745	f	\N	62
63	NORMAL	2026-05-08 21:01:27.787	f	\N	63
64	NORMAL	2026-05-08 21:01:27.805	f	\N	64
65	NORMAL	2026-05-08 21:01:27.821	f	\N	65
66	NORMAL	2026-05-08 21:01:27.837	f	\N	66
67	NORMAL	2026-05-08 21:01:27.853	f	\N	67
68	NORMAL	2026-05-08 21:01:27.87	f	\N	68
69	NORMAL	2026-05-08 21:01:27.886	f	\N	69
70	NORMAL	2026-05-08 21:01:27.902	f	\N	70
71	NORMAL	2026-05-08 21:01:27.92	f	\N	71
72	NORMAL	2026-05-08 21:47:49.401	f	\N	72
73	NORMAL	2026-05-08 21:47:49.453	f	\N	73
74	NORMAL	2026-05-08 21:47:49.472	f	\N	74
75	NORMAL	2026-05-08 21:47:49.489	f	\N	75
76	NORMAL	2026-05-08 21:47:49.505	f	\N	76
77	NORMAL	2026-05-08 21:47:49.522	f	\N	77
78	NORMAL	2026-05-08 21:47:49.539	f	\N	78
79	NORMAL	2026-05-08 21:47:49.554	f	\N	79
80	NORMAL	2026-05-08 21:47:49.573	f	\N	80
81	NORMAL	2026-05-08 21:47:49.59	f	\N	81
82	NORMAL	2026-05-08 21:56:23.569	f	\N	82
83	NORMAL	2026-05-08 21:56:23.619	f	\N	83
84	NORMAL	2026-05-08 21:56:23.633	f	\N	84
85	NORMAL	2026-05-08 21:56:23.646	f	\N	85
86	NORMAL	2026-05-08 21:56:23.66	f	\N	86
87	NORMAL	2026-05-08 21:56:23.674	f	\N	87
88	NORMAL	2026-05-08 21:56:23.688	f	\N	88
89	NORMAL	2026-05-08 21:56:23.703	f	\N	89
90	NORMAL	2026-05-08 21:56:23.718	f	\N	90
91	NORMAL	2026-05-08 21:56:23.733	f	\N	91
92	NORMAL	2026-05-08 21:58:51.359	f	\N	92
93	NORMAL	2026-05-08 21:58:51.385	f	\N	93
94	NORMAL	2026-05-08 21:58:51.407	f	\N	94
95	NORMAL	2026-05-08 21:58:51.426	f	\N	95
96	NORMAL	2026-05-08 21:58:51.448	f	\N	96
97	NORMAL	2026-05-08 21:58:51.469	f	\N	97
98	NORMAL	2026-05-08 21:58:51.49	f	\N	98
99	NORMAL	2026-05-08 21:58:51.51	f	\N	99
100	NORMAL	2026-05-08 21:58:51.532	f	\N	100
101	NORMAL	2026-05-08 21:58:51.553	f	\N	101
102	NORMAL	2026-05-08 22:11:14.221	f	\N	102
103	NORMAL	2026-05-08 22:11:14.306	f	\N	103
104	NORMAL	2026-05-08 22:11:14.329	f	\N	104
105	NORMAL	2026-05-08 22:11:14.381	f	\N	105
106	NORMAL	2026-05-08 22:11:14.413	f	\N	106
107	NORMAL	2026-05-08 22:11:14.431	f	\N	107
108	NORMAL	2026-05-08 22:11:14.451	f	\N	108
109	NORMAL	2026-05-08 22:11:14.472	f	\N	109
110	NORMAL	2026-05-08 22:11:14.495	f	\N	110
111	NORMAL	2026-05-08 22:11:14.513	f	\N	111
112	NORMAL	2026-05-08 22:14:13.101	f	\N	112
113	NORMAL	2026-05-08 22:14:13.119	f	\N	113
114	NORMAL	2026-05-08 22:14:13.134	f	\N	114
115	NORMAL	2026-05-08 22:14:13.148	f	\N	115
116	NORMAL	2026-05-08 22:14:13.163	f	\N	116
117	NORMAL	2026-05-08 22:14:13.179	f	\N	117
118	NORMAL	2026-05-08 22:14:13.195	f	\N	118
119	NORMAL	2026-05-08 22:14:13.211	f	\N	119
120	NORMAL	2026-05-08 22:14:13.229	f	\N	120
121	NORMAL	2026-05-08 22:14:13.247	f	\N	121
122	NORMAL	2026-05-08 22:16:48.229	f	\N	122
123	NORMAL	2026-05-08 22:16:48.295	f	\N	123
124	NORMAL	2026-05-08 22:16:48.317	f	\N	124
125	NORMAL	2026-05-08 22:16:48.337	f	\N	125
126	NORMAL	2026-05-08 22:16:48.355	f	\N	126
127	NORMAL	2026-05-08 22:16:48.374	f	\N	127
128	NORMAL	2026-05-08 22:16:48.392	f	\N	128
129	NORMAL	2026-05-08 22:16:48.411	f	\N	129
130	NORMAL	2026-05-08 22:16:48.429	f	\N	130
131	NORMAL	2026-05-08 22:27:52.221	f	\N	131
132	NORMAL	2026-05-08 22:27:52.267	f	\N	132
133	NORMAL	2026-05-08 22:27:52.283	f	\N	133
134	NORMAL	2026-05-08 22:27:52.301	f	\N	134
135	NORMAL	2026-05-08 22:27:52.317	f	\N	135
136	NORMAL	2026-05-08 22:27:52.333	f	\N	136
137	NORMAL	2026-05-08 22:27:52.353	f	\N	137
138	NORMAL	2026-05-08 22:27:52.371	f	\N	138
139	NORMAL	2026-05-08 22:27:52.397	f	\N	139
140	NORMAL	2026-05-11 07:36:53.84	f	\N	140
141	NORMAL	2026-05-11 07:36:53.881	f	\N	141
142	NORMAL	2026-05-11 07:36:53.9	f	\N	142
143	NORMAL	2026-05-11 07:36:53.996	f	\N	143
144	NORMAL	2026-05-11 07:36:54.028	f	\N	144
145	NORMAL	2026-05-11 07:39:27.362	f	\N	145
146	NORMAL	2026-05-11 07:39:27.396	f	\N	146
147	NORMAL	2026-05-11 07:39:27.427	f	\N	147
148	NORMAL	2026-05-11 07:39:27.458	f	\N	148
149	NORMAL	2026-05-11 07:39:27.49	f	\N	149
150	NORMAL	2026-05-11 07:41:51.686	f	\N	150
151	NORMAL	2026-05-11 07:41:51.702	f	\N	151
152	NORMAL	2026-05-11 07:41:51.718	f	\N	152
153	NORMAL	2026-05-11 07:41:51.735	f	\N	153
154	NORMAL	2026-05-11 07:41:51.751	f	\N	154
155	NORMAL	2026-05-11 07:43:34.809	f	\N	155
156	NORMAL	2026-05-11 07:43:34.863	f	\N	156
157	NORMAL	2026-05-11 07:43:34.881	f	\N	157
158	NORMAL	2026-05-11 07:43:34.9	f	\N	158
159	NORMAL	2026-05-11 07:43:34.916	f	\N	159
160	NORMAL	2026-05-11 07:46:03.578	f	\N	160
161	NORMAL	2026-05-11 07:46:03.658	f	\N	161
162	NORMAL	2026-05-11 07:46:03.733	f	\N	162
163	NORMAL	2026-05-11 07:46:03.765	f	\N	163
164	NORMAL	2026-05-11 07:46:03.789	f	\N	164
165	NORMAL	2026-05-11 07:46:03.814	f	\N	165
166	NORMAL	2026-05-11 07:46:03.834	f	\N	166
167	NORMAL	2026-05-11 07:46:03.853	f	\N	167
168	NORMAL	2026-05-11 07:46:03.872	f	\N	168
169	NORMAL	2026-05-11 07:46:03.892	f	\N	169
170	NORMAL	2026-05-11 07:54:54.356	f	\N	170
171	NORMAL	2026-05-11 07:54:54.415	f	\N	171
172	NORMAL	2026-05-11 07:54:54.432	f	\N	172
173	NORMAL	2026-05-11 07:54:54.448	f	\N	173
174	NORMAL	2026-05-11 07:54:54.466	f	\N	174
175	NORMAL	2026-05-11 07:57:09.162	f	\N	175
176	NORMAL	2026-05-11 07:57:09.198	f	\N	176
177	NORMAL	2026-05-11 07:57:09.215	f	\N	177
178	NORMAL	2026-05-11 07:57:09.233	f	\N	178
179	NORMAL	2026-05-11 07:57:09.251	f	\N	179
180	NORMAL	2026-05-11 08:18:33.987	f	\N	180
181	NORMAL	2026-05-11 08:18:34.068	f	\N	181
182	NORMAL	2026-05-11 08:18:34.089	f	\N	182
183	NORMAL	2026-05-11 08:18:34.109	f	\N	183
185	NORMAL	2026-05-11 08:21:26.05	f	\N	185
186	NORMAL	2026-05-11 08:21:26.065	f	\N	186
187	NORMAL	2026-05-11 08:21:26.08	f	\N	187
188	NORMAL	2026-05-11 08:21:26.092	f	\N	188
189	NORMAL	2026-05-11 08:21:26.105	f	\N	189
190	NORMAL	2026-05-11 08:21:26.118	f	\N	190
191	NORMAL	2026-05-11 08:27:49.027	f	\N	191
192	NORMAL	2026-05-11 08:27:49.085	f	\N	192
193	NORMAL	2026-05-11 08:27:49.106	f	\N	193
194	NORMAL	2026-05-11 08:27:49.125	f	\N	194
196	NORMAL	2026-05-11 08:27:49.164	f	\N	196
197	NORMAL	2026-05-11 08:27:49.184	f	\N	197
201	NORMAL	2026-05-11 08:31:49.155	f	\N	201
202	NORMAL	2026-05-11 08:31:49.17	f	\N	202
207	NORMAL	2026-05-11 08:31:49.247	f	\N	207
231	NORMAL	2026-05-11 08:55:08.459	f	\N	231
232	NORMAL	2026-05-11 08:55:08.481	f	\N	232
233	NORMAL	2026-05-11 08:55:08.502	f	\N	233
234	NORMAL	2026-05-11 08:55:08.523	f	\N	234
236	NORMAL	2026-05-11 12:34:49.416	f	\N	236
258	NORMAL	2026-05-11 13:16:16.757	f	\N	258
259	NORMAL	2026-05-11 13:16:16.771	f	\N	259
260	NORMAL	2026-05-11 13:20:52.142	f	\N	260
261	NORMAL	2026-05-11 13:20:52.173	f	\N	261
262	NORMAL	2026-05-11 13:20:52.188	f	\N	262
263	NORMAL	2026-05-11 13:20:52.204	f	\N	263
264	NORMAL	2026-05-11 13:20:52.221	f	\N	264
265	NORMAL	2026-05-11 13:20:52.238	f	\N	265
266	NORMAL	2026-05-11 13:20:52.255	f	\N	266
267	NORMAL	2026-05-11 13:20:52.271	f	\N	267
268	NORMAL	2026-05-11 13:20:52.289	f	\N	268
269	NORMAL	2026-05-11 13:20:52.304	f	\N	269
270	NORMAL	2026-05-11 13:51:28.18	f	\N	270
285	NORMAL	2026-05-11 21:42:42.871	f	\N	285
286	NORMAL	2026-05-11 21:42:42.895	f	\N	286
287	NORMAL	2026-05-11 21:48:33.951	f	\N	287
288	NORMAL	2026-05-11 21:54:09.242	f	\N	288
289	NORMAL	2026-05-11 21:56:51.784	f	\N	289
291	NORMAL	2026-05-11 22:12:29.459	f	\N	291
292	NORMAL	2026-05-11 22:12:29.51	f	\N	292
293	NORMAL	2026-05-11 22:12:29.53	f	\N	293
295	NORMAL	2026-05-11 22:12:29.568	f	\N	295
296	NORMAL	2026-05-11 22:12:29.588	f	\N	296
297	NORMAL	2026-05-11 22:20:31.86	f	\N	297
298	NORMAL	2026-05-11 22:20:31.911	f	\N	298
299	NORMAL	2026-05-11 22:20:31.933	f	\N	299
300	NORMAL	2026-05-11 22:20:31.955	f	\N	300
301	NORMAL	2026-05-11 22:24:41.11	f	\N	301
302	NORMAL	2026-05-11 22:30:34.366	f	\N	302
303	NORMAL	2026-05-11 22:33:04.337	f	\N	303
304	NORMAL	2026-05-11 22:41:39.58	f	\N	304
305	NORMAL	2026-05-11 22:45:45.477	f	\N	305
308	NORMAL	2026-05-11 22:59:18.524	f	\N	308
309	NORMAL	2026-05-11 22:59:18.545	f	\N	309
310	NORMAL	2026-05-11 22:59:18.564	f	\N	310
311	NORMAL	2026-05-11 22:59:18.585	f	\N	311
312	NORMAL	2026-05-11 22:59:18.605	f	\N	312
313	NORMAL	2026-05-11 22:59:18.625	f	\N	313
237	NORMAL	2026-05-11 12:34:49.507	f	/uploads/1781172501107-268.png	237
200	NORMAL	2026-05-11 08:31:49.123	f	/uploads/1781170825188-231.png	200
206	NORMAL	2026-05-11 08:31:49.232	f	/uploads/1779300205006-237.png	206
294	NORMAL	2026-05-11 22:12:29.548	f	\N	294
208	NORMAL	2026-05-11 08:31:49.263	f	/uploads/1779301366540-239.jpg	208
210	NORMAL	2026-05-11 08:38:47.404	f	/uploads/1779301976409-241.png	210
213	NORMAL	2026-05-11 08:38:47.497	f	/uploads/1779302254560-244.jpg	213
214	NORMAL	2026-05-11 08:38:47.52	f	/uploads/1779302314191-245.jpg	214
215	NORMAL	2026-05-11 08:38:47.538	f	/uploads/1779302418439-246.jpg	215
217	NORMAL	2026-05-11 08:38:47.571	f	/uploads/1779302542117-248.png	217
219	NORMAL	2026-05-11 08:38:47.62	f	/uploads/1779302649591-250.jpg	219
221	NORMAL	2026-05-11 08:41:05.077	f	/uploads/1779302760495-252.jpg	221
223	NORMAL	2026-05-11 08:41:05.111	f	/uploads/1779302865159-254.jpg	223
224	NORMAL	2026-05-11 08:41:05.129	f	/uploads/1779302956348-255.jpg	224
226	NORMAL	2026-05-11 08:41:05.164	f	/uploads/1779303280087-257.jpg	226
228	NORMAL	2026-05-11 08:41:05.198	f	/uploads/1779304817871-259.jpg	228
229	NORMAL	2026-05-11 08:41:05.214	f	/uploads/1779304963624-260.png	229
235	NORMAL	2026-05-11 12:34:48.919	f	/uploads/1779356557690-266.png	235
239	NORMAL	2026-05-11 13:03:46.393	f	/uploads/1779356747412-270.jpg	239
241	NORMAL	2026-05-11 13:06:01.429	f	/uploads/1779356863765-272.jpg	241
242	NORMAL	2026-05-11 13:06:01.445	f	/uploads/1779356963717-273.jpg	242
244	NORMAL	2026-05-11 13:06:01.478	f	/uploads/1779357057392-275.jpg	244
246	NORMAL	2026-05-11 13:12:08.809	f	/uploads/1779357384341-277.png	246
248	NORMAL	2026-05-11 13:12:08.841	f	/uploads/1779357623685-279.png	248
249	NORMAL	2026-05-11 13:12:08.856	f	/uploads/1779357783974-280.jpg	249
251	NORMAL	2026-05-11 13:16:16.656	f	/uploads/1779366740786-282.jpg	251
253	NORMAL	2026-05-11 13:16:16.685	f	/uploads/1779367116421-284.jpg	253
255	NORMAL	2026-05-11 13:16:16.714	f	/uploads/1779367276891-286.png	255
256	NORMAL	2026-05-11 13:16:16.727	f	/uploads/1779367343340-287.jpg	256
271	NORMAL	2026-05-11 13:51:28.263	f	/uploads/1779368792030-304.png	271
273	NORMAL	2026-05-11 14:04:36.089	f	/uploads/1779369024060-307.png	273
275	NORMAL	2026-05-11 14:19:54.478	f	/uploads/1779369214418-309.png	275
276	NORMAL	2026-05-11 14:24:00.305	f	/uploads/1779369315233-310.png	276
278	NORMAL	2026-05-11 14:41:29.327	f	/uploads/1779369478138-312.png	278
280	NORMAL	2026-05-11 21:24:25.473	f	/uploads/1779369610249-314.png	280
282	NORMAL	2026-05-11 21:39:11.078	f	/uploads/1779369735833-316.png	282
284	NORMAL	2026-05-11 21:42:42.843	f	/uploads/1779369946832-319.png	284
306	NORMAL	2026-05-11 22:48:49.358	f	/uploads/1779370430515-340.png	306
204	NORMAL	2026-05-11 08:31:49.201	f	/uploads/1781171032657-235.png	204
205	NORMAL	2026-05-11 08:31:49.217	f	/uploads/1781171496009-236.png	205
283	NORMAL	2026-05-11 21:42:42.809	f	/uploads/1781173218293-317.png	283
314	NORMAL	2026-05-11 22:59:18.644	f	\N	314
315	NORMAL	2026-05-11 22:59:18.666	f	\N	315
316	NORMAL	2026-05-11 22:59:18.686	f	\N	316
317	NORMAL	2026-05-11 23:09:22.729	f	\N	317
318	NORMAL	2026-05-11 23:09:22.77	f	\N	318
319	NORMAL	2026-05-11 23:09:22.792	f	\N	319
320	NORMAL	2026-05-11 23:09:22.82	f	\N	320
321	NORMAL	2026-05-11 23:09:22.844	f	\N	321
322	NORMAL	2026-05-11 23:09:22.869	f	\N	322
323	NORMAL	2026-05-11 23:09:22.899	f	\N	323
324	NORMAL	2026-05-11 23:09:22.925	f	\N	324
325	NORMAL	2026-05-11 23:09:22.946	f	\N	325
326	NORMAL	2026-05-11 23:09:22.974	f	\N	326
327	NORMAL	2026-05-11 23:16:22.07	f	\N	327
328	NORMAL	2026-05-11 23:16:22.146	f	\N	328
329	NORMAL	2026-05-11 23:16:22.174	f	\N	329
330	NORMAL	2026-05-11 23:16:22.362	f	\N	330
331	NORMAL	2026-05-11 23:16:22.908	f	\N	331
333	NORMAL	2026-05-11 23:16:23.261	f	\N	333
334	NORMAL	2026-05-11 23:16:23.411	f	\N	334
335	NORMAL	2026-05-11 23:16:23.446	f	\N	335
336	NORMAL	2026-05-11 23:16:23.48	f	\N	336
338	NORMAL	2026-05-12 19:17:42.606	f	\N	338
339	NORMAL	2026-05-12 19:21:28.034	f	\N	339
340	NORMAL	2026-05-12 19:21:28.07	f	\N	340
341	NORMAL	2026-05-12 19:21:28.089	f	\N	341
342	NORMAL	2026-05-12 19:21:28.102	f	\N	342
343	NORMAL	2026-05-12 19:21:28.116	f	\N	343
344	NORMAL	2026-05-12 19:21:28.131	f	\N	344
345	NORMAL	2026-05-12 19:21:28.147	f	\N	345
346	NORMAL	2026-05-12 19:21:28.16	f	\N	346
347	NORMAL	2026-05-12 19:21:28.173	f	\N	347
348	NORMAL	2026-05-12 19:26:55.869	f	\N	348
349	NORMAL	2026-05-12 19:26:55.919	f	\N	349
350	NORMAL	2026-05-12 19:26:55.945	f	\N	350
351	NORMAL	2026-05-12 19:26:55.972	f	\N	351
352	NORMAL	2026-05-12 19:26:55.995	f	\N	352
353	NORMAL	2026-05-12 19:26:56.019	f	\N	353
354	NORMAL	2026-05-12 19:26:56.043	f	\N	354
355	NORMAL	2026-05-12 19:26:56.066	f	\N	355
356	NORMAL	2026-05-12 19:26:56.088	f	\N	356
357	NORMAL	2026-05-12 19:31:47.665	f	\N	357
358	NORMAL	2026-05-12 19:31:47.691	f	\N	358
359	NORMAL	2026-05-12 19:31:47.713	f	\N	359
360	NORMAL	2026-05-12 19:31:47.735	f	\N	360
361	NORMAL	2026-05-12 19:31:47.757	f	\N	361
362	NORMAL	2026-05-12 19:31:47.779	f	\N	362
363	NORMAL	2026-05-12 19:31:47.801	f	\N	363
364	NORMAL	2026-05-12 19:31:47.823	f	\N	364
365	NORMAL	2026-05-12 19:31:47.845	f	\N	365
366	NORMAL	2026-05-12 19:31:47.868	f	\N	366
367	NORMAL	2026-05-12 19:31:47.89	f	\N	367
368	NORMAL	2026-05-12 19:36:46.988	f	\N	368
369	NORMAL	2026-05-12 19:36:47.065	f	\N	369
370	NORMAL	2026-05-12 19:36:47.09	f	\N	370
371	NORMAL	2026-05-12 19:36:47.115	f	\N	371
372	NORMAL	2026-05-12 19:36:47.143	f	\N	372
373	NORMAL	2026-05-12 19:36:47.169	f	\N	373
374	NORMAL	2026-05-12 19:36:47.196	f	\N	374
375	NORMAL	2026-05-12 19:36:47.216	f	\N	375
384	NORMAL	2026-05-12 19:53:27.485	f	/uploads/1779287167745-428.png	384
254	NORMAL	2026-05-11 13:16:16.7	f	/uploads/1779367179901-285.jpg	254
257	NORMAL	2026-05-11 13:16:16.742	f	/uploads/1779367450096-288.jpg	257
272	NORMAL	2026-05-11 13:59:56.387	f	/uploads/1779368942195-305.png	272
274	NORMAL	2026-05-11 14:13:58.127	f	/uploads/1779369104645-308.png	274
277	NORMAL	2026-05-11 14:28:21.577	f	/uploads/1779369375665-311.png	277
388	NORMAL	2026-05-13 06:54:37.876	f	/uploads/1779286364998-432.jpg	388
387	NORMAL	2026-05-13 06:54:37.832	f	/uploads/1779286425676-431.jpg	387
386	NORMAL	2026-05-13 06:51:43.706	f	/uploads/1779286470166-430.jpg	386
279	NORMAL	2026-05-11 21:24:25.344	f	/uploads/1779369549231-313.png	279
281	NORMAL	2026-05-11 21:32:05.625	f	/uploads/1779369671265-315.png	281
389	NORMAL	2026-05-13 06:54:37.905	f	/uploads/1779285111804-433.jpg	389
383	NORMAL	2026-05-12 19:53:27.447	f	/uploads/1779293351154-427.jpg	383
381	NORMAL	2026-05-12 19:53:27.369	f	/uploads/1779293469821-425.png	381
380	NORMAL	2026-05-12 19:53:27.326	f	/uploads/1779293507338-424.jpg	380
378	NORMAL	2026-05-12 19:53:27.168	f	/uploads/1779293593382-422.png	378
195	NORMAL	2026-05-11 08:27:49.145	f	/uploads/1779298835186-226.png	195
203	NORMAL	2026-05-11 08:31:49.186	f	/uploads/1779300106762-234.png	203
209	NORMAL	2026-05-11 08:31:49.278	f	/uploads/1779301834782-209.jpg	209
212	NORMAL	2026-05-11 08:38:47.481	f	/uploads/1779302164803-243.jpg	212
216	NORMAL	2026-05-11 08:38:47.555	f	/uploads/1779302478563-247.jpg	216
218	NORMAL	2026-05-11 08:38:47.586	f	/uploads/1779302599529-249.png	218
220	NORMAL	2026-05-11 08:41:05.042	f	/uploads/1779302699385-251.jpg	220
222	NORMAL	2026-05-11 08:41:05.094	f	/uploads/1779302809891-253.jpg	222
225	NORMAL	2026-05-11 08:41:05.146	f	/uploads/1779303143942-256.jpg	225
227	NORMAL	2026-05-11 08:41:05.182	f	/uploads/1779304732205-258.png	227
230	NORMAL	2026-05-11 08:55:08.376	f	/uploads/1779356181239-261.jpg	230
238	NORMAL	2026-05-11 12:57:28.681	f	/uploads/1779356657601-269.png	238
240	NORMAL	2026-05-11 13:06:01.41	f	/uploads/1779356815394-271.png	240
243	NORMAL	2026-05-11 13:06:01.462	f	/uploads/1779357021072-274.jpg	243
245	NORMAL	2026-05-11 13:12:08.777	f	/uploads/1779357315105-276.png	245
247	NORMAL	2026-05-11 13:12:08.825	f	/uploads/1779357499675-278.png	247
250	NORMAL	2026-05-11 13:16:16.64	f	/uploads/1779357847334-281.jpg	250
252	NORMAL	2026-05-11 13:16:16.67	f	/uploads/1779366789315-283.jpg	252
290	NORMAL	2026-05-11 22:01:39.865	f	/uploads/1779370077125-324.png	290
184	NORMAL	2026-05-11 08:21:26.029	f	/uploads/1781170342991-215.jpg	184
199	NORMAL	2026-05-11 08:27:49.223	f	/uploads/1781170754013-230.png	199
198	NORMAL	2026-05-11 08:27:49.204	f	/uploads/1781171373932-229.png	198
332	NORMAL	2026-05-11 23:16:23.209	f	/uploads/1781174021966-366.png	332
337	NORMAL	2026-05-12 19:14:05.072	f	/uploads/1781175542467-243.jpg	337
379	NORMAL	2026-05-12 19:53:27.286	f	/uploads/1779293555660-423.png	379
392	NORMAL	2026-06-11 14:57:32.282	f	/uploads/1781196156493-369.png	392
393	NORMAL	2026-06-11 15:03:25.618	f	/uploads/1781196195387-370.png	393
395	NORMAL	2026-06-11 15:07:32.074	f	/uploads/1781196641207-373.png	395
397	NORMAL	2026-06-11 15:11:01.867	f	/uploads/1781196782493-375.png	397
399	NORMAL	2026-06-11 15:18:27.052	f	/uploads/1781196940146-378.jpg	399
400	NORMAL	2026-06-11 15:20:55.212	f	/uploads/1781196975514-388.jpg	400
402	NORMAL	2026-06-11 15:26:02.405	f	/uploads/1781197068611-391.jpg	402
404	NORMAL	2026-06-11 15:29:29.191	f	/uploads/1781197159983-393.jpg	404
407	NORMAL	2026-06-11 15:48:01.527	f	/uploads/1781266716493-395.png	406
409	NORMAL	2026-06-11 15:51:19.948	f	/uploads/1781266948643-397.png	408
410	NORMAL	2026-06-11 15:52:44.021	f	/uploads/1781267591913-398.jpg	409
412	NORMAL	2026-06-11 15:56:24.269	f	/uploads/1781267664540-400.png	411
390	NORMAL	2026-06-11 14:43:56.257	f	/uploads/1781196042912-366.png	390
391	NORMAL	2026-06-11 14:54:53.295	f	/uploads/1781196088611-367.png	391
394	NORMAL	2026-06-11 15:05:58.543	f	/uploads/1781196249217-371.png	394
396	NORMAL	2026-06-11 15:09:00.433	f	/uploads/1781196703089-374.png	396
398	NORMAL	2026-06-11 15:12:50.85	f	/uploads/1781196853997-376.png	398
401	NORMAL	2026-06-11 15:23:23.493	f	/uploads/1781197017621-390.jpg	401
403	NORMAL	2026-06-11 15:27:54.39	f	/uploads/1781197117946-392.jpg	403
406	NORMAL	2026-06-11 15:42:22.504	f	/uploads/1781266619130-394.png	405
427	NORMAL	2026-06-12 12:29:01.417	f	/uploads/1781267378134-396.png	425
411	NORMAL	2026-06-11 15:54:11.311	f	/uploads/1781267617963-399.png	410
415	NORMAL	2026-06-11 16:02:36.333	f	/uploads/1781267816382-401.png	414
416	NORMAL	2026-06-11 16:05:09.631	f	/uploads/1781267916926-402.png	415
417	NORMAL	2026-06-11 16:10:01.877	f	/uploads/1781268125100-404.png	416
428	NORMAL	2026-06-12 12:48:08.221	f	/uploads/1781268563850-403.jpg	426
419	NORMAL	2026-06-11 16:12:33.463	f	/uploads/1781268716516-405.png	418
420	NORMAL	2026-06-11 16:13:46.11	f	/uploads/1781268754265-406.jpg	419
421	NORMAL	2026-06-11 16:15:19.802	f	/uploads/1781268781557-407.jpg	420
422	NORMAL	2026-06-11 16:16:39.487	f	/uploads/1781268810978-408.jpg	421
423	NORMAL	2026-06-11 16:18:06.168	f	/uploads/1781268849322-409.jpg	422
424	NORMAL	2026-06-11 16:19:41.939	f	/uploads/1781268885470-8.jpg	423
425	NORMAL	2026-06-11 16:21:22.845	f	/uploads/1781268931888-410.jpg	424
429	NORMAL	2026-06-12 12:58:05.074	f	/uploads/1781269118316-411.jpg	427
430	NORMAL	2026-06-12 13:06:26.579	f	/uploads/1781269616335-412.jpg	428
431	NORMAL	2026-06-12 13:13:31.007	f	/uploads/1781270045683-413.jpg	429
432	NORMAL	2026-06-12 13:16:17.923	f	/uploads/1781270209136-414.png	430
433	NORMAL	2026-06-12 13:19:23.392	f	/uploads/1781270382603-415.png	431
434	NORMAL	2026-06-12 13:22:43.405	f	/uploads/1781270589573-416.png	432
435	NORMAL	2026-06-12 13:24:30.693	f	/uploads/1781270693533-417.png	433
436	NORMAL	2026-06-12 13:27:55.541	f	/uploads/1781270897913-419.png	434
437	NORMAL	2026-06-12 13:30:46.228	f	/uploads/1781271072221-418.png	435
438	NORMAL	2026-06-12 13:39:30.277	f	/uploads/1781271592066-420.png	436
439	NORMAL	2026-06-12 13:42:22.663	f	/uploads/1781271778137-421.png	437
440	NORMAL	2026-06-12 13:45:20.25	f	/uploads/1781271953460-422.png	438
441	NORMAL	2026-06-12 13:50:34.151	f	/uploads/1781272266166-425.png	439
442	NORMAL	2026-06-12 13:54:15.302	f	/uploads/1781272481844-426.png	440
443	NORMAL	2026-06-12 13:56:29.622	f	/uploads/1781272625771-427.jpg	441
444	NORMAL	2026-06-12 14:03:10.498	f	/uploads/1781273009115-429.png	442
\.


--
-- Data for Name: QuestionImage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."QuestionImage" (id, url, "questionId") FROM stdin;
1	/uploads/1779284727502-433.jpg	389
2	/uploads/1779285111804-433.jpg	389
3	/uploads/1779286364998-432.jpg	388
4	/uploads/1779286425676-431.jpg	387
5	/uploads/1779286470166-430.jpg	386
7	/uploads/1779287131033-428.png	384
8	/uploads/1779287167745-428.png	384
9	/uploads/1779293351154-427.jpg	383
11	/uploads/1779293469821-425.png	381
12	/uploads/1779293507338-424.jpg	380
13	/uploads/1779293555660-423.png	379
14	/uploads/1779293593382-422.png	378
15	/uploads/1779298835186-226.png	195
16	/uploads/1779300106762-234.png	203
17	/uploads/1779300205006-237.png	206
18	/uploads/1779301366540-239.jpg	208
19	/uploads/1779301834782-209.jpg	209
20	/uploads/1779301976409-241.png	210
22	/uploads/1779302164803-243.jpg	212
23	/uploads/1779302254560-244.jpg	213
24	/uploads/1779302314191-245.jpg	214
25	/uploads/1779302418439-246.jpg	215
26	/uploads/1779302478563-247.jpg	216
27	/uploads/1779302542117-248.png	217
28	/uploads/1779302599529-249.png	218
29	/uploads/1779302649591-250.jpg	219
30	/uploads/1779302699385-251.jpg	220
31	/uploads/1779302760495-252.jpg	221
32	/uploads/1779302809891-253.jpg	222
33	/uploads/1779302865159-254.jpg	223
34	/uploads/1779302956348-255.jpg	224
35	/uploads/1779303143942-256.jpg	225
36	/uploads/1779303280087-257.jpg	226
37	/uploads/1779304732205-258.png	227
38	/uploads/1779304817871-259.jpg	228
39	/uploads/1779304963624-260.png	229
40	/uploads/1779356181239-261.jpg	230
41	/uploads/1779356557690-266.png	235
42	/uploads/1779356657601-269.png	238
43	/uploads/1779356747412-270.jpg	239
44	/uploads/1779356815394-271.png	240
45	/uploads/1779356863765-272.jpg	241
46	/uploads/1779356963717-273.jpg	242
47	/uploads/1779357021072-274.jpg	243
48	/uploads/1779357057392-275.jpg	244
49	/uploads/1779357315105-276.png	245
50	/uploads/1779357384341-277.png	246
51	/uploads/1779357499675-278.png	247
52	/uploads/1779357623685-279.png	248
53	/uploads/1779357783974-280.jpg	249
54	/uploads/1779357847334-281.jpg	250
55	/uploads/1779366740786-282.jpg	251
56	/uploads/1779366789315-283.jpg	252
57	/uploads/1779367116421-284.jpg	253
58	/uploads/1779367179901-285.jpg	254
59	/uploads/1779367276891-286.png	255
60	/uploads/1779367343340-287.jpg	256
61	/uploads/1779367450096-288.jpg	257
62	/uploads/1779368792030-304.png	271
63	/uploads/1779368942195-305.png	272
64	/uploads/1779369024060-307.png	273
65	/uploads/1779369104645-308.png	274
66	/uploads/1779369214418-309.png	275
67	/uploads/1779369315233-310.png	276
68	/uploads/1779369375665-311.png	277
69	/uploads/1779369478138-312.png	278
70	/uploads/1779369549231-313.png	279
71	/uploads/1779369610249-314.png	280
72	/uploads/1779369671265-315.png	281
73	/uploads/1779369735833-316.png	282
74	/uploads/1779369946832-319.png	284
75	/uploads/1779370077125-324.png	290
76	/uploads/1779370430515-340.png	306
77	/uploads/1781170342991-215.jpg	184
78	/uploads/1781170754013-230.png	199
79	/uploads/1781170825188-231.png	200
80	/uploads/1781171032657-235.png	204
81	/uploads/1781171373932-229.png	198
82	/uploads/1781171496009-236.png	205
83	/uploads/1781172501107-268.png	237
84	/uploads/1781173218293-317.png	283
85	/uploads/1781174021966-366.png	332
86	/uploads/1781175542467-243.jpg	337
87	/uploads/1781196042912-366.png	390
88	/uploads/1781196088611-367.png	391
89	/uploads/1781196156493-369.png	392
90	/uploads/1781196195387-370.png	393
91	/uploads/1781196249217-371.png	394
92	/uploads/1781196641207-373.png	395
93	/uploads/1781196703089-374.png	396
94	/uploads/1781196782493-375.png	397
95	/uploads/1781196853997-376.png	398
96	/uploads/1781196940146-378.jpg	399
97	/uploads/1781196975514-388.jpg	400
98	/uploads/1781197017621-390.jpg	401
99	/uploads/1781197068611-391.jpg	402
100	/uploads/1781197117946-392.jpg	403
101	/uploads/1781197159983-393.jpg	404
102	/uploads/1781266619130-394.png	406
103	/uploads/1781266716493-395.png	407
104	/uploads/1781266948643-397.png	409
105	/uploads/1781267378134-396.png	427
106	/uploads/1781267591913-398.jpg	410
107	/uploads/1781267617963-399.png	411
108	/uploads/1781267664540-400.png	412
109	/uploads/1781267816382-401.png	415
110	/uploads/1781267916926-402.png	416
111	/uploads/1781268125100-404.png	417
112	/uploads/1781268563850-403.jpg	428
113	/uploads/1781268716516-405.png	419
114	/uploads/1781268754265-406.jpg	420
115	/uploads/1781268781557-407.jpg	421
116	/uploads/1781268810978-408.jpg	422
117	/uploads/1781268849322-409.jpg	423
118	/uploads/1781268885470-8.jpg	424
119	/uploads/1781268931888-410.jpg	425
120	/uploads/1781269118316-411.jpg	429
121	/uploads/1781269616335-412.jpg	430
122	/uploads/1781270045683-413.jpg	431
123	/uploads/1781270209136-414.png	432
124	/uploads/1781270382603-415.png	433
125	/uploads/1781270589573-416.png	434
126	/uploads/1781270693533-417.png	435
127	/uploads/1781270897913-419.png	436
128	/uploads/1781271072221-418.png	437
129	/uploads/1781271592066-420.png	438
130	/uploads/1781271778137-421.png	439
131	/uploads/1781271953460-422.png	440
132	/uploads/1781272266166-425.png	441
133	/uploads/1781272481844-426.png	442
134	/uploads/1781272625771-427.jpg	443
135	/uploads/1781273009115-429.png	444
\.


--
-- Data for Name: QuestionTranslation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."QuestionTranslation" (id, language, text, "questionId", explanation) FROM stdin;
1624	EN	 This signal means:	392	\N
4	RW	Ijambo “akayira” bivuga inzira nyabagendwa ifunganye yagenewe gusa:	2	\N
5	EN	The term “Foot path” designates a narrow public way accessible only to the traffic of:	2	\N
6	FR	Le terme “sen er” désigne une voie publique étroite accessible seulement à circula on des:	2	\N
7	RW	Umurongo uciyemo uduce umenyesha ahegereye umurongo ushobora kuzuzwa n’uturanga gukata tw’ibara ryera utwo turang cyerekezo tumenyesha :	3	\N
8	EN	The broken line which announces the approach of a con nuous line m be completed by white fall back arrows, these marks announce :	3	\N
9	FR	La ligne discon nue qui annonce l’approche d’une ligne con nue peut être complétée par des flèches de reba ement de couleur blanche. Ces flèches annoncent:	3	\N
10	RW	Ahantu ho kugendera mu muhanda herek anwa n’ibimenyetso bimurika ibinyabiziga n bisho kuhagenda :	4	\N
11	EN	In places where there are traffic lights, vehicles cannot move:	4	\N
12	FR	Aux endroits oú la circula on est réglée par des signaux lumineux, les véhicules ne peuvent y circuler:	4	\N
16	RW	Ikinyabiziga cyose cyangwa ibinyabiziga bigenda bigomba kugira:	1	\N
17	EN	Every vehicle or set of vehicles in mo on must have:	1	\N
18	FR	Tout véhicule ou train de véhicules en mouvement doit avoir:	1	\N
19	EN	The following vehicles must be inspected for road worthiness ev year	5	\N
20	FR	Les véhicules cités doivent être contrôlés une fois par an:	5	\N
21	RW	Ibinyabiziga bikurikira bigomba gukorerwa isuzumwa buri mwaka:	5	\N
22	RW	Ubugari bwa romoruki ikuruwe n’ikinyami itatu n bugomba kurenza ibipimo bikurikira:	6	\N
23	EN	A width of trailer pulled by a tri cannot exceed:	6	\N
24	FR	La largeur d’une remorque rée par une tricycle ne peut excéder les limites suivantes:	6	\N
25	RW	Uburebure bw’ibinyabiziga bikurikira n bugomba kurenga metero 11 :	7	\N
26	EN	The length for the following vehicles must not exceed 11meters :	7	\N
27	FR	La longueur du véhicule est limitée à 11 mètres pour les véhicules suivants:	7	\N
28	RW	Ikinyabiziga kibujijwe guhagarara akanya kanini aha hakurikira :	8	\N
29	EN	Parking a vehicle is forbidden in these places:	8	\N
30	FR	Le sta onnement d’un véhicule est interdit:	8	\N
31	RW	Kunyuranaho bikorerwa:	9	\N
32	EN	Overtaking is performed on	9	\N
33	FR	Les dépassements s’effectuent	9	\N
34	RW	Icyapa cyerekana umuvuduko ntarengwa ikinyabiziga kitagomba kurenza gishyirwa gusa ku binyabiziga bifite uburemere ntarengwa bukurikira:	10	\N
35	EN	A plate indica ng the maximum speed is put only on the vehicle whoseauthorized weight are :	10	\N
36	FR	Une plaque indiquant la vitesse maximum que le véhicule ne peut dépasser est mise sur les véhicules dont les poids autorisés sont :	10	\N
37	RW	Ahatari mu nsisiro umuvuduko ntarengwa mu isaha wa velomoteri ni:	11	\N
38	EN	Out of agglomera on, the maximum speed of a moped is:	11	\N
39	FR	En dehors des aggloméra ons, la vitesse maximale de cyclomoteur est:	11	\N
40	RW	Umuyobozi ugenda mu muhanda igihe ubugari bwawo budatuma anyuranaho nta nkomyi ashobora kunyura mu kayira k’abanyamaguru ariko amaze kureba ibi bikurikira:	12	\N
41	EN	The person who drives on a roadway when the width of the road does not permit to perform easily overtaking, drives to the verges must respect:	12	\N
42	FR	Le conducteur qui circule sur la chaussée peut, lorsque la largeur de celle-ci ne permet pas d’effectuer aisément un dépassement peut emprunter l’accotement de plain-pied mais il doit tenir compte sur:	12	\N
43	RW	Ku byerekeye kwerekana ibinyabiziga n’ukumurika kwabyo ndetse no kwerekana ihindura ry’ibyerekezo byabyo. Birabujijwe gukora andi matara cyangwa utugarurarumuri uretse ibitegetswe ariko n bireba amatara akurikira:	13	\N
44	EN	For sign pos ng and ligh ng vehicles as well as the indica on of their direc on. It is forbidden changing them, using other lights or reflectors other than those prescribed by the decree. But this provision does not concern the following lights:	13	\N
45	FR	Sur la signalisa on et l’éclairage des véhicules ainsi que pour l’indica on de leurs changements de direc on, il est interdit d’u liser d’autre feux ou catadioptres que ceux prescrites ou prévus par le présent arête mais ce e disposi on ne concerne les feux suivants:	13	\N
46	RW	Iyo nta mategeko awugabanya by’umwihariko umuvuduko ntarengwa w’amapikipiki mu isaha ni:	14	\N
47	EN	For the lack of more restric ve regula ons, maximum speed of motorcycles is:	14	\N
48	FR	A défaut de réglementa on plus restric ve la vitesse maximale de motocycle e est:	14	\N
49	RW	Uburyo bukoreshwa kugirango ikinyabiziga kigende gahoro igihe feri idakora neza babwita:	15	\N
50	EN	The device used for slowing down the vehicle in case of brake failure is called:	15	\N
51	FR	Le disposi f des ne à ralen r et arrêter le véhicule en cas de défaillance du frein s’appelle:	15	\N
52	RW	Nibura ikinyabiziga gitegetswe kugira uduhanagurakirahure tungahe:	16	\N
53	EN	Which minimum number of winscreen wipers must be provided by every vehicle?	16	\N
54	FR	Quel est le nombre maximale d’essuie-glaces oblige pour tout véhicule?	16	\N
55	RW	Amatara maremare y’ikinyabiziga agomba kuzimwa mu bihe bikurikira:	17	\N
56	EN	Headlights of vehicle must be switched of when:	17	\N
57	FR	Les feux de route d’un véhicule doivent être éteints:	17	\N
58	RW	Ikinyabiziga n gishobora kugira amatara arenga abiri y’ubwoko bumwe keretse kubyerekeye amatara akurikira:	18	\N
59	EN	A vehicle cannot be equipped with more than two lights of the same denomina on except:	18	\N
60	FR	Un véhicule ne peut être muni de plus de deux feux de même dénomina on à l’excep on de:	18	\N
61	RW	Ubugari bwa remoriki ikuruwe n’igare cyangwa velomoteri n burenza ibipimo bikurikira:	19	\N
62	EN	The width of trailer when it is trailed by a bicycle or scooter is limited to:	19	\N
63	FR	La largeur d’une remorque rée par une bicycle e ou cyclomoteur est limitée à :	19	\N
64	RW	Ibinyabiziga bikoreshwa nka tagisi, bitegerereza abantu mu nzira nyabagendwa, bishobora gushyirwaho itara ryerekana ko ikinyabiziga kitakodeshejwe. Iryo tara rishyirwaho ku buryo bukurikira:	20	\N
65	EN	Vehicles assigned to taxi service, with parking on public high way, may be provided with a luminous device indica ng that the vehicle is free. That luminous device should be:	20	\N
66	FR	Les véhicules affectés au service de taxi, avec sta onnement sur la voie publique peuvent être munis d’un disposi f lumineux indiquant que le véhicule est libre.Ce feu doit être :	20	\N
67	RW	Za otobisi zagenewe gutwara abanyeshuri zishobora gushyirwaho amatara abiri asa n’icunga rihishije amyasa kugirango yerekane ko zihageze no kwerekana ko bagomba kwitonda, ayo matara ashyirwaho ku buryo bukurikira :	21	\N
68	EN	Buses assigned to transport of school children shall be provided with two flashing orange lights in order to signal stop and to recommend cau on. These lights are placed:	21	\N
69	FR	Les autobus des nés au transport des écoliers peuvent être munis de deux feux oranges clignotants pour signaler l’arrêt et de recommander la prudence. Ces feux sont placés :	21	\N
70	RW	Itara ryo guhagarara ry’ibara ritukura rigomba kugaragara igihe ijuru rikeye nibura mu ntera ikurikira:	22	\N
71	EN	The brake light of red color must be visible in clear weather at a minimum distance of:	22	\N
72	FR	Le feu de stop, de couleur rouge, doit être visible par atmosphère limpide à une distance minimum de :	22	\N
73	RW	Iyo umuvuduko w’ibinyabiziga bidapakiye ushobora kurenga km50 mu isaha ahategamye, bigomba kuba bifite ibikoresho by’ihoni byumvikanira mu ntera:	23	\N
74	EN	When the speed of unloaded vehicles on a flat surface cannot exceed 50km per hour, the sounding alarm apparatus can be heard at distance of:	23	\N
75	FR	Lorsque la vitesse en palier des véhicules à vide peut dépasser 50km à l’heure, ces véhicules doivent être équipés d’un appareil aver sseur sonore pouvant être entendu à une distance de :	23	\N
76	RW	Birabujijwe kugenza ibinyabiziga bigendeshwa na moteri naza romoruki zikururwa nabyo, iyo ibiziga byambaye inziga zidahagwa cyangwa inziga zikururuka zifite umubyimba uri hasi ya cm 4. Ariko ibyo n bikurikizwa kubinyabiziga bikurikira:	24	\N
77	EN	The circulation of self-propelling vehicles and trailers pulled by these vehicles is forbidden when their wheels are provided with either rigid bandages or elastic bandages of less than 0.04 meter thick. But this provision does not apply on:	24	\N
78	FR	Est interdite la circulation de véhicules automoteurs et des remorques rées par ces véhicules, lorsque les roues sont munis soit de bandages rigides, soit de bandages élastiques de moins de 0.04metre d’épaisseur. Mais ceci n’est pas appliqué aux véhicules suivants:	24	\N
79	RW	Igice cy'inzira nyabagendwa kigarukira ku mirongo ibiri yera icagaguye ibangikanye kandi gifite ubugari budahagije kugira ngo imodoka zitambuke neza, kiba ari:	25	\N
80	EN	The section of the public highway delineated by two broken and parallel white lines, and not wide enough for automobile vehicles traffic constitutes:	25	\N
81	FR	La partie de la voie publique délimitée par deux lignes blanches discontinues et parallèles, et d'une largeur insuffisante pour permettre la circulation des véhicules automobiles, constitue:	25	\N
82	RW	Ubugari bwa romoruki n burenza ubugari bw’ikinyabiziga kiyikurura iyo ikuruwe n’ibinyabiziga bikurikira:	26	\N
83	EN	The width of trailer is limited to the width of the hauling vehicle when the trailer is pulled by:	26	\N
84	FR	La largeur d’une remorque ne peut dépasser la largeur du véhicule tracteur si elle est réée par les véhicules suivants:	26	\N
85	RW	Iyo hatarimo indi myanya birabujijwe gutwara ku ntebe y’imbere y’imodoka abana badafite imyaka:	27	\N
86	EN	When the other seats are not available in the car, it is forbidden to carry on the front seat children of less than:	27	\N
87	FR	Lorsqu’il n’y a pas d’autres places disponibles, il est interdit de transporter sur siège avant d’un véhicule des enfants de moins de:	27	\N
88	RW	Icyapa kivuga gutambuka mbere y’ibinyabiziga biturutse imbere gifite amabara akurikira:	28	\N
89	EN	The sign which indicates the right of way before vehicles coming in the opposite direction has the following colors:	28	\N
90	FR	Le signal qui donne la priorité par rapport aux véhicules venant en sens inverse est coloré de façon suivante:	28	\N
91	RW	Ni ryari itegeko rigenga gutambuka mbere kw’iburyo rikurikizwa mu masangano:	29	\N
92	EN	When is the right hand priority rule applied in junction?	29	\N
93	FR	Quand est-ce que la règle de priorité de droite doit être appliquée?	29	\N
94	RW	Ibimenyetso bimurika byerekana uburyo bwo kugendera mu muhanda kw'ibinyabiziga bishyirw iburyo bw'umuhanda. Ariko bishobora no gushyirwa ibumoso cyangwa hejuru y’umuhanda:	30	\N
95	EN	Traffic lights are placed on the right side of the public highway. However they may be duplicated on the left side of the public highway or above it:	30	\N
96	FR	Les signaux lumineux règlementant la circulation des véhicules peuvent être places à gauche au-dessus de la chaussée, qu’est ce qu’on tient compte?	30	\N
97	RW	Iyo itara ry’umuhondo rimyatsa rikoreshejwe mu masangano y’amayira ahwanyije agaciro rishyirwa ahagana he:	31	\N
98	EN	When the flashing yellow light is used at cross-roads of equal sizes, where must the yellow light be placed?	31	\N
99	FR	Lorsque le feu clignotant jaune est utilisé à un carrefour dont les voies sont d’importance égale où est-il placé?	31	\N
100	RW	Inkombe z’inzira nyabagendwa cyangwa z’umuhanda zishobora kugaragazwa n’ibikoresho ngarurarumuri. Ibyo bikoresho bigomba gushyirwaho ku buryo abagenzi babibona:	32	\N
101	EN	Borders of the public highway or roadway must be signaled by reflectors. These devices must be set so users see them:	32	\N
102	FR	Les bords de la voie publique ou de la chaussée peuvent être signalés par des dispositifs réfléchissants. Ces dispositifs doivent être placés de manière que les usagers les voient:	32	\N
103	RW	Ibinyabiziga bikurikira bigomba gukorerwa isuzumwa rimwe mu mezi 6:	33	\N
104	EN	The following vehicles must be inspected every 6 months:	33	\N
105	FR	Les véhicules suivants doivent subir une visite technique tous les 6 mois:	33	\N
106	RW	Iyo kuyobya umuhanda ari ngombwa bigaragazwa kuva aho uhera no kuburebure bwawo n’icyapa gifite ubuso bw’amabara akurikira:	34	\N
107	EN	When road diversion is required it is signaled at the beginning and along its length by a sign of the following color:	34	\N
108	FR	Lorsqu’un détour est nécessaire il est signalé au début et sur toute sa longueur par un panneau de couleur:	34	\N
109	RW	Ku mihanda ibyapa bikurikira bigomba kugaragazwa ku buryo bumwe:	35	\N
110	EN	The following road signs have similar designs:	35	\N
111	FR	Les signaux suivants ont des formes similaires:	35	\N
112	RW	Ni iyihe feri ituma imodoka igenda buhoro kandi igahagarara ku buryo bwizewe bubangutse kandi nyabwo:	36	\N
113	EN	Which brake allows the vehicle to slow down and stop quickly and safely?	36	\N
114	FR	Quel type de frein permet de ralentir et d’arrêter le véhicule rapidement et sûrement?	36	\N
115	RW	Ibizirikisho by’iminyururu cyangwa by’insinga bikoreshwa gusa mu gihe cy’ingoboka bigaragazwa gute?	37	\N
116	EN	How are temporary chain or cable fastenings indicated?	37	\N
117	FR	Comment sont signalées les attaches constituées de chaînes ou câbles?	37	\N
118	RW	Uretse mu mujyi, uburemere ntarengwa ku binyabiziga bifite imitambiko itatu cyangwa irenga ni:	38	\N
119	EN	Outside urban areas, the maximum weight for vehicles with three or more axles is:	38	\N
120	FR	Hors agglomération, le poids maximum autorisé pour véhicules à trois essieux ou plus est:	38	\N
121	RW	Ubugari bw’imizigo yikorewe n’ibinyamitende ntibushobora kurenga:	39	\N
122	EN	The width of loads carried by tricycles and quadricycles must not exceed:	39	\N
123	FR	La largeur du chargement des tricycles et quadricycles ne peut excéder:	39	\N
124	RW	Kunyura ku binyabiziga bindi (uretse ibiziga bibiri) bibujijwe aha hakurikira:	40	\N
125	EN	Overtaking other vehicles (except two-wheelers) is forbidden:	40	\N
126	FR	Le dépassement de tout véhicule autre qu’un deux-roues est interdit:	40	\N
127	RW	Iyo nta mategeko awugabanya by’umwihariko umuvuduko ntarengwa ku modoka zitwara abagenzi mu buryo bwa rusange ni:	41	\N
128	EN	Where there are no specific restric ve regula ons, the maxi speeds for passenger service ve is:	41	\N
129	FR	A défaut de réglementa on restric ve specifiques, la vitesse maximale des véhicules pour le transport en commun est:	41	\N
130	RW	Iyo nta mategeko awugabanya by’umwihariko, umuvuduko ntarengwa ku modoka zikoreshwa nk’amava ri y’ifasi cyangwa amatagisi zifite uburemere bwemewe butarenga kilogarama 3500 ni:	42	\N
131	EN	Where there are no specific restric ve regula ons, the maximum speed for Motor vehicles used as hackney carriage or taxis of which the authorized weight does not exceed 3,500 kilograms is:	42	\N
132	FR	A défaut de réglementa ons restric ves specifiques, la vitesse maximale des véhicules automobiles à usage de voiture de place ou taxi dont le poids maximum autorisé n’excède pas 3500 kg est:	42	\N
133	RW	Ikinyabiziga kibujijwe guhagarara akanya kanini aha hakurikira :	43	\N
134	EN	Parking a vehicle is forbidden:	43	\N
135	FR	Le sta onnement d’un véhicule est interdit :	43	\N
136	RW	Iyo bwije kugeza bukeye cyangwa bitewe n’uko ibihe bimeze nk’igihe cy’ibihu cyangwa cy’imvura bitagishoboka kubona neza muri m 200, udutsiko twose tw’abanyamaguru nk’imperekerane cyangwa udutsiko tw’abanyeshuri bari ku murongo bayobowe n’umwarimu...	44	\N
137	EN	Between twilight and day break or because of fog or heavy rain where visibility is less than 200m...	44	\N
138	FR	Entre la tombée et le lever du jour ou en raison du brouillard ou forte pluie où la visibilité est inférieure à 200m...	44	\N
139	RW	Utuyira turi ku mpande z’umuhanda n’inkengero zigiye hejuru biharirwa abanyamaguru mu bihe bikurikira:	45	\N
140	EN	Pavements and shoulders are reserved to pedestrians when:	45	\N
141	FR	Les trottoirs et accotements sont réservés aux piétons lorsque:	45	\N
142	RW	Imburira zimurika zemerewe gukoreshwa kugirango bamenyeshe umuyobozi ko bagiye kumunyuraho zikoreshwa aha hakurikira: a) Mu nsisiro gusa b) Ahegereye inyamaswa zikurura c) Hafi y’amatungo (d) Nta gisubizo cy’ukuri kirimo	46	\N
143	EN	Luminous warning signs used to inform a driver that he is going to be overtaken are used in the following areas: a) In built-up areas only b) Approaching mounted animals only c) Approaching only livestock (d) None of the answers is correct	46	\N
144	FR	Les avertissements lumineux pour informer un conducteur qu’il va être dépassé sont utilisés dans les endroits suivants : a) Dans les agglomérations seulement b) À l’approche des animaux de selle seulement c) À l’approche du bétail seulement (d) Aucune des réponses n’est correcte	46	\N
145	RW	Uburemere ntarengwa bwemewe ku romoruki ntibugomba kurenga 1/2 cy’uburemere bw’ikinyabiziga gikurura hamwe n’uburemere bw’umuyobozi kuri romoruki zikurikira:	47	\N
146	EN	The authorized maximum weight of a trailer must not exceed half the sum of the empty weight of the towing vehicle and the driver for the following trailers:	47	\N
147	FR	Le poids maximum autorisé d’une remorque ne doit pas excéder la moitié de la somme du poids à vide du véhicule tracteur et du poids du conducteur pour les remorques suivantes :	47	\N
148	RW	Ibinyabiziga bifite ubugari burenze ibipimo bikurikira bigomba kugira amatara ndangaburumbarare:	48	\N
149	EN	Vehicles with a width greater than the following measures must be equipped with width marker lights:	48	\N
150	FR	Les véhicules dont la largeur dépasse les mesures suivantes doivent être munis de feux d’encombrement :	48	\N
1625	FR	Ce signal signifie:	392	\N
154	RW	. Nta tara na rimwe cyangwa akagarurarumur bishobora kuba bifunze ku buryo igice cyabyo c hasi cyane kimurika kitaba kiri hasi y’ibipimo bikurikira kuva ku butaka igihe ikinyabiziga kidapakiye :	49	\N
155	EN	No light or reflector may be placed lower than the following height from the ground when the vehicle is unloaded:	49	\N
156	FR	Aucun feu ou catadioptre ne peut être placé à une hauteur inférieure aux mesures suivantes du sol lorsque le véhicule est à vide :	49	\N
157	RW	Iyo ikinyabiziga gifite amatara abiri cyangwa menshi y’ubwoko bumwe ayo matara agomba kugira ibara rimwe n’ingufu zingana kandi akagomba gushyirwaho ku buryo buteganye uhereye ku murongo ugabanya ikinyabizigamo kabiri mu burebure bwacyo. Ariko ibi n bikurikizwa ku matara akurikira:	50	\N
158	EN	Where a vehicle is provided with two or more lights of the same denomination these lights must be of the same color and intensity, and they must be placed symmetrically about the median longitudinal plane of the vehicle but this provision is not applicable to the following lighting device:	50	\N
159	FR	Si un véhicule est muni de deux ou plusieurs feux de même dénomination, ces feux doivent être de même couleur et de même intensité, et ils doivent être placés symétriquement par rapport au plan longitudinal médiane du véhicule mais ceci n’est pas applicable au dispositif suivant:	50	\N
160	RW	Ahari hejuru cyane y’ubuso bumurika h’amatara ndangambere na ndanganyum n hashobora kuba aharenze ibipimo bikurikira:	51	\N
161	EN	The highest point of the illuminating area of the front and back position lights cannot be at more than following meters above the ground, the vehicle being unloaded:	51	\N
162	FR	Au-dessus du sol et le véhicule étant vide, le point le plus élevé de la plage éclairante de feux de position avant et arrière ne peut se trouver à plus de mesures suivantes:	51	\N
163	RW	Ni ryari ikinyabiziga gishobora kugenda mu muhanda moteri itaka cyangwa vitesi idakora:	52	\N
164	EN	When can the vehicle move on the slope roadway while its engine is off or its gears are out:	52	\N
165	FR	Aucun véhicule ne peut circuler sur les chaussées en déclivité si son moteur est arrêté ou si son levier de changement de vitesse est au point mort sauf:	52	\N
166	RW	Umurongo mugari wera udacagaguye ushobora gucibwa ku muhanda kugirango ugaragaze:	53	\N
167	EN	A wide and continuous white line may be drawn on the roadway to indicate:	53	\N
168	FR	Une large ligne blanche continue peut être tracée sur la chaussée pour marquer:	53	\N
169	RW	Buri modoka cyangwa buri romoruki ikuruwe n’iyo modoka bishobora kugira itara risa n’icyatsi rituma umuyobozi yerekana ko yabonye ikimenyetso cy’uwitegura kumunyuraho. Iryo tara rigomba gushyirwa:	54	\N
170	EN	Every motor vehicle or trailer pulled by such a vehicle may be provided a green light permitting the driver signal that he has perceived the warning of the person who is ready to overtake him, this light must be placed:	54	\N
171	FR	Tout véhicule automobile ou toute remorque tirée par un tel véhicule peut être muni d’un feu vert permettant au conducteur de signaler qu’il a perçu l’avertissement de celui qui s’apprête à le dépasser. Ce feu est placé:	54	\N
172	RW	Ibinyabiziga bikurikira bigomba kugira icyerekana umuvuduko kiri aho umuyobozi ashobora kukibona neza kandi kigahora kitabwaho kugirango gikore neza:	55	\N
173	EN	The following vehicles must be fitted with a speed indicator to be found at clear sight of a driver and be constantly in good working condition:	55	\N
174	FR	Tout véhicule susceptible de dépasser en palier la vitesse suivante doit être muni d’un indicateur de la vitesse placé bien en vue du conducteur et maintenu constamment en bon état de fonctionnement:	55	\N
175	RW	Ubugari bw’imizigo yikorewe n’ipikipiki idafite akanyabiziga ko kuruhande n’ubwa romoruki ikuruwe na bene icyo kinyabiziga ntibushobora kurenza:	56	\N
176	EN	The width of the loading on motorcycles without a side car and trailers pulled by these cannot exceed:	56	\N
177	FR	La largeur du chargement d’une motocyclette sans side car et d’une remorque tirée par un tel véhicule ne peut excéder:	56	\N
178	RW	Ibinyabiziga bikurikira bigomba kugira itara ry’ubururu rimyatsa riboneka mu mpande zose:	57	\N
179	EN	The following vehicles must be provided with a light emitting a flashing blue light visible from all directions:	57	\N
180	FR	Les véhicules suivants doivent être munis d’un feu émettant une lumière bleue clignotante visible dans tous les directions:	57	\N
181	RW	Ibinyabiziga bihinga n’ibindi bikoresho byihariye bikoreshwa n’ibigo bikora imirimo, iyo nijoro cyangwa bitewe n’uko ibihe bimeze bitagishoboka kubona neza muri m 200 bishobora kugaragazwa inyuma n’amatara 2 atukura, bipfa kuba bitarenza:	58	\N
182	EN	Between twilight and daybreak or because of circumstances, when it is not possible to see distinctly up to a distance of 200m the presence on the public way of agricultural machines and special implements used by construction enterprises can be signaled by two red lights at the back, provided that:	58	\N
183	FR	Les véhicules agricoles et matériels spéciaux employés par les entreprises de travaux, lorsqu’il n’est pas possible de voir distinctement jusqu’à une distance de 200m, leur présence peut être signalée par deux feux rouges à l’arrière mais à condition que:	58	\N
184	RW	Iyo romoruki iziritse ku kinyamitende, velomoteri n’amapikipiki bidafite akanyabiziga ko kuruhande, iyo uburumbarare bwayo cyangwa bw’ibyo yikoreye bituma itara ry’ikinyabiziga gikurura ritagaragara igihe bitagishoboka kubona neza muri m 200 bigomba kugaragazwa ku buryo bukurikira:	59	\N
185	EN	Between twilight and daybreak or because of circumstances, when it is not possible to see distinctly up to a distance of 200m the presence of trailers coupled to bicycles, mopeds and motorbikes without a side car must be signaled by:	59	\N
186	FR	Lorsque, entre la tombée et le lever du jour, il n’est pas possible de voir distinctement jusqu’à une distance de 200m, les remorques attachées aux cycles, cyclomoteurs et motocyclettes doivent être signalées par:	59	\N
187	RW	Ku kinyabiziga cyangwa ibinyabiziga bikururana igice kirenga ku biziga ntikigomba kurenga:	60	\N
188	EN	On the vehicle or line of vehicles the length of overhanging cannot be over than:	60	\N
189	FR	Pour les véhicules ou train des véhicules les mesures de longueur maximale de porte à faux est:	60	\N
190	RW	Iyo amatara y’ikinyabiziga agomba gucanwa kandi igihe imizigo isumba impera y’ikinyabizigaho metero irenga igice gihera cy’imizigo kigaragazwa ku buryo bukurikira:	61	\N
191	EN	When lighting of the vehicle is required if the loading projects beyond the back edge of the vehicle by more than one meter, the most protruding part must be signaled by:	61	\N
192	FR	Lorsque le chargement dépasse de plus d’un mètre l’extrémité arrière du véhicule et que l’éclairage est requis, la plus forte saillie doit être signalée par:	61	\N
193	RW	Iyo imizigo igizwe n’ibinyampeke, ikawa, ipamba idatonoye, ibishara, ibyatsi, ibishami cyangwa ubwatsi bw’amatungo bidahambiriye uretse amapaki afunze, ubugari bwayo bushobora kugera ku bipimo bikurikira: a) m 2.50 b) m 2.75 c) m 3 d) nta gisubizo cy’ukuri kirimo	62	\N
194	EN	When the loading is cons tuted by cereals, raw coffee wooden charcoal, non-ginned co on, straw, grass, boughs or forage in bulk, excluding compressed bales, its width can reach the following measures: a) 2.50m b) 2.75m c) 3m d) none of the answers is correct	62	\N
195	FR	Si le chargement est cons tué de céréale, café perchet, charbon de bois, co on non égrené, poille, herbe branchages ou fourrage en vrac à l’exclusion de balles comprimées sa largeur peut a eindre des measures suivantes: a) 2.50m b) 2.75m c) 3m d) aucune de réponses n’est correctes	62	\N
196	RW	Uretse mu mijyi kuyindi mihanda yagenywe na minisiteri ushinzwe gutwara ibintu n’abantu, uburemere ntarengwa bwemewe ku binyabiziga bifatanye bifite imitambiko itatu ni: a) toni 20 b) toni 16 c) toni 12 d) toni 10	63	\N
246	FR	En dehors des agglomérations, les signaux de danger et les signaux de priorité doivent être placés à une distance:	79	\N
197	EN	Except in urban areas, on the other roads as determined by the minister having transport in his du es, the maximum weights authorized by ar culated vehicles with three axle is: a) 20 tones b) 16 tones c) 12 tones d) 10 tones	63	\N
198	FR	A l’excep on de circonscrip ons urbaines sur les autres routes determinées par le ministre ayant le transport dans ses a ribu ons, les poids maximum autorisés pour les véhicules ar culés à trios essieux est: a) 20 tonnes b) 16 tonnes c) 12 tonnes d) 10 tonnes	63	\N
199	RW	Buri modoka cyangwa buri romoruki ikuruwe n’iyo modoka bishobora kugira itara rituma umuyobozi yerekana ko yabonye ikimenyetso cy’uwitegura kumunyuraho. Iryo tara rifite amabara akurikira: a) umuhondo b) icyatsi kibisi c) umweru d) umutuku	64	\N
200	EN	Every motor vehicle or trailer pulled by such a vehicle shall be provided with a light permi ng the driven to signal that he has no ced the warning of the person who is read to overtake him: a) yellow b) green c) white d) red	64	\N
201	FR	Tout véhicule automobile ou toute remorque rée par un tel véhicule peut être muni d’un feu perme ant au conducteur de signaler qu’il a perçu l’aver ssement de celui qui s’apprête à le dépasser. Ce feu a de couleur: a) jaune b) verte c) blanche d) rouge	64	\N
202	RW	Ikinyabiziga cyangwa ibinyabiziga bikururana bifite imitambiko ibiri ikurikiranye mu bugari bwayo ni ukuvuga imitambiko yihindukiza kucyo ifungiyeho, uburebure bwabyo n bugomba kurenza ibipimo bikurikira: a) m11 b) m10 c) m7 d) nta gisubizo cy’ukuri kirimo	65	\N
203	EN	The length of the vehicle or line of vehicles with two axles placed in the con nua on one of the other is limited to the following measures: a) 11 m b) 10 m c) 7 m d) none of the answers is correct	65	\N
204	FR	le véhicule ou train des véhicules à deux essieux placés dans le prolongement l’un de l’autre, c’est à dire oscillant, leur largeur est limitée à : a) 11 m b) 10 m c) 7 m d) aucune de réponses n’est correctes	65	\N
205	RW	Bumwe muri ubu bwoko bwa feri ituma imodoka iguma aho iri uko yaba yikoreye kose ku muzamuko cyangwa ku gacuri bya 16%: a) feri yo guhagarara umwanya munini b) feri y’urugendo c) feri yo gutabara d) nta gisubizo cy’ukuri kirimo	66	\N
206	EN	One of the following kinds of brake is allowing to maintain the vehicle whatever be the condi ons of its loading on an up or down 16% slope: a) parking brake b) service brake c) emergency braking d) none of the answers is correct	66	\N
207	FR	L’un de ces types de frein permet de maintenir le véhicule immobile, quelles que soient les condi ons de son chargement, sur une déclavité ascendante de 16%: a) frein de sta onnement b) frein de service c) frein de secour d) aucune de réponses n’est correctes	66	\N
208	RW	Utugarurarumuri turi mu mbavu z’ikinyabiziga tugomba kugira ibara rikurikira: a) umweru b) umuhondo c) umutuku d) Nta gisubizo cy’ukuri kirimo	67	\N
209	EN	The reflector placed on the sides of vehicle has the following color: a) white b) yellow c) red d) None of the answers is correct	67	\N
210	FR	Sur le véhicule, les catadioptres placés latéralement sont en couleur: a) blanche b) jaune c) rouge d) Aucune de réponses n’est correctes	67	\N
211	RW	Romoruki zifite ubugari ntarengwa bwa cm 80 zishobora gushyirwaho akagarurarumuri kamwe gusa iyo zikuruwe n’ibinyabiziga bikurikira: a) ipikipiki idafite akanyabiziga ku ruhande b) velomoteri c) amava ri y’ifasi d) nta gisubizo cy’ukuri kirimo	68	\N
212	EN	The trailers, the overall width of which does not exceed 0.80m may be provided only with one reflector if they are coupled up to the following vehicles: a) moped b) motorbike without a side car c) motor vehicles used as hackney carriage d) none of the answers is corretc	68	\N
213	FR	Les remorques dont la largeur hors tout ne dépasse pas 0.80m peuvent n’être munnies qu’un seul catadioptre si elles sont a elées par les véhicules suivants: a) vélomoteur b) motocycle e sans side car c) les voitures de place d) aucune de réponses n’est correctes	68	\N
214	RW	Amatara maremare y’ibara ryera cyangwa ry’umuhondo agomba, nijoro igihe ijuru rikeye, kumurika mu muhanda mu ntera ya m 100 nibura imbere y’ikinyabiziga, ariko ku binyabiziga bifite moteri itarengeje za sen metero kibe 125 iyo ntera igira ibipimo bikurikira: a) m200 b) m100 c) m85 d) nta gisubizo cy’ukuri kirimo	69	\N
215	EN	Road lights, of white or yellow color, must at night, by fine weather, permit the illumina on of the roadway at a distance of at least 100m in front of the vehicle but for motor vehicles with engine capacity not exceeding 125cm3 this distance is reduced to: a) 200 m b) 100 m c) 85 m d) none of the answers is correct	69	\N
216	FR	les feux de route de couleur blanche ou jaune doivent, la nuit par atmosphere limpide, perme re un éclairage de la chaussée sur une distance d’au moins 100m en avant du véhicule, mais pour les véhicules à moteur dont le cylindrée n’excede pas 125cm3 ce e distance est reduite à: a) 200 m b) 100 m c) 85 m d) aucune de réponses n’est correctes	69	\N
217	RW	Iyo banyuze iruhande rw’inkomyi abanyamaguru bagomba gukikira banyuze mu muhanda, abayobozi bagomba gusiga umwanya ufite ubugari bwa m 1 nibura hagati yabo nayo. Iyo ibyo bidashobora kubahirizwa kandi umunyamaguru akaba anyura hafi yiyo nkomyi, umuyobozi agomba kuyikikira afite umuvuduko utarengeje ibipimo bikurikira: a) km 10 mu isaha b) km 20 mu isaha c) km 30 mu isaha d) nta gisubizo cy’ukuri kirimo	70	\N
218	EN	When passing near an obstacle which pedestrians must avoid by moving to the roadway, drivers must leave beside that obstacle, a free space of at least one meter wide, where this condi on cannot be met and a pedestrians walk near the obstacle, the driver can only pass beside the pedestrian at the following maximum speed: a) 10km/h b) 20km/h c) 30km/h d) none of the answers is correct	70	\N
219	FR	En passant près d’obstacle que les piètons doivent contourner en empruntant la chaussée, les conducteurs doivent laisser, le long de cet obstacle, un espace libre d’ou moins un metre. Si ceci est impossible et que le pièton passe tant près d’un obstacle le conducteur doit contourner avec une vitesse maximale de : a) 10 km / h b) 20 km / h c) 30 km / h d) aucune de réponses n’est correctes	70	\N
220	RW	Guhagarara akanya gato no guhagarara akanya kanini bibujijwe cyane cyane aha hakurikira: a) ku mihanda y’icyerekezo kimwe hose b) mu ruhande ruteganye n’urwo ikindi kinyabiziga gihagazemo akanya gato cyangwa kanini c) ku mihanda ibisikanirwamo, iyo ubugari bw’umwanya w’ibinyabiziga ugomba gutuma bibisikana butagifite m12 d) ibisubizo byose nibyo	71	\N
221	EN	Stopping and parking are forbidden par cularly in the following space: a) on the road of one way b) on the side opposite to where another vehicle is already at stop or in parking c) on the road ways where the traffic is performed in two direc on when the width of the passage having to permit the crossing of two other vehicles would be reduced to less than 12m d) all answers are correct	71	\N
417	FR	Un panneau de dépannage est caractérisé par les couleurs blanc, noir et bleu.	136	\N
222	FR	L’arrêt et le sta onnement sont interdits en par culier: a) sur toutes les chaussées à sens unique b) du côté oppose à celui oύ un véhicule est déjà à l’arrêt ou en sta onnement c) sur les chaussées oύ la circula on se fait dans les deux sens, lorsque la largeur du passage devant perme re le croissement de deux autres véhicules serait réduite de 12m d) toutes les réponses sont justes	71	\N
223	RW	Amatara ndangambere n’aya ndanganyuma y’imodoka zitarengeje m 6 z’uburebure na m 2 z’ubugari habariwemo imitwaro kdi nta kinyabiziga kindi kiziritseho ashobora gusimburwa n’amatara akurikira, iyo ibyo binyabiziga bihagaze umwanya muto cyangwa munini mu nsisiro bibangikanye ku ruhande rw’umuhanda: a) amatara magufi b) amatara ndangaburumbarare (c) amatara yo guhagarara umwanya munini d) nta gisubizo cy’ukuri kirimo	72	\N
224	EN	The front side lights and the back ones of motor vehicles the length and the width of which, load included, do not exceed respectively 6 and 2 m and to which no other vehicle is yoked can be replaced by the following lights when these vehicles at stop or in parking in suburbs are parallel to the border of the roadway a) head lights b) gauge lights (c) parking lights d) none of the answers is correct	72	\N
225	FR	Les feux de position avant et arrière des véhicules automobiles dont la longueur et la largeur, chargement compris, n’excèdent pas respectivement 6m et 2m et aux quells aucune autre véhicule n’est attelé peuvent être remplacés par des feux suivants lorsque ces véhicules, à l’arrêt ou en stationnement dans une agglomération, sont rangés parallèlement au bord de la chaussée. a) Les feux de croissement b) les feux de gabarit (c) les feux de stationnement d) Aucune de réponses n’est correctes	72	\N
226	RW	Iyo kuva bwije kugeza bukeye cyangwa bitewe nuko ibihe bimeze nk’igihe cy’igihu cyangwa cy’imvura bitagishoboka kubona neza muri m 200, imirongo y’ingabo z’igihugu zigendera kuri gahunda n’utundi dutsiko twose tw’abanyamaguru nk’imperekerane cyangwa udutsiko tw’abanyeshuri bari ku murongo bayobowe na mwarimu, iyo bagenda mu muhanda ku isonga hakaba hari abantu barenze umwe, bagaragzwa ku buryo bukurikira: (a) imbere ni itara ryera ritwariwe ku ruhande rw’ibumoso n’umuntu uri ku murongo w’imbere hafi y’umurongo ugabanya umuhanda mo kabiri b) inyuma ni itara umuhondo ritwariwe ku ruhande rw’ibumoso n’umuntu uri ku murongo w’inyuma hafi y’umurongo ugabanya umuhanda mo kabiri c) A na B ni ibisubizo by’ukuri d) nta gisubizo cy’ukuri kirimo	73	\N
227	EN	Between twilight and daybreak or because of circumstances such as fog or heavy rain, it is not possible to see distinctly up to distance of 200m, formation of armed forces on march and of all other groups of pedestrians such as procession or school children groups in lines under the supervision of a school master, when they move on the roadway with more than one front, must be signaled in the following way: (a) in front, by a white light held on the left side, by the individual in the first rank, and in the nearest position to the axis of the roadway b) at the back, by a yellow light held on the left side, by the individual in the nearest position to the axis of the roadway c) A and B both are correct d) none of the answers is correct	73	\N
228	FR	Lorsque, entre la tombée et le lever du jour ou en raison de circonstances, il n’est pas possible de voir distinctement jusqu’à distance de 200m tous les groupements de piétons tels que cortèges ou groupe d’écoliers en rang sous la conduite d’un moniteur lorsqu’ils circulent sur la chaussée à plus d’une personne à l’avant, ils doivent être signalés par: (a) à l’avant, par un feu blanc porté du côté gauche par l’individu qui se trouve au premier rang, le plus près de l’axe de la chaussée b) à l’arrière, par un feu jaune porté du côté gauche par l’individu qui se trouve au dernier rang, le plus près de l’axe de la chaussée c) A et B sont justes d) aucune de réponses n’est correctes	73	\N
229	RW	Imizigo yikorewe n’amagare, velomoteri, amapikipiki, ibinyamitende by’ibiziga bitatu nibyo ibiziga bine bifite cyangwa bidafite moteri inyuma n shobora kurenza ibipimo bikurikira:	74	\N
230	EN	The loading on bicycles, moped, motor bicycles and tricycles and quadricycles, with or without engine cannot project beyond the back edge of the vehicle by more than following measures:	74	\N
231	FR	Le chargement de bicyclettes, cyclomoteurs, motocyclettes et tricycles et quadricycles, avec ou sans moteur, ne peut dépasser à l’avant l’extrémité du véhicule ni à l’arrière de plus de mesures suivantes:	74	\N
232	RW	Itara ndanganyuma rigomba gushyirwa aha hakurikira:	75	\N
233	EN	The near position light of vehicle are to be fixed nearest:	75	\N
234	FR	Le feu de position arrière doit être placé:	75	\N
235	RW	Nta tara na rimwe cyangwa utugarurarumuri bishobora kuba bifunze kuburyo igice cyabyo cyo hasi cyane kimurika kitaba kiri hasi ya cm 40 kuva ku butaka igihe ikinyabiziga kidapakiye ariko ibyo n bikurikizwa ku matara akurikira:	76	\N
236	EN	No light or reflector can be placed in such a manner that the lowest point of its lighting surface be below 0.40m from the ground level, the vehicle being empty but this provision is applicable neither to the following lights:	76	\N
237	FR	Aucun feu ou catadioptre ne peut être placé de manière que le point le plus bas de sa plage éclairante se trouve à moins de 0.40m du sol, le véhicule étant à vide. Mais la présente disposition n’est pas applicable aux feux suivants:	76	\N
238	RW	Iyo tumuritswe n’amatara y’urugendo y’ikinyabiziga utugarurarumuri tugomba n’ijoro, igihe ijuru rikeye kubonwa n’umuyobozi w’ikinyabiziga kiri mu ntera ikurikira:	77	\N
239	EN	When they are illuminated by road lights of the vehicles, the reflectors must be seen at night, by fine weather, by the driver of another vehicle at a distance of the following measures:	77	\N
240	FR	Lorsqu’ils sont éclairés par les feux de route de ce véhicule, les catadioptres doivent être visibles la nuit, par atmosphère limpide, par le conducteur d’un véhicule se trouvant à distance suivante:	77	\N
241	RW	Ibinyabiziga bigendeshwa na moteri, hatarimo velomoteri n’ibinyabiziga bidapakiye umuvuduko wabyo udashobora kurenga km 50 mu isaha ahateganye bigomba kuba bifite ibikoresho by’ihoni byumvikanira mu ntera ikurikira:	78	\N
242	EN	Except the mopeds and the unloaded vehicles with the speed on a flat surface cannot exceed 50km per hour, others motor vehicles must be equipped with a sounding alarm apparatus which can be heard on the following distance:	78	\N
243	FR	Les véhicules automoteurs sauf les cyclomoteurs doivent être équipés d’un appareil avertisseur sonore pouvant être entendu à une distance suivante:	78	\N
244	RW	Ahatari mu nsisiro ibyapa biburira n’ibyapa byo gutambuka mbere bigomba gushyirwa mu ntera ikurikira y’ahantu habyerekana:	79	\N
245	EN	Outside the agglomerations, danger road signs and priority road signs must be placed at the following distance from the dangerous areas they signal:	79	\N
1626	RW	 Iki cyapa kivuga:	392	\N
1627	EN	This signal constitutes by:	393	\N
247	RW	Inkombe z’inzira nyabagendwa cyangwa z’umuhanda zishobora kugaragazwa n’ibikoresho ngarurarumuri. Ibyo bikoresho bigomba gushyirwaho ku buryo abagenzi babibona ku buryo bukurikira:	80	\N
248	EN	Borders of the public highway or of the roadway must be signaled by reflectors, these devices must be so set up as the following manner:	80	\N
249	FR	Les bords de la voie publique ou de la chaussée peuvent être signalés par des dispositifs réfléchissants, ces dispositifs doivent être placés de manière suivante:	80	\N
250	RW	Ahatari mu nsisiro, umuyobozi wese ugenza ikinyabiziga kimwe cyangwa ibinyabiziga bikomatanye bifite uburemere ntarengwa bwemewe burenga ibiro 3500 cyangwa bifite uburebure bwite burenga metero 10 agomba gusiga umwanya uhagije hagati ye n’ikinyabiziga kiri imbere...	81	\N
251	EN	Out of agglomerations, a driver of a car or a set of cars of which the maximum authorized weight exceeds 3500kg or of which the overall length exceeds 10m must leave a sufficient interval between vehicles...	81	\N
252	FR	En dehors des agglomérations, tout conducteur d’un véhicule ou d’un ensemble de véhicules dont le poids maximum autorisé dépasse 3500kg ou dont la longueur hors tout dépasse 10m doit laisser un intervalle suffisant...	81	\N
253	RW	Amatara ndangacyerekezo agomba kuba agizwe n’ibintu bifashe ku rumuri rumyasa, biringaniye ku buryo bigira umubare utari igiharwe ku mpande z’imbere n’inyuma z’ikinyabiziga ayo matara aba afite amabara akurikira: a) amatara y’imbere aba yera cyangwa ari umuhondo b) ayinyuma aba atukura cyangwa asa n’icunga rihishije (c) A na B ni ibisubizo by’ukuri	82	\N
254	EN	The direction indicating lights must be constituted by fixed systems with flashing light disposed in pair at the back and the front faces of the vehicle. These lights are characterized by these colors: a) the front lights are white or yellows b) the back light are red or orange (c) A and B are both correct d) the front lights are orange	82	\N
255	FR	Les feux indicateurs de direction doivent être constitués par des dispositifs fixés à lumière clignotante disposés sur les faces avant et arrière du véhicule, les ces feux sont en couleurs suivantes: a) les feux avant sont blancs ou jaunes b) les feux arrière sont rouges ou orange (c) A et B sont justes d) les feux avant sont oranges	82	\N
256	RW	Amahoni y’ibinyabiziga bigendeshwa na moteri agomba kohereza ijwi ry’injyana imwe rikomeza kandi ridacengera amatwi ariko ibinyabiziga bikurikira bishobora kugira ihoni ridasanzwe ridahuye n’ibivuzwe haruguru: a) ibinyabiziga ndakumirwa b) ibinyabiziga bikora ku mihanda c) ibinyabiziga bifite ubugari burenze m 2.10 (d) A na B ni ibisubizo by’ukuri	83	\N
257	EN	The sounding alarms of motor vehicles must emit a uniform sound, continuous and not shrilling, but these vehicles may be provided with a special alarm which does not meet the requirements of this paragraph: a) priority vehicles b) vehicles assigned to road maintenance c) the vehicles with the width exceed 2.10m (d) A and B are both correct	83	\N
258	FR	Les avertisseurs sonores des véhicules automoteurs doivent émettre un son uniforme, continu et non strident mais les véhicules suivants peuvent être munis d’un avertisseur special ne répondant pas aux exigences citées: a) les véhicules prioritaires b) les véhicules affectés à l’entretien du réseau routier c) les véhicules dont la largeur est supérieure à 2.10m (d) A et B sont juste	83	\N
259	RW	Icyapa kibuza kunyura kubindi binyabiziga byose uretse ibinyamitende ibiri n’amapikipiki adafite akanyabiziga ku ruhande gifite ibimenyetso by’amabara akurikira:	84	\N
260	EN	The signal of no overtaking vehicles with an engine apart from those with two wheels without a side car has the symbols of these colors:	84	\N
261	FR	Le signal indiquant l’interdiction de dépasser tous les véhicules à moteur autres que ceux à deux roues sans side car, possède les symboles de couleurs suivantes:	84	\N
262	RW	Icyapa kivuga ko hatanyurwa mu byerekezo byombi kirangwa n’ubuso bw’ibara rikurikira:	85	\N
263	EN	The signal prohibiting vehicular traffic from both directions is characterized by a surface of the following color:	85	\N
264	FR	Le signal indiquant interdiction de la circulation dans les deux sens est caractérisé par la surface de couleur suivante:	85	\N
265	RW	Ibinyabiziga bikurikira bigomba kugira ibikoresho by’ihoni byumvikanira mu ntera ya m 20:	86	\N
266	EN	The vehicles mentioned hereafter must be equipped with a sounding alarm apparatus can be heard at a distance of 20m:	86	\N
267	FR	Les véhicules mentionnés ci après doivent être équipés d’un appareil avertisseur sonore pouvant être entendu à une distance de 20m:	86	\N
268	RW	Imirongo y’ingabo z’igihugu zigendera kuri gahunda n’utundi dutsiko twose tw’abanyamaguru nk’imperekerane cyangwa udutsiko tw’abanyeshuri iyo bitagishoboka kubona neza muri m200...	87	\N
269	EN	When it is not possible to see distinctly up to a distance of 200m, the formation of armed forces on march and of all other groups of pedestrians must be signaled...	87	\N
270	FR	Lorsque entre la tombée et le lever du jour il n’est pas possible de voir distinctement jusqu’à distance de 200m...	87	\N
271	RW	Amatara ndangambere na ndanganyuma y’imodoka zitarengeje m 6 z’uburebure na m 2 z’ubugari...	88	\N
272	EN	The front and rear position lights of vehicles not exceeding 6m length and 2m width...	88	\N
273	FR	Les feux de position avant et arrière des véhicules dont la longueur et la largeur n’excèdent pas...	88	\N
274	RW	Amatara ndangaburumbarare agomba kubonwa nijoro igihe ijuru rikeye...	89	\N
275	EN	Loading lights must be visible at night by fine weather...	89	\N
276	FR	Les feux d’encombrement doivent être visibles la nuit...	89	\N
277	RW	Uretse ku byerekeye imihanda iromboreje...	90	\N
278	EN	Except on highways and roads for automobiles...	90	\N
279	FR	Sauf pour les autoroutes et les routes pour automobiles...	90	\N
280	RW	Ibimenyetso by’agateganyo bigizwe n’imitemeri y’ibara risa n’icunga rihishije...	91	\N
281	EN	Provisional marks constituted by orange colored studs may replace...	91	\N
282	FR	Des marques provisoires constituées par des cônes de couleur orange peuvent remplacer...	91	\N
283	RW	Iyo bitagishoboka kubona muri m 200 imodoka zikuruwe n’inyamaswa, ingorofani, inyamaswa zitwaye imizigo cyangwa zigenderwamo kimwe n’amatungo bigomba kurangwa na : a) imbere ni itara ryera b) imbere ni itara ry’umuhondo cyangwa risa n’icunga rihishije c) inyuma ni itara rimwe ritukura (d) ibisubizo byose ni ukuri	92	\N
332	EN	Temporary danger warning signs are characterized by the following colors: a) white and black b) white and yellow c) white surface only d) none of the answers is correct	108	\N
1628	FR	Ce signal comprend :	393	\N
284	EN	when it is not possible to see distinctly up to a distance of 200m, the presence on the public way, the animal pulled vehicles, hand carts, load or saddle animals and cattle must be signaled in the following way: a) in front, by a white light b) in front, by a yellow or orange light c) at the back, by red light (d) all answers are correct	92	\N
285	FR	Lorsque, entre la tombée et le lever du jour ou en raison de circonstances telles que les brouillards ou une forte pluie, il n’est pas possible de voir distinctement jusqu’à distance de 200m, la présence, sur la voie publique, des véhicules à traction animaux charrettes à bras, animaux de charge ou de selle et bétail, doit être signalée de la manière suivante: a) à l’avant par le feu blanc b) à l’avant par le feu jaune ou orange c) à l’arrière par le feu rouge (d) toutes les réponses sont correctes	92	\N
286	RW	Uretse igihe hari amategeko yihariye akurikizwa muri ako karere ikinyabiziga cyose gihagaze umwanya muto cyangwa munini, iyo gihagaze mu mwanya wo kuruhande wagenewe abanyamaguru, kugirango bashobore kugenda batagombye kunyura mu muhanda, umuyobozi agombye kubasigira akayira gafite byibura ibipimo bikurikira by’ubugari: (a) m 1 b) m 2 c) m 0.5 d)nta gisubizo cy’ukuri kirimo	93	\N
287	EN	Except local regulation or particular lay-out of the areas, every vehicle at stop or in parking, in case it is on pavement used by pedestrians, the driver must leave them at least a space of following measures to allow their passage without moving onto the roadway: (a) one meter wide band b) two meters wide band c) 0.50 meter wide band d) none of the answers is correct	93	\N
288	FR	Sauf réglementation locale ou aménagement particulier des lieux, tout véhicule à l’arrêt ou en stationnement, s’il s’agit d’un accotement que les piétons doivent emprunter pour leur permettre le passage sans devoir emprunter la chaussée, le conducteur doit laisser à leur disposition une bande d’au moins: (a) 1m b) 2m c) 0.50m d) aucune de réponses n’est correcte	93	\N
289	RW	Icyapa cyerekana ahantu hagenewe guhagararwamo n’imodoka nini zagenewe gutwara abantu cyirangwa n’ubuso bw’amabara akurikira: a) ubururu b) umweru c) umutuku (d) nta gisubizo cy’ukuri kirimo	94	\N
290	EN	The signal showing the place which is specifically reserved as a parking place for public transport is characterized by surface of this color: a) blue b) white c) red (d) none of the answers is correct	94	\N
291	FR	Le signal indiquant l’endroit réservé à l’arrêt de service régulier de transport en commun est caractérisé par une surface de couleurs suivante: a) bleu b) blanche c) rouge (d) aucune de réponses n’est correcte	94	\N
292	RW	Icyapa cyerekana ko inzira giteyeho mu ntangiriro idakomeza kigaragazwa n’ikirango cy’amabara akurikira: a) umukara n’umutuku b) umukara n’umweru c) umweru n’umutuku d) nta gisubizo cy’ukuri kirimo	95	\N
293	EN	The signal showing that the road, at the entrance of which it is placed, leads to a dead end is characterized by symbols of following colors: a) black and red b) black and white c) white and blue d) none of the answers is correct	95	\N
294	FR	Le signal indiquant que la voie à l’entrée de laquelle il est placé est sans issue est caractérisé par un symbole ayant une couleur suivante: a) noire et rouge b) noire et blanche c) blanche et bleue d) aucune de réponses n’est correcte	95	\N
295	RW	Buri modoka yagenewe gutwara abantu, ariko umubare wabo ntarengwa ukaba munsi ya 6 umuyobozi abariwemo igomba kugira imikandara yo kurinda ibyago igenewe aba bakurikira: a) umuyobozi b) umugenzi wicaye ku ntebe y’imbere c) ishobora no kugira imikandara kuzindi ntebe z’inyuma (d) ibisubizo byose ni ukuri	96	\N
296	EN	Every motor vehicle assigned to transport people of which the maximum number of occupants is below six, including the driver must be endowed with security belts for the following persons: a) the driver b) the passenger occupying the front seat c) it can also have belts on rear seats (d) all answers are correct	96	\N
297	FR	Tout véhicule automobile affecté au transport de personnes dont le nombre maximum d’occupants est inférieur à six, conducteur compris, doit être doté de ceintures de sécurité. Ces ceintures sont destinées aux personnes suivantes: a) conducteur b) passager occupant le siège avant du véhicule c) il peut également avoir des ceintures sur les autres sièges arrière (d) toutes les réponses sont justes	96	\N
298	RW	Usibye ibinyabiziga by'ingabo z'Igihugu, Ikinyabiziga kigendeshwa na moteri kiriho ibyuma ntamenwa cyangwa ikindi cyose gituma gikoreshwa mu gutera cyangwa mu kwitabara n gishobora kugenda mu nzira nyabagendwa kidafite uruhushya rwihariye. Urwo ruhushya rutangwa na: a) police y’igihugu b) minisitiri ushinzwe gutwara abantu n’ibintu c) minisitiri w’ingabo d) ikigo cy’igihugu gishinzwe imisoro n’amahoro	97	\N
299	EN	Except to armed forces vehicles, a motor vehicle with armor or any other device permitting to be used in aggression or defense cannot move on the public way without a special permission. This permission is authorized by: (a) the minister entrusted with transport or his delegate b) National Police c) minister of defense d) tax department	97	\N
300	FR	Sauf aux véhicules des forces armées, tout véhicule automoteur muni d’un blindage ou d’un dispositif quelconque permettant de l’utiliser comme d’agression ou de défense ne peut circuler sur la voie publique sans autorisation spéciale. Cette autorisation doit être donnée par: a) police nationale b) le ministre ayant les transports à ses attributions ou son délégué c) ministre de défense d) service des impôts	97	\N
301	RW	Iyo umukumbi ugizwe n’amatungo maremare arenze ane cyangwa amatungo magufi arenze atandatu mu nzira nyabagendwa iyo hatakibona neza kuburyo umuyobozi abona muri m 200 ugomba kugaragazwa kuburyo bukurikira: a) itara ry’urumuri rwera cyangwa risa n’icunga rihishije imbere y’umukumbi b) itara ry’urumuri rutukura cyangwa umuhondo ritwawe inyuma y’umukumbi c) A na B ni ibisubizo by’ukuri (d) nta gisubizo cy’ukuri kirimo	98	\N
302	EN	Between twilight and day break, where a herd comprises more than four heads of cattle or more than six of small animals, it will be signaled by: a) white or orange hand lamp borne in front of herd b) red or yellow hand lamp borne at the back of the herd c) A and B are both correct (d) none of the answers is correct	98	\N
303	FR	Entre la tombée et lever du jour, si un troupeau comprend plus de quatre têtes de gros bétail ou plus de 6 têtes de petit bétail, il sera signalé par: a) une lanterne à feu blanc ou orange portée à l’avant du troupeau b) une lanterne à feu rouge ou jaune portée à l’arrière du troupeau c) A et B sont justes (d) aucune de réponses n’est correcte	98	\N
304	RW	Ibinyabiziga biherekeranyije mu butumwa n bishobora gutonda uburebure burenga umurongo wa m 500. Ibi bibaye bityo ibinyabiziga biherekeranye mu butumwa bishobora kugabanwamo amatsinda atonze umurongo atarengeje m 50 z’uburebure kdi hagati yayo hakaba byibura m 50 ariko ibyo n bikurikizwa kubinyabiziga bikurikira: a) ibinyabiziga bya police biherekeranyije b) ibinyabiziga by’abasirikare biherekeranyije mu nsisiro c) A na B ni ibisubizo by’ukuri d) nta gisubizo cy’ukuri kirimo	99	\N
305	EN	A convoy cannot occupy a distance of more than 500m. When this occurs, it must be divided into groups of vehicles occupying the way of a maximum 50m. however these provisions are not applicable to: a) vehicle of Rwanda national police b) military vehicles forming a convoy in built-up areas c) A and B are both correct d) none of the answer is correct	99	\N
306	FR	Un convoi peut s’étendre sur une longueur de plus de 500m. le cas échéant le convoi doit être fractionné en groupes de véhicules occupant la voie sur une longueur de 50m au plus et séparés par un intervalle d’au moins 50m. toutes fois, les dispositions qui précèdent ne sont pas applicables aux véhicules suivants: a) les véhicules de la police nationale b) les véhicules militaires formant un convoi dans les agglomérations c) A et B sont justes d) aucune de réponses n’est correcte	99	\N
307	RW	Iyo ikinyabiziga gikururwa n’inyamaswa nac gikuruye ikindi uburebure bw’ibikururwa bukab burenga m 18 hatabariwemo icyo kinyabiziga cya mbere kiziritseho hagomba ibi bikurikira: (a) umuherekeza w’ikinyabiziga cya kabiri b) abaherekeza babiri c) A na B ni ibisubizo by’ukuri d) nta gisubizo cy’ukuri kirimo	100	\N
308	EN	When a second vehicle is trailed by a yoked vehicle and that the length of the line overpasses 18m exclusive of the first vehicle shaft, they process the following: (a) the second vehicle must be accompanied by a conveyor b) two conveyors c) A and B are both correct d) none of the answers is correct	100	\N
309	FR	Lorsqu’un véhicule attelé à une remorque et que la longueur du train dépasse 18m, non compris le mont du premier véhicule, que doit-on faire pour bien contrôler la circulation? (a) un convoyeur doit accompagner le second véhicule b) deux convoyeurs doivent accompagner le second véhicule c) A et B sont justes d) aucune de réponses n’est correcte	100	\N
310	RW	Ibinyabiziga bikurikira n bitegetswe kugira ibimenyetso bibyerekana iyo byambukiranya umuhanda cyangwa bigenda ku ruhande rwawo: a) ibinyabiziga bigendwamo n’abana b) ibinyabiziga bigendwamo n’abamugaye (c) A na B ni ibisubizo by’ukuri d) nta gisubizo cy’ukuri kirimo	101	\N
311	EN	The obligation to be equipped with a signaling system does not apply to the following vehicles: a) baby cars b) wheel chairs (c) A and B are both correct d) none of the answers is correct	101	\N
312	FR	L’obligation d’être pourvus de dispositifs de signalisation n’est pas applicable aux véhicules suivants: a) voiture d’enfants b) voiture d’infirmes (c) A et B sont justes d) aucune de réponses n’est correcte	101	\N
313	RW	Icyapa cy’inyongera kigaragaza ikibanza cy’ingando cyangwa cy’abantu benshi bagender ku nyamaswa kirangwa n’amabara akurikira: (a) ubururu, umweru n’umutuku b) umukara, umweru n’umuhondo c) icyatsi kibisi, umuhondo n’ikirango cy’umukara d) nta gisubizo cy’ukuri kirimo	102	\N
314	EN	The additional road sign showing a camping or caravan site is characterized by the following colors: (a) blue, white and red b) black, white and yellow c) green, yellow with black symbol d) none of the answers is correct	102	\N
315	FR	Le panneau additionnel indiquant un terrain de camping ou de caravaning est caractérisé par les couleurs suivantes: (a) bleu, blanc et rouge b) noir, blanc et jaune c) vert, jaune avec symbole noir d) aucune de réponses n’est correcte	102	\N
316	RW	Icyapa cyerekana ahantu amategeko y’umuhanda urombeje atangirira gukurikizwa kirangwa n’amabara akurikira: a) umweru n’umukara b) umweru n’umutuku c) umweru n’umuhondo d) nta gisubizo cy’ukuri kirimo	103	\N
317	EN	The sign showing the place where special road traffic rules start is characterized by the following colors: a) white and black b) white and red c) white and yellow d) none of the answers is correct	103	\N
318	FR	Le signal indiquant l’endroit à partir duquel les règles spéciales de circulation routière commencent est caractérisé par les couleurs suivantes: a) blanc et noir b) blanc et rouge c) blanc et jaune d) aucune de réponses n’est correcte	103	\N
319	RW	Iyo imirimo yo mu muhanda ibangamira cyangwa ikabuza gukomeza kugenda, ahakorerwa imirimo hagaragazwa n’ibi bikurikira: a) icyapa cyera cya mpande enye zingana gifite 0.30m b) uruzitiro ku mpera y’iburyo c) A na B ni ibisubizo by’ukuri d) nta gisubizo cy’ukuri kirimo	104	\N
320	EN	When road works completely or partially hinder traffic, the site is signaled as follows: a) a white square panel of 0.30m side b) a barrier placed on the right side c) A and B are both correct d) none of the answers is correct	104	\N
321	FR	Lorsque les travaux gênent totalement ou partiellement la circulation, le chantier est signalé comme suit: a) panneau blanc carré de 0.30m b) barrière placée à droite c) A et B sont justes d) aucune de réponses n’est correcte	104	\N
322	RW	Iyo imirimo yo mu muhanda isaba abayobozi kuva mu mwanya wabo, ikimenyetso gitegeka kunyura ahateganijwe kirangwa n’amabara akurikira: a) ubururu n’umweru b) umutuku n’umweru hamwe n’umukara c) umutuku, umweru n’umukara d) nta gisubizo cy’ukuri kirimo	105	\N
323	EN	When road works require drivers to leave their normal lane, the compulsory direction sign is characterized by the following colors: a) blue and white b) red and white with black symbol c) red, white and black d) none of the answers is correct	105	\N
324	FR	Lorsque les travaux obligent les conducteurs à quitter leur voie normale, le signal de direction obligatoire est caractérisé par les couleurs suivantes: a) bleu et blanc b) rouge et blanc avec symbole noir c) rouge, blanc et noir d) aucune de réponses n’est correcte	105	\N
325	RW	Icyapa cyerekana amategeko yihariye mu cyambu cyangwa ku kibuga cy’indege kirangwa n’ibi bikurikira: a) ishusho mpandeshatu, umweru n’umukara b) ishusho mpandenye, ubururu n’umweru c) uruziga rw’ubururu n’umweru d) nta gisubizo cy’ukuri kirimo	106	\N
326	EN	The sign indicating special regulations in a port or airport is characterized by: a) triangle shape, white and black b) square shape, blue and white c) circle shape, blue and white d) none of the answers is correct	106	\N
327	FR	Le signal indiquant des règles spéciales dans un port ou un aéroport est caractérisé par: a) triangle, blanc et noir b) carré, bleu et blanc c) cercle, bleu et blanc d) aucune de réponses n’est correcte	106	\N
328	RW	Itara ryo ku nomero y’icyapa cy’imodoka rigomba gutuma izo numero zisomerwa nibura ku ntera ikurikira: a) 150m b) 50m c) 20m d) 10m	107	\N
329	EN	The illumination light of a vehicle registration plate must make the number readable at a minimum distance of: a) 150m b) 50m c) 20m d) 10m	107	\N
330	FR	Le feu d’éclairage de la plaque d’immatriculation doit permettre la lecture à une distance minimale de: a) 150m b) 50m c) 20m d) 10m	107	\N
331	RW	Ibyapa byerekana icyago cy’agateganyo bigaragazwa n’amabara akurikira: a) umweru n’umukara b) umweru n’umuhondo c) ubuso bw’umweru gusa d) nta gisubizo cy’ukuri kirimo	108	\N
368	EN	When loading exceeds normal width limits, it may reach up to: a) 4m b) 3.50m c) 3m d) none of the answers is correct	120	\N
333	FR	Les signaux de danger temporaire sont caractérisés par les couleurs suivantes: a) blanc et noir b) blanc et jaune c) surface blanche uniquement d) aucune de réponses n’est correcte	108	\N
334	RW	Birabujijwe kubangamira imigendere y’ibindi binyabiziga kubera kugenda gahoro cyane cyangwa gukorera feri gitunguranye bidatewe n’impamvu z’umutekano: a) kugenda gahoro cyane b) gukorera feri gitunguranye c) A na B ni ibisubizo by’ukuri d) nta gisubizo cy’ukuri kirimo	109	\N
335	EN	It is forbidden to obstruct normal traffic flow by abnormally low speed or sudden braking without safety reasons: a) abnormally low speed b) sudden braking c) A and B are both correct d) none of the answers is correct	109	\N
336	FR	Il est interdit de gêner la circulation normale par une vitesse anormalement réduite ou un freinage brusque sans raison de sécurité: a) vitesse anormalement réduite b) freinage brusque c) A et B sont justes d) aucune de réponses n’est correcte	109	\N
337	RW	Iyo hatagishoboka kubona neza muri m200, romoruki ikururwa n’ipikipiki igaragazwa n’itara rikurikira: a) itara ryera inyuma b) itara ry’umuhondo inyuma c) itara risa n’icunga inyuma d) ibisubizo byose ni ukuri	110	\N
338	EN	When visibility is reduced to 200m, a trailer pulled by a motorcycle is indicated by: a) white rear light b) yellow rear light c) orange rear light d) all answers are correct	110	\N
339	FR	Lorsque la visibilité est réduite à 200m, une remorque tirée par une motocyclette est signalée par: a) feu blanc arrière b) feu jaune arrière c) feu orange arrière d) toutes les réponses sont justes	110	\N
340	RW	Amatara maremare agomba kuzimwa iyo umuhanda umurikiwe neza cyangwa hari ikinyabiziga kiri imbere mu ntera ya m100: a) igihe umuhanda umurikiwe neza b) igihe hari ikinyabiziga kiri imbere c) A na B ni ibisubizo by’ukuri d) nta gisubizo cy’ukuri kirimo	111	\N
341	EN	High beam lights must be switched off when the road is well lit or when a vehicle is within 100m ahead: a) well-lit road b) vehicle ahead within 100m c) A and B are both correct d) none of the answers is correct	111	\N
342	FR	Les feux de route doivent être éteints lorsque la chaussée est bien éclairée ou lorsqu’un véhicule est à moins de 100m devant: a) chaussée bien éclairée b) véhicule à moins de 100m c) A et B sont justes d) aucune de réponses n’est correcte	111	\N
343	RW	Iyo akanyabiziga gasunikwa cyangwa ibyo gatwaye bidatuma umuyobozi abona neza imbere ye, uwo muyobozi agomba gukora ibi bikurikira: a) gushaka umuherekeza b) gukurura ikinyabiziga cye c) A na B ni ibisubizo by’ukuri d) nta gisubizo cy’ukuri kirimo	112	\N
344	EN	When a barrow or its loading does not allow sufficient visibility, the driver must: a) look for a conveyor to help him b) pull his vehicle c) A and B are both correct d) none of the answers is correct	112	\N
345	FR	Lorsqu’une charrette à bras ou son chargement ne laisse pas au conducteur une visibilité suffisante vers l’avant, le conducteur doit: a) chercher un convoyeur b) tirer son véhicule c) A et B sont justes d) aucune de réponses n’est correcte	112	\N
346	RW	Ikinyabiziga cyangwa inyamaswa ihagaze igomba kuba: a) mu kaboko k’iburyo b) ahegereye akayira k’abanyamaguru c) A na B ni ibisubizo by’ukuri d) nta gisubizo cy’ukuri kirimo	113	\N
347	EN	Every stopped vehicle or animal must be: a) on the right side b) as close as possible to the pavement c) A and B are both correct d) none of the answers is correct	113	\N
348	FR	Tout véhicule ou animal à l’arrêt doit être rangé: a) à droite b) le plus près possible du trottoir c) A et B sont justes d) aucune de réponses n’est correcte	113	\N
349	RW	Iyo ikinyabiziga gihagaze nijoro kigomba kugaragazwa n’ikimenyetso ariko ntibireba: a) velomoteri b) ipikipiki idafite akanyabiziga c) A na B ni ibisubizo by’ukuri d) nta gisubizo cy’ukuri kirimo	114	\N
350	EN	A vehicle immobilized at night must be signaled except: a) bicycles b) motorcycles without side car c) A and B are both correct d) none of the answers is correct	114	\N
351	FR	Tout véhicule immobilisé la nuit doit être signalé sauf: a) cyclomoteur b) motocyclette sans side-car c) A et B sont justes d) aucune de réponses n’est correcte	114	\N
352	RW	Abanyamaguru bagomba kunyura mu nzira zabugenewe ariko hari abo bitareba: a) abahagarara igihe bambuka b) udutsiko tw’abantu benshi c) A na B ni ibisubizo by’ukuri d) nta gisubizo cy’ukuri kirimo	115	\N
353	EN	Pedestrians must use sidewalks except: a) those stopping while crossing b) large groups c) A and B are both correct d) none of the answers is correct	115	\N
354	FR	Les piétons doivent emprunter les trottoirs sauf: a) ceux qui s’arrêtent en traversant b) les grands groupes c) A et B sont justes d) aucune de réponses n’est correcte	115	\N
355	RW	Ibinyabiziga biherekeranyije mu butumwa bishobora kugabanywa mu matsinda atarengeje m50. Ibi ni: a) 50m maximum b) 100m c) 150m d) nta gisubizo cy’ukuri kirimo	116	\N
356	EN	A convoy must be divided into groups not exceeding: a) 50m b) 100m c) 150m d) none of the answers is correct	116	\N
357	FR	Un convoi doit être fractionné en groupes ne dépassant pas: a) 50m b) 100m c) 150m d) aucune de réponses n’est correcte	116	\N
358	RW	Ibyapa by’inkomane y’inzira nyabagendwa bigomba kugaragara ku ntera ya: a) 200m b) 250m c) 300m d) nta gisubizo cy’ukuri kirimo	117	\N
359	EN	Road intersection signals must be visible at least at: a) 200m b) 250m c) 300m d) none of the answers is correct	117	\N
360	FR	Les signaux d’intersection doivent être visibles à: a) 200m b) 250m c) 300m d) aucune de réponses n’est correcte	117	\N
361	RW	Imbibi z’ubwihugiko bw’abanyamaguru zisigwa irangi rya: a) umuhondo ngarurarumuri b) umweru c) icunga rihishije d) nta gisubizo cy’ukuri kirimo	118	\N
362	EN	Posts at pedestrian refuges are painted: a) reflective yellow b) reflective white c) reflective orange d) none of the answers is correct	118	\N
363	FR	Les bornes des refuges pour piétons sont peintes en: a) jaune réfléchissant b) blanc réfléchissant c) orange réfléchissant d) aucune de réponses n’est correcte	118	\N
364	RW	Kugira ngo ikinyabiziga kive ahantu hari urwondo cyangwa kunyerera gishobora gukoresha: a) iminyururu irwanya ubunyerere b) udushundu ku nziga c) A na B ni ibisubizo by’ukuri d) nta gisubizo cy’ukuri kirimo	119	\N
365	EN	To move from muddy or slippery areas, a vehicle may use: a) anti-skid chains b) wheel protrusions c) A and B are both correct d) none of the answers is correct	119	\N
366	FR	Pour sortir des passages boueux ou glissants, un véhicule peut utiliser: a) chaînes antidérapantes b) saillies sur les roues c) A et B sont justes d) aucune de réponses n’est correcte	119	\N
367	RW	Iyo imizigo irenze ubugari bwemewe, mu gihe runaka ubugari bushobora kugera kuri: a) 4m b) 3.50m c) 3m d) nta gisubizo cy’ukuri kirimo	120	\N
1629	RW	Iki cyapa kigizwe:	393	\N
369	FR	Lorsque le chargement dépasse la largeur normale, il peut atteindre: a) 4m b) 3.50m c) 3m d) aucune de réponses n’est correcte	120	\N
370	RW	Mu mujyi n’imihanda y’igihugu, uburemere ntarengwa bw’ikamyo bushobora kugera kuri: a) 10 tonnes b) 16 tonnes c) 24 tonnes d) nta gisubizo cy’ukuri kirimo	121	\N
371	EN	In urban areas and national roads, the maximum load for a lorry may reach: a) 10 tonnes b) 16 tonnes c) 24 tonnes d) none of the answers is correct	121	\N
372	FR	En ville et sur les routes nationales, le poids maximum d’un camion peut atteindre: a) 10 tonnes b) 16 tonnes c) 24 tonnes d) aucune de réponses n’est correcte	121	\N
373	RW	Iyo bitewe n’imiterere y’ahantu intera itandukanya icyapa n’ahantu habi iri munsi ya m150, yerekanwa n’icyapa cy’inyongera giteye ku buryo bukurikira: a) kare ifite ubuso bw’ibara ryera b) urukiramende rufite ubuso bw’ibara ryera c) mpandeshatu ifite umuzenguruko utukura d) nta gisubizo cy’ukuri kirimo	122	\N
374	EN	Where, because of the layout of the area, the distance between the sign and the dangerous place is less than 150m, it is indicated by an additional sign: a) square with white surface b) rectangle with white surface c) triangle with red perimeter d) none of the answers is correct	122	\N
375	FR	Si en raison de la disposition des lieux, la distance séparant le signal de l’endroit dangereux est inférieure à 150m, elle est indiquée par un signal additionnel: a) carré blanc b) rectangle blanc c) triangle à contour rouge d) aucune réponse correcte	122	\N
376	RW	Amatara yo kubisikana y’ibara ryera cyangwa umuhondo agomba nijoro mu gihe ijuru rikeye kumurika nibura mu ntera ya m100 imbere y’ikinyabiziga.	123	\N
377	EN	Crossing lights of white or yellow color must, at night in clear weather, illuminate the road at least 100m ahead.	123	\N
378	FR	Les feux de croisement blancs ou jaunes doivent, la nuit par temps clair, éclairer la chaussée sur au moins 100m.	123	\N
379	RW	Igihe hari impinduka zireba nyir’ikarita cyangwa ikinyabiziga zigomba kumenyeshwa ubuyobozi bw’imisoro mu minsi 15.	124	\N
380	EN	Any change concerning the owner or vehicle identification must be declared to the tax office within 15 days.	124	\N
381	FR	Toute modification concernant le titulaire ou l’identification du véhicule doit être déclarée au service des impôts dans un délai de 15 jours.	124	\N
382	RW	Itara ry’umuhondo rimyasa ryerekana ahantu habi ntirihindura amategeko y’ibyerekeye gutambuka mbere.	125	\N
383	EN	A flashing yellow light indicating danger does not change priority rules.	125	\N
384	FR	Un feu jaune clignotant indiquant un danger ne modifie pas les règles de priorité.	125	\N
385	RW	Romoruki zifite ubugari butarengeje m0.80 zishobora kugira akagarurarumuri kamwe gusa iyo zikururwa n’igare, velomoteri cyangwa ipikipiki.	126	\N
386	EN	Trailers not exceeding 0.80m in width may have only one reflector when towed by bicycles, mopeds or motorbikes.	126	\N
387	FR	Les remorques ne dépassant pas 0,80m de largeur peuvent n’avoir qu’un seul catadioptre lorsqu’elles sont tractées par vélo, cyclomoteur ou moto.	126	\N
388	RW	Amatara maremare y’ibinyabiziga bya moteri nto (munsi ya 125cc) agomba kumurika nibura mu ntera ya m75.	127	\N
389	EN	High beam lights of motor vehicles under 125cc must illuminate the road at least 75m ahead.	127	\N
390	FR	Les feux de route des véhicules de moins de 125 cm³ doivent éclairer la chaussée sur au moins 75m.	127	\N
391	RW	Iyo ubugari bw’ikinyabiziga burenze m2.50 kigomba kugaragazwa n’amatara y’umuhondo cyangwa icunga rihishije ku mpera zacyo.	128	\N
392	EN	When a vehicle exceeds 2.50m width, it must be signaled with yellow or orange lights at its extremities.	128	\N
393	FR	Lorsque la largeur d’un véhicule dépasse 2,50m, il doit être signalé par des feux jaunes ou orange aux extrémités.	128	\N
394	RW	Imirongo yera idacagaguye igaragaza inkombe y’umuhanda igena igice kigenewe guhagarara gusa.	129	\N
395	EN	A continuous white line marking the edge of the road reserves the area for stopping only.	129	\N
396	FR	Une ligne blanche continue marque le bord de la chaussée et réserve la zone à l’arrêt seulement.	129	\N
397	RW	Iminyururu n’ibindi byuma bifasha imodoka mu kunyura ahanyerera bishobora gukoreshwa ku binyabiziga byose uretse imashini zihinga.	130	\N
398	EN	Chains and anti-skid accessories may be used on vehicles except agricultural machines.	130	\N
399	FR	Les chaînes et accessoires antidérapants peuvent être utilisés sur tous les véhicules sauf les machines agricoles.	130	\N
400	RW	Ku binyabiziga cyangwa ibinyabiziga bikururana igice kirenga ku biziga ntigishobora kurenga: inyuma m3, imbere m2.70	131	\N
401	EN	On vehicles or a line of vehicles, the overhanging must not exceed: rear 3m, front 2.70m	131	\N
402	FR	Aux véhicules ou train de véhicules, le porte-à-faux ne peut pas dépasser: arrière 3m, avant 2.70m	131	\N
403	RW	Birabujijwe gushyira mu muhanda ibinyabiziga birenze uburemere bwemewe keretse hari ibisonewe n’amategeko.	132	\N
404	EN	It is forbidden to put or maintain in circulation vehicles exceeding authorized weight unless legally exempted.	132	\N
405	FR	Il est interdit de mettre en circulation des véhicules dépassant le poids autorisé sauf exemptions légales.	132	\N
406	RW	Gushyira mu muhanda ibinyabiziga bikururana birenze bitatu bisaba uruhushya, uretse ibinyabiziga by’ubuhinzi n’iyamamaza.	133	\N
407	EN	Moving convoys of more than three vehicles requires authorization except for agricultural and advertising vehicles.	133	\N
408	FR	La circulation de convois de plus de trois véhicules nécessite une autorisation sauf pour les véhicules agricoles et publicitaires.	133	\N
409	RW	Ibinyamitende itatu bifite moteri bigomba kugira amatara ndangambere n’inyuma hamwe n’utugarurarumuri.	134	\N
410	EN	Motor tricycles must have front and rear position lights and reflectors.	134	\N
411	FR	Les tricycles à moteur doivent être munis de feux de position avant et arrière ainsi que de catadioptres.	134	\N
412	RW	Ibyapa bibuza n’ibitegeka bikurikizwa hagati y’aho bishyizwe n’inkomane ikurikira.	135	\N
413	EN	Prohibition and obligation signs apply between their location and the next junction.	135	\N
414	FR	Les panneaux d’interdiction et d’obligation s’appliquent entre leur emplacement et la prochaine intersection.	135	\N
415	RW	Icyapa cyerekana aho bagobokera ibinyabiziga kirangwa n’amabara y’umweru, umukara n’ubururu.	136	\N
416	EN	A breakdown service sign is characterized by white, black and blue colors.	136	\N
418	RW	Icyapa cyerekana igice cy’umuhanda kigaragazwa n’ubuso bw’ubururu n’ibimenyetso by’umweru.	137	\N
419	EN	A sign indicating a dangerous section is characterized by a blue background and white symbols.	137	\N
420	FR	Un panneau indiquant une section dangereuse est caractérisé par un fond bleu et des symboles blancs.	137	\N
421	RW	Umurongo w’umuhondo ucagaguye ugaragaza ko guhagarara no parikingi bibujijwe.	138	\N
422	EN	A broken yellow line means stopping and parking are prohibited.	138	\N
423	FR	Une ligne jaune discontinue signifie interdiction d’arrêt et de stationnement.	138	\N
427	RW	Ku binyabiziga bikururana igice kirenga ku biziga ntigishobora kurenga:	139	\N
428	EN	On vehicles or convoys, overhang must not exceed 	139	\N
429	FR	Pour les véhicules ou convois, le porte-à-faux ne peut dépasser	139	\N
430	RW	Mu migi no ku yindi mihanda y’igihugu igenwa na minisi ri ushinzwe gutwara abantu n’ibintu uburebure ntarengwa kuri buri mitambiko 3 ifungwaho ibiziga bine ni:	140	\N
431	EN	In urban areas as well as on na onal roads determined by the Minister having transports in his du e the maximum weights authorized by vehicle or train of vehicles for triple axle are:	140	\N
432	FR	Dans les circonscrip ons urbaines ainsi que sur les routes na onales determinées par le ministre ayant les transports dans ses a ribu ons, le poids maximum athorisé par véhicule ou train des véhicules par essieu triple sont:	140	\N
433	RW	Iyo haga y’uruhande rw’imbere rwa romoruki n’uruhande rw’inyuma rw’ikinyabiziga kiyikurura hari umwanya urenze m 3 ikibizirikanyije kigomba kugaragazwa ku buryo bukurikira iyo amatara y’ikinyabiziga agomba gucanwa:	141	\N
434	EN	When the distance between the front of a trailer and the back of the towing vehicle exceeds 3m, when the ligh ng of the vehicle is required, thei fastening must be signaled by:	141	\N
435	FR	Dès que la distance entre la face avant d’une remorque et la face arrière du véhicule tracteur dépasse 3m et lorsque l’éclairage du véhicule est requis, l’a ache doit être éclairée par:	141	\N
436	RW	Itara ryo guhagarara ry’ibara ritukura rigomba kuba ridahumisha, kandi rigomba kugaragarira mu ntera ikurikira:	142	\N
437	EN	The brake light of red color, must, without dazzling, be visible to the following distance:	142	\N
438	FR	Les feux de stop, de couleur rouge, doit, sans être éblouissant, être visible à une distance suivante:	142	\N
439	RW	Birabujijwe kongera ku mpande z’ikinyabiziga kigendeshwa na moteri cyangwa velomoteri ibi bikurikira:	143	\N
440	EN	It is forbidden to add outside a motor vehicle or a moped the following:	143	\N
441	FR	Il est interdit d’ajouter à l’extérieur d’un véhicule automoteur ou d’un cyclomoteur les objects suivants:	143	\N
442	RW	Ikintu cyose cyatuma hahindurwa ibyanditswe bireba nyirikarita cyangwa ibiranga ikinyabiziga kigomba kumenyeshwa ibiro by’imisoro haba mu magambo cyangwa mu ibaruwa ishinganye. Ibyo bikorwa mu gihe kingana gute:	144	\N
443	EN	Every fact requiring to change any men on rela ng to the owner of the cer ficate or to the iden fica on of the vehicle must be no fied at the tax department, either orally or by a registered le er within the following days:	144	\N
444	FR	Tout fait appellant une modifica on des men ons rela ves au tulaire du cer ficat ou à l’iden fica on du véhicule doit être no fié au service des impôts soit verbalement, soit par le re recommandée dans les jours suivants:	144	\N
445	RW	Kunyuranaho bikorerwa:	145	\N
446	EN	Overtaking is performed on	145	\N
447	FR	Les depassements s’effectuent	145	\N
448	RW	Iyo ubugari bw’inzira nyabagendwa igenderwamo n’ibinyabiziga budahagije kugirango bibisikane nta nkomyi abagenzi bategetswe:	146	\N
449	EN	Where the width of the public roadway used by vehicles is inadequate to permit them to cross without danger, users have to:	146	\N
450	FR	Lorsque la largeur de la voie publique u lisable par les véhicules est insuffisante pour leur perme re de se croiser sans danger, les usagers sont tenus de:	146	\N
451	RW	Umuyobozi ugenda mu muhanda igihe ubugari bwawo budatuma anyuranaho nta nkomyi ashobora kunyura mu kayira k’abanyamaguru ariko amaze kureba ibi bikurikira:	147	\N
452	EN	The driver who moves on a roadway may, when the width of this road does not permit to perfor the overtaking, move to the ve he must respect:	147	\N
453	FR	Le conducteur qui circule sur la chaussée peut, lorsque la largeur de celle-ci ne permet pas d’effectuer oisésement un dépassement, emprunter l’accotement de plain-pied mais il doit tenir compte sur:	147	\N
454	RW	Icyapa cyerekana umuvuduko ntarengwa ikinyabiziga kitagomba kurenza gishyirwa ku binyabiziga bifite uburebure ntarengwa bukurikira:	148	\N
455	EN	A plate men oning the maximum speed that the vehicle cannot t authorized to the vehicles with following authorized weight:	148	\N
456	FR	Une plaque indiquant la vitesse maximum que le véhicule ne peut dépasser est autorisé sur les véhicules don’t les poids maximum autorisé depassent les measures suivantes:	148	\N
457	RW	Iyo nta mategeko awugabanya by’umwihariko, umuvuduko ntarengwa w’amapikipiki mu isaha ni:	149	\N
458	EN	In the absence of more restric ve regula ons, maximum speed o motorcycles is:	149	\N
459	FR	A defaut de réglementa on plus restric ve, la vitesse maximale de motocycle e est:	149	\N
460	RW	Ahatari mu nsisiro umuvuduko ntarengwa wa velomoteri mu isaha ni:	150	\N
461	EN	Out of agglomera on, the maximum speed of the moped is	150	\N
462	FR	En dehors des agglomera ons, la vitesse maximale de cyclometeur est:	150	\N
463	RW	Birabujijwe guhagarara akanya kanini aha hakurikira:	151	\N
464	EN	Stopping and parking are forbidden par cularly in the following space:	151	\N
465	FR	L’arrêt et le sta onnement sont interdits en par culier:	151	\N
466	RW	Amatara maremare y’ikinyabiziga agomba kutamurika mu bihe bikurikira:	152	\N
467	EN	Bright lights of the vehicle must be switched off when:	152	\N
468	FR	Les feux de route d’un véhicule doivent être éteints:	152	\N
469	RW	Ubugari bwa romoruki ikuruwe n’igare cyangwa velomoteri n burenza ibipimo bikuri kira:	153	\N
470	EN	The width of trailer when is trailed by a bicycle or a moped cannot exceed the following limits:	153	\N
471	FR	La largeur d’une remorque lorsqu’elle est rée par une bicycle e ou un cyclomoteur est limité à:	153	\N
472	RW	Uburyo bukoreshwa kugirango ikinyabiziga kigende gahoro igihe feri idakora neza bwitwa:	154	\N
473	EN	The device used for slowing down or stopping the vehicle in the event of the in service braking failure called:	154	\N
474	FR	Le disposi f des né à relen r et arrêter le véhicule en cas de défaillance du frein de service appelé:	154	\N
475	RW	Nta mwanya n’umwe feri ifungiraho ushobora kurekurana n’ibiziga keretse:	155	\N
476	EN	No braked surface can be uncoupled from wheels except:	155	\N
477	FR	Aucune surface freinée ne doit pouvoir être désaccouplée des roues sauf:	155	\N
478	RW	Ikinyabiziga n gishobora kugira amatara arenze abiri y’ubwoko bumwe keretse kubyerekeye amatara akurikira:	156	\N
479	EN	A vehicle cannot be equipped with more than two lights of the same denomina on except:	156	\N
480	FR	Un véhicule ne peut être muni de plus de deux feux de meme dénomina on à l’excep on de:	156	\N
481	RW	Itara ndanganyuma rigomba gushyirwa aha hakurikira:	157	\N
482	EN	The rear posi on light of vehicle is to be fixed nearest:	157	\N
483	FR	Le feu de posi on arrière doit être placé:	157	\N
484	RW	Nibura ikinyabiziga gitegetswe kugira udutuhanagurabirahuri dukurikira:	158	\N
485	EN	How many windscreen wipers at minimum must every vehicle be provided with?	158	\N
486	FR	Combien d’essuie-glaces au minimum tout vehicule est obligé d’avoir?	158	\N
487	RW	Ibiziga by’ibinyabiziga bigendeshwa na moteri n’ibya velomoteri kimwe n’ibya romoruki zabyo bigomba kuba byambaye inziga zihagwa zifite amano n’ubujyakuzimu butari munsi ya milimetero imwe ku migongo yabyo yose, n’ubudodo bwabyo n bugire ahantu na hamwe bugaragara kdi n bigire aho byacitse bikomeye mu mpande zabyo. Ariko ibyo n bikurikizwa ku binyabiziga bikurikira:	159	\N
488	EN	Motor vehicles and mopeds wheels as well as those of their trailers must be provided with tyre bands the marks of which cannot have depth lower than one millimeter on their en re rolling surface. However this provision does not apply on:	159	\N
489	FR	Les roues des véhicules automoteurs et des cyclomoteurs pneuma ques don’t les sculptures ne peuvent avoir une profondeur inferieure à un milimetre sur toute la surface de roulement et don’t la toile ne peut être apparente à aucun endroit et qui ne presentent sur leurs flancs aucune déchurure profonde. Mais ces disposi ons ne sont pas applicables aux véhicules suivants:	159	\N
490	RW	Birabujijwe kugenza ibinyabiziga bigendeshwa na moteri na za romoruki zikururwa nabyo, iyo ibiziga byambaye inziga zidahagwa cyangwa inziga zikururuka zifite umubyimba uri hasi ya cm 4. Ariko ibyo n bikurikizwa ku binyabiziga bikurikira:	160	\N
491	EN	It is forbidden the circulation of self-propelling vehicles and trailers pulled by these vehicles, when their wheels are provided with either rigid bandages or elastic bandages of less than 0.04 meter thick. But these provisions do not apply on the following vehicles:	160	\N
492	FR	Est interdite la circulation de véhicules automoteurs et des remorques tirées par ces véhicules, lorsque les roues sont munies soit de bandages rigides, soit de bandages élastiques de moins de 0.04m d’épaisseur. Mais ceci n’est pas appliqué aux véhicules suivants:	160	\N
493	RW	Imirongo yera iteganye n’umurongo ugabanya umuhanda mo kabiri mu burebure bwawo ugaragaza:	161	\N
494	EN	The white lines parallel to the roadway are used by:	161	\N
495	FR	Les bandes blanches parallèles à l’axe de la chaussée indiquent:	161	\N
496	RW	Iyo harimo indi myanya birabujijwe gutwara ku ntebe y’imbere y’imodoka abana badafite imyaka ikurikira:	162	\N
497	EN	When the other seats are available in the car, it is forbidden to carry on the front seat the children of less than the following age:	162	\N
498	FR	Lorsqu’il y a d’autres places disponibles, il est interdit de transporter sur siège avant d’un véhicule des enfants de moins d’âge suivant:	162	\N
499	RW	Iyo ikinyabiziga kitagikora cyangwa cyoherejwe mu mahanga burundu ibyapa bigomba gukurwaho bikoherezwa mu by’imisoro, ibyo bikorwa mu gihe kingana:	163	\N
500	EN	In case of definitive out of use or definitive export of vehicle, the registration plates must be removed and sent back to the tax department service, this operation must be done in a period of:	163	\N
501	FR	En cas de mise hors d’usage définitive ou d’exportation définitive d’un véhicule, les plaques d’immatriculation doivent être enlevées et renvoyées au service des impôts. Dans quel délai cela doit être effectué?	163	\N
502	RW	Inkombe z’inzira nyabagendwa cyangwa z’umuhanda zishobora kugaragazwa n’ibikoresho ngarurarumuri ibyo bikoresho bigomba gushyirwaho ku buryo abagenzi babibona ku buryo bukurikira:	164	\N
503	EN	Borders of the public highway or the roadway must be signaled by reflectors, these devices must be so set up to let users see these for the following manner:	164	\N
504	FR	Les bords de la voie publique ou de la chaussée peuvent être signalés par des dispositifs réfléchissants. Ces dispositifs doivent être placés de manière que les usagers les voient de façon suivante:	164	\N
505	RW	Iyo kuyobya umuhanda ari ngombwa bigaragazwa kuva aho uhera no kuburebure bwawo n’icyapa gifite ubuso bw’amabara akurikira:	165	\N
506	EN	Where traffic deviation is required, it is signaled at the beginning and all the way long by means of an indication signal:	165	\N
507	FR	Si un détournement de la circulation est nécessaire, il est signalé à son origine et sur toute son étendue au moyen d’un signal. Ce signal a une surface de couleur suivante:	165	\N
508	RW	Ku mihanda yagenwe na minisiteri ubifite mu nshingano ibyapa biburira n’ibyapa byerekana bigomba kugaragazwa kuva bwije kugera bukeye n’urumuri rwihariye cyangwa amatara ku mihanda cyangwa ibintu ngarurarumuri. Igihe ijuru rikeye intera y’ahagaragara igomba kuba nibura:	166	\N
509	EN	On the roads designated by the Minister having public way in his remit, the danger signals and indication signals must be made visible between night fall and day break by means either of special lighting or reflecting products. When the weather is clear visibility distance must be at least:	166	\N
510	FR	Sur les routes désignées par le ministre ayant le transport public dans ses attributions, les signaux de danger et signaux d’indication doivent être rendues visible entre la tombée et le lever du jour, au moyen soit d’un éclairage spécial soit de l’éclairage public soit de produits réfléchissants. Par atmosphère limpide la distance de visibilité doit être au moins de mesure suivante:	166	\N
511	RW	Ibizirikisho by’iminyururu cyangwa by’insinga kimwe n’ibindi by’ingoboka bikoreshwa gusa igihe nta kundi umuntu yabigenza kandi nta kindi bigiriwe uretse gusa kugirango ikinyabiziga kigere aho kigomba gukorerwa kandi nturenze na rimwe km 20 mu isaha, ibyo bizirikisho bigaragazwa ku buryo bukurikira:	167	\N
512	EN	A fastening can only be used in cases of circumstances outside one’s control and exclusively for pulling a vehicle all the way to the place of repair at a speed which in any case cannot exceed 20km per hour. These fastenings must be shown in the following manner:	167	\N
513	FR	Les attaches constituées de chaines ou de câbles de fortune ne peuvent être utilisées qu’en cas de force majeure et exclusivement pour amener un véhicule jusqu’au lieu de réparation à une vitesse ne pouvant en aucun cas dépasser 20km à l’heure. Par quoi doivent être signalées ces attaches?	167	\N
514	RW	Uretse mu mijyi, kuyindi mihanda yagenywe na minisiteri ushinzwe gutwara ibintu n’abantu, uburemere ntarengwa bwemewe ku binyabiziga bifatanye bifite imitambiko itatu ni:	168	\N
515	EN	Except in urban areas, on the other roads as determined by the minister having transports in his duties, the maximum weight authorized by articulated vehicles with three axle is:	168	\N
516	FR	A l’exception de circonscriptions urbaines sur les autres routes déterminées par le ministre ayant le transport dans ses attributions, le poids maximum autorisé pour les véhicules articulés à trois essieux est:	168	\N
517	RW	Uretse mu mujyi kuyindi mihanda yajyenwe na minisiteri ushinzwe gutwara abantu n’ibintu, uburemere ntarengwa ku binyabiziga bifite imitambiko itatu cyangwa irenga hatarimo mukuzungu ni :	169	\N
518	EN	Except in urban arrears, on the other roads as determined by the minister having transport in his duties, the maximum weight authorized for three and more axle vehicles except semi-trailers is:	169	\N
519	FR	Sauf dans les circonscriptions urbaines, sur les autres routes détermines par le ministre ayant le transport dans ses attributions les poids maximum autorisés par véhicules à trois essieux et plus à l’exception de semi-remorques est:	169	\N
520	RW	Iyo nta mategeko awugabanya by’umwi umuvuduko ntarengwa ku modoka zidafite ibizibuza kwiceka kuberako ariko zakozwe ni: a) km 70 mu isaha b) km 40 mu isaha (c) km 25 mu isaha d) km20 mu isaha	170	\N
521	EN	In absence of more restric ve regula ons, maximum speed for vehicles which by design have no suspension is : a) 70 km/h b) 40 km/h (c) 25 km/h d) 20 km/h	170	\N
522	FR	A defaut de réglementa ons plus restric ves, la vitesse maximale des véhicules qui par construc on sont dépourvus de suspension est de: a) 70 km/h b) 40 km/h (c) 25 km/h d) 20 km/h	170	\N
523	RW	Iyo nta mategeko awugabanya by’umwi umuvuduko ntarengwa ku modoka zidafite ibizibuza kwiceka kuberako ariko zakozwe ni: a) km 20 mu isaha b) km 40 mu isaha c) km 35 mu isaha (d) nta gisubizo cy’ukuri kirimo	171	\N
524	EN	In absence of more restric ve regula ons, maximum speed for vehicles which by decision have no suspension is : a) 20 km/h b) 40 km/h c) 35 km/h (d) none of the answers is correct	171	\N
525	FR	A defaut de réglementa on plus restric ve, la vitesse maximale des véhicules qui, par construc on, sont dépourvus de suspension: a) 20 km/h b) 40 km/h c) 35 km/h (d) aucune de réponses n’est correcte	171	\N
526	RW	Ikinyabiziga kibujijwe guhagarara akanya kanini aha hakurikira : (a) imbere y’ahantu nyabagendwa hinjirwa n’ahasohokerwa n’abantu benshi b) mu muhanda aho ugabanyijemo ibisate bigaragazwa n’imirongo icagaguye c) A na B ni ibisubizo by’ukuri d) nta gisubizo cy’ukuri kirimo	172	\N
527	EN	On these spaces, parking a vehicle is forbidden: (a) in front of entrances and exits of public passages b) on the roadway at places where it is divided into traffic bands by non-continuous marks c) A and B are both correct d) none of the answers is correct	172	\N
528	FR	Le stationnement d’un véhicule est interdit: (a) devant les entrées et les sorties des passages publics b) sur la chaussée aux endroits où celle-ci est divisée en bandes de circulation matérialisées par des marques discontinues c) A et B sont justes d) aucune de réponses n’est correcte	172	\N
529	RW	Iyo kuva bwije kugeza bukeye cyangwa bitewe n’uko ibihe bimeze nk’igihe cy’ibihu cyangwa cy’imvura bitagishoboka kubona muri m 200, udutsiko twose tw’abanyamaguru nk’imperekerane cyangwa udutsiko tw’abanyeshuri bari ku murongo bayobowe n’umwarimu, iyo bagenda mu muhanda ku hakaba hari abantu barenze umwe bagomba kugaragazwa kuburyo bukurikira:	173	\N
530	EN	Between twilight and daybreak or because of circumstances such as fog or heavy rain it is not possible to see up to 200m, groups of pedestrians such as school groups must be signaled in the following way:	173	\N
531	FR	Entre la tombée et le lever du jour ou en raison de circonstances telles que le brouillard ou une forte pluie il n’est pas possible de voir jusqu’à 200m, les groupements de piétons doivent être signalés par:	173	\N
532	RW	Imburira zimurika zemerewe gukoreshwa kugirango bamenyeshe umuyobozi ko bagiye kumunyuraho aha hakurikira:	174	\N
533	EN	Luminous warning signs are authorized for warning a driver that he is going to be overtaken. They are used in the following areas:	174	\N
534	FR	Les avertissements lumineux sont autorisés pour avertir un conducteur qu’il va être dépassé. Cet avertissement est utilisé dans les endroits suivants:	174	\N
535	RW	Ibinyabiziga bifite ubugari bufite ibipimo bikurikira bigomba kugira amatara ndangaburumbarare:	175	\N
536	EN	The vehicles with the width which is superior to the following measures must be provided with loading light:	175	\N
537	FR	Les véhicules dont la largeur excède les mesures suivantes doivent être munis de feux d’encombrement :	175	\N
538	RW	Nta tara na rimwe cyangwa akagarurarumuri bishobora gushyirwa kuburyo igice cyo hasi kimurika kiba kiri hasi y’ibipimo bikurikira igihe ikinyabiziga kidapakiye:	176	\N
539	EN	No light or reflector can be placed in such a manner that the lowest point of its lighting surface is below the following measures from ground level, the vehicle being empty:	176	\N
540	FR	Aucun feu ou catadioptre ne peut être placé de manière que le point le plus bas de sa plage éclairante se trouve à moins des mesures suivantes, le véhicule étant vide:	176	\N
541	RW	Ahari hejuru cyane y’ubuso bumurika bw’amatara ndangambere na ndanganyuma ku kinyabiziga kidapakiye ntibushobora kurenza ibipimo bikurikira hejuru y’ubutaka:	177	\N
542	EN	For an empty vehicle, the highest point of the illuminating area of the front and rear position lights cannot be more than the following measurements above the ground:	177	\N
543	FR	Pour un véhicule vide, le point le plus élevé de la plage éclairante des feux de position avant et arrière ne peut se trouver à plus des mesures suivantes au-dessus du sol:	177	\N
544	RW	Buri modoka cyangwa romoruki ishobora kugira itara risa n’icyatsi kibisi ryerekana ko umuyobozi yabonye ikimenyetso cy’uwitegura kumunyuraho. Iryo tara rigomba gushyirwa:	178	\N
1717	EN	What does this sign mean?	422	\N
1718	FR	Que signifie ce signal?	422	\N
545	EN	Every motor vehicle or trailer pulled by such a vehicle may be provided with a green light allowing the driver to signal that he has noticed the warning of the person who is ready to overtake him. This light must be placed as follows:	178	\N
546	FR	Tout véhicule automobile ou remorque peut être muni d’un feu vert permettant au conducteur de signaler qu’il a perçu l’avertissement de celui qui s’apprête à le dépasser. Ce feu doit être placé comme suit:	178	\N
547	RW	Ubugari bw’imizigo yikorewe n’ipikipiki ifite akanyabiziga ko kuruhande kimwe n’ubwa romoruki ikuruwe na yo ntibushobora kurenza ubugari bw’ikinyabiziga kidapakiye:	179	\N
548	EN	The width of the load on motorcycles with a side car and trailer pulled by such a vehicle cannot exceed the width of the vehicle when not loaded:	179	\N
549	FR	La largeur du chargement d’une motocyclette avec side-car et d’une remorque ne peut excéder la largeur du véhicule non chargé:	179	\N
550	RW	Mu gihe telefone yawe ihamagawe utwaye imodoka wakora iki?	180	\N
551	EN	Your mobile phone rings while you are travelling. What should you do?	180	\N
552	FR	Votre téléphone portable sonne pendant votre voyage. Que devez-vous faire?	180	\N
553	RW	Mu gihe telefone yawe ihamagawe utwaye imodoka wakora iki?	181	\N
554	EN	Your mobile phone rings while you are travelling. What should you do?	181	\N
555	FR	Votre téléphone portable sonne pendant votre voyage. Que pouvez-vous faire?	181	\N
556	RW	Niki wakora mbere y’uko uhindura icyerekezo?	182	\N
557	EN	What should you do before making a U-turn?	182	\N
558	FR	Que devez-vous faire avant de faire demi-tour?	182	\N
559	RW	Ni mu bihe bikurikira ukwiye kwirinda kunyuranaho?	183	\N
560	EN	In which situation should you avoid overtaking?	183	\N
561	FR	Dans quelle situation devez-vous éviter le dépassement?	183	\N
1234	EN	If driving from A to B, what do these road markings mean?	389	\N
1235	FR	Si vous conduisez de A à B, que signifient ces marquages routiers?	389	\N
1236	RW	Mu gihe utwaye ikinyabiziga uva kuri A ugana kuri B, Iki kimenyetso kiri mu muhanda kivuze iki ?	389	\N
565	RW	Mugihe ukurikiranye na rumoruke, n’ukubera iki ugomba gusiga umwanya uhagije hagati yawe nayo?	185	\N
566	EN	You’re following a trailer. Why should you stay at a safe distance behind it?	185	\N
567	FR	Vous suivez une remorque. Pourquoi devriez-vous rester à une distance de sécurité derrière celle-ci?	185	\N
568	RW	Utegereje gukata iburyo ku iherezo ry’umuhanda, ariko ikinyabiziga gihagaze kikwikingirije. Niki wakora?	186	\N
569	EN	You’re waiting to turn right at the end of a road. Your view is obstructed by a parked vehicle. What should you do?	186	\N
570	FR	Vous attendez de tourner à droite au bout d’une route. Votre vue est obstruée par un véhicule stationné. Que devez-vous faire?	186	\N
571	RW	Mugihe uri mu rugendo rurerure ku muhanda munini, niki wakora mugihe wumva utangiye gusinzira?	187	\N
572	EN	You’re on a long motorway journey. What should you do if you start to feel sleepy?	187	\N
573	FR	Vous faites un long voyage sur l’autoroute. Que devriez-vous faire si vous commencez à vous sentir somnolent?	187	\N
574	RW	Kuki ugomba gucana amatara igihe hatangiye kwijima?	188	\N
575	EN	Why should you switch your lights on when it starts to get dark?	188	\N
576	FR	Pourquoi devriez-vous allumer vos lumières quand il commence à faire sombre?	188	\N
577	RW	Uritegura kunyura ku munyegare (cyclist) uri mu muhanda nyabagendwa. Wakora iki?	189	\N
578	EN	You are travelling on a public road. How should you overtake a cyclist?	189	\N
579	FR	Vous voyagez sur une voie publique. Comment devriez-vous dépasser un cycliste?	189	\N
580	RW	Niki wakora igihe utabona neza usubira inyuma?	190	\N
581	EN	You can’t see clearly behind when reversing. What should you do?	190	\N
582	FR	Vous ne pouvez pas voir clairement derrière lorsque vous reculez. Que devez-vous faire?	190	\N
583	RW	Igihe ukurikiwe n’ikinyabiziga gitwara abarwayi gicanye amatara y’intabaza arabagirana, wakora iki?	191	\N
584	EN	You’re being followed by an ambulance showing flashing lights. What should you do?	191	\N
585	FR	Vous êtes suivi par une ambulance avec des lumières clignotantes. Que devez-vous faire ?	191	\N
586	RW	Wifuza kugana ibumoso imbere yawe. Kubera iki ugomba gufata umwanya mwiza kandi uhagije?	192	\N
587	EN	You wish to turn left ahead. Why should you take the correct position in good time?	192	\N
588	FR	Vous souhaitez tourner à gauche. Pourquoi devez-vous prendre la bonne position à temps ?	192	\N
589	RW	Utwaye inyuma ya romoruki, umuyobozi wayo akaguha ikimenyetso cyo gutambuka iburyo ariko wowe ugana ibumoso, wakora iki?	193	\N
590	EN	You are driving behind a trailer. The driver signals right but you are going left. What should you do?	193	\N
591	FR	Vous conduisez derrière une remorque. Le conducteur signale à droite alors que vous allez à gauche. Que devez-vous faire ?	193	\N
592	RW	Wegereye inzira y’abanyamaguru ugasanga bategereje kwambuka. Wakora iki?	194	\N
593	EN	You are approaching a zebra crossing and pedestrians are waiting to cross. What should you do?	194	\N
594	FR	Vous approchez d’un passage pour piétons et ils attendent pour traverser. Que devez-vous faire ?	194	\N
1633	EN	This signal indicates:	395	\N
1634	FR	Ce signal indique :	395	\N
1635	RW	Iki cyapa cyerekana :	395	\N
598	RW	Kumanywa urumuri rudahagije ariko hatabona neza. Ni ayahe matara ugomba gukoresha?	196	\N
599	EN	Daytime visibility is poor but not seriously reduced. Which lights must be used?	196	\N
600	FR	La visibilité du jour est faible mais pas sérieusement réduite. Quelles lumières devez-vous utiliser ?	196	\N
601	RW	Ni ikihe mpamvu ituma tugomba kugabanya umuvuduko mugihe cy’ibihu?	197	\N
602	EN	Why should you reduce your speed when driving in fog?	197	\N
603	FR	Pourquoi devez-vous réduire votre vitesse lorsque vous conduisez dans le brouillard ?	197	\N
1264	EN	You are about to overtake a slow-moving motorcyclist. Which sign requires special care?	195	\N
1265	FR	Vous allez dépasser un motocycliste lent. Quel panneau demande une attention particulière ?	195	\N
1266	RW	Uri hafi kunyura k’umuyobozi   w’ikinyamitende. Muri ibi byapa bikurikira nikihe wakwitondera?	195	\N
1246	EN	Which sign means a one-way road?	383	\N
613	RW	Ni hehe byemewe kunyuranaho mu nzira y’icyerekezo kimwe?	201	\N
614	EN	Where may you overtake on a one-way road?	201	\N
615	FR	Où pouvez-vous dépasser dans une rue à sens unique ?	201	\N
616	RW	Ni uwuhe muntu tugomba kubaha ibimenyetso bye mu muhanda?	202	\N
617	EN	Whose signals must we obey among the following?	202	\N
618	FR	À quel usager doit-on obéir aux signaux routiers ?	202	\N
1636	EN	This signal means:	394	\N
1637	FR	Ce signal signifie:	394	\N
1638	RW	Iki cyapa kivuga:	394	\N
1719	RW	Iki cyapa gisobanura iki ?	422	\N
1720	EN	What does this sign mean?	423	\N
1721	FR	Que signifie ce signal?	423	\N
1722	RW	Iki cyapa gisobanura iki ?	423	\N
1723	EN	What does this sign mean?	424	\N
1724	FR	Que signifie ce signal?	424	\N
1725	RW	Iki cyapa gisobanura iki ?	424	\N
1726	EN	What does this sign mean?	425	\N
1727	FR	Que signifie ce signal?	425	\N
631	RW	Iki cyapa imbere yawe kivuze iki?	207	\N
632	EN	You see this sign ahead. What does it mean?	207	\N
633	FR	Vous voyez ce signal devant vous. Que signifie-t-il ?	207	\N
1728	RW	Iki cyapa gisobanura iki ?	425	\N
1786	EN	What does this sign mean?	438	\N
1787	FR	Que signifie ce signal ?	438	\N
1788	RW	Iki cyapa gisobanura iki ?	438	\N
1792	EN	What does this sign mean?	439	\N
1793	FR	Que signifie ce signal ?	439	\N
1794	RW	Iki cyapa gisobanura iki ?	439	\N
703	RW	Ni iki gikenewe muri ibi bikurikira kugirango ubashe gutwara imodoka mu muhanda biteganywa nitegeko?	231	\N
704	EN	Which of these is needed before you can legally use a vehicle on the road?	231	\N
705	FR	Lequel de ces éléments est nécessaire avant de pouvoir utiliser légalement un véhicule sur la route ?	231	\N
706	RW	Ikinyabiziga gishya gikenerwa gusuzumwa bwa mbere nyuma y’igihe kingana iki?	232	\N
707	EN	A new vehicle will need its first motor-vehicle inspection test when it’s how old?	232	\N
708	FR	Un nouveau véhicule aura besoin de son premier test d’inspection quand il est quel âge ?	232	\N
709	RW	Ni ryari ushobora gukoresha icyarimwe amatara yose ndangacyerekezo y’ikinyabiziga?	233	\N
710	EN	When should you use simultaneously all the vehicle’s indicator lights?	233	\N
711	FR	Quand faut-il utiliser simultanément tous les indicateurs de direction du véhicule ?	233	\N
712	RW	Ugeze ahabereye impanuka yo mu muhanda bwa mbere ugasanga abakomeretse bikomeye. Wakora iki?	234	\N
713	EN	You are the first person to arrive at an incident where people are badly injured. What should you do?	234	\N
714	FR	Vous êtes la première personne à arriver à un incident où des personnes sont gravement blessées. Que devriez-vous faire ?	234	\N
1639	EN	This signal designates:	396	\N
1640	FR	Ce signal désigne :	396	\N
1641	RW	Icyi cyapa gisobanura :	396	\N
718	RW	Wakoze impanuka yo mu muhanda , ni ikihe cyangombwa polisi ishobora kugusaba kucyerekana ?	236	\N
719	EN	You’re involved in a collision. Afterwards, which document may the police ask you to produce?	236	\N
720	FR	Vous êtes impliqué dans une collision. Ensuite, quel document la police peut-elle vous demander de produire ?	236	\N
1642	EN	This sign indicates:	397	\N
1643	FR	Ce signal indique :	397	\N
1644	RW	Icyi cyapa cyerekana :	397	\N
1645	EN	This sign showing the following:	398	\N
1646	FR	Ce signal signifie :	398	\N
1647	RW	Iki cyapa kivuga:	398	\N
1648	EN	This order of the qualified agent implies the obligation to stop:	399	\N
1649	FR	Cette injonction de l'agent qualifié implique l'obligation de s'immobiliser:	399	\N
1650	RW	Iki kimenyetso gitanzwe n'umukozi ubifitiye ububasha cyo guhagarara :	399	\N
1651	EN	These road signs forbid me to overtake on the left ?	400	\N
1652	FR	Ces signaux routiers m'interdisent de dépasser à gauche ?	400	\N
1653	RW	Ibi byapa byo mu muhanda birambuza kunyuranaho ibumoso ?	400	\N
1732	EN	What does this sign mean?	429	\N
1733	FR	Que signifie ce signal?	429	\N
1734	RW	Iki cyapa gisobanura iki ?	429	\N
1798	EN	Which sign shows no through road:	440	\N
1799	FR	Quel signal signifie une voie sans issue?	440	\N
1800	RW	Mu byapa bikurikira , ni ikihe cyerekana muhanda udakomeza:	440	\N
1654	EN	Highway. I want to overtake these two trucks in a single maneuver, by the left and at the same time. it's authorized ?	401	\N
1655	FR	Autoroute. Je veux dépasser ces deux camions en une seule manœuvre, par la gauche et en même temps. c'est autorisé ?	401	\N
1656	RW	umuhanda urombereje w'ibice byinshi. Ndashaka kunyura kuri izi kamyo ibyiri mugihe gito ibumoso icyarimwe , biremewe ?	401	\N
1657	EN	The driver of a car This road sign means :	402	\N
1658	FR	Le chauffeur d'une voiture Ce signal routier signifie quoi :	402	\N
1659	RW	k'umuyobozi w'ivaturi, iki cyapa kivuze iki ?	402	\N
1660	EN	I want to turn right. It's allowed.	403	\N
1661	FR	Je veux virer à droite. C'est permis.	403	\N
1662	RW	ndashaka gukata iburyo. Biremewe ?	403	\N
1663	EN	Railroad Crossing.	404	\N
1664	FR	Passage à niveau.	404	\N
1665	RW	umuhanda wambukiranya inzira ya gariyamoshi	404	\N
784	RW	Mugihe ikinyabiziga cyacu bakinyuzeho	258	\N
785	EN	When our vehicle is being over taken	258	\N
786	FR	Quand notre véhicule est dépassé	258	\N
787	RW	N byemewe gukoresha telephone	259	\N
788	EN	Mobile phones shall not be used	259	\N
789	FR	Les téléphones mobiles ne doivent pas être u lisés.	259	\N
790	RW	Mbere yo kunyura ku kindi kinyabiziga, ni ngombwa kumenya ko:	260	\N
791	EN	Before overtaking a vehicle, it should be ensured that:	260	\N
792	FR	Avant de dépasser un véhicule, il faut s'assurer que :	260	\N
793	RW	Ikindi kinyabiziga kiguturutse inyuma kiguterera amatara y’urumuri rumyasa, wakora iki?	261	\N
794	EN	You are driving. A vehicle comes up quickly behind, flashing head lamps. you should	261	\N
795	FR	Vous conduisez. Un véhicule monte rapidement derrière, feu de croisements clignotants. Vous devriez :	261	\N
796	RW	Mu gihe Umuntu ufite ubumuga bwo kutabona yambuka umuhanda yitwaje inkoni yera y’abatabona:	262	\N
797	EN	When a blind person crosses the road holding white cane	262	\N
798	FR	Lorsqu'un aveugle traverse la route avec une canne blanche.	262	\N
799	RW	Amatara y’urugendo, mu gihe cy’ibihu:	263	\N
800	EN	A high beam in foggy conditions	263	\N
801	FR	Un feu de route dans le brouillard	263	\N
802	RW	Gutwara uzungazunga mu muhanda:	264	\N
803	EN	Zig-zag driving is	264	\N
804	FR	La conduite en zigzag est :	264	\N
805	RW	Telephone ngendanwa n gomba gukoreshwa:	265	\N
806	EN	Mobile phones shall not be used	265	\N
807	FR	Les téléphones mobiles ne doivent pas être utilisés :	265	\N
808	RW	Kunyuranaho bibujijwe gusa igihe:	266	\N
809	EN	Overtaking is prohibited when	266	\N
810	FR	Le dépassement est interdit lorsque :	266	\N
811	RW	Mu gihe utwye ikinyabiziga ni joro ucanye amatara maremare ugahura n’ikindi kinyabiziga gitueutse mu kindi cyerecyezo:	267	\N
812	EN	While you are driving with the head light in high beam during night, a vehicle approaches from opposite direction, you will	267	\N
813	FR	Pendant que vous conduisez avec le feu de croisement en route pendant la nuit, un véhicule s’approche d’une direction opposée.	267	\N
814	RW	Igihe umuyobozi w’inyamaswa, afite inyamaswa idatuje, asaba ko ibinyabiziga bihagarara:	268	\N
815	EN	If a person in charge of an animal apprehending that the animal may become unmanageable, request to stop a vehicle	268	\N
816	FR	Si le responsable d’un animal craint que celui-ci ne devienne ingérable, demandez à ce que le véhicule soit arrêté.	268	\N
817	RW	Iyo mu muhanda hashushanyijemo umurongo wera ucagaguye, ntugomba	269	\N
818	EN	If the road is marked with broken white lines. You	269	\N
819	FR	Si la route est marquée par des lignes blanches brisées. Vous	269	\N
820	RW	Kuvuza ihoni bibujijwe:	270	\N
821	EN	Use of horn prohibited	270	\N
822	FR	U lisa on de la corne interdite	270	\N
1738	EN	What does this sign mean?	430	\N
1739	FR	Que signifie ce signal ?	430	\N
1740	RW	Iki cyapa gisobanura iki ?	430	\N
1804	RW	Iki cyapa:	441	\N
1805	EN	What does this sign mean?	441	\N
1806	FR	Que signifie ce signal ?	441	\N
1810	RW	Iki cyapa gisobanura iki ?	442	\N
1811	EN	What does this sign mean?	442	\N
1812	FR	Que signifie ce signal ?	442	\N
1666	EN	Beyond the first road sign:	406	\N
1667	FR	Au-delà du premier signal routier, il m’est :	406	\N
1668	RW	kuri iki cyapa cyo mu muhanda cyambere kintegeka ?	406	\N
1744	EN	What does this sign mean?	431	\N
1745	FR	Que signifie ce signal ?	431	\N
1746	RW	Iki cyapa gisobanura iki ?	431	\N
1750	EN	What does this sign mean?	432	\N
1751	FR	Que signifie ce signal ?	432	\N
1752	RW	Iki cyapa gisobanura iki ?	432	\N
865	RW	Niki umuyobozi w’ikinyabiziga yakora mu gihe abonye icyapa kiburira cya mpande eshatu gitukura mu muhanda?	285	\N
866	EN	What should a driver do if they see a red warning triangle on the road?	285	\N
867	FR	Que doit faire le conducteur s’il voit un triangle de signalisa on rouge sur la route ?	285	\N
868	RW	Niki umuyobozi w’ikinyabiziga agomba gukora ahuye n’amatungo mu muhanda?	286	\N
869	EN	What should the driver do if there are ca le on the road ahead?	286	\N
870	FR	Que doit faire le conducteur s'il y a du bétail sur la route ?	286	\N
871	RW	Niki umuyobozi w’ikinyabiziga yakora abonye otobisi iri kuva aho zagenewe guhagararwamo?	287	\N
872	EN	The bus ahead is moving away from a bus stop. What should a driver do?	287	\N
873	FR	Le bus devant s'éloigne d'un arrêt de bus. Que doit faire un conducteur ?	287	\N
874	RW	Niki umuyobozi w’ikinyabiziga yakora mugihe ahuye n’ikinyabiziga cyakije itara ry’umuhondo rimyatsa?	288	\N
875	EN	What should a driver do if they meet a vehicle with flashing amber beacons?	288	\N
876	FR	Que doit faire un conducteur s’il rencontre un véhicule équipé de balises jaune clignotantes ?	288	\N
877	RW	Umuyobozi w'ikinyabiziga yakora iki mu gihe anyuzweho nikindi kinyabiziga?	289	\N
878	EN	What should a driver do when being overtaken by another vehicle?	289	\N
879	FR	Que doit faire un conducteur qui se fait dépasse par un autre véhicule ?	289	\N
1819	RW	Ni ikihe cyapa gisobanura umuhanda w'icyerekezo kimwe:	443	\N
1820	EN	Which sign means a one-way road?	443	\N
1821	FR	Quel signal signifie une voie à sens unique?	443	\N
883	RW	Umuyobozi w’ikinyabiziga ugeze mu isangano rigenzurwa n’amatara yaka agasanga ataka (adakora), yakora iki?	291	\N
884	EN	What should a driver do when approaching a junction normally controlled by traffic lights and the traffic lights are not working?	291	\N
885	FR	Que doit faire un conducteur lorsqu'il s'approche d'une intersection normalement contrôlée par des feux de circulation et que ceux-ci ne fonctionnent pas ?	291	\N
886	RW	Ni iki umuyobozi w’ikinyabiziga yakora ahuye n’ishyo ry’amatungo mu muhanda?	292	\N
887	EN	What should the driver do if there are cattle on the road ahead?	292	\N
888	FR	Que doit faire le conducteur s'il y a du bétail sur la route?	292	\N
889	RW	Ni iki umuyobozi w’ikinyabiziga yakora ageze ku kazamuko gashinze cyane?	293	\N
890	EN	What should the driver do when approaching a steep hill?	293	\N
891	FR	Que doit faire le conducteur à l'approche d'une montée raide?	293	\N
895	RW	Ni iki umuyobozi w’ikinyabiziga yakora ku muhanda ufunganye ahuye n’ikindi kinyabiziga?	295	\N
896	EN	What should a driver do on a narrow road when another vehicle is coming in the opposite direction?	295	\N
897	FR	Que doit faire un conducteur sur une route étroite lorsqu’un autre véhicule arrive en sens inverse?	295	\N
898	RW	Umuyobozi w’ikinyabiziga agendera inyuma y’ikindi atagishaka kunyuraho yakora iki?	296	\N
899	EN	When driving behind another vehicle you do not intend to overtake, what should you do?	296	\N
900	FR	Lorsque vous suivez un autre véhicule sans intention de dépasser, que devez-vous faire?	296	\N
901	RW	Ni ryari amatara ndanga cyerekezo agomba gukoreshwa?	297	\N
902	EN	When should indicators/signals be used?	297	\N
903	FR	Quand faut-il utiliser les clignotants ?	297	\N
904	RW	Gutinda gutanga ibimenyetso bigira izihe ngaruka?	298	\N
905	EN	How does giving a late signal affect other road users?	298	\N
906	FR	Comment un signal tardif affecte-t-il les autres usagers de la route ?	298	\N
907	RW	Ni iki gikwiye gukorwa iyo umuntu akomeretse mu mpanuka?	299	\N
908	EN	What is the correct procedure when someone is injured in a road collision?	299	\N
909	FR	Quelle est la bonne procédure lorsqu’une personne est blessée dans un accident ?	299	\N
910	RW	Niki wakora iyo impanuka yabaye ariko nta wakomeretse, ariko hari akaga mu muhanda?	300	\N
911	EN	What should a driver do when involved in an incident with no injuries but obstruction or danger?	300	\N
912	FR	Que doit faire un conducteur lorsqu’il y a un accident sans blessés mais avec danger ou obstruction ?	300	\N
913	RW	Igihe umuyobozi w’ikinyabiziga agendera mu nzira y’icyerekezo kimwe akifuza gukata ibumoso yakora iki?	301	\N
914	EN	When driving on a one-way street and wishing to turn left, what should a driver do?	301	\N
915	FR	Lorsque le conducteur roule dans une rue à sens unique et souhaite tourner à gauche, que doit-il faire ?	301	\N
916	RW	Umuyobozi w’ikinyabiziga uri kugendera mu muhanda w’ibyerekezo bibiri agomba gukoresha uruhe ruhande rw’umuhanda?	302	\N
917	EN	When driving along a dual carriageway, which lane position should a driver be in?	302	\N
918	FR	En cas de circulation sur une chaussée à deux voies, dans quelle voie un conducteur doit-il se trouver ?	302	\N
919	RW	Igihe umuyobozi w’ikinyabiziga atwaye mu muhanda munini ugabanyijemo ibice byinshi, agomba kugendera mu kihe gice cy’umuhanda?	303	\N
920	EN	When driving on a motorway with multiple lanes, which lane should a driver use?	303	\N
921	FR	Lorsque vous conduisez sur une autoroute à plusieurs voies, dans quelle voie un conducteur doit-il se trouver ?	303	\N
922	RW	Umuyobozi w’ikinyabiziga yakora iki igihe ageze aho banyura bazenguruka (rond-point)?	304	\N
923	EN	What should a driver do when approaching a roundabout?	304	\N
924	FR	Que doit faire un conducteur à l'approche d'un sens giratoire ?	304	\N
925	RW	Ni mu buhe cyerekezo umuyobozi w’ikinyabiziga yinjiriramo igihe ageze aho banyura bazenguruka (rond-point)?	305	\N
926	EN	In what direction should a driver turn when entering a roundabout?	305	\N
927	FR	Dans quelle direction un conducteur doit-il tourner pour entrer dans un sens giratoire ?	305	\N
1669	EN	I stop at the stop line.	407	\N
1670	FR	Je m’immobilise à la ligne d'arrêt.	407	\N
1671	RW	mpagaze mu murongo wo guharara umwanya muto	407	\N
1672	EN	I want to turn left. The green car came to a stop. Who has priority?	409	\N
1673	FR	Je veux virer à gauche. La voiture verte s'est immobilisée. Qui a la priorité ?	409	\N
1674	RW	ndashaka kugata ibumoso. Imodoka y'icyatsi yaje irahagarara. Ninde ufite uburenganzira bwo gutambuka mbere?	409	\N
934	EN	What should you do when behind a bus that has stopped to pick up or drop off passengers?	308	\N
935	RW	Umuyobozi w’ikinyabiziga ugendera inyuma y’ikinyabiziga gitwara abagenzi gihagaze agomba gukora iki?	308	\N
936	FR	Que devez-vous faire lorsque vous êtes derrière un bus qui s'est arrêté pour prendre ou déposer des passagers ?	308	\N
937	EN	What should you do when you see a school traffic sign?	309	\N
938	RW	Igihe ubonye icyapa kigaragaza ishuli wakora iki?	309	\N
939	FR	Lorsque vous voyez le panneau de signalisation de l'école, que devriez-vous faire ?	309	\N
940	EN	Where is the number of passengers recorded?	310	\N
941	RW	Umubare w’abagenzi bemewe gutwarwa mu kinyabiziga wanditswe mu?	310	\N
942	FR	Où est enregistré le nombre de passagers autorisés ?	310	\N
943	EN	Drunken driving is:	311	\N
944	RW	Gutwara ikinyabiziga wasinze:	311	\N
945	FR	La conduite en état d'ivresse est :	311	\N
946	EN	A driver may overtake:	312	\N
947	RW	Umuyobozi w’ikinyabiziga ashobora kunyuranaho:	312	\N
948	FR	Le conducteur d'un véhicule peut dépasser :	312	\N
949	EN	You stop for pedestrians at a zebra crossing. They do not start to cross. What should you do?	313	\N
950	RW	Ugeze ahari inzira y’abanyamaguru barindiriye kwambuka, ntibatangiye kwambuka wakora iki?	313	\N
951	FR	Vous vous arrêtez pour des piétons au passage. Ils ne commencent pas à traverser. Que faire ?	313	\N
952	EN	If someone in your vehicle forgets to wear a seat belt, what should you do?	314	\N
953	RW	Igihe umuntu mu kinyabiziga cyawe yibagiwe kwambara umukandara wakora iki?	314	\N
954	FR	Si quelqu'un oublie de porter sa ceinture de sécurité, que faire ?	314	\N
955	EN	When school buses are stopped for picking up or dropping off students, you should:	315	\N
956	RW	Igihe otobisi z’abanyeshuli zihagaze gufata cyangwa kumanura abanyeshuli wakora iki?	315	\N
957	FR	Quand les autobus scolaires sont arrêtés, vous devriez :	315	\N
958	EN	When a vehicle is parked on the roadside during night:	316	\N
959	RW	Igihe imodoka iparitse ku nkengero z’umuhanda mu ijoro:	316	\N
960	FR	Quand un véhicule est garé au bord de la route pendant la nuit :	316	\N
961	EN	When the vehicle behind has begun to overtake your vehicle, what should you do?	317	\N
962	RW	Mu gihe hari undi muyobozi w’ikinyabiziga ugukurikiye watangiye kukunyuraho wakora iki?	317	\N
963	FR	Lorsque le véhicule à l'arrière a commencé à dépasser votre véhicule, que devez-vous faire ?	317	\N
964	EN	When driving on a two-way road and overtaking is safe, what should you do?	318	\N
965	RW	Utwaye ikinyabiziga mu muhanda ufite ibyerekezo bibiri, ikinyabiziga kiri imbere kigenda buhoro, wakora iki?	318	\N
966	FR	Lorsque vous conduisez sur une route à deux voies et que le dépassement est sûr, que devez-vous faire ?	318	\N
967	EN	What do large white strips parallel to the road mean?	319	\N
968	RW	Ibice by’umuhanda byera bigari biteganye n’umurongo ugabanya umuhanda bisobanura iki?	319	\N
969	FR	Que signifient les grandes bandes blanches parallèles à la route ?	319	\N
970	EN	What is the rearview mirror used for?	320	\N
971	RW	Uturebanyuma dukoreshwa iki?	320	\N
972	FR	À quoi sert le rétroviseur ?	320	\N
973	EN	Why should pedestrians not cross at sharp bends or near stopped vehicles?	321	\N
974	RW	Kuki abanyamaguru batemerewe kwambuka ku mikono cyangwa hafi y’imodoka ihagaze?	321	\N
975	FR	Pourquoi les piétons ne doivent-ils pas traverser dans les virages serrés ou près d’un véhicule arrêté ?	321	\N
976	EN	Is overtaking when approaching a bend allowed?	322	\N
977	RW	Kunyuranaho mu ikoni biremewe?	322	\N
978	FR	Le dépassement à l’approche d’un virage est-il permis ?	322	\N
979	EN	What should you do if you feel drowsy while driving?	323	\N
980	RW	Umuyobozi w’ikinyabiziga aramutse yumva asinzira yakora iki?	323	\N
981	FR	Que faire si vous somnolez en conduisant ?	323	\N
982	EN	What should a driver do in fog, heavy rain, or dust?	324	\N
983	RW	Umuyobozi w’ikinyabiziga yakora iki mu gihe cy’ibihu, imvura nyinshi cyangwa umukungugu mwinshi?	324	\N
984	FR	Que doit faire un conducteur dans le brouillard ou la forte pluie ?	324	\N
985	EN	How can you identify mandatory traffic signs?	325	\N
986	RW	Ni gute wamenya ibyapa bitegeka mu muhanda?	325	\N
987	FR	Comment identifier les panneaux de signalisation obligatoires ?	325	\N
988	EN	What should you do when traffic lights are not working and a police officer gives instructions?	326	\N
989	RW	Ugeze mu masangano y’umuhanda aho amatara adakora kandi umupolisi atanze amabwiriza wakora iki?	326	\N
990	FR	Que faire quand les feux ne fonctionnent pas et qu’un policier donne des instructions ?	326	\N
991	EN	The direction indicator lights must be visible at night in clear weather at a minimum distance of:	327	\N
992	RW	Amatara ndangacyerekezo agomba kugaragara nijoro igihe ijuru rikeye mu ntera nibura ya:	327	\N
993	FR	Les feux indicateurs de direction doivent être visibles de nuit par atmosphère limpide à une distance minimum de :	327	\N
994	EN	A broken white line means it is prohibited to cross it except:	328	\N
995	RW	Umurongo ucagaguye uvuga ko buri muyobozi abujijwe kuwurenga uretse mu gihe:	328	\N
996	FR	Une ligne blanche discontinue signifie qu’il est interdit de la franchir sauf :	328	\N
997	EN	A road section delimited by two broken parallel white lines is:	329	\N
998	RW	Igice cy’inzira nyabagendwa kigarukira ku mirongo ibiri yera icagaguye ibangikanye kandi gifite ubugari budahagije ni:	329	\N
999	FR	La partie de la voie publique délimitée par deux lignes blanches discontinues et parallèles est :	329	\N
1000	EN	The sign for two-way traffic has the following characteristics:	330	\N
1001	RW	Icyapa kimenyesha kugendera mu muhanda ubisikanirwamo gifite:	330	\N
1002	FR	Le panneau de circulation à double sens est caractérisé par :	330	\N
1003	EN	A motor vehicle and an animal-drawn vehicle cannot pull:	331	\N
1004	RW	Ikinyabiziga kigendeshwa na moteri n’igitwarwa n’inyamaswa ntibishobora gukurura:	331	\N
1005	FR	Un véhicule automoteur et un véhicule à traction animale ne peuvent pas tirer :	331	\N
1009	EN	This sign means priority / right of way rules	333	\N
1010	RW	Iki cyapa gisobanura gutambuka mbere cyangwa gutanga inzira	333	\N
1011	FR	Ce signal signifie priorité / règles de passage	333	\N
1012	EN	Reflectors placed on the front side of a vehicle must be:	334	\N
1013	RW	Utugarurarumuri turi ku ruhande rw’imbere rw’ikinyabiziga tugomba kuba:	334	\N
1014	FR	Les catadioptres à l’avant d’un véhicule doivent être :	334	\N
1015	EN	This sign means end of priority or right of way rules	335	\N
1016	RW	Iki cyapa kivuga iherezo ry’uburenganzira bwo gutambuka mbere	335	\N
1017	FR	Ce signal signifie fin de priorité	335	\N
1018	EN	This sign is made of:	336	\N
1019	RW	Iki cyapa kigizwe na:	336	\N
1020	FR	Ce signal est composé de :	336	\N
1024	EN	Every driver who realizes that a driver following him wishes to overtake him must:	338	\N
1025	RW	Umuyobozi ubonye ko hari undi umukurikiye ashaka kumunyuraho agomba kubahiriza ibi bikurikira :	338	\N
1026	FR	Tout conducteur qui se rend compte qu'un conducteur qui le suit souhaite le dépasser doit:	338	\N
1027	EN	This signal indicates:	339	\N
1028	RW	Iki cyapa cyerekana :	339	\N
1029	FR	Ce signal indique :	339	\N
1030	EN	This signal designates:	340	\N
1031	RW	Icyi cyapa gisobanura :	340	\N
1032	FR	Ce signal désigne :	340	\N
1033	EN	This sign indicates:	341	\N
1034	RW	Icyi cyapa cyerekana :	341	\N
1035	FR	Ce signal indique :	341	\N
1036	EN	This sign shows the following:	342	\N
1037	RW	Iki cyapa kivuga:	342	\N
1038	FR	Ce signal signifie :	342	\N
1039	EN	When the road has two traffic bands and the traffic moves in two directions, it is forbidden to:	343	\N
1040	RW	Iyo umuhanda ugabanijemo ibisate bibiri kandi ugendwamo mu byerekezo byombi umuyobozi abujijwe :	343	\N
1041	FR	Lorsque la chaussée comporte deux bandes de circulation et que la circulation s’y fait dans les deux sens, il est interdit à tout conducteur :	343	\N
1042	EN	The two-way traffic sign is characterized by:	344	\N
1043	RW	Icyapa kimenyesha kugendera mu muhanda ubisikanirwamo gifite:	344	\N
1044	FR	Le panneau de signalisation à double sens est caractérisé par:	344	\N
1045	EN	The signal (path for cattle required) has the following characteristics:	345	\N
1046	RW	Icyapa cyerekana inzira y’amatungo itegetswe giteye:	345	\N
1047	FR	Le signal (trajet requis pour le bétail) présente les caractéristiques suivantes:	345	\N
1048	EN	The signal C15 means forbidden of hooting and warning sound has the following characteristics:	346	\N
1049	RW	Icyapa cyerekana ko bibujijwe kuvuza amahoni kirangwa na :	346	\N
1050	FR	Le signal C15 signifie interdit de sifflement et le son d’avertissement présente les caractéristiques suivantes:	346	\N
1051	EN	Danger and priority signals are constituted by:	347	\N
1052	RW	Ibyapa biburira n’ibyo gutambuka mbere birangwa:	347	\N
1053	FR	Les signaux de danger et de priorité sont constitués par:	347	\N
1054	EN	Danger and priority signals are constituted by:	348	\N
1681	EN	I must:	427	\N
1682	FR	Je dois:	427	\N
1683	RW	Ngomba :	427	\N
1756	EN	What does this sign mean?	433	\N
1757	FR	Que signifie ce signal ?	433	\N
1758	RW	Iki cyapa gisobanura iki ?	433	\N
1055	RW	Ibyapa biburira nibyo gutambuka mbere birangwa:	348	\N
1056	FR	Les signaux de danger et de priorité sont constitués par:	348	\N
1057	EN	Prohibition and obligation signs only have effect:	349	\N
1058	RW	Ibyapa bibuza n’ibitegeka bikurikizwa gusa:	349	\N
1059	FR	Les signaux d’interdiction et d’obligation n’ont d’effet que:	349	\N
1060	EN	Danger road signs serve the purpose of warning the user:	350	\N
1061	RW	Ibyapa biburira bibereyeho kumenyesha umugenzi:	350	\N
1062	FR	Les panneaux de signalisation de danger ont pour but d'avertir l'utilisateur:	350	\N
1063	EN	Additional signals may notify:	351	\N
1064	RW	Ibyapa by’inyongera bishobora kumenyesha:	351	\N
1065	FR	Les signaux additionnels peuvent notifier des:	351	\N
1066	EN	The form of a signal which means compulsory bypass is:	352	\N
1067	RW	Ishusho ry’icyapa kivuga ‘ugukikira’ bitegetswe ni:	352	\N
1068	FR	La forme d’un signal indiquant le contournement obligatoire est:	352	\N
1069	EN	A signal indicating the mandatory direction has a symbol of color:	353	\N
1070	RW	Icyapa kivuga ‘icyerekezo gitegetswe’ kigizwe n’ikirango cy’ibara:	353	\N
1071	FR	Un signal indiquant la direction obligatoire d'un symbole de couleur:	353	\N
1072	EN	This order of the qualified agent implies the obligation to stop:	354	\N
1073	RW	Iki kimenyetso gitanzwe n’umukozi ubifitiye ububasha cyo guhagarara:	354	\N
1074	FR	Cette injonction de l'agent qualifié implique l'obligation de s'immobiliser:	354	\N
1075	EN	These road signs forbid me to overtake on the left?	355	\N
1076	RW	Ibi byapa byo mu muhanda birambuza kunyuranaho ibumoso?	355	\N
1077	FR	Ces signaux routiers m'interdisent de dépasser à gauche ?	355	\N
1078	EN	Highway. I want to overtake these two trucks in a single maneuver, by the left and at the same time. Is it authorized?	356	\N
1079	RW	Umuhanda urombereje w’ibice byinshi. Ndashaka kunyura kuri izi kamyo ebyiri icyarimwe ibumoso, biremewe?	356	\N
1080	FR	Autoroute. Je veux dépasser ces deux camions en une seule manœuvre, par la gauche et en même temps. Est-ce autorisé ?	356	\N
1081	EN	The driver of a car This road sign means:	357	\N
1082	RW	K’umuyobozi w’iva ri, iki cyapa kivuze iki?	357	\N
1083	FR	Le chauffeur d'une voiture Ce signal routier signifie quoi :	357	\N
1084	EN	I want to turn right. It’s allowed.	358	\N
1085	RW	Ndashaka gukata iburyo. Biremewe?	358	\N
1086	FR	Je veux virer à droite. C’est permis.	358	\N
1087	EN	Railroad Crossing.	359	\N
1088	RW	Umuhanda wambukiranya inzira ya gariyamoshi	359	\N
1089	FR	Passage à niveau.	359	\N
1090	EN	Beyond the first road sign:	360	\N
1091	RW	Kuri iki cyapa cyo mu muhanda cya mbere kintegeka?	360	\N
1092	FR	Au-delà du premier signal routier, il m’est :	360	\N
1093	EN	I stop at the stop line.	361	\N
1094	RW	Mpagaze mu murongo wo guhagarara umwanya muto	361	\N
1095	FR	Je m’immobilise à la ligne d’arrêt.	361	\N
1096	EN	I must:	362	\N
1097	RW	Ngomba:	362	\N
1098	FR	Je dois:	362	\N
1099	EN	I want to turn left. The green car came to a stop. Who has priority?	363	\N
1100	RW	Ndashaka gukata ibumoso. Imodoka y’icyatsi yaje irahagarara. Ninde ufite uburenganzira bwo gutambuka mbere?	363	\N
1101	FR	Je veux virer à gauche. La voiture verte s'est immobilisée. Qui a la priorité ?	363	\N
1102	EN	I have priority at this crossroads?	364	\N
1103	RW	Mfite uburenganzira bwo gutambuka muri iri sangano?	364	\N
1104	FR	J'ai la priorité à ce carrefour ?	364	\N
1105	EN	I drive at 20 km/h. I can still get involved in the crossroads?	365	\N
1106	RW	Ndi ku muvuduko wa 20km/h. Nshobora gukomeza muri iri sangano ry’umuhanda?	365	\N
1107	FR	Je roule à 20 km/h. Je peux encore m'engager dans le carrefour ?	365	\N
1108	EN	The driver in front of me overtook me on the left.	366	\N
1109	RW	Umuyobozi w’ikinyabiziga aritegura kunyuraho ibumoso:	366	\N
1110	FR	Le conducteur qui me précède m'a dépassé par la gauche.	366	\N
1111	EN	From these road signs, it is:	367	\N
1112	RW	Uhereye kuri ibi byapa habujijwe:	367	\N
1113	FR	A partir de ces signaux routiers, il est:	367	\N
1114	RW	uhereye kuri ibi byapa habujijwe :	368	\N
1115	EN	From these road signs, it is forbidden:	368	\N
1116	FR	A partir de ces signaux routiers, il est interdit :	368	\N
1117	RW	Ndashaka gupariki ikinyabiga iburyo kunzira y’abanyamaguru	369	\N
1118	EN	I want to store my parked car on the right, on this sidewalk.	369	\N
1119	FR	Je veux ranger ma voiture en stationnement à droite, sur ce trottoir.	369	\N
1120	RW	Iki cyapa gisobanura iki ?	370	\N
1121	EN	What does this sign mean?	370	\N
1122	FR	Que signifie ce signal?	370	\N
1123	RW	Iki cyapa gisobanura iki mu nkomane ?	371	\N
1124	EN	What does this sign mean at a junction?	371	\N
1125	FR	Que signifie ce signal à un croisement?	371	\N
1126	RW	Iki cyapa gisobanura iki aho banyura bazengurutse ?	372	\N
1127	EN	What does this sign mean at a roundabout?	372	\N
1128	FR	Qu'est-ce que ce signal signifie à un rond-point?	372	\N
1129	RW	Iki cyapa gisobanura iki ?	373	\N
1130	EN	What does this sign mean?	373	\N
1131	FR	Que signifie ce signal?	373	\N
1132	RW	Iki cyapa gisobanura iki ?	374	\N
1133	EN	What does this sign mean?	374	\N
1134	FR	Que signifie ce signal?	374	\N
1135	RW	Iki cyapa gisobanura iki ?	375	\N
1136	EN	What does this sign mean?	375	\N
1137	FR	Que signifie ce signal?	375	\N
1684	EN	I have priority at this crossroads?	410	\N
1685	FR	J'ai la priorité à ce carrefour ?	410	\N
1686	RW	Mfite uburenganzira bwo gutambuka muri iri sangano ?	410	\N
1687	EN	I drive at 20 km / h. I can still get involved in the crossroads?	411	\N
1688	FR	Je roule à 20 km/h. Je peux encore m'engager dans le carrefour ?	411	\N
1689	RW	Ndi kumuvuduko wa 20km/h. nshobora gukomeza muri iri sangano ry'umuhanda?	411	\N
1690	EN	The driver in front of me overtook me on the left.	412	\N
1691	FR	Le conducteur qui me précède m'a dépassé par la gauche.	412	\N
1692	RW	Umuyobozi wikinyabiziga aritegura kunuraho ibumoso :	412	\N
1762	EN	What does this sign mean?	434	\N
1763	FR	Que signifie ce signal ?	434	\N
1764	RW	Iki cyapa gisobanura iki ?	434	\N
1825	RW	Iki cyapa gisobanura iki ?	444	\N
1826	EN	What does this sign mean?	444	\N
1827	FR	Que signifie ce signal ?	444	\N
1240	EN	What do flashing amber beacons on an oncoming vehicle indicate?	294	\N
1241	FR	Que signifient les feux orange clignotants d’un véhicule venant en sens inverse?	294	\N
1242	RW	Ni iki amatara y’umuhondo aburira ku kinyabiziga giturutse imbere asobanura?	294	\N
1247	FR	Quel signal signifie une voie à sens unique?	383	\N
1248	RW	Ni ikihe icyapa gisobanura umuhanda w'icyerekezo kimwe:	383	\N
1252	EN	What does this sign mean?	381	\N
1253	FR	Que signifie ce signal ?	381	\N
1254	RW	Iki cyapa:	381	\N
1255	EN	Which sign shows the driver who is about to enter a narrow road that he has the right of way before vehicles moving in the opposite direction:	380	\N
1256	FR	Quel signal d’indication donnée à un conducteur qui s’engager dans un passage étroit qu’il bénéficie de la priorité par rapport aux véhicules venant en sens inverse :	380	\N
1257	RW	Muri ibi byapa bikurikira ni ikihe cyerekana ko umuyobozi ukibonye yemerewe gutambuka mbere y'abaturutse aho agana mu nzira ifunganye:	380	\N
1261	EN	What does this sign mean?	378	\N
1262	FR	Que signifie ce signal?	378	\N
1263	RW	Iki cyapa gisobanura iki ?	378	\N
1267	EN	What is the meaning of this sign?	203	\N
1268	FR	Que signifie ce signal ?	203	\N
1269	RW	Iki cyapa gisobanura iki?	203	\N
1270	EN	What does this sign mean?	206	\N
1271	FR	Que signifie ce signal ?	206	\N
1272	RW	Iki cyapa gisobanura iki?	206	\N
1276	EN	What does this sign mean?	208	\N
1216	EN	If driving from A to B, what do these road markings mean?	388	\N
1217	FR	Si vous conduisez de A à B, que signifient ces marquages routiers?	388	\N
1218	RW	Mu gihe utwaye ikinyabiziga uva kuri A ugana kuri B, Iki kimenyetso kiri mu muhanda kivuze iki ?	388	\N
1219	EN	What does this road marking mean?	387	\N
1220	FR	Que signifie ce marquage routier?	387	\N
1221	RW	Iki kimenyetso kiri mu muhanda kivuze iki ?	387	\N
1222	EN	What does this road marking mean?	386	\N
1223	FR	Que signifie ce marquage routier?	386	\N
1224	RW	Iki kimenyetso kiri mu muhanda kivuze iki?	386	\N
1277	FR	Que signifie ce signal ?	208	\N
1278	RW	Iki cyapa gisobanura iki?	208	\N
1282	EN	What does this sign mean?	209	\N
1283	FR	Ce signal signifie?	209	\N
1284	RW	Iki cyapa gisobanura iki?	209	\N
1285	EN	What does this sign mean? (Lateral winds / Road noise / Airport / All answers are correct)	210	\N
1286	FR	Que signifie ce signal ? (Vent latéral / Bruit de la route / Aéroport / Toutes les réponses sont correctes)	210	\N
1287	RW	Iki cyapa gisobanura iki? (Umuyaga w’intambike / Urusaku rwo mu muhanda / Ikibuga cy’indege / Ibisubizo byose nibyo)	210	\N
1294	EN	What does this sign mean?	212	\N
1295	FR	Que signifie ce signal ?	212	\N
1296	RW	Iki cyapa gisobanura iki?	212	\N
1297	EN	What does this sign mean?	213	\N
1298	FR	Que signifie ce signal ?	213	\N
1299	RW	Iki cyapa gisobanura iki?	213	\N
1300	EN	What does this sign mean?	214	\N
1301	FR	Que signifie ce signal ?	214	\N
1302	RW	Iki cyapa gisobanura iki?	214	\N
1303	EN	What should you do when you see this sign?	215	\N
1304	FR	Que devez-vous faire lorsque vous voyez ce signal ?	215	\N
1305	RW	Wakora iki ubonye icyi cyapa?	215	\N
1306	EN	What does this sign mean?	216	\N
1307	FR	Que signifie ce signal ?	216	\N
1308	RW	Iki cyapa gisobanura iki?	216	\N
1309	EN	What does this sign mean?	217	\N
1310	FR	Que signifie ce signal ?	217	\N
1311	RW	Iki cyapa gisobanura iki?	217	\N
1312	EN	Which shape is used for a 'give way' sign?	218	\N
1313	FR	Quelle forme est utilisée pour un panneau « céder le passage » ?	218	\N
1314	RW	Icyapa gitanga uburenganzira bwo gutambuka mbere kigira iyihe shusho?	218	\N
1315	EN	What does this sign mean?	219	\N
1316	FR	Que signifie ce signal ?	219	\N
1317	RW	Iki cyapa gisobanura iki?	219	\N
1318	EN	What does this sign mean?	220	\N
1319	FR	Ce signal signifie?	220	\N
1320	RW	Iki cyapa gisobanura iki?	220	\N
1321	EN	What does this sign mean?	221	\N
1322	FR	Ce signal signifie?	221	\N
1323	RW	Iki cyapa gisobanura iki?	221	\N
1327	EN	What does a red traffic light mean?	222	\N
1328	FR	Que signifie un feu rouge?	222	\N
1329	RW	Itara ritukura rivuga iki?	222	\N
1330	EN	What does a yellow light mean?	223	\N
1331	FR	Que signifie un feu jaune?	223	\N
1332	RW	Itara ry’umuhondo risobanura iki?	223	\N
1333	EN	What does a green light mean?	224	\N
1334	FR	Que signifie un feu vert?	224	\N
1335	RW	Itara ry’icyatsi risobanura iki?	224	\N
1336	EN	What does a broken white line mean?	225	\N
1337	FR	Que signifie une ligne blanche discontinue?	225	\N
1338	RW	Umurongo ucagaguye wera usobanura iki?	225	\N
1339	EN	What does this sign mean?	226	\N
1340	FR	Ce signal signifie?	226	\N
1341	RW	Iki cyapa gisobanura iki?	226	\N
1345	EN	What does this sign mean?	227	\N
1346	FR	Ce signal signifie?	227	\N
1347	RW	Iki cyapa gisobanura iki?	227	\N
1348	EN	What does this sign mean?	228	\N
1349	FR	Ce signal signifie?	228	\N
1350	RW	Iki cyapa gisobanura iki?	228	\N
1351	EN	What does this sign mean?	229	\N
1352	FR	Ce signal signifie?	229	\N
1353	RW	Iki cyapa gisobanura iki?	229	\N
1354	EN	At this junction, there’s a stop sign and a solid white line on the road surface. Why is there a stop sign here?	230	\N
1355	FR	À cette intersection, il y a un panneau Stop et une ligne blanche continue à la surface de la route. Pourquoi y a-t-il un panneau stop ici ?	230	\N
1356	RW	Muri iri sangano ry’umuhanda hari icyapa gisobanura “guhagarara” n’umurongo wera urombereje munzira. Niyihe mpamvu hari iki cyapa cyo “guhagarara” hano?	230	\N
1357	EN	A tanker is involved in collision. Which sign shows that it’s carrying dangerous goods?	235	\N
1358	FR	Un pétrolier est impliqué dans une collision. Quel panneau indique-qu’il transporte des marchandises dangereuses ?	235	\N
1359	RW	Umuyobozi w’ikinyabizaga cy’ikoreye ibintu bishobora gufata inkongi, n’ikihe cyapa cyerekana ko ibyo atwaye biturika by’afata inkongi ?	235	\N
1360	EN	Whoever pushes a motorcycle by hand must be considered as:	238	\N
1361	FR	Celui qui pousse à la main une moto doit être considéré comme :	238	\N
1362	RW	Umuyobozi usunika ipikipiki agomba gufatwa nka:	238	\N
1363	EN	Triangular Shape road signs announce:	239	\N
1364	FR	Les panneaux de forme triangulaire annoncent :	239	\N
1365	RW	Icyapa gikoze mw’ishusho ya mpandeshatu kimenyesha:	239	\N
1366	EN	This signal means :	240	\N
1367	FR	Ce signal signifie :	240	\N
1368	RW	Iki cyapa gisobanura :	240	\N
1369	EN	This signal means :	241	\N
1370	FR	Ce signal signifie :	241	\N
1371	RW	Iki cyapa gisobanura:	241	\N
1372	EN	Outside an agglomera on, you first encounter the two le -hand signals. Further, we announce the end of the work. Beyond that signal how fast do you roll?	242	\N
1373	FR	En dehors d’une aggloméra on, vous rencontrez d’abord les deux signaux de gauche. Plus loin, on vous annonce la fin des travaux. Au-delà de ce signal à quelle vitesse roulez-vous ? :	242	\N
1374	RW	Urenze munsisiro ,ukahasanga ibyapa bibiri ibumoso bwawe bimenyesha ko irangira ry’imirimo bitewe nicyo ibyo byapa bemenyesha wagendera kuwuhe muvuduko ?	242	\N
1375	EN	This signal indicates :	243	\N
1376	FR	Ce signal indique :	243	\N
1377	RW	Iki cyapa gisobanura iki?	243	\N
1378	EN	The two parallel discon nuous lines of white color at the edges of the road delimit:	244	\N
1379	FR	Les deux lignes discon nues parallèles de couleur blanche aux bords de la chaussée délimitent :	244	\N
1380	RW	igice kinzira nyabagendwa gikikijwe n’imirongo ibiri y’umweru iciyemo uduce kandi iteganye :	244	\N
1381	EN	This signal prevents any driver from overtaking a car:	245	\N
1382	FR	Ce signal interdit à tout conducteur de dépasser une voiture :	245	\N
1383	RW	iki cyapa kibuza abayobozi bibinyabiziga kunyuranaho :	245	\N
1384	EN	This signal prohibits overtaking on the le for the following vehicles:	246	\N
1385	FR	Ce signal interdit le dépassement par la gauche pour des vehicules suivantes :	246	\N
1386	RW	Iki cyapa kibuza kunyuranaho ibumoso ku binyabiziga bikurikira :	246	\N
1387	EN	This signaling authorizes me to move on:	247	\N
1388	FR	Ce e signalisa on m’autorise à m’engager :	247	\N
1389	RW	iki kimenyetso cyaka kinyemerera gukomeza:	247	\N
1390	EN	On a winding road, when do I brake?	248	\N
1391	FR	Sur une route sinueuse, quand est-ce que je freine ?	248	\N
1392	RW	Mu muhanda ufite uruhererekane rw’amakoni, feri y’urugendo ikoreshwa ryari?	248	\N
1393	EN	What signal obliges me to give way:	249	\N
1394	FR	Quel signal m’oblige à céder le passage :	249	\N
1395	RW	Ni ikihe cyapa muri ibi kintegeka gutanga inzira:	249	\N
1396	EN	This danger signal announces me:	250	\N
1397	FR	Ce signal de danger m’annonce :	250	\N
1398	RW	Iki cyapa gisobanura :	250	\N
1399	EN	Circula ng on a cyclo, you see one of your acquaintances. She asks you to leave her some streets further. You are 18 but do not have a second helmet. Could you?	251	\N
1400	FR	Circulant à cyclo, vous apercevez une de vos connaissances. Elle vous demande de la déposer quelques rues plus loin. Vous avez 18 ans mais ne disposez pas d’un second casque. Vous pouvez l’embarquer :	251	\N
1401	RW	Uri umuyobozi wa velomoteri, uhuye n’umwe munshu zawe agusaba ko wa mutwara ukamusiga ku’wundi muhanda. ufite imyaka 18 ariko nta ngofero yindi yabigenewe ufite. wamutwara?	251	\N
1402	EN	What signal gives you priority at future intersec ons:	252	\N
1403	FR	Quel signal vous accorde la priorité aux prochains carrefours :	252	\N
1404	RW	Ni ikihe cyapa cy’inyemerera gutambuka mbere mu masangano y’umuhanda?	252	\N
1405	EN	Before overtaking a mop ed, I have to put my flashing on the le :	253	\N
1406	FR	Avant de dépasser un cyclomotoriste, je dois me re mon clignoteur à gauche :	253	\N
1407	RW	Mbere yo kunyura kumuyobozi w’ikinyabiziga cy’imitende ibiri, ngomba gucana akaranga cyerekezo k’ibumoso?	253	\N
1408	EN	I can overtake a driver who stops in front of a pedestrian crossi ng:	254	\N
1409	FR	Je peux dépasser un conducteur qui s’arrête devant un passage pour piétons :	254	\N
1410	RW	Nshobora kunyuraho umuyobozi w’ikinyabiziga wahagaze imbere y’inzira yabanyamaguru?	254	\N
1411	EN	At height of this elevated device:	255	\N
1412	FR	À hauteur de ce disposi f surélevé :	255	\N
1413	RW	Hejuru y’aka kanunga:	255	\N
1414	EN	In case of accident, aggression ... which emergency number can call the emergency service:	256	\N
1415	FR	En cas d’accident, d’agression… quel numéro d’urgence gratuit permet d’appeler les services de secours :	256	\N
1416	RW	Mu gihe cy’impanuka mu muhanda n’ubundi bushotoranyi ni yihe nimero ya telefone y’ubutabazi wahamagara :	256	\N
1417	EN	I arrive first at the scene of an accident with injuries. My first concern is to:	257	\N
1418	FR	J’arrive le premier sur les lieux d’un accident avec blesses. Mon premier souci est de :	257	\N
1419	RW	Ugeze bwa mbere ahabereye imp anuka yo mu muhnda harimo inkomere wakora iki ?	257	\N
1420	EN	An approaching driver notices that the boy on the children’s bicycle has said goodbye to his friend. What is the correct action for the driver to take?	271	\N
1421	FR	Un automobiliste qui s’approche remarque que le jeune garçon à bicyclette a fait ses adieux à son ami. Quelle est la bonne action à prendre par le conducteur ?	271	\N
1422	RW	Umuyobozi w’ikinyabiziga yegereye aho umwana w’umuhungu utwaye akagare k’abana asezera ku nshuti ye. N’iyihe myitwarire myiza wagira imbere yabo?	271	\N
1423	EN	As the driver of the car, which conduct is correct? prepared to stop	272	\N
1424	FR	En tant que conducteur de la voiture, quel comportement est correct ? arrêter	272	\N
1425	RW	Nk’umuyobozi w’ikinyabiziga n’iyihe myitwarire wagira? ukitegura guhagarara	272	\N
1426	EN	The driver is following these two vehicles and wishes to overtake. What must the driver consider before overtaking here?	273	\N
1427	FR	Le conducteur suit ces deux véhicules et souhaite dépasser. Que doit considérer le conducteur avant de dépasser ici?	273	\N
1428	RW	Umuyobozi w’ikinyabiziga akurikiye ibinyabiziga bibiri, yifuza kubinyuraho. N’iki yashingiraho mbere yo kubinyuraho?	273	\N
1429	EN	What should the driver of the silver car do before turning right?	274	\N
1430	FR	Que doit faire le conducteur de la voiture argentée avant de tourner à droite ?	274	\N
1431	RW	N’iki umuyobozi w’ikinyabiziga yakora ashaka gukatira iburyo?	274	\N
1432	EN	What lights should a driver use in a fog?	275	\N
1433	FR	Quelles lumières un conducteur devrait-il utiliser dans un brouillard ?	275	\N
1434	RW	N’ayahe matara umuyobozi w’ikinyabiziga agomba gukoresha mugihe cy’ibihu?	275	\N
1435	EN	Which car, if any, is parked incorrectly?	276	\N
1436	FR	Quelle voiture, le cas échéant, est garée de manière incorrecte ?	276	\N
1437	RW	Muri ibi binyabiziga n’ikihe gihagaze nabi?	276	\N
1438	EN	How should a driver overtake the cyclist in this situation?	277	\N
1439	FR	Comment un conducteur devrait-il dépasser le cycliste dans cette situation ?	277	\N
1440	RW	Ni gute umuyobozi w’ikinyabiziga yanyura kumunvegare hano?	277	\N
1441	EN	What should a driver do if dazzled by the lights of an oncoming vehicle?	278	\N
1442	FR	Que doit faire le conducteur s’il est ébloui par les lumières d’un véhicule venant en sens inverse ?	278	\N
1443	RW	N’iki umuyobozi w’ikinyabiziga yakora aramutse ahumishijwe n’urumuri rw’amatara y’ikinyabiziga giturutse mu kindi cyerekezo?	278	\N
1444	EN	What should you do when approaching traffic lights that change from green to amber?	279	\N
1445	FR	Que devez-vous faire lorsque vous approchez de feux de signalisa on qui passent du vert à l’orange ?	279	\N
1446	RW	Niki ugomba gukora igihe wegereye ikimenyetso kimurika kiva mucyatsi kijya mumuhondo?	279	\N
1447	EN	What should a driver be aware of when following the motorcyclist, and the white car is reversing onto the road?	280	\N
1448	FR	Que doit savoir le conducteur lorsqu'il suit le motocycliste et que la voiture blanche fait demi-tour sur la route ?	280	\N
1449	RW	Niki umuyobozi w’ ikinyabiziga akwiriye kumenya mugihe akurikiye umuyobozi wikinyamitende ibiri kandi imodoka y’ umweru iri gusubira inyuma ijya mumuhanda?	280	\N
1450	EN	What should a driver do in this situation when intending to turn right?	281	\N
1451	FR	Que doit faire un conducteur dans cette situation lorsqu'il a l'intention de tourner à droite ?	281	\N
1452	RW	Aha niki umuyobozi w’ ikinyabiziga yakora mugihe iyo ashaka kujya iburyo?	281	\N
1453	EN	In this situation, should you overtake the cyclists?	282	\N
1454	FR	Cette situation, devriez-vous dépasser les cyclistes?	282	\N
1455	RW	Aha umuyobozi w’ ikinyabiziga ashobora kunyura kuri aba abanyamagare?	282	\N
1456	EN	Which vehicle is in the correct posi on to make a right turn from the major road into the minor road?	284	\N
1457	FR	Quel véhicule est dans la bonne posi on pour effectuer un virage à droite de la route principale dans la route secondaire ?	284	\N
1458	RW	Muri ibi binyabiziga bine ni ikihe kiri mu buryo bwiza bwo gukata ikoni ry’iburyo kiva mu muhanda munini kijya mu muto?	284	\N
1459	EN	What does a continuous white line along the center of the road mean?	290	\N
1460	FR	Que signifie une ligne blanche continue au centre de la route ?	290	\N
1461	RW	Umurongo w'umweru uromboreje uciye hagati mu muhanda uvuze iki?	290	\N
1462	EN	Where should a vehicle be positioned before turning left?	306	\N
1463	FR	Où placer un véhicule avant de tourner à gauche ?	306	\N
1464	RW	Mbere yo gukata ibumoso mu nzira nyabagendwa, ikinyabiziga kigomba kuba kiri he?	306	\N
1693	EN	From these road signs, it is forbidden:	415	\N
1694	FR	A partir de ces signaux routiers, il est interdit :	415	\N
1695	RW	uhereye kuri ibi byapa habujijwe :	415	\N
1468	EN	What should you do when you’re approaching traffic lights that are showing a yellow signal?	184	\N
1469	FR	Que devriez-vous faire lorsque vous vous approchez de feux de signalisation de couleur jaune?	184	\N
1470	RW	Niki wakora mugihe usanze mu bime bimurika harimo ibara ry’umuhondo?	184	\N
1471	EN	What does this sign mean?	199	\N
1472	FR	Que signifie ce panneau ?	199	\N
1473	RW	Icyapa gikurikira kivuze iki?	199	\N
1474	EN	On a two-lane roadway, what is the left-hand lane used for?	200	\N
1475	FR	Sur une chaussée à deux bandes, à quoi sert la bande de gauche ?	200	\N
1476	RW	Inzira nyabagendwa ifite ibyerekezo bibiri, uruhande rw’ibumoso rukoreshwa iki?	200	\N
1477	EN	Traffic signs giving orders are generally which shape?	204	\N
1478	FR	Les panneaux de signalisation donnant des ordres sont généralement de quelle forme ?	204	\N
1479	RW	Ibyapa bitegeka bikozwe mu yihe shusho?	204	\N
1480	EN	What does this sign mean?	198	\N
1481	FR	Que signifie ce panneau ?	198	\N
1482	RW	Icyapa gikurikira kivuze iki?	198	\N
1696	EN	I want to store my parked car on the right, on this sidewalk.	416	\N
1697	FR	Je veux ranger ma voiture en stationnement à droite, sur ce trottoir.	416	\N
1698	RW	Ndashaka gupariki ikinyabiga iburyo kunzira y'abanyamaguru :	416	\N
1486	EN	Which sign means no motor vehicles are allowed?	205	\N
1487	FR	Quel panneau signifie qu’aucun véhicule à moteur n’est autorisé ?	205	\N
1488	RW	Ni ikihe cyapa kigaragaza ko nta binyabiziga bifite moteri byemewe?	205	\N
1489	EN	You’ve broken down on a two-way road. You have a warning triangle. At least how far from your vehicle should you place the warning triangle	237	\N
1490	FR	Vous êtes tombé en panne sur une route à double sens. Vous avez un triangle d'aver ssement. Au moins à quelle distance de votre véhicule devriez-vous placer le triangle de pré signalisa on	237	\N
1491	RW	Uhuye n’ingorane utwaye ikinyabiziga , mu muhanda ufite ibyerekezo bibiri, ufite ikimenyetso kiburira cya mpandeshatu . wagishyira mu ntera ingana iki uvuye aho ikinyabiziga cyahagaze	237	\N
1492	EN	What should a driver do in this situa on?	283	\N
1493	FR	Que doit faire le conducteur dans ce e situa on ?	283	\N
1494	RW	Aha niki umuyobozi w’ ikinyabiziga yakora?	283	\N
1495	EN	This signal means: intersection of roads / junction	332	\N
1496	FR	Ce signal signifie : carrefour / intersection	332	\N
1497	RW	Iki cyapa kivuga aho imihanda ihurira cyangwa inkomane y’umuhanda	332	\N
1699	EN	What does this sign mean at a junction?	417	\N
1700	FR	Que signifie ce signal à un croisement?	417	\N
1701	RW	Iki cyapa gisobanura iki mu nkomane ?	417	\N
1501	EN	This signal means:	337	\N
1502	FR	Ce signal signifie:	337	\N
1503	RW	Iki cyapa kivuga:	337	\N
1504	EN	What does this sign mean?	379	\N
1505	FR	Que signifie ce signal ?	379	\N
1506	RW	Iki cyapa gisobanura iki ?	379	\N
1507	EN	What does this sign mean?	384	\N
1508	FR	Que signifie ce signal ?	384	\N
1509	RW	Iki cyapa gisobanura iki	384	\N
1768	EN	What does this sign mean?	435	\N
1769	FR	Que signifie ce signal ?	435	\N
1770	RW	Iki cyapa gisobanura iki ?	435	\N
1774	EN	What does this sign mean?	436	\N
1775	FR	Que signifie ce signal ?	436	\N
1776	RW	Iki cyapa gisobanura iki ?	436	\N
1618	EN	Intersection of road	390	\N
1619	FR	Ce signal signifie?	390	\N
1620	RW	Iki cyapa kivuga:	390	\N
1621	EN	367. This signal explains the following:	391	\N
1622	FR	367. Ce signal signifie:	391	\N
1623	RW	367. Iki cyapa gisobanura ibi bikurikira:	391	\N
1705	EN	What does this sign mean?	428	\N
1706	FR	Que signifie ce signal?	428	\N
1707	RW	Iki cyapa gisobanura iki ?	428	\N
1708	EN	What does this sign mean at a roundabout?	419	\N
1709	FR	Qu'est-ce que ce signal signifie à un rond-point?	419	\N
1710	RW	Iki cyapa gisobanura iki aho banyura bazengurutse ?	419	\N
1711	EN	What does this sign mean?	420	\N
1712	FR	Que signifie ce signal?	420	\N
1713	RW	Iki cyapa gisobanura iki ?	420	\N
1714	EN	What does this sign mean?	421	\N
1715	FR	Que signifie ce signal?	421	\N
1716	RW	Iki cyapa gisobanura iki ?	421	\N
1780	EN	What does this sign mean?	437	\N
1781	FR	Que signifie ce signal ?	437	\N
1782	RW	Iki cyapa gisobanura iki ?	437	\N
\.


--
-- Data for Name: Result; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Result" (id, score, "userId", "createdAt", total) FROM stdin;
3	0	7	2026-06-18 07:22:34.285	20
4	0	7	2026-06-18 07:35:07.315	20
5	0	7	2026-06-18 08:22:09.973	20
6	0	7	2026-06-18 09:32:15.358	20
7	1	7	2026-06-18 09:33:44.59	20
8	0	4	2026-06-18 20:57:01.035	20
9	0	4	2026-06-18 22:08:11.803	20
10	1	8	2026-06-20 10:49:07.07	20
11	1	7	2026-06-20 10:50:28.241	20
\.


--
-- Data for Name: Test; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Test" (id, title, "createdAt", duration) FROM stdin;
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, phone, email, password, role, approved, "createdAt", name, "lastLogin", profile, language) FROM stdin;
3	0786278952	\N	$2b$10$eDxOAaic8fn9kS5ijLUgfOoOdMZxiQgq9IsQqhfLB0PlIM2ETJFaG	USER	f	2026-04-28 13:59:46.434	Jean Paul	\N	\N	EN
1	0786278954	\N	$2b$10$eCpj9zed.2pxKflCRW28gO9Grwu5dwy3p1RAb1T.v7jakYsSd6In.	USER	t	2026-04-28 11:02:00.643	uwineza	\N	\N	RW
5	0786278950	\N	$2b$10$68Q7rRTf6FjX2vXPaxzdUObe.R.N5yIrV3tvOEh27ChuqIF3UngZq	USER	f	2026-04-29 12:30:26.324	Alex Alexandre	\N	\N	EN
7	0786278966	\N	$2b$10$McAA1MZs.SK00yoH431WKeBQtVZKaT473uu3YoyPFrDSyWwWBYiQi	USER	t	2026-06-17 11:25:17.961	kwizera	\N	\N	FR
8	0786278900	\N	$2b$10$8Nle23h4cm7K7GZVRmbjduAHli4JfrYddIjaXn41xs1B2zU.SNy.W	USER	t	2026-06-17 19:31:11.63	aline	\N	\N	FR
4	0786278953	\N	$2b$10$RyfaZcqjPhBDt/e13K6LIezC5Bxi1EKuNqwdEl03rNUxyNW5e5BNS	ADMIN	t	2026-04-28 14:01:43.984	Jean Paul	\N	\N	RW
6	078627896000	\N	$2b$10$PKKTE0P1C/hrA3VcYF3fweraIYC5rpz35mDvV/7MzZ7axjZNC4MkS	USER	t	2026-05-01 17:52:12.681	Kalisa Jeanvie	\N	\N	RW
\.


--
-- Data for Name: UserAnswer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserAnswer" (id, "resultId", "questionId", "optionId") FROM stdin;
29	3	155	634
30	5	436	2363
31	6	7	36
32	7	336	1356
33	8	170	694
34	10	183	745
35	11	38	159
\.


--
-- Data for Name: _TestQuestions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_TestQuestions" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
a3a2967b-e991-4280-8324-dd6bc566307d	3fa5da5f2e4c4913d92ef07ed17237607b3e254423497dca2d109cad948d8bd9	2026-04-28 03:49:27.402339-07	20260428104927_initial_schema	\N	\N	2026-04-28 03:49:27.303772-07	1
c9bc2bab-dc65-4cac-ad80-db940e0695f2	1ccb48a60fb11c9478bfbee052888551324325ecbb63d6acac28b068efe5bc9e	2026-04-28 03:59:28.507673-07	20260428105928_add_user_name	\N	\N	2026-04-28 03:59:28.474546-07	1
154d75ab-6a9a-47a2-9ae9-48e3d2dadd4f	96ce56e8a1acdba348d93c0068b0dc8397a92fc4ba51a1560a08fc097f1f89dc	2026-04-30 01:19:44.932532-07	20260430081944_fix_useranswer_relation	\N	\N	2026-04-30 01:19:44.81624-07	1
\.


--
-- Name: LoginHistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."LoginHistory_id_seq"', 1, false);


--
-- Name: OTP_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."OTP_id_seq"', 27, true);


--
-- Name: OptionTranslation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."OptionTranslation_id_seq"', 6449, true);


--
-- Name: Option_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Option_id_seq"', 2432, true);


--
-- Name: QuestionImage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."QuestionImage_id_seq"', 135, true);


--
-- Name: QuestionTranslation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."QuestionTranslation_id_seq"', 1827, true);


--
-- Name: Question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Question_id_seq"', 444, true);


--
-- Name: Result_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Result_id_seq"', 11, true);


--
-- Name: Test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Test_id_seq"', 1, false);


--
-- Name: UserAnswer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UserAnswer_id_seq"', 35, true);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 8, true);


--
-- Name: LoginHistory LoginHistory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LoginHistory"
    ADD CONSTRAINT "LoginHistory_pkey" PRIMARY KEY (id);


--
-- Name: OTP OTP_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OTP"
    ADD CONSTRAINT "OTP_pkey" PRIMARY KEY (id);


--
-- Name: OptionTranslation OptionTranslation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OptionTranslation"
    ADD CONSTRAINT "OptionTranslation_pkey" PRIMARY KEY (id);


--
-- Name: Option Option_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Option"
    ADD CONSTRAINT "Option_pkey" PRIMARY KEY (id);


--
-- Name: QuestionImage QuestionImage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionImage"
    ADD CONSTRAINT "QuestionImage_pkey" PRIMARY KEY (id);


--
-- Name: QuestionTranslation QuestionTranslation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionTranslation"
    ADD CONSTRAINT "QuestionTranslation_pkey" PRIMARY KEY (id);


--
-- Name: Question Question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Question"
    ADD CONSTRAINT "Question_pkey" PRIMARY KEY (id);


--
-- Name: Result Result_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Result"
    ADD CONSTRAINT "Result_pkey" PRIMARY KEY (id);


--
-- Name: Test Test_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Test"
    ADD CONSTRAINT "Test_pkey" PRIMARY KEY (id);


--
-- Name: UserAnswer UserAnswer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserAnswer"
    ADD CONSTRAINT "UserAnswer_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _TestQuestions _TestQuestions_AB_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_TestQuestions"
    ADD CONSTRAINT "_TestQuestions_AB_pkey" PRIMARY KEY ("A", "B");


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: OptionTranslation_optionId_language_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "OptionTranslation_optionId_language_key" ON public."OptionTranslation" USING btree ("optionId", language);


--
-- Name: QuestionTranslation_questionId_language_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "QuestionTranslation_questionId_language_key" ON public."QuestionTranslation" USING btree ("questionId", language);


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: User_phone_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_phone_key" ON public."User" USING btree (phone);


--
-- Name: _TestQuestions_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_TestQuestions_B_index" ON public."_TestQuestions" USING btree ("B");


--
-- Name: LoginHistory LoginHistory_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LoginHistory"
    ADD CONSTRAINT "LoginHistory_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: OTP OTP_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OTP"
    ADD CONSTRAINT "OTP_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: OptionTranslation OptionTranslation_optionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OptionTranslation"
    ADD CONSTRAINT "OptionTranslation_optionId_fkey" FOREIGN KEY ("optionId") REFERENCES public."Option"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Option Option_questionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Option"
    ADD CONSTRAINT "Option_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES public."Question"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: QuestionImage QuestionImage_questionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionImage"
    ADD CONSTRAINT "QuestionImage_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES public."Question"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: QuestionTranslation QuestionTranslation_questionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionTranslation"
    ADD CONSTRAINT "QuestionTranslation_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES public."Question"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Result Result_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Result"
    ADD CONSTRAINT "Result_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: UserAnswer UserAnswer_questionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserAnswer"
    ADD CONSTRAINT "UserAnswer_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES public."Question"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: UserAnswer UserAnswer_resultId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserAnswer"
    ADD CONSTRAINT "UserAnswer_resultId_fkey" FOREIGN KEY ("resultId") REFERENCES public."Result"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: _TestQuestions _TestQuestions_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_TestQuestions"
    ADD CONSTRAINT "_TestQuestions_A_fkey" FOREIGN KEY ("A") REFERENCES public."Question"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _TestQuestions _TestQuestions_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_TestQuestions"
    ADD CONSTRAINT "_TestQuestions_B_fkey" FOREIGN KEY ("B") REFERENCES public."Test"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict rPJfj6cIxVmASikUnbRmJ4iUzrsPS7Wm6cfSh9A5Tapu5vcDRZ8F6mlSROFw40K

