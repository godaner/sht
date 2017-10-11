/*需要手动添加的定时器*/


/*同步类型数量*/
DECLARE jobno0 number;
begin 
      dbms_job.submit(jobno0,'SYNCCLAZZSNUM;',sysdate,'sysdate + 1/1440');
end;



/*7天接收商品*/
DECLARE jobno0 number;
begin 
      dbms_job.submit(jobno0,'receiverGoods;',sysdate,'sysdate + 1/1440');
end;

