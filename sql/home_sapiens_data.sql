--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: home_sapiens_data; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA home_sapiens_data;


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = home_sapiens_data, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: box_logs; Type: TABLE; Schema: home_sapiens_data; Owner: -; Tablespace: 
--

CREATE TABLE box_logs (
    rec_id integer NOT NULL,
    box_id integer,
    dated timestamp with time zone NOT NULL,
    level character varying(10) NOT NULL,
    message character varying(2048) NOT NULL
);


--
-- Name: box_logs_seq; Type: SEQUENCE; Schema: home_sapiens_data; Owner: -
--

CREATE SEQUENCE box_logs_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: boxes; Type: TABLE; Schema: home_sapiens_data; Owner: -; Tablespace: 
--

CREATE TABLE boxes (
    id integer NOT NULL,
    version character varying(25) NOT NULL,
    ssid character varying(25) NOT NULL,
    public_key character varying(512) NOT NULL,
    status integer NOT NULL,
    phone_num character varying(25),
    wpa_psk character varying(25),
    megafon_lk_passw character varying(25),
    name character varying(255)
);


--
-- Name: boxes_seq; Type: SEQUENCE; Schema: home_sapiens_data; Owner: -
--

CREATE SEQUENCE boxes_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: remote_scripts; Type: TABLE; Schema: home_sapiens_data; Owner: -; Tablespace: 
--

CREATE TABLE remote_scripts (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: remote_scripts_data; Type: TABLE; Schema: home_sapiens_data; Owner: -; Tablespace: 
--

CREATE TABLE remote_scripts_data (
    id integer NOT NULL,
    script_id integer NOT NULL,
    command_type character varying(25) NOT NULL,
    command_body character varying(2048) NOT NULL
);


--
-- Name: remote_scripts_data_seq; Type: SEQUENCE; Schema: home_sapiens_data; Owner: -
--

CREATE SEQUENCE remote_scripts_data_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: remote_scripts_seq; Type: SEQUENCE; Schema: home_sapiens_data; Owner: -
--

CREATE SEQUENCE remote_scripts_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: server_log; Type: TABLE; Schema: home_sapiens_data; Owner: -; Tablespace: 
--

CREATE TABLE server_log (
    rec_id integer NOT NULL,
    module character varying(50),
    dated timestamp with time zone NOT NULL,
    level character varying(10) NOT NULL,
    message character varying(2048) NOT NULL
);


--
-- Name: server_log_seq; Type: SEQUENCE; Schema: home_sapiens_data; Owner: -
--

CREATE SEQUENCE server_log_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: terminals; Type: TABLE; Schema: home_sapiens_data; Owner: -; Tablespace: 
--

CREATE TABLE terminals (
    id numeric(15,5) NOT NULL,
    type numeric(15,5) NOT NULL,
    description character varying(255) NOT NULL,
    status numeric(15,5) NOT NULL
);


--
-- Name: terminals_seq; Type: SEQUENCE; Schema: home_sapiens_data; Owner: -
--

CREATE SEQUENCE terminals_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: traffic_stat; Type: TABLE; Schema: home_sapiens_data; Owner: -; Tablespace: 
--

CREATE TABLE traffic_stat (
    rec_id integer NOT NULL,
    dated timestamp with time zone NOT NULL,
    box_id integer NOT NULL,
    bytes_in integer NOT NULL,
    bytes_out integer NOT NULL
);


--
-- Name: traffic_stat_seq; Type: SEQUENCE; Schema: home_sapiens_data; Owner: -
--

CREATE SEQUENCE traffic_stat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users; Type: TABLE; Schema: home_sapiens_data; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    user_id integer NOT NULL,
    box_id integer NOT NULL,
    login character varying(50) NOT NULL,
    email character varying(50),
    salt character varying(64) NOT NULL,
    verifier character varying(66) NOT NULL,
    status integer NOT NULL,
    public_key character varying(260) NOT NULL,
    keyfile character varying(4096),
    sync_time timestamp with time zone
);


--
-- Name: users_seq; Type: SEQUENCE; Schema: home_sapiens_data; Owner: -
--

CREATE SEQUENCE users_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Data for Name: box_logs; Type: TABLE DATA; Schema: home_sapiens_data; Owner: -
--

COPY box_logs (rec_id, box_id, dated, level, message) FROM stdin;
5310	32	2016-12-20 11:49:34.033+03	INFO	Disconnecting box
5314	36	2016-12-20 11:49:34.034+03	INFO	Disconnecting box
5319	36	2016-12-20 11:49:34.034+03	INFO	Disconnecting box
5325	36	2016-12-20 11:50:00.169+03	INFO	Box connected from 31.173.86.214
5327	30	2016-12-20 11:50:00.435+03	INFO	Authenticated
5328	30	2016-12-20 11:50:00.435+03	INFO	Box connected from 5.228.250.240
5330	31	2016-12-20 11:50:02.242+03	INFO	Authenticated
5331	31	2016-12-20 11:50:02.242+03	INFO	Box connected from 31.173.81.103
5333	29	2016-12-20 11:50:10.401+03	INFO	Authenticated
5334	29	2016-12-20 11:50:10.401+03	INFO	Box connected from 31.173.83.138
5335	24	2016-12-20 12:26:37.742+03	INFO	Authenticating box, challenge = 7d6b75bb
5340	24	2016-12-20 12:28:24.428+03	INFO	Authenticating box, challenge = 416159a3
5345	29	2016-12-20 12:46:08.312+03	INFO	RSA LOGIN OK! BoxId=29, UserId=1, IP 85.140.0.238
5346	36	2016-12-20 13:28:50.84+03	INFO	Executing script id = 4 on box_id =36 admin ip 192.168.11.20
5349	29	2016-12-20 14:55:42.369+03	INFO	RSA LOGIN OK! BoxId=29, UserId=1, IP 83.220.236.254
5350	36	2016-12-20 15:40:11.342+03	INFO	Disconnecting box
5351	29	2016-12-20 16:42:22.336+03	INFO	RSA LOGIN OK! BoxId=29, UserId=1, IP 213.87.156.245
5352	36	2016-12-20 17:11:11.481+03	INFO	Authenticating box, challenge = 2baa2602
5355	36	2016-12-20 17:22:08.518+03	INFO	RSA LOGIN OK! BoxId=36, UserId=1, IP 192.168.11.20
5356	36	2016-12-20 17:55:59.128+03	INFO	Executing script id = 1 on box_id =36 admin ip 192.168.11.20
5367	36	2016-12-20 20:07:31.27+03	INFO	Disconnecting box
5369	29	2016-12-21 00:10:01.218+03	INFO	Disconnecting box
5371	30	2016-12-21 00:10:03.241+03	INFO	Authenticating box, challenge = 324f088e
5374	31	2016-12-21 00:10:06.408+03	INFO	Authenticating box, challenge = d49529ef
5377	29	2016-12-21 00:10:15.048+03	INFO	Authenticating box, challenge = 73763f47
5380	20	2016-12-21 11:26:40.053+03	INFO	Authenticating box, challenge = cd559fce
5383	37	2016-12-21 12:40:18.181+03	INFO	Authenticating box, challenge = ad86a0a8
5387	29	2016-12-21 14:13:26.816+03	INFO	RSA LOGIN OK! BoxId=29, UserId=1, IP 83.220.239.10
5388	29	2016-12-21 14:31:16.772+03	INFO	RSA LOGIN OK! BoxId=29, UserId=1, IP 213.87.157.247
5389	37	2016-12-21 15:43:05.044+03	INFO	Authenticating box, challenge = c5974e58
5392	32	2016-12-21 17:11:32.84+03	INFO	Authenticating box, challenge = 4f7c56b5
5396	32	2016-12-21 17:41:13.283+03	INFO	Executing script id = 4 on box_id =32 admin ip 192.168.11.20
5397	32	2016-12-21 17:41:13.346+03	INFO	Executing SYS command sudo halt -p
5399	32	2016-12-21 19:52:31.183+03	INFO	Disconnecting box
5400	37	2016-12-21 20:48:28.626+03	INFO	Executing script id = 1 on box_id =37 admin ip 192.168.11.20
5401	37	2016-12-21 20:48:28.661+03	INFO	Executing SQL command delete from sensors_data;
5411	38	2016-12-21 21:59:44.345+03	INFO	Authenticating box, challenge = f4aecfde
5415	38	2016-12-21 22:09:51.744+03	INFO	RSA LOGIN OK! BoxId=38, UserId=1, IP 31.173.80.200
5416	37	2016-12-21 23:00:15.182+03	INFO	Disconnecting box
5417	31	2016-12-22 00:10:01.132+03	INFO	Disconnecting box
5420	29	2016-12-22 00:10:01.154+03	INFO	Disconnecting box
5423	29	2016-12-22 00:10:02.893+03	INFO	Authenticated
5424	29	2016-12-22 00:10:02.893+03	INFO	Box connected from 31.173.83.138
5426	20	2016-12-22 00:10:03.892+03	INFO	Authenticated
5427	20	2016-12-22 00:10:03.892+03	INFO	Box connected from 31.173.84.140
5429	38	2016-12-22 00:10:05.337+03	INFO	Authenticated
5430	38	2016-12-22 00:10:05.337+03	INFO	Box connected from 31.173.84.56
5432	30	2016-12-22 00:10:08.702+03	INFO	Authenticated
5433	30	2016-12-22 00:10:08.702+03	INFO	Box connected from 5.228.250.240
5435	31	2016-12-22 00:10:13.748+03	INFO	Authenticated
5436	31	2016-12-22 00:10:13.748+03	INFO	Box connected from 31.173.81.103
5437	38	2016-12-22 05:15:32.945+03	INFO	RSA LOGIN OK! BoxId=38, UserId=1, IP 91.77.20.3
5454	38	2016-12-22 06:36:42.778+03	INFO	Executing script id = 3 on box_id =38 admin ip 192.168.11.20
5459	38	2016-12-22 06:37:19.186+03	INFO	Authenticating box, challenge = d27c688c
5462	29	2016-12-22 08:35:49.493+03	INFO	RSA LOGIN OK! BoxId=29, UserId=1, IP 83.220.238.214
5463	32	2016-12-22 08:43:22.377+03	INFO	RSA LOGIN OK! BoxId=32, UserId=1, IP 91.193.221.171
5464	31	2016-12-22 09:15:30.658+03	INFO	RSA LOGIN OK! BoxId=31, UserId=2, IP 87.245.133.250
5465	31	2016-12-22 10:48:34.084+03	INFO	RSA LOGIN OK! BoxId=31, UserId=2, IP 212.69.106.213
5466	38	2016-12-22 13:39:21.926+03	INFO	Authenticating box, challenge = 7d1f6b7f
5486	29	2016-12-22 14:20:38.893+03	INFO	RSA LOGIN OK! BoxId=29, UserId=1, IP 192.168.11.4
5487	38	2016-12-22 16:11:52.91+03	INFO	Disconnecting box
5488	29	2016-12-22 17:32:36.889+03	INFO	RSA LOGIN OK! BoxId=29, UserId=1, IP 83.220.236.94
5489	39	2016-12-22 19:09:36.587+03	INFO	Authenticating box, challenge = c28db67c
5493	39	2016-12-22 20:03:20.879+03	INFO	RSA LOGIN OK! BoxId=39, UserId=1, IP 91.77.20.3
5494	39	2016-12-22 20:27:19.608+03	INFO	SRP LOGIN OK! BoxId=39, UserId=1, IP 91.77.20.3
5495	39	2016-12-23 00:10:01.457+03	INFO	Disconnecting box
5499	31	2016-12-23 00:10:01.482+03	INFO	Disconnecting box
5501	29	2016-12-23 00:10:09.663+03	INFO	Authenticated
5502	29	2016-12-23 00:10:09.663+03	INFO	Box connected from 31.173.83.138
5504	20	2016-12-23 00:10:09.684+03	INFO	Authenticated
5505	20	2016-12-23 00:10:09.684+03	INFO	Box connected from 31.173.84.140
5507	30	2016-12-23 00:10:14.333+03	INFO	Authenticated
5508	30	2016-12-23 00:10:14.333+03	INFO	Box connected from 5.228.250.240
5510	39	2016-12-23 00:10:17.976+03	INFO	Authenticated
5511	39	2016-12-23 00:10:17.976+03	INFO	Box connected from 31.173.87.132
5513	31	2016-12-23 00:10:20.606+03	INFO	Authenticated
5514	31	2016-12-23 00:10:20.606+03	INFO	Box connected from 31.173.81.103
5515	29	2016-12-23 07:22:24.877+03	INFO	RSA LOGIN OK! BoxId=29, UserId=1, IP 83.220.238.107
5516	39	2016-12-23 08:34:54.24+03	INFO	RSA LOGIN OK! BoxId=39, UserId=1, IP 95.31.23.26
5517	39	2016-12-23 09:07:38.565+03	INFO	Executing script id = 3 on box_id =39 admin ip 192.168.11.20
5522	39	2016-12-23 09:08:14.513+03	INFO	Authenticating box, challenge = 5e2bd5c1
5525	29	2016-12-23 09:49:34.271+03	INFO	RSA LOGIN OK! BoxId=29, UserId=1, IP 83.220.238.107
5311	33	2016-12-20 11:49:34.033+03	INFO	Disconnecting box
5320	30	2016-12-20 11:49:34.037+03	INFO	Disconnecting box
5323	36	2016-12-20 11:50:00.157+03	INFO	Authenticating box, challenge = 1636bf29
5324	36	2016-12-20 11:50:00.166+03	INFO	Authenticated
5326	30	2016-12-20 11:50:00.434+03	INFO	Authenticating box, challenge = b1293455
5329	31	2016-12-20 11:50:02.241+03	INFO	Authenticating box, challenge = 6f70b02d
5332	29	2016-12-20 11:50:10.4+03	INFO	Authenticating box, challenge = 920d6128
5336	24	2016-12-20 12:26:37.746+03	INFO	Authenticated
5337	24	2016-12-20 12:26:37.746+03	INFO	Box connected from 192.168.11.20
5338	24	2016-12-20 12:28:13.289+03	INFO	Disconnecting box
5339	24	2016-12-20 12:28:13.291+03	INFO	Disconnecting box
5341	24	2016-12-20 12:28:24.43+03	INFO	Authenticated
5342	24	2016-12-20 12:28:24.43+03	INFO	Box connected from 192.168.11.20
5343	24	2016-12-20 12:28:35.808+03	INFO	Disconnecting box
5344	24	2016-12-20 12:28:35.808+03	INFO	Disconnecting box
5347	36	2016-12-20 13:28:50.888+03	INFO	Executing SYS command sudo halt -p
5348	36	2016-12-20 13:29:20.889+03	ERROR	Error exec SYS! 
5353	36	2016-12-20 17:11:11.483+03	INFO	Authenticated
5354	36	2016-12-20 17:11:11.483+03	INFO	Box connected from 31.173.80.74
5357	36	2016-12-20 17:55:59.147+03	INFO	Executing SQL command delete from sensors_data;
5358	36	2016-12-20 17:55:59.407+03	INFO	OK!
5359	36	2016-12-20 17:55:59.407+03	INFO	Executing SQL command delete from sms_outbox;
5360	36	2016-12-20 17:55:59.466+03	INFO	OK!
5361	36	2016-12-20 17:55:59.466+03	INFO	Executing SQL command delete from sms_inbox;
5362	36	2016-12-20 17:55:59.506+03	INFO	OK!
5363	36	2016-12-20 17:55:59.506+03	INFO	Executing SQL command delete from logs;
5364	36	2016-12-20 17:55:59.601+03	INFO	OK!
5365	36	2016-12-20 17:55:59.668+03	INFO	OK!
5366	36	2016-12-20 17:55:59.727+03	INFO	OK!
5368	30	2016-12-21 00:10:01.213+03	INFO	Disconnecting box
5372	30	2016-12-21 00:10:03.243+03	INFO	Authenticated
5373	30	2016-12-21 00:10:03.243+03	INFO	Box connected from 5.228.250.240
5375	31	2016-12-21 00:10:06.409+03	INFO	Authenticated
5376	31	2016-12-21 00:10:06.409+03	INFO	Box connected from 31.173.81.103
5378	29	2016-12-21 00:10:15.049+03	INFO	Authenticated
5379	29	2016-12-21 00:10:15.049+03	INFO	Box connected from 31.173.83.138
5381	20	2016-12-21 11:26:40.056+03	INFO	Authenticated
5382	20	2016-12-21 11:26:40.056+03	INFO	Box connected from 31.173.84.140
5384	37	2016-12-21 12:40:18.183+03	INFO	Authenticated
5385	37	2016-12-21 12:40:18.183+03	INFO	Box connected from 31.173.87.97
5386	37	2016-12-21 12:47:46.536+03	INFO	Registering user: 1
5390	37	2016-12-21 15:43:05.047+03	INFO	Authenticated
5391	37	2016-12-21 15:43:05.047+03	INFO	Box connected from 31.173.80.144
5393	32	2016-12-21 17:11:32.843+03	INFO	Authenticated
5394	32	2016-12-21 17:11:32.843+03	INFO	Box connected from 31.173.85.215
5395	32	2016-12-21 17:12:44.724+03	INFO	Registering user: 1
5398	32	2016-12-21 17:41:43.346+03	ERROR	Error exec SYS! 
5402	37	2016-12-21 20:48:28.895+03	INFO	OK!
5403	37	2016-12-21 20:48:28.895+03	INFO	Executing SQL command delete from sms_outbox;
5404	37	2016-12-21 20:48:28.965+03	INFO	OK!
5405	37	2016-12-21 20:48:28.965+03	INFO	Executing SQL command delete from sms_inbox;
5406	37	2016-12-21 20:48:29.024+03	INFO	OK!
5407	37	2016-12-21 20:48:29.024+03	INFO	Executing SQL command delete from logs;
5408	37	2016-12-21 20:48:29.087+03	INFO	OK!
5409	37	2016-12-21 20:48:29.144+03	INFO	OK!
5410	37	2016-12-21 20:48:29.204+03	INFO	OK!
5412	38	2016-12-21 21:59:44.35+03	INFO	Authenticated
5413	38	2016-12-21 21:59:44.35+03	INFO	Box connected from 31.173.84.56
5414	38	2016-12-21 22:03:45.214+03	INFO	Registering user: 1
5418	30	2016-12-22 00:10:01.136+03	INFO	Disconnecting box
5421	38	2016-12-22 00:10:01.161+03	INFO	Disconnecting box
5422	29	2016-12-22 00:10:02.892+03	INFO	Authenticating box, challenge = 98815257
5425	20	2016-12-22 00:10:03.891+03	INFO	Authenticating box, challenge = db385a00
5428	38	2016-12-22 00:10:05.335+03	INFO	Authenticating box, challenge = fe344210
5431	30	2016-12-22 00:10:08.701+03	INFO	Authenticating box, challenge = b3a8e20f
5434	31	2016-12-22 00:10:13.747+03	INFO	Authenticating box, challenge = 7cacf283
5438	38	2016-12-22 05:23:53.572+03	INFO	Executing script id = 3 on box_id =38 admin ip 192.168.11.20
5443	38	2016-12-22 05:24:30.593+03	INFO	Authenticating box, challenge = 499de55c
5446	38	2016-12-22 05:28:32.525+03	INFO	Executing script id = 3 on box_id =38 admin ip 192.168.11.20
5451	38	2016-12-22 05:29:06.206+03	INFO	Authenticating box, challenge = b9aa538b
5455	38	2016-12-22 06:36:42.821+03	INFO	Executing SYS command sudo service tomcat7 restart
5456	38	2016-12-22 06:36:43.329+03	INFO	Disconnecting box
5457	38	2016-12-22 06:36:43.33+03	INFO	Disconnecting box
5458	38	2016-12-22 06:37:12.822+03	ERROR	Error exec SYS! 
5460	38	2016-12-22 06:37:19.188+03	INFO	Authenticated
5461	38	2016-12-22 06:37:19.188+03	INFO	Box connected from 31.173.84.56
5467	38	2016-12-22 13:39:21.93+03	INFO	Authenticated
5468	38	2016-12-22 13:39:21.93+03	INFO	Box connected from 31.173.85.12
5490	39	2016-12-22 19:09:36.592+03	INFO	Authenticated
5491	39	2016-12-22 19:09:36.592+03	INFO	Box connected from 31.173.87.132
5492	39	2016-12-22 19:14:25.197+03	INFO	Registering user: 1
5496	20	2016-12-23 00:10:01.462+03	INFO	Disconnecting box
5500	29	2016-12-23 00:10:09.662+03	INFO	Authenticating box, challenge = a8d2da8
5506	30	2016-12-23 00:10:14.332+03	INFO	Authenticating box, challenge = 25f69efb
5509	39	2016-12-23 00:10:17.975+03	INFO	Authenticating box, challenge = 56bcf77f
5512	31	2016-12-23 00:10:20.605+03	INFO	Authenticating box, challenge = 357a8789
5518	39	2016-12-23 09:07:38.612+03	INFO	Executing SYS command sudo service tomcat7 restart
5519	39	2016-12-23 09:07:39.261+03	INFO	Disconnecting box
5520	39	2016-12-23 09:07:39.262+03	INFO	Disconnecting box
5521	39	2016-12-23 09:08:08.612+03	ERROR	Error exec SYS! 
5523	39	2016-12-23 09:08:14.514+03	INFO	Authenticated
5524	39	2016-12-23 09:08:14.514+03	INFO	Box connected from 31.173.87.132
5312	34	2016-12-20 11:49:34.033+03	INFO	Disconnecting box
5321	29	2016-12-20 11:49:34.037+03	INFO	Disconnecting box
5370	31	2016-12-21 00:10:01.239+03	INFO	Disconnecting box
5419	20	2016-12-22 00:10:01.146+03	INFO	Disconnecting box
5439	38	2016-12-22 05:23:53.667+03	INFO	Executing SYS command sudo service tomcat7 restart
5440	38	2016-12-22 05:23:54.305+03	INFO	Disconnecting box
5441	38	2016-12-22 05:23:54.306+03	INFO	Disconnecting box
5442	38	2016-12-22 05:24:23.667+03	ERROR	Error exec SYS! 
5444	38	2016-12-22 05:24:30.594+03	INFO	Authenticated
5445	38	2016-12-22 05:24:30.594+03	INFO	Box connected from 31.173.84.56
5447	38	2016-12-22 05:28:32.532+03	INFO	Executing SYS command sudo service tomcat7 restart
5448	38	2016-12-22 05:28:33.009+03	INFO	Disconnecting box
5449	38	2016-12-22 05:28:33.01+03	INFO	Disconnecting box
5450	38	2016-12-22 05:29:02.533+03	ERROR	Error exec SYS! 
5452	38	2016-12-22 05:29:06.207+03	INFO	Authenticated
5453	38	2016-12-22 05:29:06.207+03	INFO	Box connected from 31.173.84.56
5469	38	2016-12-22 13:51:40.969+03	INFO	Executing script id = 4 on box_id =38 admin ip 192.168.11.20
5470	38	2016-12-22 13:51:41.023+03	INFO	Executing SYS command sudo halt -p
5472	38	2016-12-22 13:56:46.984+03	INFO	Authenticating box, challenge = 136bb37d
5475	38	2016-12-22 14:00:25.091+03	INFO	Executing script id = 1 on box_id =38 admin ip 192.168.11.20
5476	38	2016-12-22 14:00:25.099+03	INFO	Executing SQL command delete from sensors_data;
5497	29	2016-12-23 00:10:01.465+03	INFO	Disconnecting box
5503	20	2016-12-23 00:10:09.683+03	INFO	Authenticating box, challenge = 1e77c615
5313	20	2016-12-20 11:49:34.033+03	INFO	Disconnecting box
5322	31	2016-12-20 11:49:34.038+03	INFO	Disconnecting box
5471	38	2016-12-22 13:52:11.023+03	ERROR	Error exec SYS! 
5473	38	2016-12-22 13:56:46.986+03	INFO	Authenticated
5474	38	2016-12-22 13:56:46.986+03	INFO	Box connected from 31.173.83.88
5477	38	2016-12-22 14:00:25.302+03	INFO	OK!
5478	38	2016-12-22 14:00:25.302+03	INFO	Executing SQL command delete from sms_outbox;
5479	38	2016-12-22 14:00:25.381+03	INFO	OK!
5480	38	2016-12-22 14:00:25.382+03	INFO	Executing SQL command delete from sms_inbox;
5481	38	2016-12-22 14:00:25.441+03	INFO	OK!
5482	38	2016-12-22 14:00:25.441+03	INFO	Executing SQL command delete from logs;
5483	38	2016-12-22 14:00:25.521+03	INFO	OK!
5484	38	2016-12-22 14:00:25.601+03	INFO	OK!
5485	38	2016-12-22 14:00:25.671+03	INFO	OK!
5498	30	2016-12-23 00:10:01.467+03	INFO	Disconnecting box
5315	35	2016-12-20 11:49:34.033+03	INFO	Disconnecting box
5316	30	2016-12-20 11:49:34.037+03	INFO	Disconnecting box
5317	29	2016-12-20 11:49:34.037+03	INFO	Disconnecting box
5318	31	2016-12-20 11:49:34.038+03	INFO	Disconnecting box
5194	35	2016-12-16 08:04:35.612+03	INFO	SRP LOGIN OK! BoxId=35, UserId=1, IP 91.77.20.3
5195	29	2016-12-16 08:38:15.302+03	INFO	RSA LOGIN OK! BoxId=29, UserId=1, IP 83.220.238.67
5196	35	2016-12-16 10:24:55.854+03	INFO	Executing script id = 3 on box_id =35 admin ip 192.168.11.20
5197	35	2016-12-16 10:24:55.875+03	INFO	Executing SYS command sudo service tomcat7 restart
5198	35	2016-12-16 10:24:56.401+03	INFO	Disconnecting box
5199	35	2016-12-16 10:24:56.402+03	INFO	Disconnecting box
5200	35	2016-12-16 10:25:25.875+03	ERROR	Error exec SYS! 
5201	35	2016-12-16 10:25:31.693+03	INFO	Authenticating box, challenge = 6670119e
5202	35	2016-12-16 10:25:31.695+03	INFO	Authenticated
5203	35	2016-12-16 10:25:31.695+03	INFO	Box connected from 31.173.80.15
5204	35	2016-12-16 10:31:31.661+03	INFO	Executing script id = 3 on box_id =35 admin ip 192.168.11.20
5205	35	2016-12-16 10:31:31.676+03	INFO	Executing SYS command sudo service tomcat7 restart
5206	35	2016-12-16 10:31:32.2+03	INFO	Disconnecting box
5207	35	2016-12-16 10:31:32.201+03	INFO	Disconnecting box
5208	35	2016-12-16 10:32:01.676+03	ERROR	Error exec SYS! 
5209	35	2016-12-16 10:32:07.977+03	INFO	Authenticating box, challenge = 5e10ecf5
5210	35	2016-12-16 10:32:07.978+03	INFO	Authenticated
5211	35	2016-12-16 10:32:07.978+03	INFO	Box connected from 31.173.80.15
5212	35	2016-12-16 10:33:14.679+03	INFO	Executing script id = 4 on box_id =35 admin ip 192.168.11.20
5213	35	2016-12-16 10:33:14.686+03	INFO	Executing SYS command sudo halt -p
5214	35	2016-12-16 10:33:44.686+03	ERROR	Error exec SYS! 
5215	35	2016-12-16 11:40:27.564+03	INFO	Authenticating box, challenge = 3f7c8b2f
5216	35	2016-12-16 11:40:27.566+03	INFO	Authenticated
5217	35	2016-12-16 11:40:27.567+03	INFO	Box connected from 31.173.83.152
5218	35	2016-12-16 12:01:54.608+03	INFO	Executing script id = 1 on box_id =35 admin ip 192.168.11.20
5219	35	2016-12-16 12:01:54.641+03	INFO	Executing SQL command delete from sensors_data;
5220	35	2016-12-16 12:01:54.846+03	INFO	OK!
5221	35	2016-12-16 12:01:54.846+03	INFO	Executing SQL command delete from sms_outbox;
5222	35	2016-12-16 12:01:54.906+03	INFO	OK!
5223	35	2016-12-16 12:01:54.906+03	INFO	Executing SQL command delete from sms_inbox;
5224	35	2016-12-16 12:01:55.026+03	INFO	OK!
5225	35	2016-12-16 12:01:55.026+03	INFO	Executing SQL command delete from logs;
5226	35	2016-12-16 12:01:55.138+03	INFO	OK!
5227	35	2016-12-16 12:01:55.186+03	INFO	OK!
5228	35	2016-12-16 12:01:55.266+03	INFO	OK!
5229	35	2016-12-16 14:13:25.323+03	INFO	Disconnecting box
5230	30	2016-12-16 18:20:19.574+03	INFO	Authenticating box, challenge = 3898e408
5231	30	2016-12-16 18:20:19.576+03	INFO	Authenticated
5232	30	2016-12-16 18:20:19.577+03	INFO	Box connected from 5.228.250.240
5233	36	2016-12-16 18:36:41.133+03	INFO	Authenticating box, challenge = 3c8f16b1
5234	36	2016-12-16 18:36:41.137+03	INFO	Authenticated
5235	36	2016-12-16 18:36:41.137+03	INFO	Box connected from 31.173.84.199
5236	36	2016-12-16 18:51:51.44+03	INFO	Registering user: 1
5237	36	2016-12-16 18:52:24.126+03	INFO	Disconnecting box
5238	36	2016-12-16 18:52:24.127+03	INFO	Disconnecting box
5239	29	2016-12-16 19:03:02.87+03	INFO	RSA LOGIN OK! BoxId=29, UserId=1, IP 185.19.21.196
5240	20	2016-12-16 20:48:53.455+03	INFO	Disconnecting box
5241	29	2016-12-16 21:10:28.655+03	INFO	RSA LOGIN OK! BoxId=29, UserId=1, IP 185.19.21.196
5242	29	2016-12-16 22:17:08.618+03	INFO	RSA LOGIN OK! BoxId=29, UserId=1, IP 83.220.238.67
5243	30	2016-12-17 00:10:01.743+03	INFO	Disconnecting box
5244	29	2016-12-17 00:10:01.757+03	INFO	Disconnecting box
5245	31	2016-12-17 00:10:01.766+03	INFO	Disconnecting box
5246	29	2016-12-17 00:10:17.398+03	INFO	Authenticating box, challenge = 389db00
5247	29	2016-12-17 00:10:17.4+03	INFO	Authenticated
5248	29	2016-12-17 00:10:17.4+03	INFO	Box connected from 31.173.83.138
5249	31	2016-12-17 00:10:17.668+03	INFO	Authenticating box, challenge = bb756c8e
5250	31	2016-12-17 00:10:17.67+03	INFO	Authenticated
5251	31	2016-12-17 00:10:17.67+03	INFO	Box connected from 31.173.81.103
5252	30	2016-12-17 00:10:21.009+03	INFO	Authenticating box, challenge = 6dba472c
5253	30	2016-12-17 00:10:21.011+03	INFO	Authenticated
5254	30	2016-12-17 00:10:21.011+03	INFO	Box connected from 5.228.250.240
5255	30	2016-12-18 00:10:01.807+03	INFO	Disconnecting box
5256	29	2016-12-18 00:10:01.804+03	INFO	Disconnecting box
5257	31	2016-12-18 00:10:01.804+03	INFO	Disconnecting box
5258	29	2016-12-18 00:10:04.586+03	INFO	Authenticating box, challenge = fb66901
5259	29	2016-12-18 00:10:04.589+03	INFO	Authenticated
5260	29	2016-12-18 00:10:04.589+03	INFO	Box connected from 31.173.83.138
5262	31	2016-12-18 00:10:04.738+03	INFO	Authenticated
5261	31	2016-12-18 00:10:04.737+03	INFO	Authenticating box, challenge = ddcf68d4
5264	30	2016-12-18 00:10:06.518+03	INFO	Authenticating box, challenge = f86df119
5263	31	2016-12-18 00:10:04.738+03	INFO	Box connected from 31.173.81.103
5265	30	2016-12-18 00:10:06.519+03	INFO	Authenticated
5266	30	2016-12-18 00:10:06.519+03	INFO	Box connected from 5.228.250.240
5267	29	2016-12-18 12:49:39.805+03	INFO	RSA LOGIN OK! BoxId=29, UserId=1, IP 83.220.236.113
5268	29	2016-12-18 14:59:49.617+03	INFO	RSA LOGIN OK! BoxId=29, UserId=1, IP 213.87.145.68
5269	29	2016-12-18 19:28:02.43+03	INFO	RSA LOGIN OK! BoxId=29, UserId=1, IP 83.220.236.237
5270	30	2016-12-19 00:10:01.587+03	INFO	Disconnecting box
5271	31	2016-12-19 00:10:01.61+03	INFO	Disconnecting box
5272	29	2016-12-19 00:10:01.605+03	INFO	Disconnecting box
5273	31	2016-12-19 00:10:11.349+03	INFO	Authenticating box, challenge = 9fc90a61
5274	31	2016-12-19 00:10:11.352+03	INFO	Authenticated
5275	31	2016-12-19 00:10:11.352+03	INFO	Box connected from 31.173.81.103
5276	29	2016-12-19 00:10:11.516+03	INFO	Authenticating box, challenge = d720c2e4
5277	29	2016-12-19 00:10:11.517+03	INFO	Authenticated
5278	29	2016-12-19 00:10:11.518+03	INFO	Box connected from 31.173.83.138
5279	30	2016-12-19 00:10:12.114+03	INFO	Authenticating box, challenge = d3735983
5280	30	2016-12-19 00:10:12.116+03	INFO	Authenticated
5281	30	2016-12-19 00:10:12.116+03	INFO	Box connected from 5.228.250.240
5282	31	2016-12-19 07:49:51.391+03	INFO	RSA LOGIN OK! BoxId=31, UserId=2, IP 188.32.200.79
5283	29	2016-12-19 15:56:56.724+03	INFO	RSA LOGIN OK! BoxId=29, UserId=1, IP 213.87.159.181
5284	36	2016-12-19 18:26:53.713+03	INFO	Authenticating box, challenge = 32353e32
5285	36	2016-12-19 18:26:53.716+03	INFO	Authenticated
5286	36	2016-12-19 18:26:53.716+03	INFO	Box connected from 31.173.86.214
5287	36	2016-12-19 18:49:45.515+03	INFO	SRP LOGIN OK! BoxId=36, UserId=1, IP 192.168.11.20
5288	29	2016-12-19 20:58:29.771+03	INFO	RSA LOGIN OK! BoxId=29, UserId=1, IP 83.220.236.254
5289	29	2016-12-19 20:59:43.873+03	INFO	SRP LOGIN OK! BoxId=29, UserId=1, IP 83.220.236.254
5290	29	2016-12-19 21:59:01.523+03	INFO	SRP LOGIN OK! BoxId=29, UserId=1, IP 85.140.3.25
5291	36	2016-12-19 23:37:07.279+03	INFO	RSA LOGIN OK! BoxId=36, UserId=1, IP 91.77.20.3
5292	31	2016-12-20 00:10:01.985+03	INFO	Disconnecting box
5293	30	2016-12-20 00:10:01.985+03	INFO	Disconnecting box
5294	29	2016-12-20 00:10:01.989+03	INFO	Disconnecting box
5295	36	2016-12-20 00:10:02.003+03	INFO	Disconnecting box
5296	29	2016-12-20 00:10:04.32+03	INFO	Authenticating box, challenge = 1ba99263
5297	29	2016-12-20 00:10:04.321+03	INFO	Authenticated
5298	29	2016-12-20 00:10:04.321+03	INFO	Box connected from 31.173.83.138
5299	36	2016-12-20 00:10:15.412+03	INFO	Authenticating box, challenge = 8ba0fa73
5300	36	2016-12-20 00:10:15.413+03	INFO	Authenticated
5301	36	2016-12-20 00:10:15.413+03	INFO	Box connected from 31.173.86.214
5302	30	2016-12-20 00:10:17.509+03	INFO	Authenticating box, challenge = 28354c13
5303	30	2016-12-20 00:10:17.51+03	INFO	Authenticated
5304	30	2016-12-20 00:10:17.51+03	INFO	Box connected from 5.228.250.240
5305	31	2016-12-20 00:10:18.162+03	INFO	Authenticating box, challenge = 29a6c990
5306	31	2016-12-20 00:10:18.164+03	INFO	Authenticated
5307	31	2016-12-20 00:10:18.164+03	INFO	Box connected from 31.173.81.103
5308	29	2016-12-20 07:27:02.333+03	INFO	SRP LOGIN OK! BoxId=29, UserId=1, IP 85.140.3.25
5309	36	2016-12-20 09:03:11.674+03	INFO	RSA LOGIN OK! BoxId=36, UserId=1, IP 91.77.20.3
\.


--
-- Name: box_logs_seq; Type: SEQUENCE SET; Schema: home_sapiens_data; Owner: -
--

SELECT pg_catalog.setval('box_logs_seq', 5525, true);


--
-- Data for Name: boxes; Type: TABLE DATA; Schema: home_sapiens_data; Owner: -
--

COPY boxes (id, version, ssid, public_key, status, phone_num, wpa_psk, megafon_lk_passw, name) FROM stdin;
35	0.0.1c	Upravdom_28a7	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDHmAmk9bHDmoz/+LsoRN5CZaN6\nsrHRRpWgpmxRFFNatGgNknn3PpcbLsH5M8UgMAXsvtohRVhuiBgBLTflblM5Tf/a\neSEfbGDchJU9WoObsVAtmxlajt0dXB8qDrgVJehQxcVsr+sXN+ToDDB1eYWqkUKa\n0XvMdw2I4eU2w2OZAwIDAQAB\n-----END PUBLIC KEY-----\n	1	+79259226517	5c7e5459ec	nb2Bhn	\N
24	0.0.1b	HomeSapiens_ccbe	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIW9jxEImrN7QAbc/u6o7yQ8go\nQwLBF72gyemWHDVgu77iQjkPAufUgmFS5MRVCM3/Dk3HRAI0Tc8pPCdwgxIIKaMq\nZ+FcyWPa1WewN03ZQitFy2NNHc27r1rNzrdz19VFH8C4ShfBCUU2hPjcNWjE7HQH\nppo5EEcIzeBxpk2wFwIDAQAB\n-----END PUBLIC KEY-----\n	1	\N	2430d6ec4a	\N	Toshiba830
31	0.0.1c	Upravdom_cb8b	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDO1rzX1EY0SdRBFspLq4bOEkXY\naWhItutNT7EOd5yc0tF72amuJ3hIyvy8oM9/kq8EyDzYFg3AxXQ4N5LE9L+jO/A6\nPD23iNa9t2jPrvGCQOiaIaHOvxPZp+yGPXnZQeVJmsoa/EeoRgNthU0L60vtOEiP\nWDU8A9HOYbZspplJrwIDAQAB\n-----END PUBLIC KEY-----\n	1	+79259226522	01fedbf940	n57d6f	Dekevich
30	0.0.1c	HomeSapiens_2981	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCuY8sdHiOMrFucGIZ+K1tmBlxL\neQv28vkJN8/CzjpZixI6OqX+UR02dDpUDy1hG1UCrXoHV563IBwZ0nJI24z2mE8B\nnJaBMWO2/Mcn/8/IX21yvKkioaxzpODstO7OGtzhZsjvB2xhQZ9WvoplxPlQfU7V\nRxX97Tn9stxXv1NxvwIDAQAB\n-----END PUBLIC KEY-----\n	1	\N	e839b10d65	\N	Solovev
36	0.0.1c	Upravdom_edce	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDYD5KTf4vR65pYsLHjZTuRaIwW\nYkvslyNfGgdUaGSwkGXes7JOeV8L+1Uds8IhaaV3uUXTBX9h3EJE+Vwsn+MUQcid\nfo9ftH1vKKzJqPIzeqzVirajuOspGPhzP4qlqL83IVdo9WVSe9BdCl5RwGRIK+Rd\nNoECgzfkLD+F4M1f6wIDAQAB\n-----END PUBLIC KEY-----\n	1	+79259226516	1f4c83aaa5	cpa7xa	\N
37	0.0.1c	Upravdom_52a1	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDO63L7YcBDalSCr+LuDDdZgXtV\np02Q+Ih3IZRxp2CMzYuP/oiLjcNDNnsXlRuR240ZLmFtcG60S1HIdzexCUKYJ76m\nIc/MPMrA4NeRhpLjehHkJ6H1nY3FLT6yB9rcJG8RmcatU6uRSpVYxA+dMFa4Q/4K\nk5enUeF5NmHg8kBxgwIDAQAB\n-----END PUBLIC KEY-----\n	1	+79259226515	f892336c6c	hrz2Y3	\N
29	0.0.1c	Upravdom_7178	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC30qNB74kmVLWQX6rEVFcGHlO4\niS7DFPoh6Fi1eajIKzvVEh2wtiAA2Cj0Lg1yXv2zdS4PCwjwkJ/Jnd8lFfhbUYP7\nNptnbkxYbpO9TMb+StvcYHZpn0HAfD/Dvfo5dhpr9h5JU5DDf5JmKV4AuMFMTePW\n4TmvRbpQow5zAEsl2QIDAQAB\n-----END PUBLIC KEY-----\n	1	+79259226521	b86606331c	3hWYX8	JDenis
20	0.0.1a	HomeSapiens_c417	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC7V4jo5Ho2rbDE7VyXFTLkCH0q\nfFU4jpD2TLcqATY0WoRNabrp+EGf2FbVTT101pCVv4Ba17F+bVOxIf4AmicTKA74\nqrVvSnuw+dPZEhETSUS+XY5+yrwW+GHlQ5ph045XvrqahFHHKNpDOu2iBUNjeq4Y\n85OhLj8+Ly83AKj3tQIDAQAB\n-----END PUBLIC KEY-----\n	1	+79265439450	6fd112653b	V0vf2c	Prototype
33	0.0.1c	Upravdom_1f3b	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDDL/G/0f+4ahB0GHh8CZk6DPz\nBl+XBVFLkq7eiHx6R/LTKO8NVkvuVSZ0Dw6skWi7fapbvJWamoWx/12MP4ZZNpzb\n38MznlTWVLWzFOXTFFQK15W20eiZjZTM8wXK5pDEup8d94vbjvVB+ozvG1dNEw58\noZI2l94N9ztWa7PKLQIDAQAB\n-----END PUBLIC KEY-----\n	1	+79259226519	d2398b4a1b	Xn7ihx	Popov
32	0.0.1c	Upravdom_7bb7	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCsD9FVZhNrpUgrJ/SrjygzGLmJ\nF8O5xkZc5prSFOGF6LoeMy5Q3iCxs9pStykcnFV0BGknD/ykMJxWTTrVdpnpzE+I\nVECCajbg76Cva/8xZW/VQRP5BTalu5Wd28CN2Nl0/WmF+SVk6f/MSGrIekab0V++\nrj2HH0SAAqtPOIPy3QIDAQAB\n-----END PUBLIC KEY-----\n	1	+79259226520	c61153761d	r0gnrl	Shamil
34	0.0.1c	Upravdom_246a	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDJRuDEVgDhIAnPEBtFGCT5y5p0\nvsOoN41t33pq2PHKuMtGQAEVQLBsL90IT2Hv7x8X1jdBhYu/myUJmvTB29HhkhZU\n76kfLHk+FXDTfIBrizwsS9/bQp/+0ERN8Sm7P+Z7XutElRmZk/b/VY3yodSI8nVj\n+WVgup3v3r/s+w03fwIDAQAB\n-----END PUBLIC KEY-----\n	1	+79259226518	b60674d645	W8nnpw	\N
38	0.0.1c	Upravdom_dc17	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDLHepSz+9P6YJmdItHfm7Bsas2\noBoWPwLI7skToGJK2KtcFX/vUxhVOIR13C7FXysQ7V2M4FLRIdzxZYJhrdlQsBlR\n17LL2kV0JNJuKDaigzkVsOca6hbo37y9iiZMAQ/mryRjInaL50FbSq5HyIKCLH9F\nwvZxeWJYdcWinniEuwIDAQAB\n-----END PUBLIC KEY-----\n	1	+79259226514	c501f20b92	t7Yxjk	\N
39	0.0.1c	Upravdom_b8d1	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDMT0YTJ56QWPQ64PvF5DIlo3k5\n26lQV/ZNhQWlF03wMu7GjmjGNeDuvVwOpdyJVfFyHeUa3HPmJOwtFjkCJ6my9Wm/\nqfjJqWotlVkRielFm62cK3TTrc0EXslf2Axm7qFOVlCR/6WGGf0KuGSbfs++l25M\nR5W3x2S7ricBZYedZQIDAQAB\n-----END PUBLIC KEY-----\n	1	+79259226513	16f7f368a2	j19sBi	\N
\.


--
-- Name: boxes_seq; Type: SEQUENCE SET; Schema: home_sapiens_data; Owner: -
--

SELECT pg_catalog.setval('boxes_seq', 39, true);


--
-- Data for Name: remote_scripts; Type: TABLE DATA; Schema: home_sapiens_data; Owner: -
--

COPY remote_scripts (id, name) FROM stdin;
1	Clean All Data
2	Update Cell_ID database
3	Restart tomcat
4	Halt p
\.


--
-- Data for Name: remote_scripts_data; Type: TABLE DATA; Schema: home_sapiens_data; Owner: -
--

COPY remote_scripts_data (id, script_id, command_type, command_body) FROM stdin;
1	1	SQL	delete from sensors_data;
4	1	SQL	delete from logs;
2	1	SQL	delete from sms_outbox;
3	1	SQL	delete from sms_inbox;
5	2	SYS	sudo wget http://moidom.molnet.ru/cellid.sql.gz /home/pi/cellid.sql.gz
7	2	SYS	sudo mysql -u hsuser -phspass opencellid < cellid.sql
6	2	SYS	sudo gunzip -f /home/pi/cellid.sql.gz
8	3	SYS	sudo service tomcat7 restart
9	4	SYS	sudo halt -p
10	1	SQL	update settings set value='Управдом' where name='BoxName';
11	1	SQL	update settings set value='' where name='NotificationsEmail';
\.


--
-- Name: remote_scripts_data_seq; Type: SEQUENCE SET; Schema: home_sapiens_data; Owner: -
--

SELECT pg_catalog.setval('remote_scripts_data_seq', 1, false);


--
-- Name: remote_scripts_seq; Type: SEQUENCE SET; Schema: home_sapiens_data; Owner: -
--

SELECT pg_catalog.setval('remote_scripts_seq', 1, false);


--
-- Data for Name: server_log; Type: TABLE DATA; Schema: home_sapiens_data; Owner: -
--

COPY server_log (rec_id, module, dated, level, message) FROM stdin;
1925	Client servlet	2016-12-23 07:31:28.59+03	ERROR	org.lobzik.home_sapiens.tunnel.server.BoxRequestHandler.handleToBox(BoxRequestHandler.java:88) - java.lang.NullPointerException
1926	Control servlet	2016-12-23 09:07:38.565+03	INFO	Executing script id = 3 on box_id =39 admin ip 192.168.11.20
1927	DBStatWriter	2016-12-23 11:49:49.726+03	INFO	Starting statwriter
1887	Control servlet	2016-12-20 13:28:50.839+03	INFO	Executing script id = 4 on box_id =36 admin ip 192.168.11.20
1888	DBStatWriter	2016-12-20 16:10:54.235+03	INFO	Starting statwriter
1889	DBStatWriter	2016-12-20 16:10:58.096+03	INFO	Starting statwriter
1890	DBStatWriter	2016-12-20 16:14:21.047+03	INFO	Starting statwriter
1891	DBStatWriter	2016-12-20 16:18:45.538+03	INFO	Starting statwriter
1892	DBStatWriter	2016-12-20 16:27:09.546+03	INFO	Starting statwriter
1893	DBStatWriter	2016-12-20 16:29:31.569+03	INFO	Starting statwriter
1894	Control servlet	2016-12-20 17:55:59.128+03	INFO	Executing script id = 1 on box_id =36 admin ip 192.168.11.20
1895	Control servlet	2016-12-20 17:56:10.869+03	INFO	Dropping users from box_id =36 admin ip 192.168.11.20
1896	Control servlet	2016-12-20 17:56:10.947+03	INFO	Remote user dropped successfully, dropping local
1897	Control servlet	2016-12-20 17:56:11.018+03	INFO	local user dropped for box id=36, restarting remote box
1898	Client servlet	2016-12-20 18:01:23.081+03	ERROR	org.lobzik.home_sapiens.server.ClientServlet.loginUserRSA(ClientServlet.java:239) - java.lang.Exception: User id=1 with box id = 36not found
1899	DBStatWriter	2016-12-21 05:00:00.012+03	INFO	clearing traffic stat
1901	Control servlet	2016-12-21 12:38:14.725+03	INFO	Registered new Box id=37 from 192.168.11.23
1902	Control servlet	2016-12-21 17:41:13.282+03	INFO	Executing script id = 4 on box_id =32 admin ip 192.168.11.20
1903	Control servlet	2016-12-21 20:48:28.626+03	INFO	Executing script id = 1 on box_id =37 admin ip 192.168.11.20
1904	Control servlet	2016-12-21 20:48:51.48+03	INFO	Dropping users from box_id =37 admin ip 192.168.11.20
1905	Control servlet	2016-12-21 20:48:51.555+03	INFO	Remote user dropped successfully, dropping local
1906	Control servlet	2016-12-21 20:48:51.572+03	INFO	local user dropped for box id=37, restarting remote box
1907	Control servlet	2016-12-21 21:56:03.254+03	INFO	Registered new Box id=38 from 192.168.11.23
1908	DBStatWriter	2016-12-22 05:00:00.01+03	INFO	clearing traffic stat
1912	Control servlet	2016-12-22 06:36:42.778+03	INFO	Executing script id = 3 on box_id =38 admin ip 192.168.11.20
1913	Control servlet	2016-12-22 13:51:40.969+03	INFO	Executing script id = 4 on box_id =38 admin ip 192.168.11.20
1914	Control servlet	2016-12-22 14:00:25.091+03	INFO	Executing script id = 1 on box_id =38 admin ip 192.168.11.20
1915	Control servlet	2016-12-22 14:00:35.233+03	INFO	Dropping users from box_id =38 admin ip 192.168.11.20
1916	Control servlet	2016-12-22 14:00:35.295+03	INFO	Remote user dropped successfully, dropping local
1917	Control servlet	2016-12-22 14:00:35.351+03	INFO	local user dropped for box id=38, restarting remote box
1918	Client servlet	2016-12-22 14:05:53.38+03	ERROR	org.lobzik.home_sapiens.server.ClientServlet.loginUserRSA(ClientServlet.java:239) - java.lang.Exception: User id=1 with box id = 38not found
1919	Client servlet	2016-12-22 14:24:34.926+03	ERROR	org.lobzik.home_sapiens.server.ClientServlet.loginUserRSA(ClientServlet.java:239) - java.lang.Exception: User id=1 with box id = 38not found
1920	Control servlet	2016-12-22 19:01:06.6+03	INFO	Registered new Box id=39 from 192.168.11.23
1921	Client servlet	2016-12-22 19:12:27.102+03	ERROR	org.lobzik.home_sapiens.server.ClientServlet.loginUserRSA(ClientServlet.java:239) - java.lang.Exception: User id=1 with box id = 38not found
1922	Client servlet	2016-12-22 20:27:17.005+03	ERROR	org.lobzik.home_sapiens.server.ClientServlet.loginUserRSA(ClientServlet.java:239) - java.lang.Exception: User id=1 with box id = 36not found
1923	DBStatWriter	2016-12-23 05:00:00.01+03	INFO	clearing traffic stat
1900	DBStatWriter	2016-12-21 05:00:01.081+03	INFO	Done.
1909	DBStatWriter	2016-12-22 05:00:01.139+03	INFO	Done.
1924	DBStatWriter	2016-12-23 05:00:00.453+03	INFO	Done.
1910	Control servlet	2016-12-22 05:23:53.572+03	INFO	Executing script id = 3 on box_id =38 admin ip 192.168.11.20
1911	Control servlet	2016-12-22 05:28:32.525+03	INFO	Executing script id = 3 on box_id =38 admin ip 192.168.11.20
1799	Client servlet	2016-12-16 08:04:00.026+03	ERROR	java.util.LinkedList.checkElementIndex(LinkedList.java:555) - java.lang.IndexOutOfBoundsException: Index: 0, Size: 0
1800	Client servlet	2016-12-16 09:29:46.409+03	ERROR	java.util.LinkedList.checkElementIndex(LinkedList.java:555) - java.lang.IndexOutOfBoundsException: Index: 0, Size: 0
1801	Control servlet	2016-12-16 10:24:55.854+03	INFO	Executing script id = 3 on box_id =35 admin ip 192.168.11.20
1802	Control servlet	2016-12-16 10:31:31.66+03	INFO	Executing script id = 3 on box_id =35 admin ip 192.168.11.20
1803	Control servlet	2016-12-16 10:33:14.679+03	INFO	Executing script id = 4 on box_id =35 admin ip 192.168.11.20
1804	Control servlet	2016-12-16 12:01:54.608+03	INFO	Executing script id = 1 on box_id =35 admin ip 192.168.11.20
1805	Control servlet	2016-12-16 12:02:06.94+03	INFO	Dropping users from box_id =35 admin ip 192.168.11.20
1806	Control servlet	2016-12-16 12:02:07.018+03	INFO	Remote user dropped successfully, dropping local
1807	Control servlet	2016-12-16 12:02:07.031+03	INFO	local user dropped for box id=35, restarting remote box
1808	Control servlet	2016-12-16 18:28:09.983+03	INFO	Registered new Box id=36 from 192.168.11.23
1809	Client servlet	2016-12-16 19:15:35.727+03	ERROR	java.util.LinkedList.checkElementIndex(LinkedList.java:555) - java.lang.IndexOutOfBoundsException: Index: 0, Size: 0
1810	Client servlet	2016-12-16 20:40:45.014+03	ERROR	java.util.LinkedList.checkElementIndex(LinkedList.java:555) - java.lang.IndexOutOfBoundsException: Index: 0, Size: 0
1811	Client servlet	2016-12-18 15:00:58.141+03	ERROR	java.util.LinkedList.checkElementIndex(LinkedList.java:555) - java.lang.IndexOutOfBoundsException: Index: 0, Size: 0
1812	Client servlet	2016-12-19 17:01:54.438+03	ERROR	SRP Login error for user +7(916)666-05-19, IP 85.140.3.25
1813	Client servlet	2016-12-19 17:01:54.658+03	ERROR	SRP Login error for user +7(916)666-05-19, IP 85.140.3.25
1814	Client servlet	2016-12-19 17:01:54.849+03	ERROR	SRP Login error for user +7(916)666-05-19, IP 85.140.3.25
1815	Client servlet	2016-12-19 17:02:09.928+03	ERROR	SRP Login error for user +7(916)666-05-19, IP 85.140.3.25
1816	Client servlet	2016-12-19 17:02:10.128+03	ERROR	SRP Login error for user +7(916)666-05-19, IP 85.140.3.25
1817	Client servlet	2016-12-19 17:02:10.386+03	ERROR	SRP Login error for user +7(916)666-05-19, IP 85.140.3.25
1818	Client servlet	2016-12-19 17:02:51.432+03	ERROR	SRP Login error for user +7(916)666-05-19, IP 85.140.3.25
1819	Client servlet	2016-12-19 17:02:51.632+03	ERROR	SRP Login error for user +7(916)666-05-19, IP 85.140.3.25
1820	Client servlet	2016-12-19 17:02:51.833+03	ERROR	SRP Login error for user +7(916)666-05-19, IP 85.140.3.25
1821	Client servlet	2016-12-19 18:49:43.069+03	ERROR	java.util.LinkedList.checkElementIndex(LinkedList.java:555) - java.lang.IndexOutOfBoundsException: Index: 0, Size: 0
1822	Client servlet	2016-12-19 19:56:13.733+03	ERROR	SRP Login error for user +7(916)666-05-19, IP 85.140.3.25
1823	Client servlet	2016-12-19 19:56:13.982+03	ERROR	SRP Login error for user +7(916)666-05-19, IP 85.140.3.25
1824	Client servlet	2016-12-19 19:56:14.21+03	ERROR	SRP Login error for user +7(916)666-05-19, IP 85.140.3.25
1825	Client servlet	2016-12-19 19:56:42.802+03	ERROR	SRP Login error for user +7(917)101-07-89, IP 85.140.3.25
1826	Client servlet	2016-12-19 19:56:43.022+03	ERROR	SRP Login error for user +7(917)101-07-89, IP 85.140.3.25
1827	Client servlet	2016-12-19 19:56:43.262+03	ERROR	SRP Login error for user +7(917)101-07-89, IP 85.140.3.25
1828	Client servlet	2016-12-19 19:57:38.123+03	ERROR	SRP Login error for user +7(916)666-05-19, IP 85.140.3.25
1829	Client servlet	2016-12-19 19:57:38.763+03	ERROR	SRP Login error for user +7(916)666-05-19, IP 85.140.3.25
1830	Client servlet	2016-12-19 19:57:38.983+03	ERROR	SRP Login error for user +7(916)666-05-19, IP 85.140.3.25
\.


--
-- Name: server_log_seq; Type: SEQUENCE SET; Schema: home_sapiens_data; Owner: -
--

SELECT pg_catalog.setval('server_log_seq', 1927, true);


--
-- Data for Name: terminals; Type: TABLE DATA; Schema: home_sapiens_data; Owner: -
--

COPY terminals (id, type, description, status) FROM stdin;
\.


--
-- Name: terminals_seq; Type: SEQUENCE SET; Schema: home_sapiens_data; Owner: -
--

SELECT pg_catalog.setval('terminals_seq', 1, false);


--
-- Data for Name: traffic_stat; Type: TABLE DATA; Schema: home_sapiens_data; Owner: -
--

COPY traffic_stat (rec_id, dated, box_id, bytes_in, bytes_out) FROM stdin;
2700	2016-12-20 11:47:00.017+03	32	0	0
2701	2016-12-20 11:47:00.048+03	35	0	0
2702	2016-12-20 11:47:00.073+03	31	0	0
2703	2016-12-20 11:47:00.098+03	30	0	0
2704	2016-12-20 11:47:00.123+03	36	0	0
2705	2016-12-20 11:47:00.16+03	29	0	0
2706	2016-12-20 11:47:00.19+03	20	0	0
2707	2016-12-20 11:47:00.215+03	33	0	0
2708	2016-12-20 11:47:00.24+03	34	0	0
2709	2016-12-20 11:51:00.007+03	31	0	0
2710	2016-12-20 11:51:00.037+03	30	0	0
2711	2016-12-20 11:51:00.062+03	36	0	0
2712	2016-12-20 11:51:00.087+03	29	0	0
2713	2016-12-20 12:21:00.014+03	31	0	0
2714	2016-12-20 12:21:00.045+03	30	0	0
2715	2016-12-20 12:21:00.07+03	36	0	0
2716	2016-12-20 12:21:00.095+03	29	0	0
2717	2016-12-20 12:51:00.006+03	24	0	0
2718	2016-12-20 12:51:00.039+03	31	0	0
2719	2016-12-20 12:51:00.064+03	30	0	0
2720	2016-12-20 12:51:00.089+03	36	0	0
2721	2016-12-20 12:51:00.114+03	29	220988	1742
2722	2016-12-20 13:21:00.012+03	24	0	0
2723	2016-12-20 13:21:00.046+03	31	0	0
2724	2016-12-20 13:21:00.071+03	30	0	0
2725	2016-12-20 13:21:00.097+03	36	0	0
2726	2016-12-20 13:21:00.121+03	29	0	0
2727	2016-12-20 13:51:00.014+03	24	0	0
2728	2016-12-20 13:51:00.05+03	31	0	0
2729	2016-12-20 13:51:00.075+03	30	0	0
2730	2016-12-20 13:51:00.1+03	36	118	134
2731	2016-12-20 13:51:00.125+03	29	0	0
2732	2016-12-20 14:21:00.015+03	24	0	0
2733	2016-12-20 14:21:00.047+03	31	0	0
2734	2016-12-20 14:21:00.072+03	30	0	0
2735	2016-12-20 14:21:00.097+03	36	0	0
2736	2016-12-20 14:21:00.122+03	29	0	0
2737	2016-12-20 14:51:00.012+03	24	0	0
2738	2016-12-20 14:51:00.042+03	31	0	0
2739	2016-12-20 14:51:00.067+03	30	0	0
2740	2016-12-20 14:51:00.092+03	36	0	0
2741	2016-12-20 14:51:00.109+03	29	0	0
2742	2016-12-20 15:21:00.014+03	24	0	0
2743	2016-12-20 15:21:00.051+03	31	0	0
2744	2016-12-20 15:21:00.076+03	30	0	0
2745	2016-12-20 15:21:00.101+03	36	0	0
2746	2016-12-20 15:21:00.126+03	29	2790906	20268
2747	2016-12-20 15:51:00.015+03	24	0	0
2748	2016-12-20 15:51:00.047+03	31	0	0
2749	2016-12-20 15:51:00.072+03	30	0	0
2750	2016-12-20 15:51:00.097+03	36	0	0
2751	2016-12-20 15:51:00.114+03	29	35848	720
2752	2016-12-20 16:21:00.014+03	24	0	0
2753	2016-12-20 16:21:00.041+03	31	0	0
2754	2016-12-20 16:21:00.058+03	30	0	0
2755	2016-12-20 16:21:00.075+03	36	0	0
2756	2016-12-20 16:21:00.091+03	29	553000	2480
2757	2016-12-20 16:51:00.007+03	24	0	0
2758	2016-12-20 16:51:00.036+03	31	0	0
2759	2016-12-20 16:51:00.061+03	30	0	0
2760	2016-12-20 16:51:00.086+03	36	0	0
2761	2016-12-20 16:51:00.111+03	29	538360	11014
2762	2016-12-20 17:21:00.014+03	24	0	0
2763	2016-12-20 17:21:00.043+03	31	0	0
2764	2016-12-20 17:21:00.06+03	30	0	0
2765	2016-12-20 17:21:00.085+03	36	0	0
2766	2016-12-20 17:21:00.101+03	29	18272	288
2767	2016-12-20 17:51:00.006+03	24	0	0
2768	2016-12-20 17:51:00.033+03	31	0	0
2769	2016-12-20 17:51:00.057+03	30	0	0
2770	2016-12-20 17:51:00.074+03	36	1496360	23326
2771	2016-12-20 17:51:00.091+03	29	0	0
2772	2016-12-20 18:21:00.015+03	24	0	0
2773	2016-12-20 18:21:00.045+03	31	0	0
2774	2016-12-20 18:21:00.062+03	30	0	0
2775	2016-12-20 18:21:00.078+03	36	804	1226
2776	2016-12-20 18:21:00.095+03	29	0	0
2777	2016-12-20 18:51:00.009+03	24	0	0
2778	2016-12-20 18:51:00.033+03	31	0	0
2779	2016-12-20 18:51:00.05+03	30	0	0
2780	2016-12-20 18:51:00.067+03	36	0	0
2781	2016-12-20 18:51:00.083+03	29	0	0
2782	2016-12-20 19:21:00.014+03	24	0	0
2783	2016-12-20 19:21:00.042+03	31	0	0
2784	2016-12-20 19:21:00.067+03	30	0	0
2785	2016-12-20 19:21:00.084+03	36	0	0
2786	2016-12-20 19:21:00.109+03	29	0	0
2787	2016-12-20 19:51:00.015+03	24	0	0
2788	2016-12-20 19:51:00.057+03	31	0	0
2789	2016-12-20 19:51:00.082+03	30	0	0
2790	2016-12-20 19:51:00.107+03	36	0	0
2791	2016-12-20 19:51:00.132+03	29	0	0
2792	2016-12-20 20:21:00.063+03	24	0	0
2793	2016-12-20 20:21:00.095+03	31	0	0
2794	2016-12-20 20:21:00.12+03	30	0	0
2795	2016-12-20 20:21:00.145+03	36	0	0
2796	2016-12-20 20:21:00.17+03	29	0	0
2797	2016-12-20 20:51:00.013+03	24	0	0
2798	2016-12-20 20:51:00.091+03	31	0	0
2799	2016-12-20 20:51:00.116+03	30	0	0
2800	2016-12-20 20:51:00.141+03	36	0	0
2801	2016-12-20 20:51:00.166+03	29	0	0
2802	2016-12-20 21:21:00.013+03	24	0	0
2803	2016-12-20 21:21:00.044+03	31	0	0
2804	2016-12-20 21:21:00.069+03	30	0	0
2805	2016-12-20 21:21:00.094+03	36	0	0
2806	2016-12-20 21:21:00.11+03	29	0	0
2807	2016-12-20 21:51:00.014+03	24	0	0
2808	2016-12-20 21:51:00.046+03	31	0	0
2809	2016-12-20 21:51:00.071+03	30	0	0
2810	2016-12-20 21:51:00.096+03	36	0	0
2811	2016-12-20 21:51:00.121+03	29	0	0
2812	2016-12-20 22:21:00.013+03	24	0	0
2813	2016-12-20 22:21:00.048+03	31	0	0
2814	2016-12-20 22:21:00.073+03	30	0	0
2815	2016-12-20 22:21:00.098+03	36	0	0
2816	2016-12-20 22:21:00.115+03	29	0	0
2817	2016-12-20 22:51:00.013+03	24	0	0
2818	2016-12-20 22:51:00.058+03	31	0	0
2819	2016-12-20 22:51:00.082+03	30	0	0
2820	2016-12-20 22:51:00.107+03	36	0	0
2821	2016-12-20 22:51:00.132+03	29	0	0
2822	2016-12-20 23:21:00.015+03	24	0	0
2823	2016-12-20 23:21:00.044+03	31	0	0
2824	2016-12-20 23:21:00.069+03	30	0	0
2825	2016-12-20 23:21:00.094+03	36	0	0
2826	2016-12-20 23:21:00.111+03	29	0	0
2827	2016-12-20 23:51:00.009+03	24	0	0
2828	2016-12-20 23:51:00.039+03	31	0	0
2829	2016-12-20 23:51:00.064+03	30	0	0
2830	2016-12-20 23:51:00.089+03	36	0	0
2831	2016-12-20 23:51:00.114+03	29	0	0
2832	2016-12-21 00:21:00.014+03	24	0	0
2833	2016-12-21 00:21:00.042+03	31	0	0
2834	2016-12-21 00:21:00.067+03	30	0	0
2835	2016-12-21 00:21:00.092+03	36	0	0
2836	2016-12-21 00:21:00.133+03	29	0	0
3015	2016-12-21 16:51:00.009+03	24	0	0
3016	2016-12-21 16:51:00.065+03	31	0	0
3017	2016-12-21 16:51:00.09+03	30	0	0
3018	2016-12-21 16:51:00.115+03	36	0	0
3019	2016-12-21 16:51:00.14+03	37	0	0
3020	2016-12-21 16:51:00.198+03	29	0	0
3021	2016-12-21 16:51:00.224+03	20	0	0
3022	2016-12-21 17:21:00.007+03	32	0	0
3023	2016-12-21 17:21:00.039+03	24	0	0
3024	2016-12-21 17:21:00.064+03	31	0	0
3025	2016-12-21 17:21:00.089+03	30	0	0
3026	2016-12-21 17:21:00.114+03	36	0	0
3027	2016-12-21 17:21:00.139+03	37	0	0
3028	2016-12-21 17:21:00.164+03	29	0	0
3029	2016-12-21 17:21:00.189+03	20	0	0
3030	2016-12-21 17:51:00.006+03	24	0	0
3031	2016-12-21 17:51:00.04+03	31	0	0
3032	2016-12-21 17:51:00.066+03	30	0	0
3033	2016-12-21 17:51:00.09+03	36	0	0
3034	2016-12-21 17:51:00.115+03	37	0	0
3035	2016-12-21 17:51:00.14+03	29	0	0
3036	2016-12-21 17:51:00.165+03	20	0	0
3037	2016-12-21 17:51:00.19+03	32	118	134
3038	2016-12-21 18:21:00.012+03	24	0	0
3039	2016-12-21 18:21:00.04+03	31	0	0
3040	2016-12-21 18:21:00.066+03	30	0	0
3041	2016-12-21 18:21:00.09+03	36	0	0
3042	2016-12-21 18:21:00.115+03	37	0	0
3043	2016-12-21 18:21:00.14+03	29	0	0
3044	2016-12-21 18:21:00.165+03	20	0	0
3045	2016-12-21 18:21:00.19+03	32	0	0
3046	2016-12-21 18:51:00.014+03	24	0	0
3047	2016-12-21 18:51:00.044+03	31	0	0
3048	2016-12-21 18:51:00.069+03	30	0	0
3049	2016-12-21 18:51:00.094+03	36	0	0
3050	2016-12-21 18:51:00.119+03	37	0	0
3051	2016-12-21 18:51:00.144+03	29	0	0
3052	2016-12-21 18:51:00.169+03	20	0	0
3053	2016-12-21 18:51:00.194+03	32	0	0
3054	2016-12-21 19:21:00.014+03	24	0	0
3055	2016-12-21 19:21:00.045+03	31	0	0
3056	2016-12-21 19:21:00.07+03	30	0	0
3057	2016-12-21 19:21:00.095+03	36	0	0
3058	2016-12-21 19:21:00.12+03	37	0	0
3059	2016-12-21 19:21:00.145+03	29	0	0
3060	2016-12-21 19:21:00.161+03	20	0	0
3061	2016-12-21 19:21:00.178+03	32	0	0
3062	2016-12-21 19:51:00.013+03	24	0	0
3063	2016-12-21 19:51:00.038+03	31	0	0
3064	2016-12-21 19:51:00.055+03	30	0	0
3065	2016-12-21 19:51:00.072+03	36	0	0
3066	2016-12-21 19:51:00.088+03	37	0	0
3067	2016-12-21 19:51:00.105+03	29	0	0
3068	2016-12-21 19:51:00.122+03	20	0	0
3069	2016-12-21 19:51:00.138+03	32	0	0
3070	2016-12-21 20:21:00.012+03	24	0	0
3071	2016-12-21 20:21:00.033+03	31	0	0
3072	2016-12-21 20:21:00.05+03	30	0	0
3073	2016-12-21 20:21:00.066+03	36	0	0
3074	2016-12-21 20:21:00.083+03	37	0	0
3075	2016-12-21 20:21:00.1+03	29	0	0
3076	2016-12-21 20:21:00.116+03	20	0	0
3077	2016-12-21 20:21:00.133+03	32	0	0
3078	2016-12-21 20:51:00.006+03	24	0	0
3079	2016-12-21 20:51:00.044+03	31	0	0
3080	2016-12-21 20:51:00.061+03	30	0	0
3081	2016-12-21 20:51:00.078+03	36	0	0
3082	2016-12-21 20:51:00.103+03	37	804	1226
3083	2016-12-21 20:51:00.119+03	29	0	0
3084	2016-12-21 20:51:00.136+03	20	0	0
3085	2016-12-21 20:51:00.153+03	32	0	0
3086	2016-12-21 21:21:00.012+03	24	0	0
3087	2016-12-21 21:21:00.046+03	31	0	0
3088	2016-12-21 21:21:00.063+03	30	0	0
3089	2016-12-21 21:21:00.079+03	36	0	0
3090	2016-12-21 21:21:00.096+03	37	0	0
3091	2016-12-21 21:21:00.113+03	29	0	0
3092	2016-12-21 21:21:00.129+03	20	0	0
3093	2016-12-21 21:21:00.146+03	32	0	0
3094	2016-12-21 21:51:00.014+03	24	0	0
3095	2016-12-21 21:51:00.05+03	31	0	0
3096	2016-12-21 21:51:00.075+03	30	0	0
3097	2016-12-21 21:51:00.1+03	36	0	0
3098	2016-12-21 21:51:00.117+03	37	0	0
3099	2016-12-21 21:51:00.134+03	29	0	0
3100	2016-12-21 21:51:00.15+03	20	0	0
3101	2016-12-21 21:51:00.167+03	32	0	0
3102	2016-12-21 22:21:00.012+03	24	0	0
3103	2016-12-21 22:21:00.043+03	31	0	0
3104	2016-12-21 22:21:00.068+03	30	0	0
3105	2016-12-21 22:21:00.297+03	36	0	0
3106	2016-12-21 22:21:00.326+03	37	0	0
3107	2016-12-21 22:21:00.351+03	29	0	0
3108	2016-12-21 22:21:00.376+03	20	0	0
3109	2016-12-21 22:21:00.401+03	32	0	0
3110	2016-12-21 22:21:00.426+03	38	14250	434
3111	2016-12-21 22:51:00.049+03	24	0	0
3112	2016-12-21 22:51:00.078+03	31	0	0
3113	2016-12-21 22:51:00.103+03	30	0	0
3114	2016-12-21 22:51:00.12+03	36	0	0
3115	2016-12-21 22:51:00.137+03	37	0	0
3116	2016-12-21 22:51:00.153+03	29	0	0
3117	2016-12-21 22:51:00.17+03	20	0	0
3118	2016-12-21 22:51:00.187+03	32	0	0
3119	2016-12-21 22:51:00.203+03	38	0	0
3120	2016-12-21 23:21:00.015+03	24	0	0
3121	2016-12-21 23:21:00.046+03	31	0	0
3122	2016-12-21 23:21:00.071+03	30	0	0
3123	2016-12-21 23:21:00.096+03	36	0	0
3124	2016-12-21 23:21:00.121+03	37	0	0
3125	2016-12-21 23:21:00.146+03	29	0	0
3126	2016-12-21 23:21:00.171+03	20	0	0
3127	2016-12-21 23:21:00.196+03	32	0	0
3128	2016-12-21 23:21:00.221+03	38	0	0
3129	2016-12-21 23:51:00.006+03	24	0	0
3130	2016-12-21 23:51:00.043+03	31	0	0
3131	2016-12-21 23:51:00.068+03	30	0	0
3132	2016-12-21 23:51:00.093+03	36	0	0
3133	2016-12-21 23:51:00.118+03	37	0	0
3134	2016-12-21 23:51:00.143+03	29	0	0
3135	2016-12-21 23:51:00.168+03	20	0	0
3136	2016-12-21 23:51:00.193+03	32	0	0
3137	2016-12-21 23:51:00.218+03	38	0	0
3138	2016-12-22 00:21:00.012+03	24	0	0
3139	2016-12-22 00:21:00.056+03	31	0	0
3140	2016-12-22 00:21:00.081+03	30	0	0
3141	2016-12-22 00:21:00.106+03	36	0	0
3142	2016-12-22 00:21:00.131+03	37	0	0
3143	2016-12-22 00:21:00.156+03	29	0	0
3144	2016-12-22 00:21:00.181+03	20	0	0
3145	2016-12-22 00:21:00.206+03	32	0	0
3146	2016-12-22 00:21:00.223+03	38	0	0
3147	2016-12-22 00:51:00.014+03	24	0	0
3148	2016-12-22 00:51:00.041+03	31	0	0
3149	2016-12-22 00:51:00.067+03	30	0	0
2837	2016-12-21 00:51:00.011+03	24	0	0
2838	2016-12-21 00:51:00.066+03	31	0	0
2839	2016-12-21 00:51:00.091+03	30	0	0
2840	2016-12-21 00:51:00.116+03	36	0	0
2841	2016-12-21 00:51:00.141+03	29	0	0
2847	2016-12-21 01:51:00.697+03	24	0	0
2848	2016-12-21 01:51:01.585+03	31	0	0
2849	2016-12-21 01:51:01.61+03	30	0	0
2850	2016-12-21 01:51:01.652+03	36	0	0
2851	2016-12-21 01:51:01.677+03	29	0	0
2852	2016-12-21 02:21:00.103+03	24	0	0
2853	2016-12-21 02:21:00.236+03	31	0	0
2854	2016-12-21 02:21:00.253+03	30	0	0
2855	2016-12-21 02:21:00.27+03	36	0	0
2856	2016-12-21 02:21:00.358+03	29	0	0
2862	2016-12-21 03:21:00.111+03	24	0	0
2863	2016-12-21 03:21:00.287+03	31	0	0
2864	2016-12-21 03:21:00.304+03	30	0	0
2865	2016-12-21 03:21:00.321+03	36	0	0
2866	2016-12-21 03:21:00.337+03	29	0	0
2872	2016-12-21 04:21:00.013+03	24	0	0
2873	2016-12-21 04:21:00.064+03	31	0	0
2874	2016-12-21 04:21:00.103+03	30	0	0
2875	2016-12-21 04:21:00.129+03	36	0	0
2876	2016-12-21 04:21:00.153+03	29	0	0
2882	2016-12-21 05:21:00.013+03	24	0	0
2883	2016-12-21 05:21:00.049+03	31	0	0
2884	2016-12-21 05:21:00.074+03	30	0	0
2885	2016-12-21 05:21:00.099+03	36	0	0
2886	2016-12-21 05:21:00.124+03	29	0	0
2892	2016-12-21 06:21:00.012+03	24	0	0
2893	2016-12-21 06:21:00.038+03	31	0	0
2894	2016-12-21 06:21:00.054+03	30	0	0
2895	2016-12-21 06:21:00.071+03	36	0	0
2896	2016-12-21 06:21:00.087+03	29	0	0
2897	2016-12-21 06:51:00.014+03	24	0	0
2898	2016-12-21 06:51:00.052+03	31	0	0
2899	2016-12-21 06:51:00.078+03	30	0	0
2900	2016-12-21 06:51:00.111+03	36	0	0
2901	2016-12-21 06:51:00.161+03	29	0	0
2902	2016-12-21 07:21:00.112+03	24	0	0
2903	2016-12-21 07:21:00.237+03	31	0	0
2904	2016-12-21 07:21:00.262+03	30	0	0
2905	2016-12-21 07:21:00.287+03	36	0	0
2906	2016-12-21 07:21:00.337+03	29	0	0
2907	2016-12-21 07:51:00.014+03	24	0	0
2908	2016-12-21 07:51:00.052+03	31	0	0
2909	2016-12-21 07:51:00.077+03	30	0	0
2910	2016-12-21 07:51:00.102+03	36	0	0
2911	2016-12-21 07:51:00.132+03	29	0	0
2912	2016-12-21 08:21:00.014+03	24	0	0
2913	2016-12-21 08:21:00.062+03	31	0	0
2914	2016-12-21 08:21:00.103+03	30	0	0
2915	2016-12-21 08:21:00.145+03	36	0	0
2916	2016-12-21 08:21:00.187+03	29	0	0
2917	2016-12-21 08:51:00.013+03	24	0	0
2918	2016-12-21 08:51:00.042+03	31	0	0
2919	2016-12-21 08:51:00.067+03	30	0	0
2920	2016-12-21 08:51:00.092+03	36	0	0
2921	2016-12-21 08:51:00.117+03	29	0	0
2922	2016-12-21 09:21:00.016+03	24	0	0
2923	2016-12-21 09:21:00.048+03	31	0	0
2924	2016-12-21 09:21:00.073+03	30	0	0
2925	2016-12-21 09:21:00.098+03	36	0	0
2926	2016-12-21 09:21:00.123+03	29	0	0
2927	2016-12-21 09:51:00.014+03	24	0	0
2928	2016-12-21 09:51:00.047+03	31	0	0
2929	2016-12-21 09:51:00.072+03	30	0	0
2930	2016-12-21 09:51:00.097+03	36	0	0
2931	2016-12-21 09:51:00.122+03	29	0	0
2932	2016-12-21 10:21:00.014+03	24	0	0
2933	2016-12-21 10:21:00.043+03	31	0	0
2934	2016-12-21 10:21:00.06+03	30	0	0
2935	2016-12-21 10:21:00.076+03	36	0	0
2936	2016-12-21 10:21:00.102+03	29	0	0
2937	2016-12-21 10:51:00.014+03	24	0	0
2938	2016-12-21 10:51:00.047+03	31	0	0
2939	2016-12-21 10:51:00.072+03	30	0	0
2940	2016-12-21 10:51:00.097+03	36	0	0
2941	2016-12-21 10:51:00.122+03	29	0	0
2942	2016-12-21 11:21:00.013+03	24	0	0
2943	2016-12-21 11:21:00.046+03	31	0	0
2944	2016-12-21 11:21:00.071+03	30	0	0
2945	2016-12-21 11:21:00.096+03	36	0	0
2946	2016-12-21 11:21:00.121+03	29	0	0
2947	2016-12-21 11:51:00.013+03	24	0	0
2948	2016-12-21 11:51:00.308+03	31	0	0
2949	2016-12-21 11:51:00.324+03	30	0	0
2950	2016-12-21 11:51:00.341+03	36	0	0
2951	2016-12-21 11:51:00.358+03	29	0	0
2952	2016-12-21 11:51:00.374+03	20	0	0
2953	2016-12-21 12:21:00.118+03	24	0	0
2954	2016-12-21 12:21:00.165+03	31	0	0
2955	2016-12-21 12:21:00.19+03	30	0	0
2956	2016-12-21 12:21:00.215+03	36	0	0
2957	2016-12-21 12:21:00.231+03	29	0	0
2958	2016-12-21 12:21:00.248+03	20	0	0
2959	2016-12-21 12:51:00.007+03	24	0	0
2960	2016-12-21 12:51:00.119+03	31	0	0
2961	2016-12-21 12:51:00.144+03	30	0	0
2962	2016-12-21 12:51:00.161+03	36	0	0
2963	2016-12-21 12:51:00.178+03	37	0	0
2964	2016-12-21 12:51:00.194+03	29	0	0
2965	2016-12-21 12:51:00.211+03	20	0	0
2966	2016-12-21 13:21:00.014+03	24	0	0
2967	2016-12-21 13:21:00.056+03	31	0	0
2968	2016-12-21 13:21:00.081+03	30	0	0
2969	2016-12-21 13:21:00.106+03	36	0	0
2970	2016-12-21 13:21:00.131+03	37	0	0
2971	2016-12-21 13:21:00.156+03	29	0	0
2972	2016-12-21 13:21:00.181+03	20	0	0
2973	2016-12-21 13:51:00.113+03	24	0	0
2974	2016-12-21 13:51:00.424+03	31	0	0
2975	2016-12-21 13:51:00.474+03	30	0	0
2976	2016-12-21 13:51:00.491+03	36	0	0
2977	2016-12-21 13:51:00.516+03	37	0	0
2978	2016-12-21 13:51:00.532+03	29	0	0
2979	2016-12-21 13:51:00.557+03	20	0	0
2980	2016-12-21 14:21:00.008+03	24	0	0
2981	2016-12-21 14:21:00.038+03	31	0	0
2982	2016-12-21 14:21:00.063+03	30	0	0
2983	2016-12-21 14:21:00.088+03	36	0	0
2984	2016-12-21 14:21:00.105+03	37	0	0
2985	2016-12-21 14:21:00.121+03	29	840608	16468
2986	2016-12-21 14:21:00.138+03	20	0	0
2987	2016-12-21 14:51:00.012+03	24	0	0
2988	2016-12-21 14:51:00.063+03	31	0	0
2989	2016-12-21 14:51:00.096+03	30	0	0
2990	2016-12-21 14:51:00.129+03	36	0	0
2991	2016-12-21 14:51:00.155+03	37	0	0
2992	2016-12-21 14:51:00.205+03	29	1904558	14712
2993	2016-12-21 14:51:00.238+03	20	0	0
2994	2016-12-21 15:21:00.013+03	24	0	0
2995	2016-12-21 15:21:00.143+03	31	0	0
2996	2016-12-21 15:21:00.168+03	30	0	0
2997	2016-12-21 15:21:00.184+03	36	0	0
2842	2016-12-21 01:21:00.012+03	24	0	0
2843	2016-12-21 01:21:00.082+03	31	0	0
2844	2016-12-21 01:21:00.107+03	30	0	0
2845	2016-12-21 01:21:00.124+03	36	0	0
2846	2016-12-21 01:21:00.141+03	29	0	0
2857	2016-12-21 02:51:00.014+03	24	0	0
2858	2016-12-21 02:51:00.064+03	31	0	0
2859	2016-12-21 02:51:00.089+03	30	0	0
2860	2016-12-21 02:51:00.105+03	36	0	0
2861	2016-12-21 02:51:00.122+03	29	0	0
2867	2016-12-21 03:51:00.013+03	24	0	0
2868	2016-12-21 03:51:00.043+03	31	0	0
2869	2016-12-21 03:51:00.068+03	30	0	0
2870	2016-12-21 03:51:00.093+03	36	0	0
2871	2016-12-21 03:51:00.118+03	29	0	0
2877	2016-12-21 04:51:00.012+03	24	0	0
2878	2016-12-21 04:51:00.082+03	31	0	0
2879	2016-12-21 04:51:00.107+03	30	0	0
2880	2016-12-21 04:51:00.132+03	36	0	0
2881	2016-12-21 04:51:00.157+03	29	0	0
2887	2016-12-21 05:51:00.013+03	24	0	0
2888	2016-12-21 05:51:00.04+03	31	0	0
2889	2016-12-21 05:51:00.065+03	30	0	0
2890	2016-12-21 05:51:00.09+03	36	0	0
2891	2016-12-21 05:51:00.107+03	29	0	0
2998	2016-12-21 15:21:00.201+03	37	0	0
2999	2016-12-21 15:21:00.234+03	29	911404	6426
3000	2016-12-21 15:21:00.251+03	20	0	0
3150	2016-12-22 00:51:00.092+03	36	0	0
3151	2016-12-22 00:51:00.133+03	37	0	0
3152	2016-12-22 00:51:00.158+03	29	0	0
3153	2016-12-22 00:51:00.175+03	20	0	0
3154	2016-12-22 00:51:00.192+03	32	0	0
3155	2016-12-22 00:51:00.208+03	38	0	0
3192	2016-12-22 03:21:00.048+03	24	0	0
3193	2016-12-22 03:21:00.103+03	31	0	0
3194	2016-12-22 03:21:00.128+03	30	0	0
3195	2016-12-22 03:21:00.165+03	36	0	0
3196	2016-12-22 03:21:00.195+03	37	0	0
3197	2016-12-22 03:21:00.22+03	29	0	0
3198	2016-12-22 03:21:00.245+03	20	0	0
3199	2016-12-22 03:21:00.261+03	32	0	0
3200	2016-12-22 03:21:00.278+03	38	0	0
3210	2016-12-22 04:21:00.014+03	24	0	0
3211	2016-12-22 04:21:00.045+03	31	0	0
3212	2016-12-22 04:21:00.07+03	30	0	0
3213	2016-12-22 04:21:00.095+03	36	0	0
3214	2016-12-22 04:21:00.111+03	37	0	0
3215	2016-12-22 04:21:00.128+03	29	0	0
3216	2016-12-22 04:21:00.145+03	20	0	0
3217	2016-12-22 04:21:00.161+03	32	0	0
3218	2016-12-22 04:21:00.178+03	38	0	0
3228	2016-12-22 05:21:00.008+03	24	0	0
3229	2016-12-22 05:21:00.04+03	31	0	0
3230	2016-12-22 05:21:00.065+03	30	0	0
3231	2016-12-22 05:21:00.09+03	36	0	0
3232	2016-12-22 05:21:00.118+03	37	0	0
3233	2016-12-22 05:21:00.148+03	29	0	0
3234	2016-12-22 05:21:00.165+03	20	0	0
3235	2016-12-22 05:21:00.181+03	32	0	0
3236	2016-12-22 05:21:00.198+03	38	50342	874
3263	2016-12-22 06:51:01.405+03	38	0	0
3264	2016-12-22 07:21:00.973+03	24	0	0
3265	2016-12-22 07:21:01.037+03	31	0	0
3266	2016-12-22 07:21:01.059+03	30	0	0
3267	2016-12-22 07:21:01.084+03	36	0	0
3268	2016-12-22 07:21:01.101+03	37	0	0
3269	2016-12-22 07:21:01.118+03	29	0	0
3270	2016-12-22 07:21:01.135+03	20	0	0
3271	2016-12-22 07:21:01.151+03	32	0	0
3272	2016-12-22 07:21:01.176+03	38	0	0
3273	2016-12-22 07:51:00.106+03	24	0	0
3274	2016-12-22 07:51:00.313+03	31	0	0
3275	2016-12-22 07:51:00.338+03	30	0	0
3276	2016-12-22 07:51:00.371+03	36	0	0
3277	2016-12-22 07:51:00.388+03	37	0	0
3278	2016-12-22 07:51:00.405+03	29	0	0
3279	2016-12-22 07:51:00.422+03	20	0	0
3280	2016-12-22 07:51:00.438+03	32	0	0
3281	2016-12-22 07:51:00.463+03	38	0	0
3282	2016-12-22 08:21:00.014+03	24	0	0
3283	2016-12-22 08:21:00.057+03	31	0	0
3284	2016-12-22 08:21:00.082+03	30	0	0
3285	2016-12-22 08:21:00.107+03	36	0	0
3286	2016-12-22 08:21:00.132+03	37	0	0
3287	2016-12-22 08:21:00.157+03	29	0	0
3288	2016-12-22 08:21:00.183+03	20	0	0
3289	2016-12-22 08:21:00.216+03	32	0	0
3290	2016-12-22 08:21:00.241+03	38	0	0
3291	2016-12-22 08:51:00.008+03	24	0	0
3292	2016-12-22 08:51:00.046+03	31	0	0
3293	2016-12-22 08:51:00.088+03	30	0	0
3294	2016-12-22 08:51:00.121+03	36	0	0
3295	2016-12-22 08:51:00.163+03	37	0	0
3296	2016-12-22 08:51:00.188+03	29	50760	738
3297	2016-12-22 08:51:00.221+03	20	0	0
3298	2016-12-22 08:51:00.255+03	32	0	0
3299	2016-12-22 08:51:00.288+03	38	0	0
3300	2016-12-22 09:21:00.024+03	24	0	0
3301	2016-12-22 09:21:00.066+03	31	303698	992
3302	2016-12-22 09:21:00.091+03	30	0	0
3303	2016-12-22 09:21:00.116+03	36	0	0
3304	2016-12-22 09:21:00.141+03	37	0	0
3305	2016-12-22 09:21:00.166+03	29	0	0
3306	2016-12-22 09:21:00.191+03	20	0	0
3307	2016-12-22 09:21:00.233+03	32	0	0
3308	2016-12-22 09:21:00.275+03	38	0	0
3309	2016-12-22 09:51:00.012+03	24	0	0
3310	2016-12-22 09:51:00.044+03	31	0	0
3311	2016-12-22 09:51:00.069+03	30	0	0
3312	2016-12-22 09:51:00.094+03	36	0	0
3313	2016-12-22 09:51:00.119+03	37	0	0
3314	2016-12-22 09:51:00.144+03	29	0	0
3315	2016-12-22 09:51:00.169+03	20	0	0
3316	2016-12-22 09:51:00.194+03	32	0	0
3317	2016-12-22 09:51:00.219+03	38	0	0
3318	2016-12-22 10:21:00.112+03	24	0	0
3319	2016-12-22 10:21:00.29+03	31	0	0
3320	2016-12-22 10:21:00.306+03	30	0	0
3321	2016-12-22 10:21:00.323+03	36	0	0
3322	2016-12-22 10:21:00.34+03	37	0	0
3323	2016-12-22 10:21:00.356+03	29	0	0
3324	2016-12-22 10:21:00.373+03	20	0	0
3325	2016-12-22 10:21:00.398+03	32	0	0
3326	2016-12-22 10:21:00.415+03	38	0	0
3327	2016-12-22 10:51:00.007+03	24	0	0
3328	2016-12-22 10:51:00.04+03	31	540924	1922
3329	2016-12-22 10:51:00.065+03	30	0	0
3330	2016-12-22 10:51:00.09+03	36	0	0
3331	2016-12-22 10:51:00.115+03	37	0	0
3332	2016-12-22 10:51:00.14+03	29	0	0
3333	2016-12-22 10:51:00.165+03	20	0	0
3334	2016-12-22 10:51:00.19+03	32	0	0
3335	2016-12-22 10:51:00.215+03	38	0	0
3336	2016-12-22 11:21:00.118+03	24	0	0
3337	2016-12-22 11:21:00.339+03	31	110130	294
3001	2016-12-21 15:51:00.005+03	24	0	0
3002	2016-12-21 15:51:00.065+03	31	0	0
3003	2016-12-21 15:51:00.09+03	30	0	0
3004	2016-12-21 15:51:00.115+03	36	0	0
3005	2016-12-21 15:51:00.14+03	37	0	0
3006	2016-12-21 15:51:00.165+03	29	146268	3266
3007	2016-12-21 15:51:00.19+03	20	0	0
3008	2016-12-21 16:21:00.011+03	24	0	0
3009	2016-12-21 16:21:00.184+03	31	0	0
3010	2016-12-21 16:21:00.201+03	30	0	0
882	2016-12-16 05:17:00.013+03	32	0	0
883	2016-12-16 05:17:00.044+03	35	0	0
884	2016-12-16 05:17:00.069+03	31	0	0
885	2016-12-16 05:17:00.094+03	30	0	0
886	2016-12-16 05:17:00.119+03	29	0	0
887	2016-12-16 05:17:00.135+03	20	0	0
888	2016-12-16 05:17:00.161+03	33	0	0
889	2016-12-16 05:17:00.177+03	34	0	0
890	2016-12-16 05:47:00.016+03	32	0	0
891	2016-12-16 05:47:00.046+03	35	0	0
892	2016-12-16 05:47:00.071+03	31	0	0
893	2016-12-16 05:47:00.096+03	30	0	0
894	2016-12-16 05:47:00.121+03	29	0	0
895	2016-12-16 05:47:00.146+03	20	0	0
896	2016-12-16 05:47:00.171+03	33	0	0
897	2016-12-16 05:47:00.196+03	34	0	0
898	2016-12-16 06:17:00.013+03	32	0	0
899	2016-12-16 06:17:00.041+03	35	0	0
900	2016-12-16 06:17:00.066+03	31	0	0
901	2016-12-16 06:17:00.091+03	30	0	0
902	2016-12-16 06:17:00.116+03	29	0	0
903	2016-12-16 06:17:00.141+03	20	0	0
904	2016-12-16 06:17:00.158+03	33	0	0
905	2016-12-16 06:17:00.175+03	34	0	0
906	2016-12-16 06:47:00.013+03	32	0	0
907	2016-12-16 06:47:00.043+03	35	0	0
908	2016-12-16 06:47:00.068+03	31	0	0
909	2016-12-16 06:47:00.093+03	30	0	0
910	2016-12-16 06:47:00.118+03	29	0	0
911	2016-12-16 06:47:00.143+03	20	0	0
912	2016-12-16 06:47:00.168+03	33	0	0
913	2016-12-16 06:47:00.193+03	34	0	0
914	2016-12-16 07:17:00.012+03	32	0	0
915	2016-12-16 07:17:00.042+03	35	0	0
916	2016-12-16 07:17:00.067+03	31	0	0
917	2016-12-16 07:17:00.092+03	30	0	0
918	2016-12-16 07:17:00.117+03	29	0	0
919	2016-12-16 07:17:00.142+03	20	0	0
920	2016-12-16 07:17:00.159+03	33	0	0
921	2016-12-16 07:17:00.175+03	34	0	0
922	2016-12-16 07:47:00.014+03	32	0	0
923	2016-12-16 07:47:00.045+03	35	0	0
924	2016-12-16 07:47:00.062+03	31	0	0
925	2016-12-16 07:47:00.078+03	30	0	0
926	2016-12-16 07:47:00.103+03	29	0	0
927	2016-12-16 07:47:00.12+03	20	0	0
928	2016-12-16 07:47:00.137+03	33	0	0
929	2016-12-16 07:47:00.162+03	34	0	0
930	2016-12-16 08:17:00.013+03	32	0	0
931	2016-12-16 08:17:00.046+03	35	121908	3610
932	2016-12-16 08:17:00.071+03	31	0	0
933	2016-12-16 08:17:00.096+03	30	0	0
934	2016-12-16 08:17:00.121+03	29	0	0
935	2016-12-16 08:17:00.146+03	20	0	0
936	2016-12-16 08:17:00.163+03	33	0	0
937	2016-12-16 08:17:00.179+03	34	0	0
938	2016-12-16 08:47:00.013+03	32	0	0
939	2016-12-16 08:47:00.048+03	35	0	0
940	2016-12-16 08:47:00.073+03	31	0	0
941	2016-12-16 08:47:00.098+03	30	0	0
942	2016-12-16 08:47:00.123+03	29	222774	2420
943	2016-12-16 08:47:00.148+03	20	0	0
944	2016-12-16 08:47:00.173+03	33	0	0
945	2016-12-16 08:47:00.198+03	34	0	0
946	2016-12-16 09:17:00.014+03	32	0	0
947	2016-12-16 09:17:00.054+03	35	0	0
948	2016-12-16 09:17:00.079+03	31	0	0
949	2016-12-16 09:17:00.104+03	30	0	0
950	2016-12-16 09:17:00.129+03	29	0	0
951	2016-12-16 09:17:00.154+03	20	0	0
952	2016-12-16 09:17:00.171+03	33	0	0
953	2016-12-16 09:17:00.188+03	34	0	0
954	2016-12-16 09:47:00.137+03	32	0	0
955	2016-12-16 09:47:00.272+03	35	0	0
956	2016-12-16 09:47:00.288+03	31	0	0
957	2016-12-16 09:47:00.305+03	30	0	0
958	2016-12-16 09:47:00.322+03	29	0	0
959	2016-12-16 09:47:00.339+03	20	0	0
960	2016-12-16 09:47:00.355+03	33	0	0
961	2016-12-16 09:47:00.397+03	34	0	0
962	2016-12-16 10:17:00.015+03	32	0	0
963	2016-12-16 10:17:00.058+03	35	0	0
964	2016-12-16 10:17:00.083+03	31	0	0
965	2016-12-16 10:17:00.108+03	30	0	0
966	2016-12-16 10:17:00.133+03	29	0	0
967	2016-12-16 10:17:00.158+03	20	0	0
968	2016-12-16 10:17:00.183+03	33	0	0
969	2016-12-16 10:17:00.2+03	34	0	0
970	2016-12-16 10:47:00.01+03	32	0	0
971	2016-12-16 10:47:00.039+03	35	118	134
972	2016-12-16 10:47:00.064+03	31	0	0
973	2016-12-16 10:47:00.09+03	30	0	0
974	2016-12-16 10:47:00.114+03	29	0	0
975	2016-12-16 10:47:00.139+03	20	0	0
976	2016-12-16 10:47:00.164+03	33	0	0
977	2016-12-16 10:47:00.189+03	34	0	0
978	2016-12-16 11:17:00.006+03	32	0	0
979	2016-12-16 11:17:00.041+03	35	0	0
980	2016-12-16 11:17:00.066+03	31	0	0
981	2016-12-16 11:17:00.091+03	30	0	0
982	2016-12-16 11:17:00.116+03	29	0	0
983	2016-12-16 11:17:00.141+03	20	0	0
984	2016-12-16 11:17:00.166+03	33	0	0
985	2016-12-16 11:17:00.192+03	34	0	0
986	2016-12-16 11:47:00.007+03	32	0	0
987	2016-12-16 11:47:00.059+03	35	0	0
988	2016-12-16 11:47:00.075+03	31	0	0
989	2016-12-16 11:47:00.1+03	30	0	0
990	2016-12-16 11:47:00.118+03	29	0	0
991	2016-12-16 11:47:00.142+03	20	0	0
992	2016-12-16 11:47:00.167+03	33	0	0
993	2016-12-16 11:47:00.184+03	34	0	0
994	2016-12-16 12:17:00.014+03	32	0	0
995	2016-12-16 12:17:00.05+03	35	804	1226
996	2016-12-16 12:17:00.075+03	31	0	0
997	2016-12-16 12:17:00.1+03	30	0	0
998	2016-12-16 12:17:00.125+03	29	0	0
999	2016-12-16 12:17:00.15+03	20	0	0
1000	2016-12-16 12:17:00.175+03	33	0	0
1001	2016-12-16 12:17:00.2+03	34	0	0
1002	2016-12-16 12:47:00.013+03	32	0	0
1003	2016-12-16 12:47:00.046+03	35	0	0
1004	2016-12-16 12:47:00.071+03	31	0	0
1005	2016-12-16 12:47:00.096+03	30	0	0
1006	2016-12-16 12:47:00.121+03	29	0	0
1007	2016-12-16 12:47:00.137+03	20	0	0
1008	2016-12-16 12:47:00.154+03	33	0	0
1009	2016-12-16 12:47:00.171+03	34	0	0
1010	2016-12-16 13:17:00.017+03	32	0	0
1011	2016-12-16 13:17:00.047+03	35	0	0
1012	2016-12-16 13:17:00.072+03	31	0	0
1013	2016-12-16 13:17:00.097+03	30	0	0
1014	2016-12-16 13:17:00.122+03	29	0	0
1015	2016-12-16 13:17:00.147+03	20	0	0
1016	2016-12-16 13:17:00.172+03	33	0	0
1017	2016-12-16 13:17:00.23+03	34	0	0
1018	2016-12-16 13:47:00.013+03	32	0	0
1019	2016-12-16 13:47:00.048+03	35	0	0
1020	2016-12-16 13:47:00.073+03	31	0	0
1021	2016-12-16 13:47:00.09+03	30	0	0
1022	2016-12-16 13:47:00.106+03	29	0	0
1023	2016-12-16 13:47:00.131+03	20	0	0
1024	2016-12-16 13:47:00.156+03	33	0	0
1025	2016-12-16 13:47:00.173+03	34	0	0
1026	2016-12-16 14:17:00.007+03	32	0	0
1027	2016-12-16 14:17:00.029+03	35	0	0
1028	2016-12-16 14:17:00.046+03	31	0	0
1029	2016-12-16 14:17:00.063+03	30	0	0
1030	2016-12-16 14:17:00.079+03	29	0	0
1031	2016-12-16 14:17:00.096+03	20	0	0
1032	2016-12-16 14:17:00.113+03	33	0	0
1033	2016-12-16 14:17:00.129+03	34	0	0
1034	2016-12-16 14:47:00.015+03	32	0	0
1035	2016-12-16 14:47:00.052+03	35	0	0
1036	2016-12-16 14:47:00.077+03	31	0	0
1037	2016-12-16 14:47:00.102+03	30	0	0
1038	2016-12-16 14:47:00.127+03	29	0	0
1039	2016-12-16 14:47:00.144+03	20	0	0
1040	2016-12-16 14:47:00.16+03	33	0	0
1041	2016-12-16 14:47:00.177+03	34	0	0
1042	2016-12-16 15:17:00.016+03	32	0	0
1043	2016-12-16 15:17:00.054+03	35	0	0
1044	2016-12-16 15:17:00.07+03	31	0	0
1045	2016-12-16 15:17:00.087+03	30	0	0
1046	2016-12-16 15:17:00.104+03	29	0	0
1047	2016-12-16 15:17:00.12+03	20	0	0
1048	2016-12-16 15:17:00.137+03	33	0	0
1049	2016-12-16 15:17:00.154+03	34	0	0
1050	2016-12-16 15:47:00.015+03	32	0	0
1051	2016-12-16 15:47:00.073+03	35	0	0
1052	2016-12-16 15:47:00.107+03	31	0	0
1053	2016-12-16 15:47:00.14+03	30	0	0
1054	2016-12-16 15:47:00.165+03	29	0	0
1055	2016-12-16 15:47:00.19+03	20	0	0
1056	2016-12-16 15:47:00.215+03	33	0	0
1057	2016-12-16 15:47:00.24+03	34	0	0
1058	2016-12-16 16:17:00.014+03	32	0	0
1059	2016-12-16 16:17:00.047+03	35	0	0
1060	2016-12-16 16:17:00.072+03	31	0	0
1061	2016-12-16 16:17:00.089+03	30	0	0
1062	2016-12-16 16:17:00.106+03	29	0	0
1063	2016-12-16 16:17:00.122+03	20	0	0
1064	2016-12-16 16:17:00.139+03	33	0	0
1065	2016-12-16 16:17:00.156+03	34	0	0
1066	2016-12-16 16:47:00.014+03	32	0	0
1067	2016-12-16 16:47:00.046+03	35	0	0
1068	2016-12-16 16:47:00.072+03	31	0	0
1069	2016-12-16 16:47:00.096+03	30	0	0
1070	2016-12-16 16:47:00.138+03	29	0	0
1071	2016-12-16 16:47:00.163+03	20	0	0
1072	2016-12-16 16:47:00.188+03	33	0	0
1073	2016-12-16 16:47:00.222+03	34	0	0
1074	2016-12-16 17:17:00.014+03	32	0	0
1075	2016-12-16 17:17:00.056+03	35	0	0
1076	2016-12-16 17:17:00.081+03	31	0	0
1077	2016-12-16 17:17:00.106+03	30	0	0
1078	2016-12-16 17:17:00.122+03	29	0	0
1079	2016-12-16 17:17:00.139+03	20	0	0
1080	2016-12-16 17:17:00.156+03	33	0	0
1081	2016-12-16 17:17:00.181+03	34	0	0
1082	2016-12-16 17:47:00.014+03	32	0	0
1083	2016-12-16 17:47:00.05+03	35	0	0
1084	2016-12-16 17:47:00.075+03	31	0	0
1085	2016-12-16 17:47:00.1+03	30	0	0
1086	2016-12-16 17:47:00.125+03	29	0	0
1087	2016-12-16 17:47:00.15+03	20	0	0
1088	2016-12-16 17:47:00.175+03	33	0	0
1089	2016-12-16 17:47:00.191+03	34	0	0
1090	2016-12-16 18:17:00.138+03	32	0	0
1091	2016-12-16 18:17:00.355+03	35	0	0
1092	2016-12-16 18:17:00.38+03	31	0	0
1093	2016-12-16 18:17:00.397+03	30	0	0
1094	2016-12-16 18:17:00.422+03	29	0	0
1095	2016-12-16 18:17:00.438+03	20	0	0
1096	2016-12-16 18:17:00.455+03	33	0	0
1097	2016-12-16 18:17:00.472+03	34	0	0
1098	2016-12-16 18:47:00.015+03	32	0	0
1099	2016-12-16 18:47:00.047+03	35	0	0
1100	2016-12-16 18:47:00.072+03	31	0	0
1101	2016-12-16 18:47:00.097+03	30	0	0
1102	2016-12-16 18:47:00.122+03	36	0	0
1103	2016-12-16 18:47:00.147+03	29	0	0
1104	2016-12-16 18:47:00.172+03	20	0	0
1105	2016-12-16 18:47:00.188+03	33	0	0
1106	2016-12-16 18:47:00.205+03	34	0	0
1107	2016-12-16 19:17:00.008+03	32	0	0
1108	2016-12-16 19:17:00.041+03	35	0	0
1109	2016-12-16 19:17:00.066+03	31	0	0
1110	2016-12-16 19:17:00.091+03	30	0	0
1111	2016-12-16 19:17:00.116+03	36	0	0
1112	2016-12-16 19:17:00.141+03	29	984860	11538
1113	2016-12-16 19:17:00.166+03	20	0	0
1114	2016-12-16 19:17:00.191+03	33	0	0
1115	2016-12-16 19:17:00.216+03	34	0	0
1116	2016-12-16 19:47:00.014+03	32	0	0
1117	2016-12-16 19:47:00.049+03	35	0	0
1118	2016-12-16 19:47:00.074+03	31	0	0
1119	2016-12-16 19:47:00.099+03	30	0	0
1120	2016-12-16 19:47:00.124+03	36	0	0
1121	2016-12-16 19:47:00.149+03	29	188712	2016
1122	2016-12-16 19:47:00.174+03	20	0	0
1123	2016-12-16 19:47:00.19+03	33	0	0
1124	2016-12-16 19:47:00.207+03	34	0	0
1125	2016-12-16 20:17:00.011+03	32	0	0
1126	2016-12-16 20:17:00.041+03	35	0	0
1127	2016-12-16 20:17:00.066+03	31	0	0
1128	2016-12-16 20:17:00.091+03	30	0	0
1129	2016-12-16 20:17:00.116+03	36	0	0
1130	2016-12-16 20:17:00.133+03	29	0	0
1131	2016-12-16 20:17:00.15+03	20	0	0
1132	2016-12-16 20:17:00.166+03	33	0	0
1133	2016-12-16 20:17:00.183+03	34	0	0
1134	2016-12-16 20:47:00.014+03	32	0	0
1135	2016-12-16 20:47:00.043+03	35	0	0
1136	2016-12-16 20:47:00.068+03	31	0	0
1137	2016-12-16 20:47:00.093+03	30	0	0
1138	2016-12-16 20:47:00.118+03	36	0	0
1139	2016-12-16 20:47:00.143+03	29	0	0
1140	2016-12-16 20:47:00.168+03	20	0	0
1141	2016-12-16 20:47:00.193+03	33	0	0
1142	2016-12-16 20:47:00.21+03	34	0	0
1143	2016-12-16 21:17:00.011+03	32	0	0
1144	2016-12-16 21:17:00.045+03	35	0	0
1145	2016-12-16 21:17:00.07+03	31	0	0
1146	2016-12-16 21:17:00.095+03	30	0	0
1147	2016-12-16 21:17:00.12+03	36	0	0
1148	2016-12-16 21:17:00.136+03	29	155918	2694
1149	2016-12-16 21:17:00.153+03	20	0	0
1150	2016-12-16 21:17:00.17+03	33	0	0
1151	2016-12-16 21:17:00.186+03	34	0	0
1152	2016-12-16 21:47:00.013+03	32	0	0
1153	2016-12-16 21:47:00.075+03	35	0	0
1154	2016-12-16 21:47:00.117+03	31	0	0
1155	2016-12-16 21:47:00.15+03	30	0	0
1156	2016-12-16 21:47:00.183+03	36	0	0
1157	2016-12-16 21:47:00.225+03	29	269768	2880
1158	2016-12-16 21:47:00.242+03	20	0	0
1159	2016-12-16 21:47:00.276+03	33	0	0
1160	2016-12-16 21:47:00.292+03	34	0	0
1161	2016-12-16 22:17:00.015+03	32	0	0
1162	2016-12-16 22:17:00.046+03	35	0	0
1163	2016-12-16 22:17:00.071+03	31	0	0
1164	2016-12-16 22:17:00.096+03	30	0	0
1165	2016-12-16 22:17:00.121+03	36	0	0
1166	2016-12-16 22:17:00.138+03	29	26976	288
1167	2016-12-16 22:17:00.154+03	20	0	0
1168	2016-12-16 22:17:00.171+03	33	0	0
1169	2016-12-16 22:17:00.196+03	34	0	0
1170	2016-12-16 22:47:00.014+03	32	0	0
1171	2016-12-16 22:47:00.056+03	35	0	0
1172	2016-12-16 22:47:00.08+03	31	0	0
1173	2016-12-16 22:47:00.105+03	30	0	0
1174	2016-12-16 22:47:00.13+03	36	0	0
1175	2016-12-16 22:47:00.155+03	29	463620	10182
1176	2016-12-16 22:47:00.18+03	20	0	0
1177	2016-12-16 22:47:00.205+03	33	0	0
1178	2016-12-16 22:47:00.222+03	34	0	0
1179	2016-12-16 23:17:00.015+03	32	0	0
1180	2016-12-16 23:17:00.047+03	35	0	0
1181	2016-12-16 23:17:00.072+03	31	0	0
1182	2016-12-16 23:17:00.097+03	30	0	0
1183	2016-12-16 23:17:00.122+03	36	0	0
1184	2016-12-16 23:17:00.139+03	29	0	0
1185	2016-12-16 23:17:00.156+03	20	0	0
1186	2016-12-16 23:17:00.172+03	33	0	0
1187	2016-12-16 23:17:00.189+03	34	0	0
1188	2016-12-16 23:47:00.018+03	32	0	0
1189	2016-12-16 23:47:00.054+03	35	0	0
1190	2016-12-16 23:47:00.079+03	31	0	0
1191	2016-12-16 23:47:00.104+03	30	0	0
1192	2016-12-16 23:47:00.129+03	36	0	0
1193	2016-12-16 23:47:00.154+03	29	1239604	24044
1194	2016-12-16 23:47:00.179+03	20	0	0
1195	2016-12-16 23:47:00.204+03	33	0	0
1196	2016-12-16 23:47:00.229+03	34	0	0
1197	2016-12-17 00:17:00.012+03	32	0	0
1198	2016-12-17 00:17:00.058+03	35	0	0
1199	2016-12-17 00:17:00.083+03	31	0	0
1200	2016-12-17 00:17:00.108+03	30	0	0
1201	2016-12-17 00:17:00.133+03	36	0	0
1202	2016-12-17 00:17:00.158+03	29	0	0
1203	2016-12-17 00:17:00.175+03	20	0	0
1204	2016-12-17 00:17:00.225+03	33	0	0
1205	2016-12-17 00:17:00.241+03	34	0	0
1206	2016-12-17 00:47:00.012+03	32	0	0
1207	2016-12-17 00:47:00.035+03	35	0	0
1208	2016-12-17 00:47:00.052+03	31	0	0
1209	2016-12-17 00:47:00.068+03	30	0	0
1210	2016-12-17 00:47:00.085+03	36	0	0
1211	2016-12-17 00:47:00.102+03	29	882566	12062
1212	2016-12-17 00:47:00.118+03	20	0	0
1213	2016-12-17 00:47:00.135+03	33	0	0
1214	2016-12-17 00:47:00.152+03	34	0	0
1215	2016-12-17 01:17:00.014+03	32	0	0
1216	2016-12-17 01:17:00.047+03	35	0	0
1217	2016-12-17 01:17:00.072+03	31	0	0
1218	2016-12-17 01:17:00.097+03	30	0	0
1219	2016-12-17 01:17:00.122+03	36	0	0
1220	2016-12-17 01:17:00.147+03	29	394142	27236
1221	2016-12-17 01:17:00.164+03	20	0	0
1222	2016-12-17 01:17:00.18+03	33	0	0
1223	2016-12-17 01:17:00.198+03	34	0	0
1224	2016-12-17 01:47:00.086+03	32	0	0
1225	2016-12-17 01:47:00.246+03	35	0	0
1226	2016-12-17 01:47:00.271+03	31	0	0
1227	2016-12-17 01:47:00.288+03	30	0	0
1228	2016-12-17 01:47:00.305+03	36	0	0
1229	2016-12-17 01:47:00.33+03	29	38396	720
1230	2016-12-17 01:47:00.355+03	20	0	0
1231	2016-12-17 01:47:00.38+03	33	0	0
1232	2016-12-17 01:47:00.614+03	34	0	0
1233	2016-12-17 02:17:00.117+03	32	0	0
1234	2016-12-17 02:17:00.285+03	35	0	0
1235	2016-12-17 02:17:00.31+03	31	0	0
1236	2016-12-17 02:17:00.327+03	30	0	0
1237	2016-12-17 02:17:00.343+03	36	0	0
1238	2016-12-17 02:17:00.36+03	29	202240	3600
1239	2016-12-17 02:17:00.377+03	20	0	0
1240	2016-12-17 02:17:00.393+03	33	0	0
1241	2016-12-17 02:17:00.41+03	34	0	0
1242	2016-12-17 02:47:00.013+03	32	0	0
1243	2016-12-17 02:47:00.043+03	35	0	0
1244	2016-12-17 02:47:00.068+03	31	0	0
1245	2016-12-17 02:47:00.093+03	30	0	0
1246	2016-12-17 02:47:00.117+03	36	0	0
1247	2016-12-17 02:47:00.143+03	29	0	0
1248	2016-12-17 02:47:00.168+03	20	0	0
1249	2016-12-17 02:47:00.193+03	33	0	0
1250	2016-12-17 02:47:00.218+03	34	0	0
1251	2016-12-17 03:17:00.149+03	32	0	0
1252	2016-12-17 03:17:00.332+03	35	0	0
1253	2016-12-17 03:17:00.357+03	31	0	0
1254	2016-12-17 03:17:00.374+03	30	0	0
1255	2016-12-17 03:17:00.39+03	36	0	0
1256	2016-12-17 03:17:00.407+03	29	0	0
1257	2016-12-17 03:17:00.424+03	20	0	0
1258	2016-12-17 03:17:00.44+03	33	0	0
1259	2016-12-17 03:17:00.457+03	34	0	0
1260	2016-12-17 03:47:00.011+03	32	0	0
1261	2016-12-17 03:47:00.039+03	35	0	0
1262	2016-12-17 03:47:00.064+03	31	0	0
1263	2016-12-17 03:47:00.107+03	30	0	0
1264	2016-12-17 03:47:00.139+03	36	0	0
1265	2016-12-17 03:47:00.164+03	29	0	0
1266	2016-12-17 03:47:00.189+03	20	0	0
1267	2016-12-17 03:47:00.214+03	33	0	0
1268	2016-12-17 03:47:00.239+03	34	0	0
1269	2016-12-17 04:17:00.018+03	32	0	0
1270	2016-12-17 04:17:00.056+03	35	0	0
1271	2016-12-17 04:17:00.081+03	31	0	0
1272	2016-12-17 04:17:00.106+03	30	0	0
1273	2016-12-17 04:17:00.131+03	36	0	0
1274	2016-12-17 04:17:00.157+03	29	0	0
1275	2016-12-17 04:17:00.181+03	20	0	0
1276	2016-12-17 04:17:00.198+03	33	0	0
1277	2016-12-17 04:17:00.223+03	34	0	0
1278	2016-12-17 04:47:00.014+03	32	0	0
1279	2016-12-17 04:47:00.048+03	35	0	0
1280	2016-12-17 04:47:00.073+03	31	0	0
1281	2016-12-17 04:47:00.098+03	30	0	0
1282	2016-12-17 04:47:00.123+03	36	0	0
1283	2016-12-17 04:47:00.148+03	29	0	0
1284	2016-12-17 04:47:00.173+03	20	0	0
1285	2016-12-17 04:47:00.198+03	33	0	0
1286	2016-12-17 04:47:00.223+03	34	0	0
1287	2016-12-17 05:17:00.012+03	32	0	0
1288	2016-12-17 05:17:00.044+03	35	0	0
1289	2016-12-17 05:17:00.103+03	31	0	0
1290	2016-12-17 05:17:00.128+03	30	0	0
1291	2016-12-17 05:17:00.152+03	36	0	0
1292	2016-12-17 05:17:00.177+03	29	0	0
1293	2016-12-17 05:17:00.194+03	20	0	0
1294	2016-12-17 05:17:00.211+03	33	0	0
1295	2016-12-17 05:17:00.228+03	34	0	0
1296	2016-12-17 05:47:00.013+03	32	0	0
1297	2016-12-17 05:47:00.045+03	35	0	0
1298	2016-12-17 05:47:00.07+03	31	0	0
1299	2016-12-17 05:47:00.095+03	30	0	0
1300	2016-12-17 05:47:00.12+03	36	0	0
1301	2016-12-17 05:47:00.145+03	29	0	0
1302	2016-12-17 05:47:00.17+03	20	0	0
1303	2016-12-17 05:47:00.195+03	33	0	0
1304	2016-12-17 05:47:00.22+03	34	0	0
1305	2016-12-17 06:17:00.013+03	32	0	0
1306	2016-12-17 06:17:00.047+03	35	0	0
1307	2016-12-17 06:17:00.064+03	31	0	0
1308	2016-12-17 06:17:00.08+03	30	0	0
1309	2016-12-17 06:17:00.097+03	36	0	0
1310	2016-12-17 06:17:00.114+03	29	0	0
1311	2016-12-17 06:17:00.139+03	20	0	0
1312	2016-12-17 06:17:00.155+03	33	0	0
1313	2016-12-17 06:17:00.172+03	34	0	0
1314	2016-12-17 06:47:00.123+03	32	0	0
1315	2016-12-17 06:47:00.315+03	35	0	0
1316	2016-12-17 06:47:00.332+03	31	0	0
1317	2016-12-17 06:47:00.348+03	30	0	0
1318	2016-12-17 06:47:00.365+03	36	0	0
1319	2016-12-17 06:47:00.382+03	29	0	0
1320	2016-12-17 06:47:00.398+03	20	0	0
1321	2016-12-17 06:47:00.415+03	33	0	0
1322	2016-12-17 06:47:00.432+03	34	0	0
1323	2016-12-17 07:17:00.014+03	32	0	0
1324	2016-12-17 07:17:00.046+03	35	0	0
1325	2016-12-17 07:17:00.063+03	31	0	0
1326	2016-12-17 07:17:00.08+03	30	0	0
1327	2016-12-17 07:17:00.096+03	36	0	0
1328	2016-12-17 07:17:00.113+03	29	0	0
1329	2016-12-17 07:17:00.13+03	20	0	0
1330	2016-12-17 07:17:00.146+03	33	0	0
1331	2016-12-17 07:17:00.163+03	34	0	0
1332	2016-12-17 07:47:00.108+03	32	0	0
1333	2016-12-17 07:47:00.293+03	35	0	0
1334	2016-12-17 07:47:00.31+03	31	0	0
1335	2016-12-17 07:47:00.326+03	30	0	0
1336	2016-12-17 07:47:00.343+03	36	0	0
1337	2016-12-17 07:47:00.36+03	29	0	0
1338	2016-12-17 07:47:00.376+03	20	0	0
1339	2016-12-17 07:47:00.393+03	33	0	0
1340	2016-12-17 07:47:00.41+03	34	0	0
1341	2016-12-17 08:17:00.014+03	32	0	0
1342	2016-12-17 08:17:00.051+03	35	0	0
1343	2016-12-17 08:17:00.067+03	31	0	0
1344	2016-12-17 08:17:00.084+03	30	0	0
1345	2016-12-17 08:17:00.101+03	36	0	0
1346	2016-12-17 08:17:00.117+03	29	0	0
1347	2016-12-17 08:17:00.134+03	20	0	0
1348	2016-12-17 08:17:00.151+03	33	0	0
1349	2016-12-17 08:17:00.184+03	34	0	0
1350	2016-12-17 08:47:00.012+03	32	0	0
1351	2016-12-17 08:47:00.046+03	35	0	0
1352	2016-12-17 08:47:00.071+03	31	0	0
1353	2016-12-17 08:47:00.096+03	30	0	0
1354	2016-12-17 08:47:00.121+03	36	0	0
1355	2016-12-17 08:47:00.146+03	29	0	0
1356	2016-12-17 08:47:00.163+03	20	0	0
1357	2016-12-17 08:47:00.179+03	33	0	0
1358	2016-12-17 08:47:00.196+03	34	0	0
1359	2016-12-17 09:17:00.006+03	32	0	0
1360	2016-12-17 09:17:00.04+03	35	0	0
1361	2016-12-17 09:17:00.065+03	31	0	0
1362	2016-12-17 09:17:00.081+03	30	0	0
1363	2016-12-17 09:17:00.106+03	36	0	0
1364	2016-12-17 09:17:00.123+03	29	0	0
1365	2016-12-17 09:17:00.14+03	20	0	0
1366	2016-12-17 09:17:00.156+03	33	0	0
1367	2016-12-17 09:17:00.173+03	34	0	0
1368	2016-12-17 09:47:00.015+03	32	0	0
1369	2016-12-17 09:47:00.052+03	35	0	0
1370	2016-12-17 09:47:00.077+03	31	0	0
1371	2016-12-17 09:47:00.102+03	30	0	0
1372	2016-12-17 09:47:00.127+03	36	0	0
1373	2016-12-17 09:47:00.152+03	29	363844	5284
1374	2016-12-17 09:47:00.169+03	20	0	0
1375	2016-12-17 09:47:00.186+03	33	0	0
1376	2016-12-17 09:47:00.202+03	34	0	0
1377	2016-12-17 10:17:00.014+03	32	0	0
1378	2016-12-17 10:17:00.043+03	35	0	0
1379	2016-12-17 10:17:00.068+03	31	0	0
1380	2016-12-17 10:17:00.093+03	30	0	0
1381	2016-12-17 10:17:00.118+03	36	0	0
1382	2016-12-17 10:17:00.143+03	29	0	0
1383	2016-12-17 10:17:00.168+03	20	0	0
1384	2016-12-17 10:17:00.193+03	33	0	0
1385	2016-12-17 10:17:00.218+03	34	0	0
1386	2016-12-17 10:47:00.013+03	32	0	0
1387	2016-12-17 10:47:00.041+03	35	0	0
1388	2016-12-17 10:47:00.067+03	31	0	0
1389	2016-12-17 10:47:00.112+03	30	0	0
1390	2016-12-17 10:47:00.158+03	36	0	0
1391	2016-12-17 10:47:00.183+03	29	0	0
1392	2016-12-17 10:47:00.2+03	20	0	0
1393	2016-12-17 10:47:00.216+03	33	0	0
1394	2016-12-17 10:47:00.233+03	34	0	0
1395	2016-12-17 11:17:00.01+03	32	0	0
1396	2016-12-17 11:17:00.047+03	35	0	0
1397	2016-12-17 11:17:00.072+03	31	0	0
1398	2016-12-17 11:17:00.097+03	30	0	0
1399	2016-12-17 11:17:00.113+03	36	0	0
1400	2016-12-17 11:17:00.13+03	29	0	0
1401	2016-12-17 11:17:00.147+03	20	0	0
1402	2016-12-17 11:17:00.172+03	33	0	0
1403	2016-12-17 11:17:00.188+03	34	0	0
1404	2016-12-17 11:47:00.112+03	32	0	0
1405	2016-12-17 11:47:00.26+03	35	0	0
1406	2016-12-17 11:47:00.293+03	31	0	0
1407	2016-12-17 11:47:00.31+03	30	0	0
1408	2016-12-17 11:47:00.327+03	36	0	0
1409	2016-12-17 11:47:00.352+03	29	0	0
1410	2016-12-17 11:47:00.368+03	20	0	0
1411	2016-12-17 11:47:00.385+03	33	0	0
1412	2016-12-17 11:47:00.402+03	34	0	0
1413	2016-12-17 12:17:00.013+03	32	0	0
1414	2016-12-17 12:17:00.048+03	35	0	0
1415	2016-12-17 12:17:00.073+03	31	0	0
1416	2016-12-17 12:17:00.098+03	30	0	0
1417	2016-12-17 12:17:00.123+03	36	0	0
1418	2016-12-17 12:17:00.148+03	29	0	0
1419	2016-12-17 12:17:00.173+03	20	0	0
1420	2016-12-17 12:17:00.198+03	33	0	0
1421	2016-12-17 12:17:00.223+03	34	0	0
1422	2016-12-17 12:47:00.016+03	32	0	0
1423	2016-12-17 12:47:00.059+03	35	0	0
1424	2016-12-17 12:47:00.084+03	31	0	0
1425	2016-12-17 12:47:00.134+03	30	0	0
1426	2016-12-17 12:47:00.159+03	36	0	0
1427	2016-12-17 12:47:00.184+03	29	0	0
1428	2016-12-17 12:47:00.209+03	20	0	0
1429	2016-12-17 12:47:00.234+03	33	0	0
1430	2016-12-17 12:47:00.259+03	34	0	0
1431	2016-12-17 13:17:00.013+03	32	0	0
1432	2016-12-17 13:17:00.047+03	35	0	0
1433	2016-12-17 13:17:00.072+03	31	0	0
1434	2016-12-17 13:17:00.097+03	30	0	0
1435	2016-12-17 13:17:00.122+03	36	0	0
1436	2016-12-17 13:17:00.147+03	29	0	0
1437	2016-12-17 13:17:00.172+03	20	0	0
1438	2016-12-17 13:17:00.197+03	33	0	0
1439	2016-12-17 13:17:00.222+03	34	0	0
1440	2016-12-17 13:47:00.014+03	32	0	0
1441	2016-12-17 13:47:00.056+03	35	0	0
1442	2016-12-17 13:47:00.081+03	31	0	0
1443	2016-12-17 13:47:00.106+03	30	0	0
1444	2016-12-17 13:47:00.131+03	36	0	0
1445	2016-12-17 13:47:00.156+03	29	0	0
1446	2016-12-17 13:47:00.181+03	20	0	0
1447	2016-12-17 13:47:00.206+03	33	0	0
1448	2016-12-17 13:47:00.223+03	34	0	0
1449	2016-12-17 14:17:00.015+03	32	0	0
1450	2016-12-17 14:17:00.046+03	35	0	0
1451	2016-12-17 14:17:00.096+03	31	0	0
1452	2016-12-17 14:17:00.121+03	30	0	0
1453	2016-12-17 14:17:00.138+03	36	0	0
1454	2016-12-17 14:17:00.154+03	29	0	0
1455	2016-12-17 14:17:00.171+03	20	0	0
1456	2016-12-17 14:17:00.188+03	33	0	0
1457	2016-12-17 14:17:00.204+03	34	0	0
1458	2016-12-17 14:47:00.013+03	32	0	0
1459	2016-12-17 14:47:00.048+03	35	0	0
1460	2016-12-17 14:47:00.073+03	31	0	0
1461	2016-12-17 14:47:00.098+03	30	0	0
1462	2016-12-17 14:47:00.141+03	36	0	0
1463	2016-12-17 14:47:00.173+03	29	0	0
1464	2016-12-17 14:47:00.198+03	20	0	0
1465	2016-12-17 14:47:00.223+03	33	0	0
1466	2016-12-17 14:47:00.248+03	34	0	0
1467	2016-12-17 15:17:00.013+03	32	0	0
1468	2016-12-17 15:17:00.046+03	35	0	0
1469	2016-12-17 15:17:00.071+03	31	0	0
1470	2016-12-17 15:17:00.096+03	30	0	0
1471	2016-12-17 15:17:00.121+03	36	0	0
1472	2016-12-17 15:17:00.138+03	29	0	0
1473	2016-12-17 15:17:00.154+03	20	0	0
1474	2016-12-17 15:17:00.171+03	33	0	0
1475	2016-12-17 15:17:00.188+03	34	0	0
1476	2016-12-17 15:47:00.014+03	32	0	0
1477	2016-12-17 15:47:00.111+03	35	0	0
1478	2016-12-17 15:47:00.163+03	31	0	0
1479	2016-12-17 15:47:00.194+03	30	0	0
1480	2016-12-17 15:47:00.219+03	36	0	0
1481	2016-12-17 15:47:00.244+03	29	0	0
1482	2016-12-17 15:47:00.269+03	20	0	0
1483	2016-12-17 15:47:00.294+03	33	0	0
1484	2016-12-17 15:47:00.319+03	34	0	0
1485	2016-12-17 16:17:00.014+03	32	0	0
1486	2016-12-17 16:17:00.051+03	35	0	0
1487	2016-12-17 16:17:00.076+03	31	0	0
1488	2016-12-17 16:17:00.101+03	30	0	0
1489	2016-12-17 16:17:00.126+03	36	0	0
1490	2016-12-17 16:17:00.143+03	29	0	0
1491	2016-12-17 16:17:00.159+03	20	0	0
1492	2016-12-17 16:17:00.176+03	33	0	0
1493	2016-12-17 16:17:00.201+03	34	0	0
1494	2016-12-17 16:47:00.013+03	32	0	0
1495	2016-12-17 16:47:00.046+03	35	0	0
1496	2016-12-17 16:47:00.071+03	31	0	0
1497	2016-12-17 16:47:00.096+03	30	0	0
1498	2016-12-17 16:47:00.121+03	36	0	0
1499	2016-12-17 16:47:00.147+03	29	0	0
1500	2016-12-17 16:47:00.192+03	20	0	0
1501	2016-12-17 16:47:00.23+03	33	0	0
1502	2016-12-17 16:47:00.255+03	34	0	0
1503	2016-12-17 17:17:00.014+03	32	0	0
1504	2016-12-17 17:17:00.054+03	35	0	0
1505	2016-12-17 17:17:00.079+03	31	0	0
1506	2016-12-17 17:17:00.104+03	30	0	0
1507	2016-12-17 17:17:00.129+03	36	0	0
1508	2016-12-17 17:17:00.154+03	29	0	0
1509	2016-12-17 17:17:00.171+03	20	0	0
1510	2016-12-17 17:17:00.187+03	33	0	0
1511	2016-12-17 17:17:00.212+03	34	0	0
1512	2016-12-17 17:47:00.014+03	32	0	0
1513	2016-12-17 17:47:00.042+03	35	0	0
1514	2016-12-17 17:47:00.067+03	31	0	0
1515	2016-12-17 17:47:00.092+03	30	0	0
1516	2016-12-17 17:47:00.117+03	36	0	0
1517	2016-12-17 17:47:00.142+03	29	0	0
1518	2016-12-17 17:47:00.167+03	20	0	0
1519	2016-12-17 17:47:00.192+03	33	0	0
1520	2016-12-17 17:47:00.217+03	34	0	0
1521	2016-12-17 18:17:00.015+03	32	0	0
1522	2016-12-17 18:17:00.049+03	35	0	0
1523	2016-12-17 18:17:00.074+03	31	0	0
1524	2016-12-17 18:17:00.099+03	30	0	0
1525	2016-12-17 18:17:00.124+03	36	0	0
1526	2016-12-17 18:17:00.149+03	29	0	0
1527	2016-12-17 18:17:00.166+03	20	0	0
1528	2016-12-17 18:17:00.182+03	33	0	0
1529	2016-12-17 18:17:00.199+03	34	0	0
1530	2016-12-17 18:47:00.013+03	32	0	0
1531	2016-12-17 18:47:00.049+03	35	0	0
1532	2016-12-17 18:47:00.074+03	31	0	0
1533	2016-12-17 18:47:00.099+03	30	0	0
1534	2016-12-17 18:47:00.124+03	36	0	0
1535	2016-12-17 18:47:00.149+03	29	0	0
1536	2016-12-17 18:47:00.174+03	20	0	0
1537	2016-12-17 18:47:00.199+03	33	0	0
1538	2016-12-17 18:47:00.257+03	34	0	0
1539	2016-12-17 19:17:00.014+03	32	0	0
1540	2016-12-17 19:17:00.044+03	35	0	0
1541	2016-12-17 19:17:00.069+03	31	0	0
1542	2016-12-17 19:17:00.094+03	30	0	0
1543	2016-12-17 19:17:00.119+03	36	0	0
1544	2016-12-17 19:17:00.144+03	29	0	0
1545	2016-12-17 19:17:00.169+03	20	0	0
1546	2016-12-17 19:17:00.185+03	33	0	0
1547	2016-12-17 19:17:00.202+03	34	0	0
1548	2016-12-17 19:47:00.014+03	32	0	0
1549	2016-12-17 19:47:00.044+03	35	0	0
1550	2016-12-17 19:47:00.061+03	31	0	0
1551	2016-12-17 19:47:00.086+03	30	0	0
1552	2016-12-17 19:47:00.119+03	36	0	0
1553	2016-12-17 19:47:00.144+03	29	0	0
1554	2016-12-17 19:47:00.169+03	20	0	0
1555	2016-12-17 19:47:00.194+03	33	0	0
1556	2016-12-17 19:47:00.219+03	34	0	0
1557	2016-12-17 20:17:00.013+03	32	0	0
1558	2016-12-17 20:17:00.056+03	35	0	0
1559	2016-12-17 20:17:00.081+03	31	0	0
1560	2016-12-17 20:17:00.106+03	30	0	0
1561	2016-12-17 20:17:00.156+03	36	0	0
1562	2016-12-17 20:17:00.181+03	29	0	0
1563	2016-12-17 20:17:00.206+03	20	0	0
1564	2016-12-17 20:17:00.231+03	33	0	0
1565	2016-12-17 20:17:00.256+03	34	0	0
1566	2016-12-17 20:47:00.015+03	32	0	0
1567	2016-12-17 20:47:00.06+03	35	0	0
1568	2016-12-17 20:47:00.085+03	31	0	0
1569	2016-12-17 20:47:00.148+03	30	0	0
1570	2016-12-17 20:47:00.201+03	36	0	0
1571	2016-12-17 20:47:00.226+03	29	0	0
1572	2016-12-17 20:47:00.291+03	20	0	0
1573	2016-12-17 20:47:00.318+03	33	0	0
1574	2016-12-17 20:47:00.343+03	34	0	0
1575	2016-12-17 21:17:00.013+03	32	0	0
1576	2016-12-17 21:17:00.043+03	35	0	0
1577	2016-12-17 21:17:00.068+03	31	0	0
1578	2016-12-17 21:17:00.093+03	30	0	0
1579	2016-12-17 21:17:00.119+03	36	0	0
1580	2016-12-17 21:17:00.144+03	29	0	0
1581	2016-12-17 21:17:00.169+03	20	0	0
1582	2016-12-17 21:17:00.194+03	33	0	0
1583	2016-12-17 21:17:00.22+03	34	0	0
1584	2016-12-17 21:47:00.012+03	32	0	0
1585	2016-12-17 21:47:00.115+03	35	0	0
1586	2016-12-17 21:47:00.183+03	31	0	0
1587	2016-12-17 21:47:00.365+03	30	0	0
1588	2016-12-17 21:47:00.723+03	36	0	0
1589	2016-12-17 21:47:00.87+03	29	0	0
1590	2016-12-17 21:47:00.952+03	20	0	0
1591	2016-12-17 21:47:01.135+03	33	0	0
1592	2016-12-17 21:47:01.477+03	34	0	0
1593	2016-12-17 22:17:00.013+03	32	0	0
1594	2016-12-17 22:17:00.081+03	35	0	0
1595	2016-12-17 22:17:00.107+03	31	0	0
1596	2016-12-17 22:17:00.131+03	30	0	0
1597	2016-12-17 22:17:00.156+03	36	0	0
1598	2016-12-17 22:17:00.181+03	29	0	0
1599	2016-12-17 22:17:00.207+03	20	0	0
1600	2016-12-17 22:17:00.231+03	33	0	0
1601	2016-12-17 22:17:00.256+03	34	0	0
1602	2016-12-17 22:47:00.013+03	32	0	0
1603	2016-12-17 22:47:00.045+03	35	0	0
1604	2016-12-17 22:47:00.079+03	31	0	0
1605	2016-12-17 22:47:00.104+03	30	0	0
1606	2016-12-17 22:47:00.129+03	36	0	0
1607	2016-12-17 22:47:00.154+03	29	0	0
1608	2016-12-17 22:47:00.179+03	20	0	0
1609	2016-12-17 22:47:00.204+03	33	0	0
1610	2016-12-17 22:47:00.229+03	34	0	0
1611	2016-12-17 23:17:00.014+03	32	0	0
1612	2016-12-17 23:17:00.044+03	35	0	0
1613	2016-12-17 23:17:00.069+03	31	0	0
1614	2016-12-17 23:17:00.095+03	30	0	0
1615	2016-12-17 23:17:00.119+03	36	0	0
1616	2016-12-17 23:17:00.144+03	29	0	0
1617	2016-12-17 23:17:00.169+03	20	0	0
1618	2016-12-17 23:17:00.195+03	33	0	0
1619	2016-12-17 23:17:00.211+03	34	0	0
1620	2016-12-17 23:47:00.015+03	32	0	0
1621	2016-12-17 23:47:00.048+03	35	0	0
1622	2016-12-17 23:47:00.073+03	31	0	0
1623	2016-12-17 23:47:00.098+03	30	0	0
1624	2016-12-17 23:47:00.123+03	36	0	0
1625	2016-12-17 23:47:00.148+03	29	0	0
1626	2016-12-17 23:47:00.173+03	20	0	0
1627	2016-12-17 23:47:00.198+03	33	0	0
1628	2016-12-17 23:47:00.223+03	34	0	0
1629	2016-12-18 00:17:00.012+03	32	0	0
1630	2016-12-18 00:17:00.045+03	35	0	0
1631	2016-12-18 00:17:00.061+03	31	0	0
1632	2016-12-18 00:17:00.078+03	30	0	0
1633	2016-12-18 00:17:00.103+03	36	0	0
1634	2016-12-18 00:17:00.12+03	29	0	0
1635	2016-12-18 00:17:00.136+03	20	0	0
1636	2016-12-18 00:17:00.153+03	33	0	0
1637	2016-12-18 00:17:00.17+03	34	0	0
1638	2016-12-18 00:47:00.014+03	32	0	0
1639	2016-12-18 00:47:00.091+03	35	0	0
1640	2016-12-18 00:47:00.116+03	31	0	0
1641	2016-12-18 00:47:00.141+03	30	0	0
1642	2016-12-18 00:47:00.167+03	36	0	0
1643	2016-12-18 00:47:00.191+03	29	0	0
1644	2016-12-18 00:47:00.216+03	20	0	0
1645	2016-12-18 00:47:00.241+03	33	0	0
1646	2016-12-18 00:47:00.267+03	34	0	0
1647	2016-12-18 01:17:00.013+03	32	0	0
1648	2016-12-18 01:17:00.043+03	35	0	0
1649	2016-12-18 01:17:00.06+03	31	0	0
1650	2016-12-18 01:17:00.076+03	30	0	0
1651	2016-12-18 01:17:00.093+03	36	0	0
1652	2016-12-18 01:17:00.11+03	29	0	0
1653	2016-12-18 01:17:00.126+03	20	0	0
1654	2016-12-18 01:17:00.143+03	33	0	0
1655	2016-12-18 01:17:00.16+03	34	0	0
1656	2016-12-18 01:47:00.013+03	32	0	0
1657	2016-12-18 01:47:00.046+03	35	0	0
1658	2016-12-18 01:47:00.071+03	31	0	0
1659	2016-12-18 01:47:00.096+03	30	0	0
1660	2016-12-18 01:47:00.121+03	36	0	0
1661	2016-12-18 01:47:00.146+03	29	0	0
1662	2016-12-18 01:47:00.162+03	20	0	0
1663	2016-12-18 01:47:00.179+03	33	0	0
1664	2016-12-18 01:47:00.196+03	34	0	0
1665	2016-12-18 02:17:00.013+03	32	0	0
1666	2016-12-18 02:17:00.088+03	35	0	0
1667	2016-12-18 02:17:00.113+03	31	0	0
1668	2016-12-18 02:17:00.138+03	30	0	0
1669	2016-12-18 02:17:00.163+03	36	0	0
1670	2016-12-18 02:17:00.188+03	29	0	0
1671	2016-12-18 02:17:00.213+03	20	0	0
1672	2016-12-18 02:17:00.238+03	33	0	0
1673	2016-12-18 02:17:00.255+03	34	0	0
1674	2016-12-18 02:47:00.061+03	32	0	0
1675	2016-12-18 02:47:00.207+03	35	0	0
1676	2016-12-18 02:47:00.232+03	31	0	0
1677	2016-12-18 02:47:00.282+03	30	0	0
1678	2016-12-18 02:47:00.298+03	36	0	0
1679	2016-12-18 02:47:00.323+03	29	0	0
1680	2016-12-18 02:47:00.34+03	20	0	0
1681	2016-12-18 02:47:00.357+03	33	0	0
1682	2016-12-18 02:47:00.373+03	34	0	0
1683	2016-12-18 03:17:00.102+03	32	0	0
1684	2016-12-18 03:17:00.249+03	35	0	0
1685	2016-12-18 03:17:00.266+03	31	0	0
1686	2016-12-18 03:17:00.299+03	30	0	0
1687	2016-12-18 03:17:00.316+03	36	0	0
1688	2016-12-18 03:17:00.333+03	29	0	0
1689	2016-12-18 03:17:00.349+03	20	0	0
1690	2016-12-18 03:17:00.374+03	33	0	0
1691	2016-12-18 03:17:00.399+03	34	0	0
1692	2016-12-18 03:47:00.014+03	32	0	0
1693	2016-12-18 03:47:00.057+03	35	0	0
1694	2016-12-18 03:47:00.082+03	31	0	0
1695	2016-12-18 03:47:00.107+03	30	0	0
1696	2016-12-18 03:47:00.132+03	36	0	0
1697	2016-12-18 03:47:00.182+03	29	0	0
1698	2016-12-18 03:47:00.199+03	20	0	0
1699	2016-12-18 03:47:00.216+03	33	0	0
1700	2016-12-18 03:47:00.232+03	34	0	0
1701	2016-12-18 04:17:00.014+03	32	0	0
1702	2016-12-18 04:17:00.053+03	35	0	0
1703	2016-12-18 04:17:00.078+03	31	0	0
1704	2016-12-18 04:17:00.095+03	30	0	0
1705	2016-12-18 04:17:00.111+03	36	0	0
1706	2016-12-18 04:17:00.136+03	29	0	0
1707	2016-12-18 04:17:00.153+03	20	0	0
1708	2016-12-18 04:17:00.169+03	33	0	0
1709	2016-12-18 04:17:00.186+03	34	0	0
1710	2016-12-18 04:47:00.012+03	32	0	0
1711	2016-12-18 04:47:00.042+03	35	0	0
1712	2016-12-18 04:47:00.067+03	31	0	0
1713	2016-12-18 04:47:00.092+03	30	0	0
1714	2016-12-18 04:47:00.117+03	36	0	0
1715	2016-12-18 04:47:00.142+03	29	0	0
1716	2016-12-18 04:47:00.167+03	20	0	0
1717	2016-12-18 04:47:00.183+03	33	0	0
1718	2016-12-18 04:47:00.2+03	34	0	0
1719	2016-12-18 05:17:00.021+03	32	0	0
1720	2016-12-18 05:17:00.112+03	35	0	0
1721	2016-12-18 05:17:00.137+03	31	0	0
1722	2016-12-18 05:17:00.154+03	30	0	0
1723	2016-12-18 05:17:00.17+03	36	0	0
1724	2016-12-18 05:17:00.187+03	29	0	0
1725	2016-12-18 05:17:00.204+03	20	0	0
1726	2016-12-18 05:17:00.22+03	33	0	0
1727	2016-12-18 05:17:00.237+03	34	0	0
1728	2016-12-18 05:47:00.012+03	32	0	0
1729	2016-12-18 05:47:00.041+03	35	0	0
1730	2016-12-18 05:47:00.066+03	31	0	0
1731	2016-12-18 05:47:00.091+03	30	0	0
1732	2016-12-18 05:47:00.116+03	36	0	0
1733	2016-12-18 05:47:00.141+03	29	0	0
1734	2016-12-18 05:47:00.166+03	20	0	0
1735	2016-12-18 05:47:00.183+03	33	0	0
1736	2016-12-18 05:47:00.2+03	34	0	0
1737	2016-12-18 06:17:00.598+03	32	0	0
1738	2016-12-18 06:17:01.136+03	35	0	0
1739	2016-12-18 06:17:01.219+03	31	0	0
1740	2016-12-18 06:17:01.303+03	30	0	0
1741	2016-12-18 06:17:01.612+03	36	0	0
1742	2016-12-18 06:17:01.703+03	29	0	0
1743	2016-12-18 06:17:01.794+03	20	0	0
1744	2016-12-18 06:17:01.953+03	33	0	0
1745	2016-12-18 06:17:02.037+03	34	0	0
1746	2016-12-18 06:47:00.11+03	32	0	0
1747	2016-12-18 06:47:00.263+03	35	0	0
1748	2016-12-18 06:47:00.313+03	31	0	0
1749	2016-12-18 06:47:00.329+03	30	0	0
1750	2016-12-18 06:47:00.346+03	36	0	0
1751	2016-12-18 06:47:00.363+03	29	0	0
1752	2016-12-18 06:47:00.38+03	20	0	0
1753	2016-12-18 06:47:00.396+03	33	0	0
1754	2016-12-18 06:47:00.413+03	34	0	0
1755	2016-12-18 07:17:00.014+03	32	0	0
1756	2016-12-18 07:17:00.042+03	35	0	0
1757	2016-12-18 07:17:00.067+03	31	0	0
1758	2016-12-18 07:17:00.092+03	30	0	0
1759	2016-12-18 07:17:00.117+03	36	0	0
1760	2016-12-18 07:17:00.134+03	29	0	0
1761	2016-12-18 07:17:00.15+03	20	0	0
1762	2016-12-18 07:17:00.167+03	33	0	0
1763	2016-12-18 07:17:00.184+03	34	0	0
1764	2016-12-18 07:47:00.145+03	32	0	0
1765	2016-12-18 07:47:00.322+03	35	0	0
1766	2016-12-18 07:47:00.338+03	31	0	0
1767	2016-12-18 07:47:00.363+03	30	0	0
1768	2016-12-18 07:47:00.388+03	36	0	0
1769	2016-12-18 07:47:00.413+03	29	0	0
1770	2016-12-18 07:47:00.438+03	20	0	0
1771	2016-12-18 07:47:00.463+03	33	0	0
1772	2016-12-18 07:47:00.488+03	34	0	0
1773	2016-12-18 08:17:00.014+03	32	0	0
1774	2016-12-18 08:17:00.048+03	35	0	0
1775	2016-12-18 08:17:00.073+03	31	0	0
1776	2016-12-18 08:17:00.098+03	30	0	0
1777	2016-12-18 08:17:00.123+03	36	0	0
1778	2016-12-18 08:17:00.139+03	29	0	0
1779	2016-12-18 08:17:00.156+03	20	0	0
1780	2016-12-18 08:17:00.172+03	33	0	0
1781	2016-12-18 08:17:00.189+03	34	0	0
1782	2016-12-18 08:47:00.131+03	32	0	0
1783	2016-12-18 08:47:00.291+03	35	0	0
1784	2016-12-18 08:47:00.349+03	31	0	0
1785	2016-12-18 08:47:00.366+03	30	0	0
1786	2016-12-18 08:47:00.383+03	36	0	0
1787	2016-12-18 08:47:00.408+03	29	0	0
1788	2016-12-18 08:47:00.433+03	20	0	0
1789	2016-12-18 08:47:00.458+03	33	0	0
1790	2016-12-18 08:47:00.483+03	34	0	0
1791	2016-12-18 09:17:00.014+03	32	0	0
1792	2016-12-18 09:17:00.048+03	35	0	0
1793	2016-12-18 09:17:00.073+03	31	0	0
1794	2016-12-18 09:17:00.098+03	30	0	0
1795	2016-12-18 09:17:00.123+03	36	0	0
1796	2016-12-18 09:17:00.148+03	29	0	0
1797	2016-12-18 09:17:00.173+03	20	0	0
1798	2016-12-18 09:17:00.19+03	33	0	0
1799	2016-12-18 09:17:00.206+03	34	0	0
1800	2016-12-18 09:47:00.532+03	32	0	0
1801	2016-12-18 09:47:01.725+03	35	0	0
1802	2016-12-18 09:47:01.923+03	31	0	0
1803	2016-12-18 09:47:02.006+03	30	0	0
1804	2016-12-18 09:47:02.073+03	36	0	0
1805	2016-12-18 09:47:02.139+03	29	0	0
1806	2016-12-18 09:47:02.198+03	20	0	0
1807	2016-12-18 09:47:02.256+03	33	0	0
1808	2016-12-18 09:47:02.306+03	34	0	0
1809	2016-12-18 10:17:00.014+03	32	0	0
1810	2016-12-18 10:17:00.043+03	35	0	0
1811	2016-12-18 10:17:00.069+03	31	0	0
1812	2016-12-18 10:17:00.093+03	30	0	0
1813	2016-12-18 10:17:00.118+03	36	0	0
1814	2016-12-18 10:17:00.143+03	29	0	0
1815	2016-12-18 10:17:00.16+03	20	0	0
1816	2016-12-18 10:17:00.177+03	33	0	0
1817	2016-12-18 10:17:00.193+03	34	0	0
1818	2016-12-18 10:47:00.013+03	32	0	0
1819	2016-12-18 10:47:00.045+03	35	0	0
1820	2016-12-18 10:47:00.07+03	31	0	0
1821	2016-12-18 10:47:00.087+03	30	0	0
1822	2016-12-18 10:47:00.104+03	36	0	0
1823	2016-12-18 10:47:00.12+03	29	0	0
1824	2016-12-18 10:47:00.137+03	20	0	0
1825	2016-12-18 10:47:00.154+03	33	0	0
1826	2016-12-18 10:47:00.17+03	34	0	0
1827	2016-12-18 11:17:00.135+03	32	0	0
1828	2016-12-18 11:17:00.312+03	35	0	0
1829	2016-12-18 11:17:00.37+03	31	0	0
1830	2016-12-18 11:17:00.387+03	30	0	0
1831	2016-12-18 11:17:00.403+03	36	0	0
1832	2016-12-18 11:17:00.42+03	29	0	0
1833	2016-12-18 11:17:00.437+03	20	0	0
1834	2016-12-18 11:17:00.453+03	33	0	0
1835	2016-12-18 11:17:00.47+03	34	0	0
1836	2016-12-18 11:47:00.014+03	32	0	0
1837	2016-12-18 11:47:00.05+03	35	0	0
1838	2016-12-18 11:47:00.075+03	31	0	0
1839	2016-12-18 11:47:00.1+03	30	0	0
1840	2016-12-18 11:47:00.125+03	36	0	0
1841	2016-12-18 11:47:00.15+03	29	0	0
1842	2016-12-18 11:47:00.175+03	20	0	0
1843	2016-12-18 11:47:00.2+03	33	0	0
1844	2016-12-18 11:47:00.225+03	34	0	0
1845	2016-12-18 12:17:00.146+03	32	0	0
1846	2016-12-18 12:17:00.353+03	35	0	0
1847	2016-12-18 12:17:00.37+03	31	0	0
1848	2016-12-18 12:17:00.386+03	30	0	0
1849	2016-12-18 12:17:00.436+03	36	0	0
1850	2016-12-18 12:17:00.453+03	29	0	0
1851	2016-12-18 12:17:00.478+03	20	0	0
1852	2016-12-18 12:17:00.495+03	33	0	0
1853	2016-12-18 12:17:00.511+03	34	0	0
1854	2016-12-18 12:47:00.014+03	32	0	0
1855	2016-12-18 12:47:00.05+03	35	0	0
1856	2016-12-18 12:47:00.075+03	31	0	0
1857	2016-12-18 12:47:00.1+03	30	0	0
1858	2016-12-18 12:47:00.124+03	36	0	0
1859	2016-12-18 12:47:00.149+03	29	0	0
1860	2016-12-18 12:47:00.174+03	20	0	0
1861	2016-12-18 12:47:00.2+03	33	0	0
1862	2016-12-18 12:47:00.225+03	34	0	0
1863	2016-12-18 13:17:00.564+03	32	0	0
1864	2016-12-18 13:17:01.2+03	35	0	0
1865	2016-12-18 13:17:01.233+03	31	0	0
1866	2016-12-18 13:17:01.274+03	30	0	0
1867	2016-12-18 13:17:01.299+03	36	0	0
1868	2016-12-18 13:17:01.333+03	29	828336	34028
1869	2016-12-18 13:17:01.409+03	20	0	0
1870	2016-12-18 13:17:01.468+03	33	0	0
1871	2016-12-18 13:17:01.51+03	34	0	0
1872	2016-12-18 13:47:00.013+03	32	0	0
1873	2016-12-18 13:47:00.038+03	35	0	0
1874	2016-12-18 13:47:00.054+03	31	0	0
1875	2016-12-18 13:47:00.079+03	30	0	0
1876	2016-12-18 13:47:00.096+03	36	0	0
1877	2016-12-18 13:47:00.113+03	29	129470	3248
1878	2016-12-18 13:47:00.129+03	20	0	0
1879	2016-12-18 13:47:00.146+03	33	0	0
1880	2016-12-18 13:47:00.179+03	34	0	0
1881	2016-12-18 14:17:00.015+03	32	0	0
1882	2016-12-18 14:17:00.045+03	35	0	0
1883	2016-12-18 14:17:00.07+03	31	0	0
1884	2016-12-18 14:17:00.095+03	30	0	0
1885	2016-12-18 14:17:00.12+03	36	0	0
1886	2016-12-18 14:17:00.145+03	29	0	0
1887	2016-12-18 14:17:00.17+03	20	0	0
1888	2016-12-18 14:17:00.195+03	33	0	0
1889	2016-12-18 14:17:00.212+03	34	0	0
1890	2016-12-18 14:47:00.133+03	32	0	0
1891	2016-12-18 14:47:00.338+03	35	0	0
1892	2016-12-18 14:47:00.363+03	31	0	0
1893	2016-12-18 14:47:00.38+03	30	0	0
1894	2016-12-18 14:47:00.396+03	36	0	0
1895	2016-12-18 14:47:00.422+03	29	0	0
1896	2016-12-18 14:47:00.438+03	20	0	0
1897	2016-12-18 14:47:00.463+03	33	0	0
1898	2016-12-18 14:47:00.48+03	34	0	0
1899	2016-12-18 15:17:00.051+03	32	0	0
1900	2016-12-18 15:17:00.223+03	35	0	0
1901	2016-12-18 15:17:00.265+03	31	0	0
1902	2016-12-18 15:17:00.282+03	30	0	0
1903	2016-12-18 15:17:00.298+03	36	0	0
1904	2016-12-18 15:17:00.315+03	29	674610	9246
1905	2016-12-18 15:17:00.332+03	20	0	0
1906	2016-12-18 15:17:00.348+03	33	0	0
1907	2016-12-18 15:17:00.373+03	34	0	0
1908	2016-12-18 15:47:00.014+03	32	0	0
1909	2016-12-18 15:47:00.059+03	35	0	0
1910	2016-12-18 15:47:00.084+03	31	0	0
1911	2016-12-18 15:47:00.109+03	30	0	0
1912	2016-12-18 15:47:00.134+03	36	0	0
1913	2016-12-18 15:47:00.15+03	29	30150	432
1914	2016-12-18 15:47:00.167+03	20	0	0
1915	2016-12-18 15:47:00.184+03	33	0	0
1916	2016-12-18 15:47:00.2+03	34	0	0
1917	2016-12-18 16:17:00.014+03	32	0	0
1918	2016-12-18 16:17:00.057+03	35	0	0
1919	2016-12-18 16:17:00.082+03	31	0	0
1920	2016-12-18 16:17:00.107+03	30	0	0
1921	2016-12-18 16:17:00.132+03	36	0	0
1922	2016-12-18 16:17:00.157+03	29	0	0
1923	2016-12-18 16:17:00.182+03	20	0	0
1924	2016-12-18 16:17:00.207+03	33	0	0
1925	2016-12-18 16:17:00.224+03	34	0	0
1926	2016-12-18 16:47:00.015+03	32	0	0
1927	2016-12-18 16:47:00.045+03	35	0	0
1928	2016-12-18 16:47:00.07+03	31	0	0
1929	2016-12-18 16:47:00.095+03	30	0	0
1930	2016-12-18 16:47:00.12+03	36	0	0
1931	2016-12-18 16:47:00.145+03	29	0	0
1932	2016-12-18 16:47:00.162+03	20	0	0
1933	2016-12-18 16:47:00.178+03	33	0	0
1934	2016-12-18 16:47:00.195+03	34	0	0
1935	2016-12-18 17:17:00.014+03	32	0	0
1936	2016-12-18 17:17:00.062+03	35	0	0
1937	2016-12-18 17:17:00.087+03	31	0	0
1938	2016-12-18 17:17:00.112+03	30	0	0
1939	2016-12-18 17:17:00.137+03	36	0	0
1940	2016-12-18 17:17:00.162+03	29	0	0
1941	2016-12-18 17:17:00.187+03	20	0	0
1942	2016-12-18 17:17:00.212+03	33	0	0
1943	2016-12-18 17:17:00.229+03	34	0	0
1944	2016-12-18 17:47:00.17+03	32	0	0
1945	2016-12-18 17:47:00.353+03	35	0	0
1946	2016-12-18 17:47:00.369+03	31	0	0
1947	2016-12-18 17:47:00.386+03	30	0	0
1948	2016-12-18 17:47:00.403+03	36	0	0
1949	2016-12-18 17:47:00.42+03	29	0	0
1950	2016-12-18 17:47:00.436+03	20	0	0
1951	2016-12-18 17:47:00.453+03	33	0	0
1952	2016-12-18 17:47:00.47+03	34	0	0
1953	2016-12-18 18:17:00.016+03	32	0	0
1954	2016-12-18 18:17:00.067+03	35	0	0
1955	2016-12-18 18:17:00.092+03	31	0	0
1956	2016-12-18 18:17:00.117+03	30	0	0
1957	2016-12-18 18:17:00.142+03	36	0	0
1958	2016-12-18 18:17:00.167+03	29	156830	590
1959	2016-12-18 18:17:00.192+03	20	0	0
1960	2016-12-18 18:17:00.226+03	33	0	0
1961	2016-12-18 18:17:00.268+03	34	0	0
1962	2016-12-18 18:47:00.013+03	32	0	0
1963	2016-12-18 18:47:00.043+03	35	0	0
1964	2016-12-18 18:47:00.068+03	31	0	0
1965	2016-12-18 18:47:00.093+03	30	0	0
1966	2016-12-18 18:47:00.118+03	36	0	0
1967	2016-12-18 18:47:00.143+03	29	0	0
1968	2016-12-18 18:47:00.16+03	20	0	0
1969	2016-12-18 18:47:00.185+03	33	0	0
1970	2016-12-18 18:47:00.201+03	34	0	0
1971	2016-12-18 19:17:00.033+03	32	0	0
1972	2016-12-18 19:17:00.069+03	35	0	0
1973	2016-12-18 19:17:00.094+03	31	0	0
1974	2016-12-18 19:17:00.119+03	30	0	0
1975	2016-12-18 19:17:00.144+03	36	0	0
1976	2016-12-18 19:17:00.169+03	29	0	0
1977	2016-12-18 19:17:00.194+03	20	0	0
1978	2016-12-18 19:17:00.252+03	33	0	0
1979	2016-12-18 19:17:00.269+03	34	0	0
1980	2016-12-18 19:47:00.013+03	32	0	0
1981	2016-12-18 19:47:00.042+03	35	0	0
1982	2016-12-18 19:47:00.067+03	31	0	0
1983	2016-12-18 19:47:00.092+03	30	0	0
1984	2016-12-18 19:47:00.117+03	36	0	0
1985	2016-12-18 19:47:00.142+03	29	217276	1032
1986	2016-12-18 19:47:00.167+03	20	0	0
1987	2016-12-18 19:47:00.184+03	33	0	0
1988	2016-12-18 19:47:00.201+03	34	0	0
1989	2016-12-18 20:17:00.015+03	32	0	0
1990	2016-12-18 20:17:00.051+03	35	0	0
1991	2016-12-18 20:17:00.076+03	31	0	0
1992	2016-12-18 20:17:00.143+03	30	0	0
1993	2016-12-18 20:17:00.168+03	36	0	0
1994	2016-12-18 20:17:00.193+03	29	0	0
1995	2016-12-18 20:17:00.218+03	20	0	0
1996	2016-12-18 20:17:00.243+03	33	0	0
1997	2016-12-18 20:17:00.268+03	34	0	0
1998	2016-12-18 20:47:00.013+03	32	0	0
1999	2016-12-18 20:47:00.047+03	35	0	0
2000	2016-12-18 20:47:00.072+03	31	0	0
2001	2016-12-18 20:47:00.097+03	30	0	0
2002	2016-12-18 20:47:00.122+03	36	0	0
2003	2016-12-18 20:47:00.147+03	29	0	0
2004	2016-12-18 20:47:00.164+03	20	0	0
2005	2016-12-18 20:47:00.181+03	33	0	0
2006	2016-12-18 20:47:00.197+03	34	0	0
2007	2016-12-18 21:17:00.015+03	32	0	0
2008	2016-12-18 21:17:00.044+03	35	0	0
2009	2016-12-18 21:17:00.069+03	31	0	0
2010	2016-12-18 21:17:00.085+03	30	0	0
2011	2016-12-18 21:17:00.111+03	36	0	0
2012	2016-12-18 21:17:00.127+03	29	0	0
2013	2016-12-18 21:17:00.152+03	20	0	0
2014	2016-12-18 21:17:00.169+03	33	0	0
2015	2016-12-18 21:17:00.186+03	34	0	0
2016	2016-12-18 21:47:00.013+03	32	0	0
2017	2016-12-18 21:47:00.048+03	35	0	0
2018	2016-12-18 21:47:00.073+03	31	0	0
2019	2016-12-18 21:47:00.098+03	30	0	0
2020	2016-12-18 21:47:00.123+03	36	0	0
2021	2016-12-18 21:47:00.148+03	29	0	0
2022	2016-12-18 21:47:00.174+03	20	0	0
2023	2016-12-18 21:47:00.19+03	33	0	0
2024	2016-12-18 21:47:00.215+03	34	0	0
2025	2016-12-18 22:17:00.01+03	32	0	0
2026	2016-12-18 22:17:00.043+03	35	0	0
2027	2016-12-18 22:17:00.068+03	31	0	0
2028	2016-12-18 22:17:00.093+03	30	0	0
2029	2016-12-18 22:17:00.109+03	36	0	0
2030	2016-12-18 22:17:00.126+03	29	0	0
2031	2016-12-18 22:17:00.143+03	20	0	0
2032	2016-12-18 22:17:00.159+03	33	0	0
2033	2016-12-18 22:17:00.176+03	34	0	0
2034	2016-12-18 22:47:00.012+03	32	0	0
2035	2016-12-18 22:47:00.05+03	35	0	0
2036	2016-12-18 22:47:00.075+03	31	0	0
2037	2016-12-18 22:47:00.1+03	30	0	0
2038	2016-12-18 22:47:00.125+03	36	0	0
2039	2016-12-18 22:47:00.15+03	29	0	0
2040	2016-12-18 22:47:00.175+03	20	0	0
2041	2016-12-18 22:47:00.191+03	33	0	0
2042	2016-12-18 22:47:00.208+03	34	0	0
2043	2016-12-18 23:17:00.014+03	32	0	0
2044	2016-12-18 23:17:00.049+03	35	0	0
2045	2016-12-18 23:17:00.074+03	31	0	0
2046	2016-12-18 23:17:00.099+03	30	0	0
2047	2016-12-18 23:17:00.124+03	36	0	0
2048	2016-12-18 23:17:00.149+03	29	0	0
2049	2016-12-18 23:17:00.174+03	20	0	0
2050	2016-12-18 23:17:00.199+03	33	0	0
2051	2016-12-18 23:17:00.224+03	34	0	0
2052	2016-12-18 23:47:00.014+03	32	0	0
2053	2016-12-18 23:47:00.053+03	35	0	0
2054	2016-12-18 23:47:00.078+03	31	0	0
2055	2016-12-18 23:47:00.103+03	30	0	0
2056	2016-12-18 23:47:00.128+03	36	0	0
2057	2016-12-18 23:47:00.153+03	29	0	0
2058	2016-12-18 23:47:00.178+03	20	0	0
2059	2016-12-18 23:47:00.194+03	33	0	0
2060	2016-12-18 23:47:00.211+03	34	0	0
2061	2016-12-19 00:17:00.012+03	32	0	0
2062	2016-12-19 00:17:00.041+03	35	0	0
2063	2016-12-19 00:17:00.066+03	31	0	0
2064	2016-12-19 00:17:00.091+03	30	0	0
2065	2016-12-19 00:17:00.116+03	36	0	0
2066	2016-12-19 00:17:00.141+03	29	0	0
2067	2016-12-19 00:17:00.166+03	20	0	0
2068	2016-12-19 00:17:00.191+03	33	0	0
2069	2016-12-19 00:17:00.216+03	34	0	0
2070	2016-12-19 00:47:00.012+03	32	0	0
2071	2016-12-19 00:47:00.043+03	35	0	0
2072	2016-12-19 00:47:00.067+03	31	0	0
2073	2016-12-19 00:47:00.093+03	30	0	0
2074	2016-12-19 00:47:00.118+03	36	0	0
2075	2016-12-19 00:47:00.143+03	29	0	0
2076	2016-12-19 00:47:00.168+03	20	0	0
2077	2016-12-19 00:47:00.193+03	33	0	0
2078	2016-12-19 00:47:00.218+03	34	0	0
2079	2016-12-19 01:17:00.013+03	32	0	0
2080	2016-12-19 01:17:00.044+03	35	0	0
2081	2016-12-19 01:17:00.069+03	31	0	0
2082	2016-12-19 01:17:00.094+03	30	0	0
2083	2016-12-19 01:17:00.119+03	36	0	0
2084	2016-12-19 01:17:00.145+03	29	0	0
2085	2016-12-19 01:17:00.169+03	20	0	0
2086	2016-12-19 01:17:00.194+03	33	0	0
2087	2016-12-19 01:17:00.22+03	34	0	0
2088	2016-12-19 01:47:00.959+03	32	0	0
2089	2016-12-19 01:47:01.685+03	35	0	0
2090	2016-12-19 01:47:01.71+03	31	0	0
2091	2016-12-19 01:47:01.785+03	30	0	0
2092	2016-12-19 01:47:01.81+03	36	0	0
2093	2016-12-19 01:47:01.935+03	29	0	0
2094	2016-12-19 01:47:02.035+03	20	0	0
2095	2016-12-19 01:47:02.127+03	33	0	0
2096	2016-12-19 01:47:02.26+03	34	0	0
2097	2016-12-19 02:17:00.117+03	32	0	0
2098	2016-12-19 02:17:00.301+03	35	0	0
2099	2016-12-19 02:17:00.318+03	31	0	0
2100	2016-12-19 02:17:00.334+03	30	0	0
2101	2016-12-19 02:17:00.351+03	36	0	0
2102	2016-12-19 02:17:00.368+03	29	0	0
2103	2016-12-19 02:17:00.384+03	20	0	0
2104	2016-12-19 02:17:00.401+03	33	0	0
2105	2016-12-19 02:17:00.418+03	34	0	0
2106	2016-12-19 02:47:00.014+03	32	0	0
2107	2016-12-19 02:47:00.047+03	35	0	0
2108	2016-12-19 02:47:00.072+03	31	0	0
2109	2016-12-19 02:47:00.097+03	30	0	0
2110	2016-12-19 02:47:00.122+03	36	0	0
2111	2016-12-19 02:47:00.147+03	29	0	0
2112	2016-12-19 02:47:00.172+03	20	0	0
2113	2016-12-19 02:47:00.231+03	33	0	0
2114	2016-12-19 02:47:00.256+03	34	0	0
2115	2016-12-19 03:17:00.014+03	32	0	0
2116	2016-12-19 03:17:00.043+03	35	0	0
2117	2016-12-19 03:17:00.068+03	31	0	0
2118	2016-12-19 03:17:00.093+03	30	0	0
2119	2016-12-19 03:17:00.118+03	36	0	0
2120	2016-12-19 03:17:00.143+03	29	0	0
2121	2016-12-19 03:17:00.159+03	20	0	0
2122	2016-12-19 03:17:00.184+03	33	0	0
2123	2016-12-19 03:17:00.201+03	34	0	0
2124	2016-12-19 03:47:00.013+03	32	0	0
2125	2016-12-19 03:47:00.042+03	35	0	0
2126	2016-12-19 03:47:00.067+03	31	0	0
2127	2016-12-19 03:47:00.092+03	30	0	0
2128	2016-12-19 03:47:00.117+03	36	0	0
2129	2016-12-19 03:47:00.142+03	29	0	0
2130	2016-12-19 03:47:00.167+03	20	0	0
2131	2016-12-19 03:47:00.192+03	33	0	0
2132	2016-12-19 03:47:00.217+03	34	0	0
2133	2016-12-19 04:17:00.012+03	32	0	0
2134	2016-12-19 04:17:00.043+03	35	0	0
2135	2016-12-19 04:17:00.068+03	31	0	0
2136	2016-12-19 04:17:00.093+03	30	0	0
2137	2016-12-19 04:17:00.118+03	36	0	0
2138	2016-12-19 04:17:00.143+03	29	0	0
2139	2016-12-19 04:17:00.16+03	20	0	0
2140	2016-12-19 04:17:00.176+03	33	0	0
2141	2016-12-19 04:17:00.193+03	34	0	0
2142	2016-12-19 04:47:00.01+03	32	0	0
2143	2016-12-19 04:47:00.039+03	35	0	0
2144	2016-12-19 04:47:00.056+03	31	0	0
2145	2016-12-19 04:47:00.081+03	30	0	0
2146	2016-12-19 04:47:00.106+03	36	0	0
2147	2016-12-19 04:47:00.131+03	29	0	0
2148	2016-12-19 04:47:00.156+03	20	0	0
2149	2016-12-19 04:47:00.181+03	33	0	0
2150	2016-12-19 04:47:00.206+03	34	0	0
2151	2016-12-19 05:17:00.013+03	32	0	0
2152	2016-12-19 05:17:00.043+03	35	0	0
2153	2016-12-19 05:17:00.068+03	31	0	0
2154	2016-12-19 05:17:00.093+03	30	0	0
2155	2016-12-19 05:17:00.118+03	36	0	0
2156	2016-12-19 05:17:00.143+03	29	0	0
2157	2016-12-19 05:17:00.168+03	20	0	0
2158	2016-12-19 05:17:00.185+03	33	0	0
2159	2016-12-19 05:17:00.202+03	34	0	0
2160	2016-12-19 05:47:00.012+03	32	0	0
2161	2016-12-19 05:47:00.045+03	35	0	0
2162	2016-12-19 05:47:00.07+03	31	0	0
2163	2016-12-19 05:47:00.095+03	30	0	0
2164	2016-12-19 05:47:00.12+03	36	0	0
2165	2016-12-19 05:47:00.145+03	29	0	0
2166	2016-12-19 05:47:00.17+03	20	0	0
2167	2016-12-19 05:47:00.195+03	33	0	0
2168	2016-12-19 05:47:00.22+03	34	0	0
2169	2016-12-19 06:17:00.012+03	32	0	0
2170	2016-12-19 06:17:00.045+03	35	0	0
2171	2016-12-19 06:17:00.07+03	31	0	0
2172	2016-12-19 06:17:00.095+03	30	0	0
2173	2016-12-19 06:17:00.12+03	36	0	0
2174	2016-12-19 06:17:00.145+03	29	0	0
2175	2016-12-19 06:17:00.17+03	20	0	0
2176	2016-12-19 06:17:00.195+03	33	0	0
2177	2016-12-19 06:17:00.22+03	34	0	0
2178	2016-12-19 06:47:00.013+03	32	0	0
2179	2016-12-19 06:47:00.042+03	35	0	0
2180	2016-12-19 06:47:00.067+03	31	0	0
2181	2016-12-19 06:47:00.092+03	30	0	0
2182	2016-12-19 06:47:00.109+03	36	0	0
2183	2016-12-19 06:47:00.126+03	29	0	0
2184	2016-12-19 06:47:00.142+03	20	0	0
2185	2016-12-19 06:47:00.159+03	33	0	0
2186	2016-12-19 06:47:00.175+03	34	0	0
2187	2016-12-19 07:17:00.013+03	32	0	0
2188	2016-12-19 07:17:00.051+03	35	0	0
2189	2016-12-19 07:17:00.068+03	31	0	0
2190	2016-12-19 07:17:00.084+03	30	0	0
2191	2016-12-19 07:17:00.101+03	36	0	0
2192	2016-12-19 07:17:00.118+03	29	0	0
2193	2016-12-19 07:17:00.143+03	20	0	0
2194	2016-12-19 07:17:00.159+03	33	0	0
2195	2016-12-19 07:17:00.176+03	34	0	0
2196	2016-12-19 07:47:00.012+03	32	0	0
2197	2016-12-19 07:47:00.037+03	35	0	0
2198	2016-12-19 07:47:00.054+03	31	0	0
2199	2016-12-19 07:47:00.071+03	30	0	0
2200	2016-12-19 07:47:00.087+03	36	0	0
2201	2016-12-19 07:47:00.104+03	29	0	0
2202	2016-12-19 07:47:00.121+03	20	0	0
2203	2016-12-19 07:47:00.137+03	33	0	0
2204	2016-12-19 07:47:00.154+03	34	0	0
2205	2016-12-19 08:17:00.013+03	32	0	0
2206	2016-12-19 08:17:00.046+03	35	0	0
2207	2016-12-19 08:17:00.071+03	31	595312	1774
2208	2016-12-19 08:17:00.096+03	30	0	0
2209	2016-12-19 08:17:00.121+03	36	0	0
2210	2016-12-19 08:17:00.146+03	29	0	0
2211	2016-12-19 08:17:00.171+03	20	0	0
2212	2016-12-19 08:17:00.196+03	33	0	0
2213	2016-12-19 08:17:00.213+03	34	0	0
2214	2016-12-19 08:47:00.013+03	32	0	0
2215	2016-12-19 08:47:00.043+03	35	0	0
2216	2016-12-19 08:47:00.068+03	31	210680	2844
2217	2016-12-19 08:47:00.093+03	30	0	0
2218	2016-12-19 08:47:00.118+03	36	0	0
2219	2016-12-19 08:47:00.143+03	29	0	0
2220	2016-12-19 08:47:00.168+03	20	0	0
2221	2016-12-19 08:47:00.193+03	33	0	0
2222	2016-12-19 08:47:00.218+03	34	0	0
2223	2016-12-19 09:17:00.015+03	32	0	0
2224	2016-12-19 09:17:00.049+03	35	0	0
2225	2016-12-19 09:17:00.074+03	31	0	0
2226	2016-12-19 09:17:00.099+03	30	0	0
2227	2016-12-19 09:17:00.124+03	36	0	0
2228	2016-12-19 09:17:00.149+03	29	0	0
2229	2016-12-19 09:17:00.174+03	20	0	0
2230	2016-12-19 09:17:00.199+03	33	0	0
2231	2016-12-19 09:17:00.224+03	34	0	0
2232	2016-12-19 09:47:00.013+03	32	0	0
2233	2016-12-19 09:47:00.047+03	35	0	0
2234	2016-12-19 09:47:00.072+03	31	0	0
2235	2016-12-19 09:47:00.097+03	30	0	0
2236	2016-12-19 09:47:00.122+03	36	0	0
2237	2016-12-19 09:47:00.164+03	29	0	0
2238	2016-12-19 09:47:00.197+03	20	0	0
2239	2016-12-19 09:47:00.214+03	33	0	0
2240	2016-12-19 09:47:00.239+03	34	0	0
2241	2016-12-19 10:17:00.013+03	32	0	0
2242	2016-12-19 10:17:00.047+03	35	0	0
2243	2016-12-19 10:17:00.072+03	31	0	0
2244	2016-12-19 10:17:00.097+03	30	0	0
2245	2016-12-19 10:17:00.122+03	36	0	0
2246	2016-12-19 10:17:00.147+03	29	0	0
2247	2016-12-19 10:17:00.172+03	20	0	0
2248	2016-12-19 10:17:00.197+03	33	0	0
2249	2016-12-19 10:17:00.222+03	34	0	0
2250	2016-12-19 10:47:00.014+03	32	0	0
2251	2016-12-19 10:47:00.048+03	35	0	0
2252	2016-12-19 10:47:00.073+03	31	514280	47716
2253	2016-12-19 10:47:00.098+03	30	0	0
2254	2016-12-19 10:47:00.123+03	36	0	0
2255	2016-12-19 10:47:00.206+03	29	0	0
2256	2016-12-19 10:47:00.223+03	20	0	0
2257	2016-12-19 10:47:00.248+03	33	0	0
2258	2016-12-19 10:47:00.264+03	34	0	0
2259	2016-12-19 11:17:00.014+03	32	0	0
2260	2016-12-19 11:17:00.074+03	35	0	0
2261	2016-12-19 11:17:00.139+03	31	0	0
2262	2016-12-19 11:17:00.166+03	30	0	0
2263	2016-12-19 11:17:00.199+03	36	0	0
2264	2016-12-19 11:17:00.388+03	29	0	0
2265	2016-12-19 11:17:00.424+03	20	0	0
2266	2016-12-19 11:17:00.624+03	33	0	0
2267	2016-12-19 11:17:00.724+03	34	0	0
2268	2016-12-19 11:47:00.014+03	32	0	0
2269	2016-12-19 11:47:00.044+03	35	0	0
2270	2016-12-19 11:47:00.069+03	31	0	0
2271	2016-12-19 11:47:00.094+03	30	0	0
2272	2016-12-19 11:47:00.119+03	36	0	0
2273	2016-12-19 11:47:00.152+03	29	0	0
2274	2016-12-19 11:47:00.178+03	20	0	0
2275	2016-12-19 11:47:00.202+03	33	0	0
2276	2016-12-19 11:47:00.227+03	34	0	0
2277	2016-12-19 12:17:00.013+03	32	0	0
2278	2016-12-19 12:17:00.045+03	35	0	0
2279	2016-12-19 12:17:00.07+03	31	0	0
2280	2016-12-19 12:17:00.095+03	30	0	0
2281	2016-12-19 12:17:00.12+03	36	0	0
2282	2016-12-19 12:17:00.145+03	29	0	0
2283	2016-12-19 12:17:00.17+03	20	0	0
2284	2016-12-19 12:17:00.195+03	33	0	0
2285	2016-12-19 12:17:00.22+03	34	0	0
2286	2016-12-19 12:47:00.011+03	32	0	0
2287	2016-12-19 12:47:00.048+03	35	0	0
2288	2016-12-19 12:47:00.072+03	31	0	0
2289	2016-12-19 12:47:00.098+03	30	0	0
2290	2016-12-19 12:47:00.122+03	36	0	0
2291	2016-12-19 12:47:00.148+03	29	0	0
2292	2016-12-19 12:47:00.172+03	20	0	0
2293	2016-12-19 12:47:00.197+03	33	0	0
2294	2016-12-19 12:47:00.222+03	34	0	0
2295	2016-12-19 13:17:00.013+03	32	0	0
2296	2016-12-19 13:17:00.065+03	35	0	0
2297	2016-12-19 13:17:00.09+03	31	0	0
2298	2016-12-19 13:17:00.115+03	30	0	0
2299	2016-12-19 13:17:00.14+03	36	0	0
2300	2016-12-19 13:17:00.165+03	29	0	0
2301	2016-12-19 13:17:00.19+03	20	0	0
2302	2016-12-19 13:17:00.223+03	33	0	0
2303	2016-12-19 13:17:00.248+03	34	0	0
2304	2016-12-19 13:47:00.013+03	32	0	0
2305	2016-12-19 13:47:00.042+03	35	0	0
2306	2016-12-19 13:47:00.067+03	31	0	0
2307	2016-12-19 13:47:00.092+03	30	0	0
2308	2016-12-19 13:47:00.126+03	36	0	0
2309	2016-12-19 13:47:00.151+03	29	0	0
2310	2016-12-19 13:47:00.177+03	20	0	0
2311	2016-12-19 13:47:00.202+03	33	0	0
2312	2016-12-19 13:47:00.218+03	34	0	0
2313	2016-12-19 14:17:00.014+03	32	0	0
2314	2016-12-19 14:17:00.057+03	35	0	0
2315	2016-12-19 14:17:00.082+03	31	0	0
2316	2016-12-19 14:17:00.15+03	30	0	0
2317	2016-12-19 14:17:00.19+03	36	0	0
2318	2016-12-19 14:17:00.216+03	29	0	0
2319	2016-12-19 14:17:00.241+03	20	0	0
2320	2016-12-19 14:17:00.266+03	33	0	0
2321	2016-12-19 14:17:00.282+03	34	0	0
2322	2016-12-19 14:47:00.013+03	32	0	0
2323	2016-12-19 14:47:00.041+03	35	0	0
2324	2016-12-19 14:47:00.066+03	31	0	0
2325	2016-12-19 14:47:00.091+03	30	0	0
2326	2016-12-19 14:47:00.116+03	36	0	0
2327	2016-12-19 14:47:00.141+03	29	0	0
2328	2016-12-19 14:47:00.166+03	20	0	0
2329	2016-12-19 14:47:00.182+03	33	0	0
2330	2016-12-19 14:47:00.199+03	34	0	0
2331	2016-12-19 15:17:00.014+03	32	0	0
2332	2016-12-19 15:17:00.054+03	35	0	0
2333	2016-12-19 15:17:00.079+03	31	0	0
2334	2016-12-19 15:17:00.104+03	30	0	0
2335	2016-12-19 15:17:00.137+03	36	0	0
2336	2016-12-19 15:17:00.163+03	29	0	0
2337	2016-12-19 15:17:00.187+03	20	0	0
2338	2016-12-19 15:17:00.213+03	33	0	0
2339	2016-12-19 15:17:00.237+03	34	0	0
2340	2016-12-19 15:47:00.012+03	32	0	0
2341	2016-12-19 15:47:00.048+03	35	0	0
2342	2016-12-19 15:47:00.072+03	31	0	0
2343	2016-12-19 15:47:00.097+03	30	0	0
2344	2016-12-19 15:47:00.122+03	36	0	0
2345	2016-12-19 15:47:00.148+03	29	0	0
2346	2016-12-19 15:47:00.173+03	20	0	0
2347	2016-12-19 15:47:00.189+03	33	0	0
2348	2016-12-19 15:47:00.206+03	34	0	0
2349	2016-12-19 16:17:00.013+03	32	0	0
2350	2016-12-19 16:17:00.043+03	35	0	0
2351	2016-12-19 16:17:00.068+03	31	0	0
2352	2016-12-19 16:17:00.094+03	30	0	0
2353	2016-12-19 16:17:00.118+03	36	0	0
2354	2016-12-19 16:17:00.143+03	29	954722	5804
2355	2016-12-19 16:17:00.16+03	20	0	0
2356	2016-12-19 16:17:00.177+03	33	0	0
2357	2016-12-19 16:17:00.193+03	34	0	0
2358	2016-12-19 16:47:00.013+03	32	0	0
2359	2016-12-19 16:47:00.042+03	35	0	0
2360	2016-12-19 16:47:00.067+03	31	0	0
2361	2016-12-19 16:47:00.093+03	30	0	0
2362	2016-12-19 16:47:00.117+03	36	0	0
2363	2016-12-19 16:47:00.142+03	29	0	0
2364	2016-12-19 16:47:00.167+03	20	0	0
2365	2016-12-19 16:47:00.192+03	33	0	0
2366	2016-12-19 16:47:00.209+03	34	0	0
2367	2016-12-19 17:17:00.144+03	32	0	0
2368	2016-12-19 17:17:00.178+03	35	0	0
2369	2016-12-19 17:17:00.203+03	31	0	0
2370	2016-12-19 17:17:00.229+03	30	0	0
2371	2016-12-19 17:17:00.253+03	36	0	0
2372	2016-12-19 17:17:00.279+03	29	0	0
2373	2016-12-19 17:17:00.303+03	20	0	0
2374	2016-12-19 17:17:00.328+03	33	0	0
2375	2016-12-19 17:17:00.353+03	34	0	0
2376	2016-12-19 17:47:00.013+03	32	0	0
2377	2016-12-19 17:47:00.07+03	35	0	0
2378	2016-12-19 17:47:00.095+03	31	0	0
2379	2016-12-19 17:47:00.12+03	30	0	0
2380	2016-12-19 17:47:00.145+03	36	0	0
2381	2016-12-19 17:47:00.17+03	29	0	0
2382	2016-12-19 17:47:00.195+03	20	0	0
2383	2016-12-19 17:47:00.22+03	33	0	0
2384	2016-12-19 17:47:00.236+03	34	0	0
2385	2016-12-19 18:17:00.014+03	32	0	0
2386	2016-12-19 18:17:00.048+03	35	0	0
2387	2016-12-19 18:17:00.072+03	31	0	0
2388	2016-12-19 18:17:00.097+03	30	0	0
2389	2016-12-19 18:17:00.123+03	36	0	0
2390	2016-12-19 18:17:00.148+03	29	0	0
2391	2016-12-19 18:17:00.173+03	20	0	0
2392	2016-12-19 18:17:00.197+03	33	0	0
2393	2016-12-19 18:17:00.222+03	34	0	0
2394	2016-12-19 18:47:00.013+03	32	0	0
2395	2016-12-19 18:47:00.045+03	35	0	0
2396	2016-12-19 18:47:00.07+03	31	0	0
2397	2016-12-19 18:47:00.095+03	30	0	0
2398	2016-12-19 18:47:00.12+03	36	0	0
2399	2016-12-19 18:47:00.145+03	29	0	0
2400	2016-12-19 18:47:00.17+03	20	0	0
2401	2016-12-19 18:47:00.195+03	33	0	0
2402	2016-12-19 18:47:00.22+03	34	0	0
2403	2016-12-19 19:17:00.018+03	32	0	0
2404	2016-12-19 19:17:00.036+03	35	0	0
2405	2016-12-19 19:17:00.052+03	31	0	0
2406	2016-12-19 19:17:00.077+03	30	0	0
2407	2016-12-19 19:17:00.094+03	36	357536	7630
2408	2016-12-19 19:17:00.111+03	29	0	0
2409	2016-12-19 19:17:00.128+03	20	0	0
2410	2016-12-19 19:17:00.144+03	33	0	0
2411	2016-12-19 19:17:00.169+03	34	0	0
2412	2016-12-19 19:47:00.013+03	32	0	0
2413	2016-12-19 19:47:00.083+03	35	0	0
2414	2016-12-19 19:47:00.107+03	31	0	0
2415	2016-12-19 19:47:00.169+03	30	0	0
2416	2016-12-19 19:47:00.19+03	36	129872	1298
2417	2016-12-19 19:47:00.206+03	29	0	0
2418	2016-12-19 19:47:00.223+03	20	0	0
2419	2016-12-19 19:47:00.24+03	33	0	0
2420	2016-12-19 19:47:00.257+03	34	0	0
2421	2016-12-19 20:17:00.014+03	32	0	0
2422	2016-12-19 20:17:00.048+03	35	0	0
2423	2016-12-19 20:17:00.073+03	31	0	0
2424	2016-12-19 20:17:00.098+03	30	0	0
2425	2016-12-19 20:17:00.123+03	36	0	0
2426	2016-12-19 20:17:00.156+03	29	0	0
2427	2016-12-19 20:17:00.173+03	20	0	0
2428	2016-12-19 20:17:00.189+03	33	0	0
2429	2016-12-19 20:17:00.206+03	34	0	0
2430	2016-12-19 20:47:00.013+03	32	0	0
2431	2016-12-19 20:47:00.048+03	35	0	0
2432	2016-12-19 20:47:00.073+03	31	0	0
2433	2016-12-19 20:47:00.09+03	30	0	0
2434	2016-12-19 20:47:00.107+03	36	0	0
2435	2016-12-19 20:47:00.123+03	29	0	0
2436	2016-12-19 20:47:00.148+03	20	0	0
2437	2016-12-19 20:47:00.165+03	33	0	0
2438	2016-12-19 20:47:00.182+03	34	0	0
2439	2016-12-19 21:17:00.014+03	32	0	0
2440	2016-12-19 21:17:00.048+03	35	0	0
2441	2016-12-19 21:17:00.073+03	31	0	0
2442	2016-12-19 21:17:00.098+03	30	0	0
2443	2016-12-19 21:17:00.123+03	36	0	0
2444	2016-12-19 21:17:00.148+03	29	752590	20780
2445	2016-12-19 21:17:00.173+03	20	0	0
2446	2016-12-19 21:17:00.189+03	33	0	0
2447	2016-12-19 21:17:00.206+03	34	0	0
2448	2016-12-19 21:47:00.013+03	32	0	0
2449	2016-12-19 21:47:00.048+03	35	0	0
2450	2016-12-19 21:47:00.073+03	31	0	0
2451	2016-12-19 21:47:00.098+03	30	0	0
2452	2016-12-19 21:47:00.123+03	36	0	0
2453	2016-12-19 21:47:00.148+03	29	0	0
2454	2016-12-19 21:47:00.173+03	20	0	0
2455	2016-12-19 21:47:00.198+03	33	0	0
2456	2016-12-19 21:47:00.223+03	34	0	0
2457	2016-12-19 22:17:00.014+03	32	0	0
2458	2016-12-19 22:17:00.047+03	35	0	0
2459	2016-12-19 22:17:00.072+03	31	0	0
2460	2016-12-19 22:17:00.097+03	30	0	0
2461	2016-12-19 22:17:00.122+03	36	0	0
2462	2016-12-19 22:17:00.147+03	29	553910	9874
2463	2016-12-19 22:17:00.172+03	20	0	0
2464	2016-12-19 22:17:00.189+03	33	0	0
2465	2016-12-19 22:17:00.205+03	34	0	0
2466	2016-12-19 22:47:00.014+03	32	0	0
2467	2016-12-19 22:47:00.051+03	35	0	0
2468	2016-12-19 22:47:00.076+03	31	0	0
2469	2016-12-19 22:47:00.101+03	30	0	0
2470	2016-12-19 22:47:00.117+03	36	0	0
2471	2016-12-19 22:47:00.134+03	29	0	0
2472	2016-12-19 22:47:00.151+03	20	0	0
2473	2016-12-19 22:47:00.167+03	33	0	0
2474	2016-12-19 22:47:00.184+03	34	0	0
2475	2016-12-19 23:17:00.013+03	32	0	0
2476	2016-12-19 23:17:00.042+03	35	0	0
2477	2016-12-19 23:17:00.067+03	31	0	0
2478	2016-12-19 23:17:00.092+03	30	0	0
2479	2016-12-19 23:17:00.117+03	36	0	0
2480	2016-12-19 23:17:00.142+03	29	0	0
2481	2016-12-19 23:17:00.167+03	20	0	0
2482	2016-12-19 23:17:00.192+03	33	0	0
2483	2016-12-19 23:17:00.208+03	34	0	0
2484	2016-12-19 23:47:00.012+03	32	0	0
2485	2016-12-19 23:47:00.047+03	35	0	0
2486	2016-12-19 23:47:00.072+03	31	0	0
2487	2016-12-19 23:47:00.097+03	30	0	0
2488	2016-12-19 23:47:00.113+03	36	61344	1288
2489	2016-12-19 23:47:00.13+03	29	0	0
2490	2016-12-19 23:47:00.155+03	20	0	0
2491	2016-12-19 23:47:00.172+03	33	0	0
2492	2016-12-19 23:47:00.197+03	34	0	0
2493	2016-12-20 00:17:00.013+03	32	0	0
2494	2016-12-20 00:17:00.044+03	35	0	0
2495	2016-12-20 00:17:00.069+03	31	0	0
2496	2016-12-20 00:17:00.094+03	30	0	0
2497	2016-12-20 00:17:00.119+03	36	0	0
2498	2016-12-20 00:17:00.144+03	29	0	0
2499	2016-12-20 00:17:00.169+03	20	0	0
2500	2016-12-20 00:17:00.194+03	33	0	0
2501	2016-12-20 00:17:00.21+03	34	0	0
2502	2016-12-20 00:47:00.012+03	32	0	0
2503	2016-12-20 00:47:00.044+03	35	0	0
2504	2016-12-20 00:47:00.069+03	31	0	0
2505	2016-12-20 00:47:00.095+03	30	0	0
2506	2016-12-20 00:47:00.12+03	36	0	0
2507	2016-12-20 00:47:00.137+03	29	0	0
2508	2016-12-20 00:47:00.154+03	20	0	0
2509	2016-12-20 00:47:00.17+03	33	0	0
2510	2016-12-20 00:47:00.187+03	34	0	0
2511	2016-12-20 01:17:00.013+03	32	0	0
2512	2016-12-20 01:17:00.048+03	35	0	0
2513	2016-12-20 01:17:00.106+03	31	0	0
2514	2016-12-20 01:17:00.131+03	30	0	0
2515	2016-12-20 01:17:00.156+03	36	0	0
2516	2016-12-20 01:17:00.181+03	29	0	0
2517	2016-12-20 01:17:00.206+03	20	0	0
2518	2016-12-20 01:17:00.231+03	33	0	0
2519	2016-12-20 01:17:00.256+03	34	0	0
2520	2016-12-20 01:47:00.046+03	32	0	0
2521	2016-12-20 01:47:00.121+03	35	0	0
2522	2016-12-20 01:47:00.138+03	31	0	0
2523	2016-12-20 01:47:00.155+03	30	0	0
2524	2016-12-20 01:47:00.171+03	36	0	0
2525	2016-12-20 01:47:00.206+03	29	0	0
2526	2016-12-20 01:47:00.223+03	20	0	0
2527	2016-12-20 01:47:00.239+03	33	0	0
2528	2016-12-20 01:47:00.256+03	34	0	0
2529	2016-12-20 02:17:00.418+03	32	0	0
2530	2016-12-20 02:17:01.014+03	35	0	0
2531	2016-12-20 02:17:01.056+03	31	0	0
2532	2016-12-20 02:17:01.089+03	30	0	0
2533	2016-12-20 02:17:01.131+03	36	0	0
2534	2016-12-20 02:17:01.173+03	29	0	0
2535	2016-12-20 02:17:01.197+03	20	0	0
2536	2016-12-20 02:17:01.222+03	33	0	0
2537	2016-12-20 02:17:01.256+03	34	0	0
2538	2016-12-20 02:47:00.016+03	32	0	0
2539	2016-12-20 02:47:00.051+03	35	0	0
2540	2016-12-20 02:47:00.076+03	31	0	0
2541	2016-12-20 02:47:00.101+03	30	0	0
2542	2016-12-20 02:47:00.126+03	36	0	0
2543	2016-12-20 02:47:00.151+03	29	0	0
2544	2016-12-20 02:47:00.167+03	20	0	0
2545	2016-12-20 02:47:00.184+03	33	0	0
2546	2016-12-20 02:47:00.201+03	34	0	0
2547	2016-12-20 03:17:00.015+03	32	0	0
2548	2016-12-20 03:17:00.048+03	35	0	0
2549	2016-12-20 03:17:00.073+03	31	0	0
2550	2016-12-20 03:17:00.098+03	30	0	0
2551	2016-12-20 03:17:00.123+03	36	0	0
2552	2016-12-20 03:17:00.148+03	29	0	0
2553	2016-12-20 03:17:00.181+03	20	0	0
2554	2016-12-20 03:17:00.206+03	33	0	0
2555	2016-12-20 03:17:00.231+03	34	0	0
2556	2016-12-20 03:47:00.012+03	32	0	0
2557	2016-12-20 03:47:00.041+03	35	0	0
2558	2016-12-20 03:47:00.066+03	31	0	0
2559	2016-12-20 03:47:00.091+03	30	0	0
2560	2016-12-20 03:47:00.116+03	36	0	0
2561	2016-12-20 03:47:00.141+03	29	0	0
2562	2016-12-20 03:47:00.166+03	20	0	0
2563	2016-12-20 03:47:00.191+03	33	0	0
2564	2016-12-20 03:47:00.216+03	34	0	0
2565	2016-12-20 04:17:00.011+03	32	0	0
2566	2016-12-20 04:17:00.041+03	35	0	0
2567	2016-12-20 04:17:00.066+03	31	0	0
2568	2016-12-20 04:17:00.091+03	30	0	0
2569	2016-12-20 04:17:00.116+03	36	0	0
2570	2016-12-20 04:17:00.141+03	29	0	0
2571	2016-12-20 04:17:00.166+03	20	0	0
2572	2016-12-20 04:17:00.191+03	33	0	0
2573	2016-12-20 04:17:00.216+03	34	0	0
2574	2016-12-20 04:47:00.014+03	32	0	0
2575	2016-12-20 04:47:00.081+03	35	0	0
2576	2016-12-20 04:47:00.106+03	31	0	0
2577	2016-12-20 04:47:00.131+03	30	0	0
2578	2016-12-20 04:47:00.156+03	36	0	0
2579	2016-12-20 04:47:00.173+03	29	0	0
2580	2016-12-20 04:47:00.19+03	20	0	0
2581	2016-12-20 04:47:00.206+03	33	0	0
2582	2016-12-20 04:47:00.224+03	34	0	0
2583	2016-12-20 05:17:00.013+03	32	0	0
2584	2016-12-20 05:17:00.055+03	35	0	0
2585	2016-12-20 05:17:00.08+03	31	0	0
2586	2016-12-20 05:17:00.105+03	30	0	0
2587	2016-12-20 05:17:00.122+03	36	0	0
2588	2016-12-20 05:17:00.147+03	29	0	0
2589	2016-12-20 05:17:00.163+03	20	0	0
2590	2016-12-20 05:17:00.18+03	33	0	0
2591	2016-12-20 05:17:00.197+03	34	0	0
2592	2016-12-20 05:47:00.014+03	32	0	0
2593	2016-12-20 05:47:00.046+03	35	0	0
2594	2016-12-20 05:47:00.071+03	31	0	0
2595	2016-12-20 05:47:00.104+03	30	0	0
2596	2016-12-20 05:47:00.129+03	36	0	0
2597	2016-12-20 05:47:00.154+03	29	0	0
2598	2016-12-20 05:47:00.179+03	20	0	0
2599	2016-12-20 05:47:00.196+03	33	0	0
2600	2016-12-20 05:47:00.213+03	34	0	0
2601	2016-12-20 06:17:00.013+03	32	0	0
2602	2016-12-20 06:17:00.044+03	35	0	0
2603	2016-12-20 06:17:00.069+03	31	0	0
2604	2016-12-20 06:17:00.094+03	30	0	0
2605	2016-12-20 06:17:00.119+03	36	0	0
2606	2016-12-20 06:17:00.135+03	29	0	0
2607	2016-12-20 06:17:00.152+03	20	0	0
2608	2016-12-20 06:17:00.169+03	33	0	0
2609	2016-12-20 06:17:00.185+03	34	0	0
2610	2016-12-20 06:47:00.013+03	32	0	0
2611	2016-12-20 06:47:00.06+03	35	0	0
2612	2016-12-20 06:47:00.095+03	31	0	0
2613	2016-12-20 06:47:00.12+03	30	0	0
2614	2016-12-20 06:47:00.145+03	36	0	0
2615	2016-12-20 06:47:00.17+03	29	0	0
2616	2016-12-20 06:47:00.195+03	20	0	0
2617	2016-12-20 06:47:00.22+03	33	0	0
2618	2016-12-20 06:47:00.245+03	34	0	0
2619	2016-12-20 07:17:00.014+03	32	0	0
2620	2016-12-20 07:17:00.047+03	35	0	0
2621	2016-12-20 07:17:00.072+03	31	0	0
2622	2016-12-20 07:17:00.097+03	30	0	0
2623	2016-12-20 07:17:00.122+03	36	0	0
2624	2016-12-20 07:17:00.138+03	29	0	0
2625	2016-12-20 07:17:00.155+03	20	0	0
2626	2016-12-20 07:17:00.172+03	33	0	0
2627	2016-12-20 07:17:00.197+03	34	0	0
2628	2016-12-20 07:47:00.013+03	32	0	0
2629	2016-12-20 07:47:00.044+03	35	0	0
2630	2016-12-20 07:47:00.069+03	31	0	0
2631	2016-12-20 07:47:00.094+03	30	0	0
2632	2016-12-20 07:47:00.119+03	36	0	0
2633	2016-12-20 07:47:00.144+03	29	73820	1150
2634	2016-12-20 07:47:00.169+03	20	0	0
2635	2016-12-20 07:47:00.194+03	33	0	0
2636	2016-12-20 07:47:00.211+03	34	0	0
2637	2016-12-20 08:17:00.014+03	32	0	0
2638	2016-12-20 08:17:00.046+03	35	0	0
2639	2016-12-20 08:17:00.071+03	31	0	0
2640	2016-12-20 08:17:00.096+03	30	0	0
2641	2016-12-20 08:17:00.155+03	36	0	0
2642	2016-12-20 08:17:00.19+03	29	0	0
2643	2016-12-20 08:17:00.207+03	20	0	0
2644	2016-12-20 08:17:00.223+03	33	0	0
2645	2016-12-20 08:17:00.24+03	34	0	0
2646	2016-12-20 08:47:00.015+03	32	0	0
2647	2016-12-20 08:47:00.05+03	35	0	0
2648	2016-12-20 08:47:00.075+03	31	0	0
2649	2016-12-20 08:47:00.125+03	30	0	0
2650	2016-12-20 08:47:00.15+03	36	0	0
2651	2016-12-20 08:47:00.175+03	29	0	0
2652	2016-12-20 08:47:00.2+03	20	0	0
2653	2016-12-20 08:47:00.217+03	33	0	0
2654	2016-12-20 08:47:00.233+03	34	0	0
2655	2016-12-20 09:17:00.007+03	32	0	0
2656	2016-12-20 09:17:00.026+03	35	0	0
2657	2016-12-20 09:17:00.043+03	31	0	0
2658	2016-12-20 09:17:00.059+03	30	0	0
2659	2016-12-20 09:17:00.076+03	36	81508	1432
2660	2016-12-20 09:17:00.093+03	29	0	0
2661	2016-12-20 09:17:00.109+03	20	0	0
2662	2016-12-20 09:17:00.126+03	33	0	0
2663	2016-12-20 09:17:00.143+03	34	0	0
2664	2016-12-20 09:47:00.013+03	32	0	0
2665	2016-12-20 09:47:00.031+03	35	0	0
2666	2016-12-20 09:47:00.048+03	31	0	0
2667	2016-12-20 09:47:00.065+03	30	0	0
2668	2016-12-20 09:47:00.081+03	36	0	0
2669	2016-12-20 09:47:00.098+03	29	0	0
2670	2016-12-20 09:47:00.115+03	20	0	0
2671	2016-12-20 09:47:00.131+03	33	0	0
2672	2016-12-20 09:47:00.148+03	34	0	0
2673	2016-12-20 10:17:00.012+03	32	0	0
2674	2016-12-20 10:17:00.039+03	35	0	0
2675	2016-12-20 10:17:00.056+03	31	0	0
2676	2016-12-20 10:17:00.072+03	30	0	0
2677	2016-12-20 10:17:00.089+03	36	0	0
2678	2016-12-20 10:17:00.106+03	29	0	0
2679	2016-12-20 10:17:00.122+03	20	0	0
2680	2016-12-20 10:17:00.147+03	33	0	0
2681	2016-12-20 10:17:00.172+03	34	0	0
2682	2016-12-20 10:47:00.014+03	32	0	0
2683	2016-12-20 10:47:00.049+03	35	0	0
2684	2016-12-20 10:47:00.074+03	31	0	0
2685	2016-12-20 10:47:00.099+03	30	0	0
2686	2016-12-20 10:47:00.124+03	36	0	0
2687	2016-12-20 10:47:00.149+03	29	0	0
2688	2016-12-20 10:47:00.174+03	20	0	0
2689	2016-12-20 10:47:00.199+03	33	0	0
2690	2016-12-20 10:47:00.224+03	34	0	0
2691	2016-12-20 11:17:00.013+03	32	0	0
2692	2016-12-20 11:17:00.036+03	35	0	0
2693	2016-12-20 11:17:00.053+03	31	0	0
2694	2016-12-20 11:17:00.07+03	30	0	0
2695	2016-12-20 11:17:00.086+03	36	0	0
2696	2016-12-20 11:17:00.103+03	29	0	0
2697	2016-12-20 11:17:00.12+03	20	0	0
2698	2016-12-20 11:17:00.136+03	33	0	0
2699	2016-12-20 11:17:00.153+03	34	0	0
3011	2016-12-21 16:21:00.217+03	36	0	0
3012	2016-12-21 16:21:00.267+03	37	0	0
3013	2016-12-21 16:21:00.284+03	29	0	0
3014	2016-12-21 16:21:00.301+03	20	0	0
3156	2016-12-22 01:21:00.013+03	24	0	0
3157	2016-12-22 01:21:00.057+03	31	0	0
3158	2016-12-22 01:21:00.082+03	30	0	0
3159	2016-12-22 01:21:00.107+03	36	0	0
3160	2016-12-22 01:21:00.132+03	37	0	0
3161	2016-12-22 01:21:00.157+03	29	0	0
3162	2016-12-22 01:21:00.182+03	20	0	0
3163	2016-12-22 01:21:00.207+03	32	0	0
3164	2016-12-22 01:21:00.223+03	38	0	0
3165	2016-12-22 01:51:00.058+03	24	0	0
3166	2016-12-22 01:51:00.195+03	31	0	0
3167	2016-12-22 01:51:00.237+03	30	0	0
3168	2016-12-22 01:51:00.262+03	36	0	0
3169	2016-12-22 01:51:00.312+03	37	0	0
3170	2016-12-22 01:51:00.329+03	29	0	0
3171	2016-12-22 01:51:00.345+03	20	0	0
3172	2016-12-22 01:51:00.37+03	32	0	0
3173	2016-12-22 01:51:00.387+03	38	0	0
3174	2016-12-22 02:21:00.598+03	24	0	0
3175	2016-12-22 02:21:01.244+03	31	0	0
3176	2016-12-22 02:21:01.285+03	30	0	0
3177	2016-12-22 02:21:01.318+03	36	0	0
3178	2016-12-22 02:21:01.343+03	37	0	0
3179	2016-12-22 02:21:01.368+03	29	0	0
3180	2016-12-22 02:21:01.402+03	20	0	0
3181	2016-12-22 02:21:01.444+03	32	0	0
3182	2016-12-22 02:21:01.468+03	38	0	0
3183	2016-12-22 02:51:00.013+03	24	0	0
3184	2016-12-22 02:51:00.045+03	31	0	0
3185	2016-12-22 02:51:00.07+03	30	0	0
3186	2016-12-22 02:51:00.089+03	36	0	0
3187	2016-12-22 02:51:00.114+03	37	0	0
3188	2016-12-22 02:51:00.139+03	29	0	0
3189	2016-12-22 02:51:00.164+03	20	0	0
3190	2016-12-22 02:51:00.189+03	32	0	0
3191	2016-12-22 02:51:00.214+03	38	0	0
3201	2016-12-22 03:51:00.015+03	24	0	0
3202	2016-12-22 03:51:00.047+03	31	0	0
3203	2016-12-22 03:51:00.072+03	30	0	0
3204	2016-12-22 03:51:00.097+03	36	0	0
3205	2016-12-22 03:51:00.122+03	37	0	0
3206	2016-12-22 03:51:00.147+03	29	0	0
3207	2016-12-22 03:51:00.172+03	20	0	0
3208	2016-12-22 03:51:00.189+03	32	0	0
3209	2016-12-22 03:51:00.206+03	38	0	0
3219	2016-12-22 04:51:00.029+03	24	0	0
3220	2016-12-22 04:51:00.085+03	31	0	0
3221	2016-12-22 04:51:00.11+03	30	0	0
3222	2016-12-22 04:51:00.135+03	36	0	0
3223	2016-12-22 04:51:00.16+03	37	0	0
3224	2016-12-22 04:51:00.185+03	29	0	0
3225	2016-12-22 04:51:00.202+03	20	0	0
3226	2016-12-22 04:51:00.219+03	32	0	0
3227	2016-12-22 04:51:00.244+03	38	0	0
3237	2016-12-22 05:51:00.107+03	24	0	0
3238	2016-12-22 05:51:00.282+03	31	0	0
3239	2016-12-22 05:51:00.307+03	30	0	0
3240	2016-12-22 05:51:00.332+03	36	0	0
3241	2016-12-22 05:51:00.348+03	37	0	0
3242	2016-12-22 05:51:00.365+03	29	0	0
3243	2016-12-22 05:51:00.382+03	20	0	0
3244	2016-12-22 05:51:00.398+03	32	0	0
3245	2016-12-22 05:51:00.415+03	38	80098	1732
3246	2016-12-22 06:21:00.014+03	24	0	0
3247	2016-12-22 06:21:00.053+03	31	0	0
3248	2016-12-22 06:21:00.078+03	30	0	0
3249	2016-12-22 06:21:00.103+03	36	0	0
3250	2016-12-22 06:21:00.128+03	37	0	0
3251	2016-12-22 06:21:00.153+03	29	0	0
3252	2016-12-22 06:21:00.188+03	20	0	0
3253	2016-12-22 06:21:00.22+03	32	0	0
3254	2016-12-22 06:21:00.245+03	38	63428	1440
3255	2016-12-22 06:51:00.017+03	24	0	0
3256	2016-12-22 06:51:01.23+03	31	0	0
3257	2016-12-22 06:51:01.246+03	30	0	0
3258	2016-12-22 06:51:01.263+03	36	0	0
3259	2016-12-22 06:51:01.305+03	37	0	0
3260	2016-12-22 06:51:01.33+03	29	0	0
3261	2016-12-22 06:51:01.355+03	20	0	0
3262	2016-12-22 06:51:01.38+03	32	0	0
3338	2016-12-22 11:21:00.355+03	30	0	0
3339	2016-12-22 11:21:00.372+03	36	0	0
3340	2016-12-22 11:21:00.389+03	37	0	0
3341	2016-12-22 11:21:00.405+03	29	0	0
3342	2016-12-22 11:21:00.422+03	20	0	0
3343	2016-12-22 11:21:00.439+03	32	0	0
3344	2016-12-22 11:21:00.455+03	38	0	0
3345	2016-12-22 11:51:00.014+03	24	0	0
3346	2016-12-22 11:51:00.039+03	31	0	0
3347	2016-12-22 11:51:00.055+03	30	0	0
3348	2016-12-22 11:51:00.089+03	36	0	0
3349	2016-12-22 11:51:00.114+03	37	0	0
3350	2016-12-22 11:51:00.139+03	29	0	0
3351	2016-12-22 11:51:00.173+03	20	0	0
3352	2016-12-22 11:51:00.205+03	32	0	0
3353	2016-12-22 11:51:00.23+03	38	0	0
3354	2016-12-22 12:21:00.23+03	24	0	0
3355	2016-12-22 12:21:00.268+03	31	0	0
3356	2016-12-22 12:21:00.309+03	30	0	0
3357	2016-12-22 12:21:00.351+03	36	0	0
3358	2016-12-22 12:21:00.393+03	37	0	0
3359	2016-12-22 12:21:00.443+03	29	0	0
3360	2016-12-22 12:21:00.485+03	20	0	0
3361	2016-12-22 12:21:00.526+03	32	0	0
3362	2016-12-22 12:21:00.559+03	38	0	0
3363	2016-12-22 12:51:00.014+03	24	0	0
3364	2016-12-22 12:51:00.054+03	31	0	0
3365	2016-12-22 12:51:00.079+03	30	0	0
3366	2016-12-22 12:51:00.104+03	36	0	0
3367	2016-12-22 12:51:00.129+03	37	0	0
3368	2016-12-22 12:51:00.154+03	29	0	0
3369	2016-12-22 12:51:00.179+03	20	0	0
3370	2016-12-22 12:51:00.204+03	32	0	0
3371	2016-12-22 12:51:00.229+03	38	0	0
3372	2016-12-22 13:21:00.011+03	24	0	0
3373	2016-12-22 13:21:00.045+03	31	0	0
3374	2016-12-22 13:21:00.061+03	30	0	0
3375	2016-12-22 13:21:00.078+03	36	0	0
3376	2016-12-22 13:21:00.095+03	37	0	0
3377	2016-12-22 13:21:00.111+03	29	0	0
3378	2016-12-22 13:21:00.128+03	20	0	0
3379	2016-12-22 13:21:00.145+03	32	0	0
3380	2016-12-22 13:21:00.161+03	38	0	0
3381	2016-12-22 13:51:00.012+03	24	0	0
3382	2016-12-22 13:51:00.241+03	31	0	0
3383	2016-12-22 13:51:00.257+03	30	0	0
3384	2016-12-22 13:51:00.274+03	36	0	0
3385	2016-12-22 13:51:00.291+03	37	0	0
3386	2016-12-22 13:51:00.308+03	29	0	0
3387	2016-12-22 13:51:00.324+03	20	0	0
3388	2016-12-22 13:51:00.341+03	32	0	0
3389	2016-12-22 13:51:00.358+03	38	0	0
3390	2016-12-22 14:21:00.01+03	24	0	0
3391	2016-12-22 14:21:00.028+03	31	0	0
3392	2016-12-22 14:21:00.045+03	30	0	0
3393	2016-12-22 14:21:00.062+03	36	0	0
3394	2016-12-22 14:21:00.078+03	37	0	0
3395	2016-12-22 14:21:00.095+03	29	610000	4444
3396	2016-12-22 14:21:00.112+03	20	0	0
3397	2016-12-22 14:21:00.128+03	32	0	0
3398	2016-12-22 14:21:00.145+03	38	804	1226
3399	2016-12-22 14:51:00.129+03	24	0	0
3400	2016-12-22 14:51:00.308+03	31	0	0
3401	2016-12-22 14:51:00.358+03	30	0	0
3402	2016-12-22 14:51:00.376+03	36	0	0
3403	2016-12-22 14:51:00.401+03	37	0	0
3404	2016-12-22 14:51:00.426+03	29	20630	288
3405	2016-12-22 14:51:00.451+03	20	0	0
3406	2016-12-22 14:51:00.476+03	32	0	0
3407	2016-12-22 14:51:00.501+03	38	0	0
3408	2016-12-22 15:21:00.012+03	24	0	0
3409	2016-12-22 15:21:00.034+03	31	0	0
3410	2016-12-22 15:21:00.05+03	30	0	0
3411	2016-12-22 15:21:00.067+03	36	0	0
3412	2016-12-22 15:21:00.084+03	37	0	0
3413	2016-12-22 15:21:00.1+03	29	0	0
3414	2016-12-22 15:21:00.117+03	20	0	0
3415	2016-12-22 15:21:00.134+03	32	0	0
3416	2016-12-22 15:21:00.15+03	38	0	0
3417	2016-12-22 15:51:00.014+03	24	0	0
3418	2016-12-22 15:51:00.075+03	31	0	0
3419	2016-12-22 15:51:00.108+03	30	0	0
3420	2016-12-22 15:51:00.15+03	36	0	0
3421	2016-12-22 15:51:00.189+03	37	0	0
3422	2016-12-22 15:51:00.25+03	29	0	0
3423	2016-12-22 15:51:00.309+03	20	0	0
3424	2016-12-22 15:51:00.35+03	32	0	0
3425	2016-12-22 15:51:00.392+03	38	0	0
3426	2016-12-22 16:21:00.06+03	24	0	0
3427	2016-12-22 16:21:00.273+03	31	0	0
3428	2016-12-22 16:21:00.289+03	30	0	0
3429	2016-12-22 16:21:00.306+03	36	0	0
3430	2016-12-22 16:21:00.323+03	37	0	0
3431	2016-12-22 16:21:00.34+03	29	0	0
3432	2016-12-22 16:21:00.356+03	20	0	0
3433	2016-12-22 16:21:00.381+03	32	0	0
3434	2016-12-22 16:21:00.398+03	38	0	0
3435	2016-12-22 16:51:00.015+03	24	0	0
3436	2016-12-22 16:51:00.051+03	31	0	0
3437	2016-12-22 16:51:00.075+03	30	0	0
3438	2016-12-22 16:51:00.1+03	36	0	0
3439	2016-12-22 16:51:00.125+03	37	0	0
3440	2016-12-22 16:51:00.15+03	29	0	0
3441	2016-12-22 16:51:00.175+03	20	0	0
3442	2016-12-22 16:51:00.2+03	32	0	0
3443	2016-12-22 16:51:00.225+03	38	0	0
3444	2016-12-22 17:21:00.015+03	24	0	0
3445	2016-12-22 17:21:00.05+03	31	0	0
3446	2016-12-22 17:21:00.075+03	30	0	0
3447	2016-12-22 17:21:00.1+03	36	0	0
3448	2016-12-22 17:21:00.125+03	37	0	0
3449	2016-12-22 17:21:00.15+03	29	0	0
3450	2016-12-22 17:21:00.175+03	20	0	0
3451	2016-12-22 17:21:00.2+03	32	0	0
3452	2016-12-22 17:21:00.225+03	38	0	0
3453	2016-12-22 17:51:00.015+03	24	0	0
3454	2016-12-22 17:51:00.049+03	31	0	0
3455	2016-12-22 17:51:00.074+03	30	0	0
3456	2016-12-22 17:51:00.099+03	36	0	0
3457	2016-12-22 17:51:00.124+03	37	0	0
3458	2016-12-22 17:51:00.149+03	29	263836	5270
3459	2016-12-22 17:51:00.174+03	20	0	0
3460	2016-12-22 17:51:00.199+03	32	0	0
3461	2016-12-22 17:51:00.224+03	38	0	0
3462	2016-12-22 18:21:00.006+03	24	0	0
3463	2016-12-22 18:21:00.026+03	31	0	0
3464	2016-12-22 18:21:00.043+03	30	0	0
3465	2016-12-22 18:21:00.06+03	36	0	0
3466	2016-12-22 18:21:00.076+03	37	0	0
3467	2016-12-22 18:21:00.093+03	29	0	0
3468	2016-12-22 18:21:00.11+03	20	0	0
3469	2016-12-22 18:21:00.126+03	32	0	0
3470	2016-12-22 18:21:00.143+03	38	0	0
3471	2016-12-22 18:51:00.011+03	24	0	0
3472	2016-12-22 18:51:00.041+03	31	0	0
3473	2016-12-22 18:51:00.066+03	30	0	0
3474	2016-12-22 18:51:00.091+03	36	0	0
3475	2016-12-22 18:51:00.116+03	37	0	0
3476	2016-12-22 18:51:00.141+03	29	0	0
3477	2016-12-22 18:51:00.157+03	20	0	0
3478	2016-12-22 18:51:00.174+03	32	0	0
3479	2016-12-22 18:51:00.191+03	38	0	0
3480	2016-12-22 19:21:00.008+03	24	0	0
3481	2016-12-22 19:21:00.033+03	31	0	0
3482	2016-12-22 19:21:00.049+03	30	0	0
3483	2016-12-22 19:21:00.066+03	36	0	0
3484	2016-12-22 19:21:00.083+03	37	0	0
3485	2016-12-22 19:21:00.108+03	29	0	0
3486	2016-12-22 19:21:00.141+03	20	0	0
3487	2016-12-22 19:21:00.174+03	32	0	0
3488	2016-12-22 19:21:00.208+03	38	0	0
3489	2016-12-22 19:21:00.233+03	39	0	0
3490	2016-12-22 19:51:00.016+03	24	0	0
3491	2016-12-22 19:51:00.035+03	31	0	0
3492	2016-12-22 19:51:00.052+03	30	0	0
3493	2016-12-22 19:51:00.068+03	36	0	0
3494	2016-12-22 19:51:00.085+03	37	0	0
3495	2016-12-22 19:51:00.102+03	29	0	0
3496	2016-12-22 19:51:00.118+03	20	0	0
3497	2016-12-22 19:51:00.143+03	32	0	0
3498	2016-12-22 19:51:00.16+03	38	0	0
3499	2016-12-22 19:51:00.177+03	39	0	0
3500	2016-12-22 20:21:00.011+03	24	0	0
3501	2016-12-22 20:21:00.041+03	31	0	0
3502	2016-12-22 20:21:00.066+03	30	0	0
3503	2016-12-22 20:21:00.091+03	36	0	0
3504	2016-12-22 20:21:00.107+03	37	0	0
3505	2016-12-22 20:21:00.124+03	29	0	0
3506	2016-12-22 20:21:00.141+03	20	0	0
3507	2016-12-22 20:21:00.157+03	32	0	0
3508	2016-12-22 20:21:00.174+03	38	0	0
3509	2016-12-22 20:21:00.191+03	39	1172184	12864
3510	2016-12-22 20:51:00.014+03	24	0	0
3511	2016-12-22 20:51:00.035+03	31	0	0
3512	2016-12-22 20:51:00.06+03	30	0	0
3513	2016-12-22 20:51:00.102+03	36	0	0
3514	2016-12-22 20:51:00.127+03	37	0	0
3515	2016-12-22 20:51:00.152+03	29	0	0
3516	2016-12-22 20:51:00.169+03	20	0	0
3517	2016-12-22 20:51:00.194+03	32	0	0
3518	2016-12-22 20:51:00.21+03	38	0	0
3519	2016-12-22 20:51:00.227+03	39	581202	11844
3520	2016-12-22 21:21:00.014+03	24	0	0
3521	2016-12-22 21:21:00.037+03	31	0	0
3522	2016-12-22 21:21:00.054+03	30	0	0
3523	2016-12-22 21:21:00.071+03	36	0	0
3524	2016-12-22 21:21:00.087+03	37	0	0
3525	2016-12-22 21:21:00.104+03	29	0	0
3526	2016-12-22 21:21:00.121+03	20	0	0
3527	2016-12-22 21:21:00.137+03	32	0	0
3528	2016-12-22 21:21:00.154+03	38	0	0
3529	2016-12-22 21:21:00.171+03	39	63898	1036
3530	2016-12-22 21:51:00.013+03	24	0	0
3531	2016-12-22 21:51:00.031+03	31	0	0
3532	2016-12-22 21:51:00.048+03	30	0	0
3533	2016-12-22 21:51:00.064+03	36	0	0
3534	2016-12-22 21:51:00.081+03	37	0	0
3535	2016-12-22 21:51:00.098+03	29	0	0
3536	2016-12-22 21:51:00.114+03	20	0	0
3537	2016-12-22 21:51:00.131+03	32	0	0
3538	2016-12-22 21:51:00.148+03	38	0	0
3539	2016-12-22 21:51:00.164+03	39	454400	9360
3540	2016-12-22 22:21:00.013+03	24	0	0
3541	2016-12-22 22:21:00.032+03	31	0	0
3542	2016-12-22 22:21:00.048+03	30	0	0
3543	2016-12-22 22:21:00.065+03	36	0	0
3544	2016-12-22 22:21:00.082+03	37	0	0
3545	2016-12-22 22:21:00.107+03	29	0	0
3546	2016-12-22 22:21:00.123+03	20	0	0
3547	2016-12-22 22:21:00.14+03	32	0	0
3548	2016-12-22 22:21:00.157+03	38	0	0
3549	2016-12-22 22:21:00.173+03	39	0	0
3550	2016-12-22 22:51:00.012+03	24	0	0
3551	2016-12-22 22:51:00.03+03	31	0	0
3552	2016-12-22 22:51:00.047+03	30	0	0
3553	2016-12-22 22:51:00.064+03	36	0	0
3554	2016-12-22 22:51:00.08+03	37	0	0
3555	2016-12-22 22:51:00.097+03	29	0	0
3556	2016-12-22 22:51:00.114+03	20	0	0
3557	2016-12-22 22:51:00.13+03	32	0	0
3558	2016-12-22 22:51:00.147+03	38	0	0
3559	2016-12-22 22:51:00.164+03	39	0	0
3560	2016-12-22 23:21:00.013+03	24	0	0
3561	2016-12-22 23:21:00.044+03	31	0	0
3562	2016-12-22 23:21:00.06+03	30	0	0
3563	2016-12-22 23:21:00.085+03	36	0	0
3564	2016-12-22 23:21:00.102+03	37	0	0
3565	2016-12-22 23:21:00.127+03	29	0	0
3566	2016-12-22 23:21:00.152+03	20	0	0
3567	2016-12-22 23:21:00.169+03	32	0	0
3568	2016-12-22 23:21:00.186+03	38	0	0
3569	2016-12-22 23:21:00.211+03	39	0	0
3570	2016-12-22 23:51:00.015+03	24	0	0
3571	2016-12-22 23:51:00.034+03	31	0	0
3572	2016-12-22 23:51:00.051+03	30	0	0
3573	2016-12-22 23:51:00.068+03	36	0	0
3574	2016-12-22 23:51:00.143+03	37	0	0
3575	2016-12-22 23:51:00.159+03	29	0	0
3576	2016-12-22 23:51:00.193+03	20	0	0
3577	2016-12-22 23:51:00.209+03	32	0	0
3578	2016-12-22 23:51:00.226+03	38	0	0
3579	2016-12-22 23:51:00.243+03	39	0	0
3580	2016-12-23 00:21:00.013+03	24	0	0
3581	2016-12-23 00:21:00.035+03	31	0	0
3582	2016-12-23 00:21:00.052+03	30	0	0
3583	2016-12-23 00:21:00.069+03	36	0	0
3584	2016-12-23 00:21:00.086+03	37	0	0
3585	2016-12-23 00:21:00.102+03	29	0	0
3586	2016-12-23 00:21:00.127+03	20	0	0
3587	2016-12-23 00:21:00.144+03	32	0	0
3588	2016-12-23 00:21:00.16+03	38	0	0
3589	2016-12-23 00:21:00.185+03	39	0	0
3590	2016-12-23 00:51:00.014+03	24	0	0
3591	2016-12-23 00:51:00.053+03	31	0	0
3592	2016-12-23 00:51:00.078+03	30	0	0
3593	2016-12-23 00:51:00.103+03	36	0	0
3594	2016-12-23 00:51:00.128+03	37	0	0
3595	2016-12-23 00:51:00.153+03	29	0	0
3596	2016-12-23 00:51:00.178+03	20	0	0
3597	2016-12-23 00:51:00.203+03	32	0	0
3598	2016-12-23 00:51:00.228+03	38	0	0
3599	2016-12-23 00:51:00.253+03	39	0	0
3600	2016-12-23 01:21:00.116+03	24	0	0
3601	2016-12-23 01:21:00.296+03	31	0	0
3602	2016-12-23 01:21:00.313+03	30	0	0
3603	2016-12-23 01:21:00.33+03	36	0	0
3604	2016-12-23 01:21:00.346+03	37	0	0
3605	2016-12-23 01:21:00.363+03	29	0	0
3606	2016-12-23 01:21:00.38+03	20	0	0
3607	2016-12-23 01:21:00.396+03	32	0	0
3608	2016-12-23 01:21:00.413+03	38	0	0
3609	2016-12-23 01:21:00.43+03	39	0	0
3610	2016-12-23 01:51:00.145+03	24	0	0
3611	2016-12-23 01:51:00.347+03	31	0	0
3612	2016-12-23 01:51:00.364+03	30	0	0
3613	2016-12-23 01:51:00.38+03	36	0	0
3614	2016-12-23 01:51:00.405+03	37	0	0
3615	2016-12-23 01:51:00.447+03	29	0	0
3616	2016-12-23 01:51:00.497+03	20	0	0
3617	2016-12-23 01:51:00.514+03	32	0	0
3618	2016-12-23 01:51:00.531+03	38	0	0
3619	2016-12-23 01:51:00.555+03	39	0	0
3620	2016-12-23 02:21:00.114+03	24	0	0
3621	2016-12-23 02:21:00.288+03	31	0	0
3622	2016-12-23 02:21:00.305+03	30	0	0
3623	2016-12-23 02:21:00.321+03	36	0	0
3624	2016-12-23 02:21:00.338+03	37	0	0
3625	2016-12-23 02:21:00.355+03	29	0	0
3626	2016-12-23 02:21:00.371+03	20	0	0
3627	2016-12-23 02:21:00.396+03	32	0	0
3628	2016-12-23 02:21:00.413+03	38	0	0
3629	2016-12-23 02:21:00.43+03	39	0	0
3630	2016-12-23 02:51:00.017+03	24	0	0
3631	2016-12-23 02:51:00.04+03	31	0	0
3632	2016-12-23 02:51:00.057+03	30	0	0
3633	2016-12-23 02:51:00.073+03	36	0	0
3634	2016-12-23 02:51:00.09+03	37	0	0
3635	2016-12-23 02:51:00.107+03	29	0	0
3636	2016-12-23 02:51:00.123+03	20	0	0
3637	2016-12-23 02:51:00.14+03	32	0	0
3638	2016-12-23 02:51:00.157+03	38	0	0
3639	2016-12-23 02:51:00.182+03	39	0	0
3640	2016-12-23 03:21:00.014+03	24	0	0
3641	2016-12-23 03:21:00.056+03	31	0	0
3642	2016-12-23 03:21:00.081+03	30	0	0
3643	2016-12-23 03:21:00.106+03	36	0	0
3644	2016-12-23 03:21:00.132+03	37	0	0
3645	2016-12-23 03:21:00.156+03	29	0	0
3646	2016-12-23 03:21:00.181+03	20	0	0
3647	2016-12-23 03:21:00.198+03	32	0	0
3648	2016-12-23 03:21:00.214+03	38	0	0
3649	2016-12-23 03:21:00.231+03	39	0	0
3650	2016-12-23 03:51:00.013+03	24	0	0
3651	2016-12-23 03:51:00.046+03	31	0	0
3652	2016-12-23 03:51:00.071+03	30	0	0
3653	2016-12-23 03:51:00.096+03	36	0	0
3654	2016-12-23 03:51:00.121+03	37	0	0
3655	2016-12-23 03:51:00.146+03	29	0	0
3656	2016-12-23 03:51:00.171+03	20	0	0
3657	2016-12-23 03:51:00.196+03	32	0	0
3658	2016-12-23 03:51:00.221+03	38	0	0
3659	2016-12-23 03:51:00.246+03	39	0	0
3660	2016-12-23 04:21:00.014+03	24	0	0
3661	2016-12-23 04:21:00.05+03	31	0	0
3662	2016-12-23 04:21:00.075+03	30	0	0
3663	2016-12-23 04:21:00.1+03	36	0	0
3664	2016-12-23 04:21:00.125+03	37	0	0
3665	2016-12-23 04:21:00.15+03	29	0	0
3666	2016-12-23 04:21:00.175+03	20	0	0
3667	2016-12-23 04:21:00.192+03	32	0	0
3668	2016-12-23 04:21:00.208+03	38	0	0
3669	2016-12-23 04:21:00.233+03	39	0	0
3670	2016-12-23 04:51:00.014+03	24	0	0
3671	2016-12-23 04:51:00.044+03	31	0	0
3672	2016-12-23 04:51:00.069+03	30	0	0
3673	2016-12-23 04:51:00.094+03	36	0	0
3674	2016-12-23 04:51:00.119+03	37	0	0
3675	2016-12-23 04:51:00.135+03	29	0	0
3676	2016-12-23 04:51:00.152+03	20	0	0
3677	2016-12-23 04:51:00.169+03	32	0	0
3678	2016-12-23 04:51:00.185+03	38	0	0
3679	2016-12-23 04:51:00.202+03	39	0	0
3680	2016-12-23 05:21:00.015+03	24	0	0
3681	2016-12-23 05:21:00.058+03	31	0	0
3682	2016-12-23 05:21:00.083+03	30	0	0
3683	2016-12-23 05:21:00.108+03	36	0	0
3684	2016-12-23 05:21:00.133+03	37	0	0
3685	2016-12-23 05:21:00.174+03	29	0	0
3686	2016-12-23 05:21:00.199+03	20	0	0
3687	2016-12-23 05:21:00.216+03	32	0	0
3688	2016-12-23 05:21:00.233+03	38	0	0
3689	2016-12-23 05:21:00.249+03	39	0	0
3690	2016-12-23 05:51:00.014+03	24	0	0
3691	2016-12-23 05:51:00.056+03	31	0	0
3692	2016-12-23 05:51:00.081+03	30	0	0
3693	2016-12-23 05:51:00.106+03	36	0	0
3694	2016-12-23 05:51:00.131+03	37	0	0
3695	2016-12-23 05:51:00.156+03	29	0	0
3696	2016-12-23 05:51:00.181+03	20	0	0
3697	2016-12-23 05:51:00.206+03	32	0	0
3698	2016-12-23 05:51:00.231+03	38	0	0
3699	2016-12-23 05:51:00.257+03	39	0	0
3700	2016-12-23 06:21:00.014+03	24	0	0
3701	2016-12-23 06:21:00.05+03	31	0	0
3702	2016-12-23 06:21:00.075+03	30	0	0
3703	2016-12-23 06:21:00.1+03	36	0	0
3704	2016-12-23 06:21:00.125+03	37	0	0
3705	2016-12-23 06:21:00.15+03	29	0	0
3706	2016-12-23 06:21:00.175+03	20	0	0
3707	2016-12-23 06:21:00.2+03	32	0	0
3708	2016-12-23 06:21:00.217+03	38	0	0
3709	2016-12-23 06:21:00.234+03	39	0	0
3710	2016-12-23 06:51:00.014+03	24	0	0
3711	2016-12-23 06:51:00.048+03	31	0	0
3712	2016-12-23 06:51:00.073+03	30	0	0
3713	2016-12-23 06:51:00.098+03	36	0	0
3714	2016-12-23 06:51:00.123+03	37	0	0
3715	2016-12-23 06:51:00.14+03	29	0	0
3716	2016-12-23 06:51:00.157+03	20	0	0
3717	2016-12-23 06:51:00.174+03	32	0	0
3718	2016-12-23 06:51:00.19+03	38	0	0
3719	2016-12-23 06:51:00.215+03	39	0	0
3720	2016-12-23 07:21:00.014+03	24	0	0
3721	2016-12-23 07:21:00.05+03	31	0	0
3722	2016-12-23 07:21:00.075+03	30	0	0
3723	2016-12-23 07:21:00.1+03	36	0	0
3724	2016-12-23 07:21:00.125+03	37	0	0
3725	2016-12-23 07:21:00.15+03	29	0	0
3726	2016-12-23 07:21:00.175+03	20	0	0
3727	2016-12-23 07:21:00.2+03	32	0	0
3728	2016-12-23 07:21:00.225+03	38	0	0
3729	2016-12-23 07:21:00.242+03	39	0	0
3730	2016-12-23 07:51:00.015+03	24	0	0
3731	2016-12-23 07:51:00.044+03	31	0	0
3732	2016-12-23 07:51:00.094+03	30	0	0
3733	2016-12-23 07:51:00.119+03	36	0	0
3734	2016-12-23 07:51:00.136+03	37	0	0
3735	2016-12-23 07:51:00.152+03	29	1251458	46006
3736	2016-12-23 07:51:00.169+03	20	0	0
3737	2016-12-23 07:51:00.186+03	32	0	0
3738	2016-12-23 07:51:00.202+03	38	0	0
3739	2016-12-23 07:51:00.219+03	39	0	0
3740	2016-12-23 08:21:00.01+03	24	0	0
3741	2016-12-23 08:21:00.029+03	31	0	0
3742	2016-12-23 08:21:00.046+03	30	0	0
3743	2016-12-23 08:21:00.062+03	36	0	0
3744	2016-12-23 08:21:00.079+03	37	0	0
3745	2016-12-23 08:21:00.096+03	29	76912	1584
3746	2016-12-23 08:21:00.112+03	20	0	0
3747	2016-12-23 08:21:00.146+03	32	0	0
3748	2016-12-23 08:21:00.162+03	38	0	0
3749	2016-12-23 08:21:00.179+03	39	0	0
3750	2016-12-23 08:51:00.009+03	24	0	0
3751	2016-12-23 08:51:00.03+03	31	0	0
3752	2016-12-23 08:51:00.047+03	30	0	0
3753	2016-12-23 08:51:00.064+03	36	0	0
3754	2016-12-23 08:51:00.08+03	37	0	0
3755	2016-12-23 08:51:00.097+03	29	81570	1180
3756	2016-12-23 08:51:00.114+03	20	0	0
3757	2016-12-23 08:51:00.13+03	32	0	0
3758	2016-12-23 08:51:00.155+03	38	0	0
3759	2016-12-23 08:51:00.172+03	39	63662	1146
3760	2016-12-23 09:21:00.017+03	24	0	0
3761	2016-12-23 09:21:00.045+03	31	0	0
3762	2016-12-23 09:21:00.07+03	30	0	0
3763	2016-12-23 09:21:00.087+03	36	0	0
3764	2016-12-23 09:21:00.103+03	37	0	0
3765	2016-12-23 09:21:00.12+03	29	0	0
3766	2016-12-23 09:21:00.137+03	20	0	0
3767	2016-12-23 09:21:00.153+03	32	0	0
3768	2016-12-23 09:21:00.17+03	38	0	0
3769	2016-12-23 09:21:00.187+03	39	0	0
3770	2016-12-23 09:51:00.01+03	24	0	0
3771	2016-12-23 09:51:00.034+03	31	0	0
3772	2016-12-23 09:51:00.051+03	30	0	0
3773	2016-12-23 09:51:00.067+03	36	0	0
3774	2016-12-23 09:51:00.084+03	37	0	0
3775	2016-12-23 09:51:00.101+03	29	318122	1342
3776	2016-12-23 09:51:00.117+03	20	0	0
3777	2016-12-23 09:51:00.134+03	32	0	0
3778	2016-12-23 09:51:00.159+03	38	0	0
3779	2016-12-23 09:51:00.176+03	39	0	0
3780	2016-12-23 10:21:00.015+03	24	0	0
3781	2016-12-23 10:21:00.045+03	31	0	0
3782	2016-12-23 10:21:00.07+03	30	0	0
3783	2016-12-23 10:21:00.095+03	36	0	0
3784	2016-12-23 10:21:00.111+03	37	0	0
3785	2016-12-23 10:21:00.128+03	29	0	0
3786	2016-12-23 10:21:00.145+03	20	0	0
3787	2016-12-23 10:21:00.161+03	32	0	0
3788	2016-12-23 10:21:00.179+03	38	0	0
3789	2016-12-23 10:21:00.196+03	39	0	0
3790	2016-12-23 10:51:00.015+03	24	0	0
3791	2016-12-23 10:51:00.048+03	31	0	0
3792	2016-12-23 10:51:00.073+03	30	0	0
3793	2016-12-23 10:51:00.098+03	36	0	0
3794	2016-12-23 10:51:00.123+03	37	0	0
3795	2016-12-23 10:51:00.148+03	29	631940	8046
3796	2016-12-23 10:51:00.173+03	20	0	0
3797	2016-12-23 10:51:00.198+03	32	0	0
3798	2016-12-23 10:51:00.223+03	38	0	0
3799	2016-12-23 10:51:00.248+03	39	0	0
3800	2016-12-23 11:21:00.014+03	24	0	0
3801	2016-12-23 11:21:00.044+03	31	0	0
3802	2016-12-23 11:21:00.069+03	30	0	0
3803	2016-12-23 11:21:00.094+03	36	0	0
3804	2016-12-23 11:21:00.119+03	37	0	0
3805	2016-12-23 11:21:00.135+03	29	214356	4032
3806	2016-12-23 11:21:00.152+03	20	0	0
3807	2016-12-23 11:21:00.169+03	32	0	0
3808	2016-12-23 11:21:00.185+03	38	0	0
3809	2016-12-23 11:21:00.202+03	39	0	0
3810	2016-12-23 11:51:00.013+03	24	0	0
3811	2016-12-23 11:51:00.06+03	31	0	0
3812	2016-12-23 11:51:00.085+03	30	0	0
3813	2016-12-23 11:51:00.11+03	36	0	0
3814	2016-12-23 11:51:00.136+03	37	0	0
3815	2016-12-23 11:51:00.16+03	29	0	0
3816	2016-12-23 11:51:00.185+03	20	0	0
3817	2016-12-23 11:51:00.211+03	32	0	0
3818	2016-12-23 11:51:00.235+03	38	0	0
3819	2016-12-23 11:51:00.285+03	39	0	0
\.


--
-- Name: traffic_stat_seq; Type: SEQUENCE SET; Schema: home_sapiens_data; Owner: -
--

SELECT pg_catalog.setval('traffic_stat_seq', 3819, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: home_sapiens_data; Owner: -
--

COPY users (id, user_id, box_id, login, email, salt, verifier, status, public_key, keyfile, sync_time) FROM stdin;
17	66	20	+7(123)456-78-90	labozin@molnet.ru	dhPN4oAqzsjEXCw2	3f75a9015debf0ca73cd4ef709ae9c4c0930319d68184b3cc5ff08d14808e58	1	844af8350323d29b7bf760245eec4298491e9c144c813493e2d315669de4c5f67ac6eb2117c539d3334db9bd64322d5950fd6160fe4d328d5c3db23f9bc7d84d82847fce176223b9d514a33067096e80f832f00661798d44949ce5fc01d48bbe1e216e236f05af2f7b692d1bbf9fba5e1dfc4c7a3c438a42b7a0a598b2390f33	c63669b63b8e40c62ee904418436ec1ef970cce1f724c97f45d4e676204cb10feb03d6872959a32b11b516cf19de6265c46b7422c9f0b8b5bd53f9f09b02cd5e0d86bc69765e3a74928d6f47754241082d1ad49f5ee022fcc5498b52b53d49c2846253cd7101135c4157aedd117f02cab1d774c08f941c94b2ee1633741bc867f2f403c9fd2fb4846ad9cccb4f6b7b26c3d3ae9850639026396eb2fe4db4e06dc58728863916ad8ef1d91b5e8bd0f891e63481366e3b88a09c1e8ee82ca0e1bae49b610c6a25fd606443eb22c484106a9c351efdeba8c3ebb9b6c117321c548a79a622f44986714301f0034a2c2b2dc2f5d9d897d1bf66992480231d41ab0a2cea5d32ffbf42fef4b97946d2a12815136ead92a26c176e19d9b5463c1c4eee1682df0a7f8d2154c6f757227d4b9b219c261f056e616c12544d4a8a3f9602edafe7de6eed83c58f68fca978c9cb02df7fa425dfad49f8e071567159f42ba29e63e42930197618b8f9cc809803423d456e3b69428ac5e73825fb32c76162b70dfca15843b736c5179e388f70b19c848cacf962d8c03263b6945f1ee81523aaad1d771e1f616e59721712390179a940618614b8108818cb80e49c1432c27fd3002b3a5182d6e64742d0084c8adae57802a7cb6c5996822966525e5433cf48ca2e2141970845e82d6a7315cba1ea9ec6788c69bbff897fdb29f3dc89182f43f08142d1255b1d914f0ca4102ec7151df9327e6f10fb55e34849aac41c6ab090483cc851832577487fd07997ed28e97f5973b5cf313a8bee7e424d923ba41eb515ed1a24749cd4e52059c64662db530c3e518204649eeb95db2e3b8aeeb84ca614014d1319d93c72732891461cdf0d44f75a24a047bbb24673ca89f8d2effe635b99df5bb5f061cef711f942545c12a2961e7824fd0a2067b89dda0a0ac36ddfcf13c8a2ecf739453c308f3cb44e9b608472cc83098d3dc199cbf752a28d08360f6b7a229aca884ce6a1354d28f26638d710b14bbeb281cbe9dcf92123351c5c7183caee7594dbe1a7748da235a5c44f123dd8ec7e17fb3c644910cced99ca4ac68ffa81fae2be7eaf84910892b9724238df8d79e9730f7b72c4647cb51975811e42a15b097c0202110ee65148ac5528a4594dedb03e7c8f8f1e540a434b1fba02a029	2016-11-22 17:09:34+03
19	3	30	+7(916)684-81-91	\N	cfKbvbeZ9E4ewApi	b721a4fe3cb01be1565fc50bba5420a0fa7c33d83fe1294dee1e542e883505b3	1	cfbcc10092673fa89f8a0a88757108afb827630fba07731e48e1558d894e3e0438f09c2015ca0e73478af11a1e8f32dc598f1e94910b25dcb4345f8a12afd513200dc546abf5f98adb329d2355f8e770dc7c19d10f5b5e5241a255df713e477a423654122ab8761b493d719fd262d6896daacbf4c02ce4272225763fc9bc8f87	518f3ac8bd02901a4474d99581dc4a9b7027c9e7425b8fba82db59a019544d7e1ba643132324aa53a7d507131d1402a6cc4aa15403e019818f50d6f5cde128f91bc762774de4947893a3b1a4a13353983ba528fe33e564ee6e370ecb907ba061e8f287c8f9d61aad94ee1b6f3737e29eb0b725d525a30c203f18f4903ad11ef36e8a3b24f3c7f938db286d70c0c2b2d33ac493d0f154b9b058c39ade11597c465a005759103b2a43194578f4391960a78d503d62858a24cca6baa0ea1cedcde4f352dab8a8ed2ffc536d827d31d71042ed975dd4b26b1890304f8d471956bc5ef94a447cda1de56aeeed4f45b815c298e7d0218078c3fae439f4e9a1f14ec8bedabb08435e393ef8c2556de60a9712b48b9c256520aa97ca894d033f5a74e2f769fcd639413f677a25ab45438509623b26db782144e04736aef796d2c77d119316bffb054e5c59eab5124424080b3ee2ca57bcc146e352441282f7ee564b006c816f7dc0fe042486807169a0506b741fc906dfe56101957412320e7737c7c38646388ce746cefe3a756c63ae90e46cd6dab95e0bade42e0bf76aa834bb53b88cb90c1b5293d9e537bb8f2a6de38185e08966cfbe371d4b1c21626e204af0051913d0afb52622d3916d33054e24ccfe2cb06b8e0f50f609332f2eb00132a79f8b8db48bcc6a2d0fef0ffcc3237a821b0a623600f20eec146db3c15eeb600c30cc2859bfa8d1201d2d443925ed912dd25e4189bb445620f4089707d441a952bc833c3fbf21866a2401b073b24c3b93f04ee0dcdbd800f86e32a7afbdec5df189cea9938cfee2e881b826ec0fa8371dca46825d16234f0a356cbbc0ae6cfde5f2505f7c7f742bb4d78b5be6f050a313ad7a1f960283d4208c657c339c60bcc0f4781ea13a28afd2a71abbd501962336ff0911310bb1872449f6bf46203b7bf1882e0db973b9bcdd2ef29f0b00cadbe2880a91fa29d8182ce12b7eb28a9b56945fdb13324e2759909390a3073cbb61ed0bcb497fbf3e1af7854eb7cb062becca85eb114e3dd2946e37ffe34b4dd0f526a7c34f45ef8fe0b843784087e4aff8a5239fde618ee8d7af6e73ce762badaaf920484fe694b1a34623edddac673ef45a70e4eeb037216175c5bb1ef16e39eaa107eff11b727a7f9f6bb92a45443313	2016-11-18 15:54:02.182+03
37	1	29	+7(916)666-05-19	naras@mail.ru	nfcIGK9ZMGLkC13y	b5b1fb41e356733e78aefa318e06501ac1c5771ce00376f83d95a6d7bca822c5	1	ab286e807648e9b137da006ec0480919d903a4c00f70d123cfcf75bdee6692fb01710487674f9a170815fb41bfae0204e764ecd1be075cf49bdadb71e5b0a28b058ed0b1982c452af318dadc86c308b4076d7f96f70addaec95518ef3ba71e7b27fe2849c82fdf9c011b4e9decf71baa8a1ca15f1cc81368f83a52bba457199f	832cebe1307992fe56adec65018df83360f1477989b9549de88121bd626aef30db77d1e97a76e4070bb30cae3218f44dcf53d0e14e8fd68ee18de0ffbcc24b3b1180a3a2df78428ab24cf474bfed1764dc19cb283eaec8a19a6dce6e735fe55d62ca8af9647d0e22cd640720daf54163196036a54af1fda384b6519f79c2f8543492d8dcb41b3b30fbfebf91ba6ee894f3086896ea439ebe40e9b625562da7aae530d4fabbfdd1484f475afdfac85a36c55ed4aaf696279a76d7e0a327e9385a9f0bc4eb7122780a9d2014c3c14da5bd5c23fd7a9898dfd4e20445ef6102f826feb3ac30abe1b55b904360dbe7aaf89ceb846263e074e4f2cc6686b37e4c94ee19ead609f67b24bc3c1616d2ae06ff216b58345e0c25fb806e60cb9aef3d0c8bd839a269ddb2f481495d2b1cdde55da1bd6dcc3e354b394800b9510ee2eab686aa1073753aa5815c89ff81a273f18aa18996af37cce52cd777f5cd2a531f9baadfe4ed3f4cf180073972962962f0b71d3d73873403b25055106e34fde20677234d626d14d22b9f464047b8e938bee7f264e1086699a155f05fc1bad6baf3443ac39830c4c040eba4cc94d428817e05cfa14f4d4387993ea6a35a1c7411e66e5c99d37a3f971715924e0c318ff1ecbff85ebf6d964e23afcaa6340349d0bf12f30fab375cb932a42d9ff61b8a7d40ff84cffd7ef4fc66a23794e4baf3d61d57917de207cbad6e4d4263a810c97990bbc13e0fb5bfe32b52c5c6b5e3775d21ea5fbf071b5f808bf6f34b500da0b10f7e26fe7919b2ab17456cc4bfad8283d9d3ec6a1d85bbf1c33626dcfacc1500754e2ab4b91d5cc0d90a8901b8f8f162f28a7523d74fd3dc204bdfc3ab337af093059fd24812e1691f576be2e0daa8d2eebe45df9fcc56dc2ebb5d5f0481546d8106a2382a39c3a16a64a979085347029464c2959ab8a447b2c2edf3c368345a6071a24cd05458f3ec21afa04bbad9c750f04a9a05e25fbe21fa7a5a10aa0148bb1bf8954969e40e525a1079064f213a5ab5defa27242515698a3afdd5e68a1706b8e48140d4ef21bd5daa5be77608a77b58e56a51cf99b437f0a06a5491cf10c4f39c3453115a02a9303db4fd98463f81782342315d184a996e921573ceb7aa923d539dad0e1e4315df27ccd6899bb4	2016-12-09 23:47:03.235+03
33	2	31	+7(985)924-36-28	\N	FfSjMTcWiYFXcCeX	a09ecb27d2f84c56d1b5db809fbff27e21d637165d16d8c2e2e48379a01f1693	1	76a110d5a30369fa43429c8cad1f4f40cc8f74c4ab51b3db89ed502904f2bc28531f207d08b4975ebf58de589ab7ed50a88575d10fa8a75bd473bf7185b4b98c7c4f723d97e391961b5390ab8a76c9dd805748c5690bf6174abacaea8c0fb34ac856bfb5cf0c907574024f78615a6c9539f28694e2b467a83f6ffc16b18bd911	8da4a1800e9223996193f968f82668543aa5ea1f95b23a4c4f56c746710ca50aeeb91144d5c5de95fe8e62beb4798c47a08a15f2382f4beedc39f9ae3bc641d12f4f3e44ca4aa3508e6ce5124a5d16d8e69cb60cbd35b3e44f43ed95674ca40eb954fc9eb8987451125f06c62758e62ffa8299450f3353dd0c7f6168f599dc84a21ff77696da298884364fb9bf361d169310d8669b4872f010957d0ad42bf6008e28603f5db80871dadefef2a9b07aaf96db19c88af92b0ca9fcaaed6b3676a721ab1a37ecbf9698286c83ae7e32c629af3a9430e4c33c0fed6b0d27105016afc9fbe74d0dead1bb0892eb3724a34168d2aee1a03c5b242c6b7284a18a65b41ea34eaa6b310fb3e3d7e727cc2f1fe067eec9ba7e76b05e18838068fb3daa8285b507d5f38ad9b07f5aa4686d634f0bbc5dd3e288dc47aafa94299846bb6d12f3b9005735be7cddd53f3ad5db7eefb4d2efeaf051e7f19216a1425bb400b8801cf81d8b683c4677575a6f210fc464585da95d7b5fd80a37c16b25d7f139a8ff34551f4e0618f1f56d4891361ad3077e6a924b620c2eb80efa6f7b0339986b1d995014cb5e5eb8516f984ab6b84a3883d938a996d1c252d34547a0486d483e32658035da4170dc1b13d67a6a271d4a4d229d602b4dc46bfc4000359ca1a8e56185a25db5d5e073876d7b36166d5902bc34f083ab463924c4d1a7853919b16f31ddf7a846dd9f6974dda14e8aeda6ea6f24c12fac08305dc6e10af0c1e30365a6af8a5c75ed93764e7a9953ab699325f1a983135d2dd93ddb6b1a6f69bec24b66946fbf1009383836d97aff2b198b079a13d44fbc3d7570084351cdb88616cb99ae9f6bbbca9221b2e5f3edcf5d400fc992edb67e59d4c6444b8036a742ddbeb51efd6ce43d621fd2a2b46efeeb5e0a6c5dcb94e32c1aa683f4b0b2988a4f6af014f8c1022d188e76a54d4c913d6875faf5aae67d493a70cd7ff476d1d95573f914bf436300716b397e185aba1bb9b1c45a4e4536bf6b7de466d46401038231bafe861f9a670650c7d787990b7ff5df361c6740488bb23f8fe3ae89342d1091d826d22d32f40d44ab99b0ee25c1b405b20a727c85c39ceec750f7a5676666c1edbf1c1babb1d92445471e7394312318980eb24bfa082a314a5bec6967e097	2016-12-08 10:07:06.516+03
47	1	32	+7(925)740-87-12	\N	mdtkiTl8dWnens5W	4106c3b5e41209feaec80b8a47c60d67541670bc9af635a44461059e4a75029f	1	80a2d7a5527c5211dd51e3ef9acd4031f2bf9a89447506dfe900a86b52ab2efbee2a9ba1734b193825a3178d2da108e3fef627877752beb0c19ff947cd10605d1e075d921a19049243cdebcc10f6c1b6b32fc2718ab4212b7a85a3088f56afcca6fcd761933cbf06b006c825fc51c5fd836c56442d0235675367f37d9024d61f	24c9a656445e141b474bc0cdff5d87b63ff760d0ad1dc1d4e63c61d82488fda20983c2be7a3821a43ad1dbaf2da79bfee0db9ba92f53852921e8a0b946e42236c6b4434d6afbe280e6d028f3cb53d1f46e80944b85018f34996da524c21eb4a8b43f8c18bf9c5fda3116ebda693f031bb54535d17954f6d71e3a53b0103651c06c46a3365c9ed184cc5aba54068eee811e5c0d4369d971b1f02d9cd7ad417887a2c57e4ee2dab726547b870e977925af5c8262a3d936059ac008c206792856a486a370f054f759c75e5c19e5052c64592133d9afb996d2a10491c19524712fe8d23f044a6480efb5973846342a18feaaea24570d222c245cb455df543167b345c445a540db08b9820bf21ec05c812aeb87918c11926cf5726779fe6eefb6b76648a4d5768bdb907c566ae91931dacaa813f7a886d17a8c0a9577389eceeddc77271d599a25f55c1c6101f01a60e1a735cd0489fd4602c33be9583ea3405a9e29f27949a364d10c01a6ae6ebd5a79d9dfb7a47a5ef3525e5eb3fddfd836fdcf6c88bc215e52b34b0b6945693b79f78d5d436e2fc13b95ae8fba491b09559be019cc72aec0c47b0fecb9e181f67672c977fb22e64810aff2583ace29719bafc8cf9ae5d8224024740a64d193931435d23a3e7452c7755289801ad5451bb89d26fbcd376d47305e40102d0543b46b5bba5973a18dbd68cdfc2095f04008999e686532834a81c5ae96af04c68788fa647a958497654bc9667a3fccf314fde5922cf2c5641d7e396a4bc05a1246b85d9eb80484819c6b5b4c93957f39700d303c651b2c99daf2a5825110f97b7e4f5cee8de26f4c2412386cf1ff2ae30257c8a1727cebfa0bdbf66467bb99c63cb0a4f7ae114e0fec36a482fd9e0d69e58edc909f0bc9c3926bc3e9a7045ce4a4913330311ab6b1e67fd97d142b9a61c8026d7ed677e2ae58d0ffe85477d08c8e15705167ac9e04befbe1f4ca803d020bf8e0204167d76ee8cc98ca020537c5209352294e4f37343a1dabdc48977cfc1325424a63556559ed32c97803947998228433d562f8493dbae52c332a8f5e8fd8891e70b13e79bbc6300a1e84a0d66c8759b7d7414167d27eaee6c79b22b6c5849547b03ef9912ee6c202f10052cec4203c5d1d740a130695ce15e4ad702fd09bdeaf	2016-12-21 17:12:44.731+03
49	1	39	+7(926)335-71-07	\N	5i68u01g5opgHuub	8d78ae20f86ebb732b7deb221ed2ada6b632b744d8a615447531d03fe621735	1	92cf5573b6770a680e2d906d4a262f74473d5261fe05d27bad8498b799cf0ea7ab41457b9600241f585a97439b4cd6209d5ab92280dfed7f22b98c241569de0bb88acf7027a795523d81e9d9c1976a6bc23c17ac33c2b1e397153fd04acfa3d75f1ba281a6b490a8497bfec89fc2a24678408f0ee62e9b95ed3be25473e399b5	546ab81c3e66655109172b9723f3881ae095cb80a8ec640070596becfe0ff545a9bc060860c980311693c585206fc79e35c7d55ea508c94fb70f1d5e2633f7582f701886880aaa1e2f9713c5548dae5cbf629079b5a4674b477dad6ebf5256d547f694761fbd70aee348a6e4b1dbdcdd9694b708609493cfd7187b0d6324ce6556149d1468cc46e1d50f4990da3fe13631d368eb8eb94786e5b281c5110030d87b55dca73430954a886233e0ec8c2c45a9ec4968ad637efcef0cc7391165c0e596765d2a7f82c97482790ca5a6b672e65ea9857e3cdefe8974caab4a6912f1a60a3fe3c50ec174b5e6cd7a3cf13015d1db0b17329057707249bc80fb2b4931f597bc5ca2b1aea04d522bc4c3d54835cb61738e284f82c314943bc84c2814c36713dd93c7638ff57dd3f18a6cc1425b8f1b564a0e28399de85d7adf6a851ae7125f56b72ba73befcbd1b154596e4e3ada2de7926f994884979504bfba19024ceaf58acc6f7354d4e778ca2416b5d52a178f78e44176fb5600ad26dc587fefdfbf4f71d7344ba27de28df049cd2998e696502ca48c5a0ac9cc7516d793998cd126d7f534852047d366cfd13595fb3897743f3d5ae7c39879cdc1982f45c1ae1604aaf1ed3eb757e105f9a9978bdbc26cdf370c553c6f6e5596936cda37f6ac351c35b78b93bf7ff62f43e7bb490836a5519c84998230ed94f73a9f474c114c4802ddd08fcf77e137dac0027c4333c3b1e22287eb044647a869e397571878b15b010b1235a707a34562796fecb81f8ca66001d1a2e4a21ee45d170fd873f0d78a0ac45c7ea7edbf2fe2fcfa4b3a4a66ab6db841c66c6a545eadf94d9e04205ec1e5e91b2dd4cd2e350a23f79061f17f1314ff85d8b5663be2ef62afb450eb17aaf6c8a92c3972e44632b669ee222cfe0622fe0f5e1897e5e5999aa1743ec187644abc1b5bf76a79370a8ce54e8855dc49b6d782353061ec03efba5a3a6b42c1afe4569781579bbba7b35bdffe6b9e0d863e5fc5ef83c615086706e9695e8e05967ae3a5946c60e331a2ea78aba83010ec5b22eac43db5d563e3de709fdd75a09d547c9378255d66a45d6fecdcc3052bcdd93914fd29c559e2a9ab0536cbee7ebad67e8cb6a46611bde75eff90554d1a4cf581c745a62fa702a7352e64a44d	2016-12-22 19:14:25.209+03
\.


--
-- Name: users_seq; Type: SEQUENCE SET; Schema: home_sapiens_data; Owner: -
--

SELECT pg_catalog.setval('users_seq', 49, true);


--
-- Name: pk_box_logs; Type: CONSTRAINT; Schema: home_sapiens_data; Owner: -; Tablespace: 
--

ALTER TABLE ONLY box_logs
    ADD CONSTRAINT pk_box_logs PRIMARY KEY (rec_id);


--
-- Name: pk_boxes; Type: CONSTRAINT; Schema: home_sapiens_data; Owner: -; Tablespace: 
--

ALTER TABLE ONLY boxes
    ADD CONSTRAINT pk_boxes PRIMARY KEY (id);


--
-- Name: pk_remote_scripts; Type: CONSTRAINT; Schema: home_sapiens_data; Owner: -; Tablespace: 
--

ALTER TABLE ONLY remote_scripts
    ADD CONSTRAINT pk_remote_scripts PRIMARY KEY (id);


--
-- Name: pk_terminals; Type: CONSTRAINT; Schema: home_sapiens_data; Owner: -; Tablespace: 
--

ALTER TABLE ONLY terminals
    ADD CONSTRAINT pk_terminals PRIMARY KEY (id);


--
-- Name: pk_traffic_stat; Type: CONSTRAINT; Schema: home_sapiens_data; Owner: -; Tablespace: 
--

ALTER TABLE ONLY traffic_stat
    ADD CONSTRAINT pk_traffic_stat PRIMARY KEY (rec_id);


--
-- Name: remote_scripts_data_pkey; Type: CONSTRAINT; Schema: home_sapiens_data; Owner: -; Tablespace: 
--

ALTER TABLE ONLY remote_scripts_data
    ADD CONSTRAINT remote_scripts_data_pkey PRIMARY KEY (id);


--
-- Name: server_logs_pkey; Type: CONSTRAINT; Schema: home_sapiens_data; Owner: -; Tablespace: 
--

ALTER TABLE ONLY server_log
    ADD CONSTRAINT server_logs_pkey PRIMARY KEY (rec_id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: home_sapiens_data; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

