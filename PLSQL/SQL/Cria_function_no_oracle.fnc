create or replace function TiraEspacosDuplicados(S in varchar2) return varchar2
is
 vAux varchar(30) ;
 i  number;
 T  number;
begin
  T := length(S);
  for i in 1..T loop
    if Substr(S,i,2) <> '  ' Then
      vAux := vAux || Substr(S,i,1);
    end if;
  end loop;
  return vAux;
  
  
end;
/
