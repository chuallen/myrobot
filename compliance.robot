*** Settings ***
Suite Setup       Close All Browsers
Test Setup
Test Teardown
Library           Selenium2Library
Library           DatabaseLibrary
Library           Collections
Library           XML
Library           Screenshot
Library           AutoItLibrary
Library           ExampleLibrary
Library           ExampleLibrary.OtherLibrary

*** Test Cases ***
借款端_注册_登录_预约申请
    Open Browser    https://lo-test.yingu.com/#/register

金管系统_录单
    金管系统_录单配置    liuliu    1    0

金管系统_上传图片
    上传图片loancode查询    HEB1201703160007    http://10.0.129.210:8091/

金管系统_提交
    提交

金管系统_初审
    Open Browser    http://10.0.129.210:8091/    chrome
    send    {F11}
    Comment    Maximize Browser Window
    input text    name=user_name    zhangyanbing
    input text    name=user_pass    1
    Click Button    imageField
    sleep    1
    Click Element    //*[@id='left15']
    sleep    2
    Click Element    //*[@id='left15_zi14']    #获取订单
    sleep    5
    Click Element    {BACKSPACE}
    sleep    5
    Select From List By Index    xpath=//*[@id='14']    2
    Click Element    //*[@id='button']
    sleep    5
    Click Element    //*[@id='form1']/div[1]/div/ul/li[6]/a
    sleep    5
    Select Window    url=http://10.0.129.152:8091/XinShen/XinshenBiao/HEB1201703140005#
    Execute Javascript    document.documentElement.scrollTop=20000
    Input Text    //*[@id='CheckIncome']    5000
    Input Text    //*[@id='XDExtendLoan']    5
    Click Element    //*[@id='form1']/div[25]/input[2]

金管系统_终审
    Open Browser    http://10.0.129.210:8091/
    Maximize Browser Window
    input text    name=user_name    zsgongzhijing
    input text    name=user_pass    123456
    Click Button    imageField
    sleep    1
    Click Element    left17
    sleep    2
    Click Element    left17_zi22
    sleep    2
    Click Element    btn
    sleep    5
    Confirm Action
    Click Element    xpath=html/body/div[1]/div/table/tbody/tr[2]/td[2]/div/table/tbody/tr[3]/td/div/button
    click element    xpath=//*[@id='datagrid-row-r1-1-0']/td[2]/div/a
    sleep    5
    Click link    //*[@id='datagrid-row-r1-1-0']/td[2]
    Select Window    http://10.0.129.152:8091/XinShen/ZS_XSB_xinshenbiao/DY1201510156210011?type=2

liuliu确认金额
    柳柳确认金额    0    100000

借款端绑卡签约
    Open Browser    https://lo-test.yingu.com/#/login

运营系统审核通过
    Open Browser    http://10.0.129.210:9001/
    Maximize Browser Window
    input text    user_name    kehaitao
    input text    user_pass    1
    Click Button    imageField
    sleep    3
    click element    xpath=html/body/div[2]/div[2]/a[1]/img
    sleep    3
    Comment    goto    http://10.0.128.112:8089/Normal/Index
    sleep    3
    Click Link    合同审核
    input text    txtName    褚志强
    sleep    5
    Click Element    xpath=html/body/div[4]/div[1]/ul/li[15]/input
    sleep    5
    Click Element    xpath=//*[@id='divContent']/div[3]/div[8]/a

银谷后台挂标
    Comment    银谷后台挂标    2017-03-17    1    6    #银多利1
    Comment    银谷后台挂标    2017-03-17    2    8    #银多利3
    银谷后台挂标    2017-03-17    3    6    #银多利6
    Comment    银谷后台挂标    2017-03-17    4    6    #银多利12
    Comment    银谷后台挂标    2017-03-17    3    8    #银多利24
    Comment    银谷后台挂标    2017-03-17    6    5    #银月赢12
    Comment    银谷后台挂标    2017-03-17    7    3    #银月赢24
    Comment    银谷后台挂标    2017-03-17    8    2    #谷便利
    Comment    银谷后台挂标    2017-03-17    9    8    #新手福利
    Comment    银谷后台挂标    2017-03-17    10    5    #银多利36期

债匹系统预留列表
    Open Browser    http://10.0.128.246:8081/yingu-claim-rule/
    send    {f11}
    input text    account    test
    input text    password    123456
    Click Button    login
    sleep    3
    Click Element    //*[@id='parentMenu_1']
    sleep    3
    Click Element    //*[@id="subMenu_1"]/li[8]/a
    sleep    3
    input text    //*[@id='formList']/div/input[4]    褚志强
    sleep    2
    Click Element    //*[@id='formList']/div/input[4]

银谷后台挂标后推送
    Open Browser    https://qa01-www.yingujr.com/    chrome
    input text    form-username    test
    input text    form-password    123456
    Click Button    butto
    sleep    5
    send    {F11}
    Click Element    //*[@id="side-menu"]/li[16]/a/span[1]
    sleep    5
    Click Element    //*[@id="side-menu"]/li[16]/ul/li/a
    sleep    5
    sleep    2
    Select Frame    //*[@id="content-main"]/iframe[2]
    Select From List By Index    //*[@id="push"]    1
    sleep    5
    Click Element    xpath=/html/body/div[1]/div[2]/div[1]/div[2]/button[1]
    sleep    3
    Click Element    //*[@id="tb_departments"]/thead/tr/th[1]/div[1]/input

银谷在线出借端
    Open Browser    https://qa01-passport.yingujr.com/sso/login?service=https%3A%2F%2Fqa01-www.yingujr.com%2Fuser%2Fbank    ie
    send    {f11}
    input text    userName    17710181598
    input text    password    hand1234
    Click element    submit

贷后管理系统
    Open Browser    http://10.0.129.171:13080/
    Maximize Browser Window
    sleep    2
    input text    //*[@id='regForm']/div[1]/input    admin    #输入用户名
    sleep    2
    input text    //*[@id='regForm']/div[2]/input    admin    #输入 密码
    Click Button    //*[@id='regForm']/div[3]/div/button    #点击登陆

金融管理系统上传合同
    Open Browser    http://10.0.129.210:8091/
    Maximize Browser Window
    input text    name=user_name    liuliu
    input text    name=user_pass    1
    Click Button    imageField
    sleep    2
    Click Element    //*[@id='left3']
    Click Element    //*[@id='left3_zi77']
    sleep    2
    Comment    Select From List By Index    left3_zi77    5
    Select From List By Index    ApprovalStatus    5
    Click Element    xpath=//*[@id='bodyer']/div[2]/div[2]/div[2]/div/div[1]/ul/li[12]/input

运营终审通过
    Open Browser    http://10.0.129.210:9001/
    Maximize Browser Window
    input text    user_name    kehaitao
    input text    user_pass    1
    Click Button    imageField
    sleep    3
    click element    xpath=html/body/div[2]/div[2]/a[1]/img
    sleep    3
    Comment    goto    http://10.0.128.112:8089/Normal/Index
    sleep    3
    Click Link    合同审核
    input text    txtName    张楠
    sleep    5
    Click Element    xpath=html/body/div[4]/div[1]/ul/li[15]/input
    sleep    5
    Click Element    xpath=//*[@id='divContent']/div[3]/div[8]/a

线上放款端转账
    Open Browser    http://172.24.132.69:8080/loan-online/
    Maximize Browser Window
    input text    username    YG0005266
    input text    pwd    111111aA
    Click link    登录

自助月还系统
    Open Browser    http://10.0.129.131:9080
    Maximize Browser Window
    input text    usernameone    13311598060
    input text    passwordone    123456
    Click Element    logging

线上借款端登录
    Open Browser    https://lo-test.yingu.com/#/login

会退重新邦卡流程
    Open Browser    http://172.24.132.69:9090/lo-server/    firefox    first
    send    {F11}
    input text    username    onlineAdmin
    input text    pwd    111111aA
    Click link    登录

登录先上
    [Setup]    Close All Browsers

生成4个字符串
    ${A}    Gen Nums    4
    LOG    ${A}

*** Keywords ***
借款端_预约申请
    Open Browser    https://lo-test.yingu.com

金管系统_录单配置
    [Arguments]    ${PoneNum}    ${passwd}    ${order}
    Open Browser    http://10.0.129.210:8091/
    Comment    send    {f11}
    Maximize Browser Window
    input text    name=user_name    ${PoneNum}
    input text    name=user_pass    ${passwd}
    Click Button    imageField
    sleep    5
    Click Element    id=left1
    sleep    2
    Click Element    id=left1_zi3
    sleep    5
    Click Element    //*[@id='datagrid-row-r1-1-${order}']/td[2]/div/a
    sleep    1
    Select From List By Index    1    1
    sleep    1
    input text    month_repayment    1000
    sleep    1
    Select From List By Index    daikuanleixing    2
    sleep    1
    Select From List By Index    Repayment    2
    sleep    1
    Select From List By Index    4    2
    sleep    1
    Execute Javascript    document.documentElement.scrollTop=500
    Select From List By Index    5    2
    sleep    1
    input text    Nation    汉族
    sleep    1
    Select From List By Index    7    2
    sleep    1
    Select From List By Index    zhufangxingzhi    2
    sleep    1
    Select From List By Index    chechanzhuangkuang    2
    sleep    1
    Select From List By Index    8    2
    sleep    5
    Click Element    canjiagongzuoshijian
    sleep    5
    Select Frame    xpath=/html/body/div[6]/iframe
    Click Element    dpOkInput
    Unselect Frame
    sleep    1
    Select From List By Index    hukoushi    1
    sleep    1
    Select From List By Index    hukouqu    1
    sleep    1
    input text    hukoudizhi    北京市海淀
    sleep    1
    Select From List By Index    zhuzhaishi    1
    sleep    1
    Select From List By Index    zhuzhaiqu    1
    sleep    1
    input text    zhuzhaidizhi    北京市海淀区1
    sleep    1
    Select From List By Index    property_type    2
    sleep    1
    Select From List By Index    9    2
    sleep    1
    input text    CompanyRegistrationID    111111111111111111
    sleep    1
    input text    department    技术部
    sleep    1
    input text    danweiquhao    010
    sleep    1
    input text    officetel    58975555
    sleep    1
    input text    income    50000
    sleep    1
    Select From List By Index    danweishi    1
    sleep    1
    Select From List By Index    danweiqu    1
    sleep    1
    input text    compantadd    北京市石景山
    sleep    1
    Select From List By Index    hangyeleixing    2
    sleep    1
    Select From List By Index    zhiyeleixing    2
    sleep    1
    Select From List By Index    10    2
    sleep    1
    Select From List By Index    position_level    2
    sleep    1
    Click Element    dates_employed
    Select Frame    xpath=/html/body/div[6]/iframe
    Click Element    dpOkInput
    Unselect Frame
    input text    companyname    银谷
    sleep    1
    input text    Direct_relative_1    张三
    sleep    1
    input text    relation_d1    父亲
    sleep    1
    input text    Phone_d1    13701558552
    sleep    1
    input text    Direct_relative_2    李四
    sleep    1
    input text    relation_d2    母亲
    sleep    1
    input text    Phone_d2    13677778452
    sleep    1
    input text    contacts_1    王五
    sleep    1
    input text    relation_c1    苟富贵
    sleep    1
    input text    Phone_c1    15801452565
    sleep    1
    input text    contacts_2    朋友
    sleep    1
    input text    relation_c2    让他人
    sleep    1
    input text    Phone_c2    13662559531
    sleep    1
    Select From List By Index    13    2
    sleep    1
    Select From List By Index    tuandui    2
    sleep    1
    Select From List By Index    xiaoshou    3
    sleep    1
    input text    Spouse    撒旦法
    sleep    1
    input text    relation_s    撒旦法发
    sleep    1
    input text    Phone_s    15801125425
    sleep    1
    input text    property_type_money    1000000
    Click Button    button2
    Click Element    xpath=html/body/div[1]/div/table/tbody/tr[2]/td[2]/div/table/tbody/tr[3]/td/div/button[1]
    sleep    10
    Comment    Close Browser

上传图片loancode查询
    [Arguments]    ${loancode}    ${url}
    Open Browser    http://10.0.129.210:8091/    chrome    first
    send    {F11}
    input text    name=user_name    liuliu
    input text    name=user_pass    1
    Click Button    imageField
    sleep    5
    Comment    Click Element    id=left1
    Comment    sleep    2
    Comment    Click Element    //*[@id='left1_zi2']
    Comment    sleep    3
    Comment    Input Text    //*[@id='select']/span[2]/input    ${loancode}
    Comment    sleep    3
    Comment    click element    //*[@id='select']/span[2]/span/span
    sleep    1
    Comment    Click Element    id=datagrid-row-r1-1-0
    sleep    5
    click element    //*[@id="datagrid-row-r1-1-0"]/td[2]/div/a
    sleep    5
    Select Window    url=${url}
    sleep    5
    Click Element    uploadifyUploader
    Wait For Active Window    打开
    Control Click    打开    \    Edit1
    send    "D023.png"
    sleep    5
    Control Click    打开    \    DirectUIHWND2
    Send    {CTRLDOWN}
    Send    a
    Control Click    打开    \    Button1
    sleep    5
    Execute Javascript    document.documentElement.scrollTop=20000
    Click Element    //*[@id='btnBegin']/img
    Comment    Close Browser
    Switch Browser    first
    sleep    10
    Click Element    //*[@id='left1_zi3']
    sleep    5
    Click Element    //*[@id='datagrid-row-r1-1-0']/td[2]/div/a
    sleep    2

提交
    Open Browser    http://10.0.129.210:8091/
    Maximize Browser Window
    input text    name=user_name    jiaofeng
    input text    name=user_pass    1
    Click Button    imageField
    sleep    1
    Click Element    id=left2
    sleep    2
    Click Element    //*[@id='left2_zi4']
    sleep    1
    Click Element    //*[@id='datagrid-row-r2-1-0']/td[2]/div/a
    sleep    5
    Select From List By Index    xpath=//*[@id='14']    2
    input text    Loanremark    提交
    Click Element    //*[@id='button']
    Click Element    xpath=html/body/div[1]/div/table/tbody/tr[2]/td[2]/div/table/tbody/tr[3]/td/div/button[1]
    sleep    5
    Close Browser

上传图片loancode改造
    [Arguments]    ${loancode}    ${url}
    Open Browser    http://10.0.129.152:8091    firefox    first
    Maximize Browser Window
    input text    name=user_name    liuliu
    input text    name=user_pass    1
    Click Button    imageField
    sleep    5
    Click Element    id=left1
    sleep    2
    Click Element    //*[@id='left1_zi2']
    sleep    3
    Input Text    //*[@id='select']/span[2]/input    ${loancode}
    sleep    3
    click element    //*[@id='select']/span[2]/span/span
    sleep    1
    Comment    Click Element    id=datagrid-row-r1-1-0
    sleep    5
    click element    //*[@id='datagrid-row-r1-1-0']/td[2]/div/a
    sleep    5
    Select Window    url=${url}
    sleep    5
    Click Element    uploadifyUploader
    Wait For Active Window    打开
    Control Click    打开    \    Edit1
    send    "D023.png"
    sleep    5
    Control Click    打开    \    DirectUIHWND2
    Send    {CTRLDOWN}
    Send    a
    Control Click    打开    \    Button1
    sleep    5
    Execute Javascript    document.documentElement.scrollTop=20000
    Click Element    //*[@id='btnBegin']/img
    Comment    Close Browser
    Switch Browser    first
    sleep    10
    Click Element    //*[@id='left1_zi3']
    sleep    5
    Click Element    //*[@id='datagrid-row-r1-1-0']/td[2]/div/a
    sleep    2

柳柳确认金额
    [Arguments]    ${row}    ${money}
    Open Browser    http://10.0.129.210:8091/
    Maximize Browser Window
    input text    name=user_name    liuliu
    input text    name=user_pass    1
    Click Button    imageField
    sleep    5
    Click Element    left2
    Click Element    left2_zi5
    sleep    5
    Click Element    //*[@id='datagrid-row-r1-1-${row}']/td[2]/div/a
    Execute Javascript    document.documentElement.scrollTop=800
    input text    XDExtendLoan    ${money}
    SLEEP    3
    Click Element    //*[@id='anniu']/tbody/tr/td/input[5]
    Input Text    //*[@id='demo-labs-input']    ${money}
    SLEEP    2
    Click Element    XPATH=html/body/div[1]/div/table/tbody/tr[2]/td[2]/div/table/tbody/tr[3]/td/div/button[1]
    Confirm Action

银谷后台挂标
    [Arguments]    ${date}    ${Period}    ${Money}
    Open Browser    http://qa01-jr.sysop.yingu.com/login \    chrome
    input text    form-username    test
    input text    form-password    123456
    Click Button    butto
    sleep    5
    send    {F11}
    Click Element    //*[@id="side-menu"]/li[16]/a/span[1]
    sleep    5
    Click Element    //*[@id="side-menu"]/li[16]/ul/li/a
    sleep    5
    sleep    2
    Select Frame    //*[@id="content-main"]/iframe[2]
    Click Element    //*[@id="btn_add"]    #点击增加
    sleep    5
    Click Element    //*[@id="pushTime"]
    Click Element    xpath=/html/body/div[5]/div[1]/table/tfoot/tr[1]/th
    Comment    send    2017-03-17
    sleep    3
    Input Text    //*[@id="plan_id"]/div[${Period} ]/div/div[1]/input    ${Money}
    sleep    3
    Click Element    //*[@id="btn_save"]
    sleep    5
    Click Element    xpath=/html/body/div[5]/div[7]/button[2]
    Select From List By Index    //*[@id="push"]    5
    sleep    5
    Click Element    xpath=/html/body/div[1]/div[2]/div[1]/div[2]/button[1]
    sleep    5
    Click Element    //*[@id="tb_departments"]/thead/tr/th[1]/div[1]/input
    sleep    5
    click element    //*[@id="btn_push"]
