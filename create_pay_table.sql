/*Creates the sql query below */ 
 
create or replace function public.__update_paid_cross_table() returns void 
language plpgsql
as $function$
declare 
	rec record;
	months text;
	counter record;
	cnt int;
	final_str text;
	len int;
begin
	cnt := 0;
	months := '';
	select count(distinct( month_year )) as cnt into counter from pay_table;
	raise notice '%', counter.cnt;
	len := counter.cnt;
	for rec in select distinct month_year from pay_table order by 1 
	loop 
		cnt := cnt+ 1;
		if months = '' and cnt < len  then months := concat('"', rec.month_year, '"', ' text', ',');
		else  
			if cnt = len then months := concat(  months , '
' ,  '"', rec.month_year, '"' , ' text');
			else months := concat(  months , '
' ,  '"', rec.month_year, '"' , ' text' , ',');
			end if;
		end if;
	end loop; 
	raise notice '%' , months;
end;
$function$;

select public.__update_paid_cross_table();





select *  from crosstab( 
   'select player_full_name, month_year, paid_amount from pay_table order by 1,2', 'select distinct month_year from pay_table order by 1 ' 
)
as(
player_full_name text,
"07_2022" text,
"08_2022" text,
"09_2022" text,
"10_2022" text,
"11_2022" text,
"12_2022" text, 
"01_2023" text .......
)
 

