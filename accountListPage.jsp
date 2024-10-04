<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%-- DB로부터 오는 값을 받아주는 라이브러리(셀렉트 할 때 필요함) --%>
<%@ page import="java.sql.ResultSet" %> 


<%-- 벡엔드 통신 --%>

<% 
// jsp 문법을 적을 수 있는 공간

//  받아올 값 없으므ㅡ로 그부분 지워주기


// DB 코드(라이브러리 쓸거임: 위에서 임포트 해야함)

// DB Connect 찾아오기 ////
Class.forName("org.mariadb.jdbc.Driver"); // 커넥터를 찾아오는 부분(에러 : 커넥터 파일이 잘못됐거나, 디비 서버가 꺼져있거나, 디비가 설치가 안됐거나 등 디비 관련된 문제임)

// DB 통신 연결 ////
Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "stageus", "1234"); // db에 연결하는 부분(디비의 ip주소)
// jdbc:mariadb://localhost ->  : localhost데이터베이스 서버의 ip 주소
// 3306 : 마리아디비 포트
// web : 내가 사용할 디비 이름

// SQL 작성 ////
String sql = "SELECT * FROM account"; // SQL을 만들어주는 라이브러리

// SQL 전송 준비 상태로 만들기 ////
PreparedStatement query = connect.prepareStatement(sql);


//// Query 전송 ////
ResultSet result = query.executeQuery(); // 값을 받아오므로 변수 만들어줌
// 테이블을 가져오는데 제일 위 로우의 제일 앞에 커서가 있음. 이 커서가 한줄 끝으로 이동하면 읽은거임. 다음줄로 ㄴ커서가 넘어가서 반복함(반복문 중 while문)

// result.next() // 커서를 한줄 이동시키는 명령어(첫번째 로우를 읽은거임)
// result.getString("id") // 첫번째 로우의 id를 읽음(메모리에 잠깐 올라감)
// result.getString("pw") // 첫번째 로우의 pw를 읽음
// result.next() // 두번째 로우를 읽은거임
// result.getString("id") // 두번째 로우의 id를 읽음(메모리에 잠깐 올라감)
// result.getString("pw") // 두번째 로우의 pw를 읽음

// result.next()를 일단 해보고 불가능하면(다읽었을 때) 멈춤
// while(result.next()) {
//   result.getString("id")
//   result.getString("pw")
// }

%>

<%-- 화면에 그려주는 코드는 여기서부터임 --%>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
</head>
<body>
  
  <% while(result.next()) { %>

  <div>
    <span><%=result.getString("id")%></span>
    <span><%=result.getString("pw")%></span>
  </div>

  <% } %>
  <%-- while문 만큼 html을 그려줌  --%>

</body>

<%-- jsp에서 프론트로 넘어오는 값은 자료형이 무시된채로 raw 데이터가 넘어옴("ㄴㄹㅁ"를 입력하면 "ㄴㄹㅁ"가 아니라 ㄴㄹㅁ로 넘어옴) --%>
<%-- => 쌍따옴표를 넣어줘야 함 => (<%=idValue%>) 를 ("<%=idValue%>")로 해줘야함  --%>
