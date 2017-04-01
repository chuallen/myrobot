-- ɾ��ת����ˮ
delete from rec_repayment_record where rel_id in (
select id from rec_transit_record where trade_relation_id in (
select id from rec_contract_relation where loan_detail_id = (select id from rec_loan_detail where loan_code = 'HEB1201703090016')
)
);
-- ɾ��ת�˼�¼
delete from rec_transit_record where trade_relation_id in (
select id from rec_contract_relation where loan_detail_id = (select id from rec_loan_detail where loan_code = 'HEB1201703090016')
);
-- ɾ���ſ���ˮ
delete from rec_repayment_record where rel_id in (
select id from rec_draw_record where trade_relation_id in (
select id from rec_contract_relation where loan_detail_id = (select id from rec_loan_detail where loan_code = 'HEB1201703090016')
)
);
-- ɾ���ſ��¼
delete from rec_draw_record where trade_relation_id in (
select id from rec_contract_relation where loan_detail_id = (select id from rec_loan_detail where loan_code = 'HEB1201703090016')
);
-- ɾ��������ˮ
delete from rec_withhold_serial where rel_id in (
select id from rec_withhold_record where loan_repayment_plan_id in (
select id from rec_loaner_repayment_plan where loan_code = 'HEB1201703090016'
)
);
-- ɾ�����ۼ�¼
delete from rec_withhold_record where loan_repayment_plan_id in 
(select id from rec_loaner_repayment_plan where loan_code = 'HEB1201703090016');

-- ɾ�����˱�����
delete from rec_repayment_plan_relation where loan_repayment_plan_id in 
(select id from rec_loaner_repayment_plan where  loan_code = 'HEB1201703090016');

-- ɾ������ƻ�
delete from rec_loaner_repayment_plan where  loan_code = 'HEB1201703090016';

-- ɾ��ծƥ��ϵ
delete from rec_contract_relation where loan_detail_id = (select id from rec_loan_detail where loan_code = 'HEB1201703090016');

-- ɾ�������Ϣ
delete from rec_loan_detail where loan_code = 'HEB1201703090016';

-- �������Ϣ�������Ƿ��ظ�
select loan_code, count(0) from rec_loan_detail group by loan_code having count(0) > 1;

-- ��������Ϣ��������Ƿ��ظ�
select lend_code, count(0) from rec_lend_detail group by lend_code having count(0) > 1;

-- �»����, ʣ�౾��,��ǰ���廹���,�����ܶ�
select a.period, a.plan_repayment_total as '�»����' ,a.last_total_principal as 'ʣ�౾��' ,a.settlement_money as '��ǰ���廹���', 
a.plan_repayment_principal as '�»�����', a.plan_repayment_interest as '�»���Ϣ'
from rec_loaner_repayment_plan a where loan_code = 'BD1201703100006' 




-- 1�����ݽ�����Ų�ѯ�ſ�MQ��־
select 
a.customer_name "���ͻ�����",
a.account_id "���ͻ�id",
a.loan_code "�����",
f.customer_name "����ͻ�����",
f.account_id "����ͻ�id",
f.lend_code "������",
c.create_date "����ʱ��",
a.loan_principal "����",
c.interest "��Ϣ",
c.service_fee "�����",
c.draw_total_money "ʵ�ʷſ���",
c.trade_money "ƥ����",
d.principal "�ſ���",
d.interest "�ſ���Ϣ",
d.service_fee "�ſ�����",
e.req_params "����MQ��Ϣ",
e.res_data "����MQ��Ϣ",
d.global_id,
c.trade_relation_id "ƥ���ϵ����",
d.actual_money "��ˮ�ۿ���",
CASE a.draw_status
WHEN '1' THEN 'δ�ſ�'
WHEN '2' THEN '�ſ���'
WHEN '3' THEN '�ſ�ɹ�'
WHEN '4' THEN '�ſ�ʧ��'
WHEN '5' THEN '�ܾ�'
ELSE 'δ֪' END "������Ϣ�ſ�״̬",
CASE c.draw_status
WHEN '1' THEN 'δ�ſ�'
WHEN '2' THEN '�ſ���'
WHEN '3' THEN '�ſ�ɹ�'
WHEN '4' THEN '�ſ�ʧ��'
ELSE 'δ֪' END "�ſ��¼�ſ�״̬",
CASE d.status
WHEN '1' THEN 'δ����'
WHEN '2' THEN '������'
WHEN '3' THEN '�ɹ�'
WHEN '4' THEN 'ʧ��'
ELSE 'δ֪' END "�ſ���ˮ�ſ�״̬"
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



-- 2�����ݽ�����Ų�ѯ�ջ����ۺ�ת��״̬
select 
d.customer_name "���ͻ�����",
d.account_id "���ͻ�id",
e.customer_name "����ͻ�����",
e.account_id "����ͻ�id",
c.create_date "����ʱ��",
a.loan_code "�������",
e.lend_code "������",
a.current_end_date "�ջ�����",
a.period "����",
a.plan_repayment_total "�ջ��ܶ�",
b.plan_repayment_total "������Ӧ���ܶ�",
b.plan_repayment_principal "������Ӧ�ձ���",
b.plan_repayment_interest "������Ӧ����Ϣ",
b.warranty_flag "�ʱ���渶",
CASE b.status
WHEN '1' THEN 'δת��'
WHEN '2' THEN 'ת����'
WHEN '3' THEN 'ת�˳ɹ�'
WHEN '4' THEN 'ת��ʧ��'
ELSE 'δ֪' END "ת��״̬",
CASE c.status
WHEN '1' THEN 'δ����'
WHEN '2' THEN '������'
WHEN '3' THEN '�ɹ�'
WHEN '4' THEN 'ʧ��'
ELSE 'δ֪' END "��ˮ״̬"
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



-- 3�����ݽ�����Ų�ѯ�ջ�����״̬
select 
d.customer_name "���ͻ�����",
d.account_id "���ͻ�id",
c.create_date "����ʱ��",
a.loan_code "�������",
a.current_end_date "�ջ�����",
a.period "����",
a.plan_repayment_total "�ջ��ܶ�",
b.plan_repayment_total "�����ܶ�",
CASE b.status
WHEN '1' THEN 'δ����'
WHEN '2' THEN '������'
WHEN '3' THEN '���۳ɹ�'
WHEN '4' THEN '����ʧ��'
ELSE 'δ֪' END "����״̬",
c.actual_money "��ˮ�ۿ���",
CASE c.status
WHEN '1' THEN 'δ����'
WHEN '2' THEN '������'
WHEN '3' THEN '�ɹ�'
WHEN '4' THEN 'ʧ��'
ELSE 'δ֪' END "��ˮ״̬"
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




-- 4�����ݽ�����Ų�ѯծתMQ��־
select 
a.customer_name "���ͻ�����",
a.account_id "���ͻ�id",
a.loan_code "�����",
f.customer_name "����ͻ�����",
f.account_id "����ͻ�id",
f.lend_code "������",
c.create_date "����ʱ��",
a.loan_principal "����",
c.draw_total_money "ʵ�ʷſ���",
c.real_draw_date "ʵ�ʷſ�ʱ��",
d.principal "�ſ���",
d.interest "�ſ���Ϣ",
d.service_fee "�ſ�����",
e.req_params "����MQ��Ϣ",
e.res_data "����MQ��Ϣ",
d.global_id,
c.trade_relation_id "ƥ���ϵ����",
d.actual_money "��ˮ�ۿ���",
CASE c.draw_status
WHEN '1' THEN 'δ�ſ�'
WHEN '2' THEN '�ſ���'
WHEN '3' THEN '�ſ�ɹ�'
WHEN '4' THEN '�ſ�ʧ��'
ELSE 'δ֪' END "ծת��¼�ſ�״̬",
CASE d.status
WHEN '1' THEN 'δ����'
WHEN '2' THEN '������'
WHEN '3' THEN '�ɹ�'
WHEN '4' THEN 'ʧ��'
ELSE 'δ֪' END "�ſ���ˮ�ſ�״̬"
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





