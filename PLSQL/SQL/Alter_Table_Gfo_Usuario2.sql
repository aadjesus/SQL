Alter Table GFO_USUARIO Add(Codigo_Interno Number 
                           ,Ramal number(5));

Alter Table GFO_USUARIO Add(Constraint fk_GFOUsuario_GrupAtendRamal
                           Foreign Key (Codigo_Interno, Ramal)
                            References gfo_Grupo_Atendimento_Ramal );

