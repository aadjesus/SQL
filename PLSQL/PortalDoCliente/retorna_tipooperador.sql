create or replace function retorna_tipooperador (vid_ticket in number) return varchar2
is
vtipo_operador varchar2(1);
vultima_data date;
voperador number;
begin

select max(data_hora) into vultima_data from mtk_tramite where id_ticket = vid_ticket;
select max(id_operador) into voperador from mtk_tramite where id_ticket = vid_ticket and data_hora = vultima_data;

if sql%notfound then
vtipo_operador := null;
else
select perfil into vtipo_operador from mtk_operador where id = voperador;
end if;

return (vtipo_operador);

exception when no_data_found then
 return null;

end;