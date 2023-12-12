<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%	//���� �� ������� null�� ������ �κ��� ��������ڿ��� ���� �ٶ��ϴ�.
	//out.println("����1");
	NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

    String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");

	String sSiteCode = "BZ557"; // NICE�κ��� �ο����� ����Ʈ �ڵ�
	String sSitePassword = "Hh6zYNNGKc5M"; // NICE�κ��� �ο����� ����Ʈ �н�����

    String sCipherTime = "";			// ��ȣȭ�� �ð�
    String sRequestNumber = "";			// ��û ��ȣ
    String sResponseNumber = "";		// ���� ������ȣ
    String sAuthType = "";				// ���� ����
    String sName = "";					// ����
    String sDupInfo = "";				// �ߺ����� Ȯ�ΰ� (DI_64 byte)
    String sConnInfo = "";				// �������� Ȯ�ΰ� (CI_88 byte)
    String sBirthDate = "";				// �������(YYYYMMDD)
    String sGender = "";				// ����
    String sNationalInfo = "";			// ��/�ܱ������� (���߰��̵� ����)
	String sMobileNo = "";				// �޴�����ȣ
	String sMobileCo = "";				// ��Ż�
    String sMessage = "";
    String sPlainData = "";
    
    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

    if( iReturn == 0 )
    {
        sPlainData = niceCheck.getPlainData();
        sCipherTime = niceCheck.getCipherDateTime();
        
        // ����Ÿ�� �����մϴ�.
        java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);
        
        sRequestNumber  = (String)mapresult.get("REQ_SEQ");
        sResponseNumber = (String)mapresult.get("RES_SEQ");
        sAuthType		= (String)mapresult.get("AUTH_TYPE");
        sName			= (String)mapresult.get("NAME");
		//sName			= (String)mapresult.get("UTF8_NAME"); //charset utf8 ���� �ּ� ���� �� ���
        sBirthDate		= (String)mapresult.get("BIRTHDATE");
        sGender			= (String)mapresult.get("GENDER");
        sNationalInfo  	= (String)mapresult.get("NATIONALINFO");
        sDupInfo		= (String)mapresult.get("DI");
        sConnInfo		= (String)mapresult.get("CI");
        sMobileNo		= (String)mapresult.get("MOBILE_NO");
        sMobileCo		= (String)mapresult.get("MOBILE_CO");
        String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");
        if(!sRequestNumber.equals(session_sRequestNumber))
        {
            sMessage = "���ǰ� ����ġ �����Դϴ�.";
            sResponseNumber = "";
            sAuthType = "";
        }
        else{
        	%>
        	<script src="https://d3e54v103j8qbb.cloudfront.net/js/jquery-3.4.1.min.220afd743d.js?site=5e9e98d3908fa91a88dbb4ca" type="text/javascript" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
        	<script>
        		console.log("dbg1");
        		var sName = '<%=sName %>';
        		var sBirthDate = '<%=sBirthDate %>';
        		var sGender = '<%=sGender %>';//0�̸� ���� 1�̸� ����
        		var mobile = '<%=sMobileNo %>';
        		var sDupInfo = '<%=sDupInfo %>';     
        		console.log("sDupInfo:"+sDupInfo +" sGender:"+sGender);
        		var idnum = sBirthDate.substring(2,8);
     /*    		if(sGender==0)
        			idnum= idnum+'2';
        		else
        			idnum= idnum+'1';
        		console.log("idnum:"+idnum); */
        		
        		
				var date = new Date();
                
                var year = date.getFullYear()-19;//���� 2020-19                  
                var birthdate = sBirthDate.substring(0,4);
                //console.log("year:"+year+" birthdate:"+birthdate);
                //����2020-19 = 2001 /   2001<birthday =>2001�� ���Ĵ� �̼��� 
                /* if( parseInt(year) < parseInt(birthdate)){
                	alert("�̼����ڴ� ������ �Ұ����մϴ�");
                } */
                console.log("dbg2");
                //���۽��� ����ȣ ���� ��� ��ȸ
                jQuery.ajax({
                    type:"POST",
                    url :"/landmine/verificationPhone.do?phone=" +mobile,
                    dataType:"json",
                    success : function(data) {
                    	if(data.result == "success"){
                    		opener.parent.getphone(mobile, sBirthDate, sName, 0);
                    	}
                    	else{
                        	alert("�޴��� ���� ���:"+data.msg);
                    	}
                    },
                     complete : function(data) {
                    	 console.log("complete!!!!!!!!!!!!!!!!!!!!!!!!");
                    	 self.close(); 
                     },
                     error : function(xhr, status , error){console.log("ajax ERROR!!! : " );}
                });
                
                
        		console.log("idnum:"+idnum);
        		
        		
        		
        		
        		/* opener.parent.getphone(mobile, sBirthDate, idnum, sName, sDupInfo);
        		self.close(); */
        	</script>        	
        	<%
        }
    }
    else if( iReturn == -1)
    {
        sMessage = "��ȣȭ �ý��� �����Դϴ�.";
    }    
    else if( iReturn == -4)
    {
        sMessage = "��ȣȭ ó�� �����Դϴ�.";
    }    
    else if( iReturn == -5)
    {
        sMessage = "��ȣȭ �ؽ� �����Դϴ�.";
    }    
    else if( iReturn == -6)
    {
        sMessage = "��ȣȭ ������ �����Դϴ�.";
    }    
    else if( iReturn == -9)
    {
        sMessage = "�Է� ������ �����Դϴ�.";
    }    
    else if( iReturn == -12)
    {
        sMessage = "����Ʈ �н����� �����Դϴ�.";
    }    
    else
    {
        sMessage = "�˼� ���� ���� �Դϴ�. iReturn : " + iReturn;
    }

%>
<%!

	public String requestReplace (String paramValue, String gubun) {

        String result = "";
        
        if (paramValue != null) {
        	
        	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

        	paramValue = paramValue.replaceAll("\\*", "");
        	paramValue = paramValue.replaceAll("\\?", "");
        	paramValue = paramValue.replaceAll("\\[", "");
        	paramValue = paramValue.replaceAll("\\{", "");
        	paramValue = paramValue.replaceAll("\\(", "");
        	paramValue = paramValue.replaceAll("\\)", "");
        	paramValue = paramValue.replaceAll("\\^", "");
        	paramValue = paramValue.replaceAll("\\$", "");
        	paramValue = paramValue.replaceAll("'", "");
        	paramValue = paramValue.replaceAll("@", "");
        	paramValue = paramValue.replaceAll("%", "");
        	paramValue = paramValue.replaceAll(";", "");
        	paramValue = paramValue.replaceAll(":", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll("#", "");
        	paramValue = paramValue.replaceAll("--", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll(",", "");
        	
        	if(gubun != "encodeData"){
        		paramValue = paramValue.replaceAll("\\+", "");
        		paramValue = paramValue.replaceAll("/", "");
            paramValue = paramValue.replaceAll("=", "");
        	}
        	
        	result = paramValue;
            
        }
        return result;
  }
%>

<html>
<head>
    <title>landmine</title>
</head>
<body>
   <center>
    <p><p><p><p>
    ���������� �Ϸ� �Ǿ����ϴ�.<br>
     <%-- <table border=1>
        <tr>
            <td>��ȣȭ�� �ð�</td>
            <td><%= sCipherTime %> (YYMMDDHHMMSS)</td>
        </tr>
        <tr>
            <td>��û ��ȣ</td>
            <td><%= sRequestNumber %></td>
        </tr>            
        <tr>
            <td>NICE���� ��ȣ</td>
            <td><%= sResponseNumber %></td>
        </tr>            
        <tr>
            <td>��������</td>
            <td><%= sAuthType %></td>
        </tr>
		<tr>
            <td>����</td>
            <td><%= sName %></td>
        </tr>
		<tr>
            <td>�ߺ����� Ȯ�ΰ�(DI)</td>
            <td><%= sDupInfo %></td>
        </tr>
		<tr>
            <td>�������� Ȯ�ΰ�(CI)</td>
            <td><%= sConnInfo %></td>
        </tr>
		<tr>
            <td>�������(YYYYMMDD)</td>
            <td><%= sBirthDate %></td>
        </tr>
		<tr>
            <td>����</td>
            <td><%= sGender %></td>
        </tr>
				<tr>
            <td>��/�ܱ�������</td>
            <td><%= sNationalInfo %></td>
        </tr>
        </tr>
			<td>�޴�����ȣ</td>
            <td><%= sMobileNo %></td>
        </tr>
		<tr>
			<td>��Ż�</td>
			<td><%= sMobileCo %></td>
        </tr>
		<tr>
			<td colspan="2">���� �� ������� ���� ������ ���� ���� ���Ϲ����� �� �ֽ��ϴ�. <br>
			�Ϻ� ������� null�� ���ϵǴ� ��� ��������� �Ǵ� ���μ�(02-2122-4615)�� ���ǹٶ��ϴ�.</td>
		</tr>
		</table><br><br>   --%>     
    <%= sMessage %><br> 
    </center> 
</body>
</html>