CREATE OR REPLACE FUNCTION public._remove_string(character varying)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
declare
	sample_id ALIAS for $1;
	arr text;
	sample_nums int;
	i text;
begin	
	raise notice 'Start';
	if regexp_matches( sample_id,  '[$&+,:;=?@#|<>.^*()%!-_]')::varchar is not null then 
			for i in select regexp_split_to_table(sample_id, '') loop
				if regexp_matches( i,  '[0-9]+')::varchar	is not null then 			
				raise notice 'String: %' , i;
				arr := concat(arr, i);
				end if;
			end loop;
		sample_nums := arr::bigint;
		return  arr ;
	else return 0;
	raise notice 'no digit found in string!';
	end if;
end;
$function$
;
