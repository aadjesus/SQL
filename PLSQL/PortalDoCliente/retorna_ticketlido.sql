create or replace function retorna_ticketlido (vid_ticket in number, vid_operador in number) return varchar2
is
vlido varchar2(1);
begin

select lido into vlido
from (select lido from mtk_notificacao where id_ticket = vid_ticket and id_operador = vid_operador order by tipo desc)
where rownum = 1;

return (vlido);

exception when no_data_found then
 return '-1';

end;