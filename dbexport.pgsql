--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

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
-- Name: decrement_department_count(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.decrement_department_count() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE department
SET emp_count = subquery.cnt -1
FROM (
        SELECT department_id, COUNT(*) AS cnt
        FROM   employee_department
        GROUP  BY department_id
     ) AS subquery
WHERE id = subquery.department_id;
RETURN NULL;
END;
$$;


ALTER FUNCTION public.decrement_department_count() OWNER TO postgres;

--
-- Name: getemployee(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getemployee(param integer) RETURNS TABLE(employee character varying, department character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
		select E.name as employee, D.name as department FROM employee E inner join employee_department ED on E.id = ED.employee_id inner join department D on ED.department_id = D.id where D.id = param;
END; $$;


ALTER FUNCTION public.getemployee(param integer) OWNER TO postgres;

--
-- Name: increment_department_count(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.increment_department_count() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE department
SET emp_count = subquery.cnt
FROM (
        SELECT department_id, COUNT(*) AS cnt
        FROM   employee_department
        GROUP  BY department_id
     ) AS subquery
WHERE id = subquery.department_id;
RETURN NULL;
END;
$$;


ALTER FUNCTION public.increment_department_count() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    id integer NOT NULL,
    name character varying(255),
    code character varying(255),
    emp_count integer
);


ALTER TABLE public.department OWNER TO postgres;

--
-- Name: department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.department_id_seq OWNER TO postgres;

--
-- Name: department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.department_id_seq OWNED BY public.department.id;


--
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255)
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- Name: employee_department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee_department (
    employee_id integer,
    department_id integer,
    doj date
);


ALTER TABLE public.employee_department OWNER TO postgres;

--
-- Name: employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_id_seq OWNER TO postgres;

--
-- Name: employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employee_id_seq OWNED BY public.employee.id;


--
-- Name: department id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department ALTER COLUMN id SET DEFAULT nextval('public.department_id_seq'::regclass);


--
-- Name: employee id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee ALTER COLUMN id SET DEFAULT nextval('public.employee_id_seq'::regclass);


--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department (id, name, code, emp_count) FROM stdin;
1	Information Technology	IT	2
\.


--
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee (id, name, email) FROM stdin;
41	Komal Ghate	komal@gmail.com
42	Sunil Ghate	sunil@gmail.com
\.


--
-- Data for Name: employee_department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee_department (employee_id, department_id, doj) FROM stdin;
41	1	\N
42	1	\N
\.


--
-- Name: department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.department_id_seq', 1, true);


--
-- Name: employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_id_seq', 42, true);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id);


--
-- Name: employee_department department_count_decrement_trig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER department_count_decrement_trig AFTER DELETE ON public.employee_department FOR EACH ROW EXECUTE FUNCTION public.decrement_department_count();


--
-- Name: employee_department department_count_increment_trig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER department_count_increment_trig AFTER INSERT ON public.employee_department FOR EACH ROW EXECUTE FUNCTION public.increment_department_count();


--
-- Name: employee_department employee_department_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_department
    ADD CONSTRAINT employee_department_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.department(id);


--
-- Name: employee_department employee_department_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_department
    ADD CONSTRAINT employee_department_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(id);


--
-- PostgreSQL database dump complete
--

