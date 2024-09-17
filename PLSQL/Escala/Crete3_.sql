Declare
    v_username Varchar2(100);
    v_cascade  Varchar2(100);
Begin
    Begin
        Select Max(1)
          Into v_username
          From Dba_Users
         Where username = 'PLANTAOTESTEVITOR';
    
        If v_username = 1 Then
            Begin
                For item In (Select *
                               From all_Objects
                              Where GENERATED = 'N'
                                    And owner = 'PLANTAOTESTEVITOR'
                                    And Not object_type In ('JOB', 'INDEX')
                              Order By Timestamp Asc)
                Loop
                    Begin
                        v_cascade := '';
                        If item.object_type = 'TABLE' Then
                            v_cascade := ' CASCADE CONSTRAINTS';
                        End If;
                        Execute Immediate 'DROP  ' || item.object_type || ' ' ||
                                          item.owner || '.' ||
                                          item.object_name || v_cascade;
                    Exception
                        When Others Then
                            dbms_output.put_line(item.object_name || ': ' ||
                                                 Sqlerrm);
                    End;
                End Loop;
            End;
        Else
            Begin
                Execute Immediate 'Create User PLANTAOTESTEVITOR IDENTIFIED By PLANTAOTESTEVITOR Default TABLESPACE GLOBUS_TABLE';
                Execute Immediate 'GRANT DBA To PLANTAOTESTEVITOR';
                Execute Immediate 'GRANT Connect To PLANTAOTESTEVITOR';
            
                -- Grant/Revoke role privileges
                Execute Immediate 'grant Connect To PLANTAOTESTEVITOR';
                Execute Immediate 'grant dba To PLANTAOTESTEVITOR';
                Execute Immediate 'grant imp_full_database To PLANTAOTESTEVITOR';
                Execute Immediate 'grant Resource To PLANTAOTESTEVITOR';
                Execute Immediate 'grant select_catalog_role To PLANTAOTESTEVITOR';
                -- Grant/Revoke system privileges
                Execute Immediate 'grant Create public synonym To PLANTAOTESTEVITOR';
                Execute Immediate 'grant debug Any Procedure To PLANTAOTESTEVITOR';
                Execute Immediate 'grant debug Connect session To PLANTAOTESTEVITOR';
                Execute Immediate 'GRANT Select Any Table To PLANTAOTESTEVITOR';
                Execute Immediate 'grant Insert Any Table To PLANTAOTESTEVITOR';
                Execute Immediate 'grant Update Any Table To PLANTAOTESTEVITOR';
                Execute Immediate 'grant Delete Any Table To PLANTAOTESTEVITOR';
                Execute Immediate 'GRANT Select Any sequence To PLANTAOTESTEVITOR';
                Execute Immediate 'grant Execute Any Procedure To PLANTAOTESTEVITOR';
                Execute Immediate 'grant unlimited tablespace To PLANTAOTESTEVITOR';
            End;
        End If;
    Exception
        When Others Then
            dbms_output.put_line(Sqlerrm);
    End;