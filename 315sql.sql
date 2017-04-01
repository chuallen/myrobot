-- 删除转账流水
delete from rec_repayment_record where rel_id in (
select id from rec_transit_record where trade_relation_id in (
select id from rec_contract_relation where loan_detail_id = (select id from rec_loan_detail where loan_code = 'HEB1201703090016')
)
);
-- 删除转账记录
delete from rec_transit_record where trade_relation_id in (
select id from rec_contract_relation where loan_detail_id = (select id from rec_loan_detail where loan_code = 'HEB1201703090016')
);
-- 删除放款流水
delete from rec_repayment_record where rel_id in (
select id from rec_draw_record where trade_relation_id in (
select id from rec_contract_relation where loan_detail_id = (select id from rec_loan_detail where loan_code = 'HEB1201703090016')
)
);
-- 删除放款记录
delete from rec_draw_record where trade_relation_id in (
select id from rec_contract_relation where loan_detail_id = (select id from rec_loan_detail where loan_code = 'HEB1201703090016')
);
-- 删除代扣流水
delete from rec_withhold_serial where rel_id in (
select id from rec_withhold_record where loan_repayment_plan_id in (
select id from rec_loaner_repayment_plan where loan_code = 'HEB1201703090016'
)
);
-- 删除代扣记录
delete from rec_withhold_record where loan_repayment_plan_id in 
(select id from rec_loaner_repayment_plan where loan_code = 'HEB1201703090016');

-- 删除分账表数据
delete from rec_repayment_plan_relation where loan_repayment_plan_id in 
(select id from rec_loaner_repayment_plan where  loan_code = 'HEB1201703090016');

-- 删除还款计划
delete from rec_loaner_repayment_plan where  loan_code = 'HEB1201703090016';

-- 删除债匹关系
delete from rec_contract_relation where loan_detail_id = (select id from rec_loan_detail where loan_code = 'HEB1201703090016');

-- 删除借款信息
delete from rec_loan_detail where loan_code = 'HEB1201703090016';

-- 检查借款信息表借款编号是否重复
select loan_code, count(0) from rec_loan_detail group by loan_code having count(0) > 1;

-- 检查出借信息表出借编号是否重复
select lend_code, count(0) from rec_lend_detail group by lend_code having count(0) > 1;

-- 月还款额, 剩余本金,提前结清还款额,还款总额
select a.period, a.plan_repayment_total as '月还款额' ,a.last_total_principal as '剩余本金' ,a.settlement_money as '提前结清还款额', 
a.plan_repayment_principal as '月还本金', a.plan_repayment_interest as '月还利息'
from rec_loaner_repayment_plan a where loan_code = 'BD1201703100006' 




-- 1、根据进件编号查询放款MQ日志
select 
a.customer_name "借款客户姓名",
a.account_id "借款客户id",
a.loan_code "借款编号",
f.customer_name "出借客户姓名",
f.account_id "出借客户id",
f.lend_code "出借编号",
c.create_date "操作时间",
a.loan_principal "借款本金",
c.interest "利息",
c.service_fee "服务费",
c.draw_total_money "实际放款金额",
c.trade_money "匹配金额",
d.principal "放款金额",
d.interest "放款利息",
d.service_fee "放款服务费",
e.req_params "请求MQ信息",
e.res_data "返回MQ信息",
d.global_id,
c.trade_relation_id "匹配关系主键",
d.actual_money "流水扣款金额",
CASE a.draw_status
WHEN '1' THEN '未放款'
WHEN '2' THEN '放款中'
WHEN '3' THEN '放款成功'
WHEN '4' THEN '放款失败'
WHEN '5' THEN '拒绝'
ELSE '未知' END "出借信息放款状态",
CASE c.draw_status
WHEN '1' THEN '未放款'
WHEN '2' THEN '放款中'
WHEN '3' THEN '放款成功'
WHEN '4' THEN '放款失败'
ELSE '未知' END "放款记录放款状态",
CASE d.status
WHEN '1' THEN '未处理'
WHEN '2' THEN '处理中'
WHEN '3' THEN '成功'
WHEN '4' THEN '失败'
ELSE '未知' END "放款流水放款状态"
from rec_loan_detail a,
rec_contract_relation b,
rec_draw_record c,
rec_repayment_record d,
rec_log e,
rec_lend_detail f
where a.id = b.loan_detail_id
and b.id = c.trade_relation_id
and c.id = d.rel_id
and d.global_id = e.biz_id
and f.id = b.lend_detail_id
-- and c.draw_status = d.status
and d.type = 1
-- and d.status = 4
and a.loan_code = 'BJ1201703160004';



-- 2、根据进件编号查询日还代扣后转账状态
select 
d.customer_name "借款客户姓名",
d.account_id "借款客户id",
e.customer_name "出借客户姓名",
e.account_id "出借客户id",
c.create_date "操作时间",
a.loan_code "进件编号",
e.lend_code "出借编号",
a.current_end_date "日还日期",
a.period "期数",
a.plan_repayment_total "日还总额",
b.plan_repayment_total "出借人应收总额",
b.plan_repayment_principal "出借人应收本金",
b.plan_repayment_interest "出借人应收利息",
b.warranty_flag "质保金垫付",
CASE b.status
WHEN '1' THEN '未转账'
WHEN '2' THEN '转账中'
WHEN '3' THEN '转账成功'
WHEN '4' THEN '转账失败'
ELSE '未知' END "转账状态",
CASE c.status
WHEN '1' THEN '未处理'
WHEN '2' THEN '处理中'
WHEN '3' THEN '成功'
WHEN '4' THEN '失败'
ELSE '未知' END "流水状态"
from 
rec_loaner_repayment_plan a,
rec_repayment_plan_relation b,
rec_repayment_record c,
rec_loan_detail d,
rec_lend_detail e
where 1 = 1
and a.id = b.loan_repayment_plan_id
and b.id = c.rel_id
and a.loan_detail_id = d.id
and e.id = b.lend_detail_id
and c.type in (2, 5)
and a.loan_code = 'HEB1201703170010';



-- 3、根据进件编号查询日还代扣状态
select 
d.customer_name "借款客户姓名",
d.account_id "借款客户id",
c.create_date "操作时间",
a.loan_code "进件编号",
a.current_end_date "日还日期",
a.period "期数",
a.plan_repayment_total "日还总额",
b.plan_repayment_total "代扣总额",
CASE b.status
WHEN '1' THEN '未代扣'
WHEN '2' THEN '代扣中'
WHEN '3' THEN '代扣成功'
WHEN '4' THEN '代扣失败'
ELSE '未知' END "代扣状态",
c.actual_money "流水扣款金额",
CASE c.status
WHEN '1' THEN '未处理'
WHEN '2' THEN '处理中'
WHEN '3' THEN '成功'
WHEN '4' THEN '失败'
ELSE '未知' END "流水状态"
from 
rec_loaner_repayment_plan a,
rec_withhold_record b,
rec_withhold_serial c,
rec_loan_detail d
where 1 = 1
and a.id = b.loan_repayment_plan_id
and b.id = c.rel_id
and a.loan_detail_id = d.id
and a.loan_code = 'HEB1201703170010';




-- 4、根据进件编号查询债转MQ日志
select 
a.customer_name "借款客户姓名",
a.account_id "借款客户id",
a.loan_code "借款编号",
f.customer_name "出借客户姓名",
f.account_id "出借客户id",
f.lend_code "出借编号",
c.create_date "操作时间",
a.loan_principal "借款本金",
c.draw_total_money "实际放款金额",
c.real_draw_date "实际放款时间",
d.principal "放款金额",
d.interest "放款利息",
d.service_fee "放款服务费",
e.req_params "请求MQ信息",
e.res_data "返回MQ信息",
d.global_id,
c.trade_relation_id "匹配关系主键",
d.actual_money "流水扣款金额",
CASE c.draw_status
WHEN '1' THEN '未放款'
WHEN '2' THEN '放款中'
WHEN '3' THEN '放款成功'
WHEN '4' THEN '放款失败'
ELSE '未知' END "债转记录放款状态",
CASE d.status
WHEN '1' THEN '未处理'
WHEN '2' THEN '处理中'
WHEN '3' THEN '成功'
WHEN '4' THEN '失败'
ELSE '未知' END "放款流水放款状态"
from rec_loan_detail a,
rec_contract_relation b,
rec_transit_record c,
rec_repayment_record d,
rec_log e,
rec_lend_detail f
where a.id = b.loan_detail_id
and b.id = c.trade_relation_id
and c.id = d.rel_id
and d.global_id = e.biz_id
and f.id = b.lend_detail_id
-- and c.draw_status = d.status
and d.type = 3
-- and d.status = 4
and a.loan_code = 'HEB1201703180002';

SELECT  a.`period`,a.`plan_repayment_total`,a.`plan_repayment_principal`,a.`current_start_date`,a.`current_end_date`,
a.`plan_repayment_interest`,a.`penalty_interest`,a.`penalty_days`,a.`penalty_money`,a.daily_actual_should_paid_total
FROM rec_loaner_repayment_plan a  WHERE a.loan_code='HEB1201703290004'





