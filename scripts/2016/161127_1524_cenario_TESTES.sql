declare @tmp varchar(6); set @tmp = 'ailton'

select left(@tmp,len(@tmp)-1)

select CONVERT(VARCHAR(4),@tmp)