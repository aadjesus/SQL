select a.HoraInicio serv_HoraInicio, a.HoraFim serv_HoraFim, b.HoraInicio, b.HoraFim, c.Id IdEscalaServicoDiaria, b.Id IdEscalaServicoHorario
,d.*
from EscalaServico a
join EscalaServicoHorario b on b.IdEscalaServico =a.Id

left join EscalaServicoDiaria c on c.IdEscalaServico = a.Id
left join EscalaServicoViagemDiaria d on b.Id = d.IdEscalaServicoHorario and c.Id = d.IdEscalaServicoDiaria
where a.Id = 1

select a.HoraInicio serv_HoraInicio, a.HoraFim serv_HoraFim, b.HoraInicio, b.HoraFim, c.Id IdEscalaServicoDiaria, b.Id IdEscalaServicoHorario
,d.*
from EscalaServico a
join EscalaServicoHorario b on b.IdEscalaServico =a.Id

join EscalaServicoDiaria c on c.IdEscalaServico = a.Id
join EscalaServicoViagemDiaria d on b.Id = d.IdEscalaServicoHorario and c.Id = d.IdEscalaServicoDiaria
where a.Id = 1

--select * from EscalaServico where id= 1
--select * from EscalaServicoDiaria where IdEscalaServico= 1
--select * from EscalaServicoHorario where IdEscalaServico= 4
--select * from EscalaServicoViagemDiaria

