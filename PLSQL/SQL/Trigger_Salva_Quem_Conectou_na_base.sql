Create Or Replace Trigger Trigger_Quem_Conect_base
  After Logon On Database
Declare
  p_Aplicacao Varchar2(100);
  p_UsuarioSO Varchar2(100);
  p_Usuario   Varchar2(100);
  p_Ip        Varchar2(100);
Begin
  Select Upper(Sys_Context('USERENV', 'MODULE'))     Into p_Aplicacao From Dual;
  Select Upper(Sys_Context('USERENV', 'HOST'))       Into p_Usuario   From Dual;
  Select Upper(SYS_CONTEXT('USERENV', 'OS_USER'))    Into p_UsuarioSO From Dual;
  Select Upper(Sys_Context('USERENV', 'IP_ADDRESS')) Into p_Ip        From Dual;
  
  Insert Into Quem_Conectou_na_base
    (Aplicacao,
     Usuario,
     UsuarioSO,
     Ip,
     Data)
  Values
    (p_Aplicacao,
     p_Usuario,
     p_UsuarioSO,
     p_Ip,
     Sysdate);
End;

/*

Create Table Quem_Conectou_na_base(aplicacao Varchar2(100) 
                    ,Usuario    Varchar2(100) 
                    ,UsuarioSO Varchar2(100) 
                    ,IP Varchar2(100) 
                    ,Data Date)
                    
Select *
  From Quem_Conectou_Na_Base a
 Where Nvl(a.Aplicacao, 'x') <> 'x'
   And a.Data = (Select Max(b.Data)
                   From Quem_Conectou_Na_Base b
                  Where a.Aplicacao = b.Aplicacao)

*/