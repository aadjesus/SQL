select *
  from ( 
  select /*+ FIRST_ROWS(n) */
  topn.*, ROWNUM rnum
      from ( ...sua_consulta_entra_aqui...,
             order by critério, ROWID ) topn
      where ROWNUM <= :LINHA_FINAL )
where rnum  > :LINHA_INICIAL;

-------------------------------------------------


Select *
  From (
        Select a.*, ROWNUM ROW_NUM
          From funcionario a
         Where ROWNUM <= 20
         Order By a.ID
        
        )
 Where ROW_NUM > 10
 
 
 public PagedResult<LocalidadeModel> GetLocalidadePaginacao(int pageNo, int pageSize)
        {
            var skip = (pageNo - 1) * pageSize;

            var total = Session.Query<LocalidadeModel>().Count();

            var localidade = Session.Query<LocalidadeModel>()
                .Where(x => x.DataExclusao == null)
                .OrderBy(x => x.Nome)
                .Skip(skip)
                .Take(pageSize);

            return new PagedResult<LocalidadeModel>(localidade, pageNo, pageSize, total);
        }