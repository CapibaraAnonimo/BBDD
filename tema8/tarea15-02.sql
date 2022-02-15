DROP function tablaMul;
DROP function tablas;
create or replace function tablaMul(numeric) returns void
as $$
declare
	a numeric;
begin
	a := $1;
	for tabla in 0..10 loop
		 raise notice '% x % = %', a, tabla, tabla*a;
	end loop;
end; $$
language plpgsql;




create or replace function tablas() returns void
as $$
declare
begin
	for tabla in 0..10 loop
		Perform tablaMul(tabla);
	end loop;
end; $$
language plpgsql;



SELECT tablas()