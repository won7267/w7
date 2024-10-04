<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%-- : html에서 !Doctype과 같은 역할. 복붙해서 다른 프로젝트에서도 쓰기! --%>

<%-- 커넥터 파일을 찾아오는 라이브러리(mariadb 찾는 라이브러리) --%>
<%@ page import="java.sql.DriverManager" %>
<%-- DB에 연결하는 라이브러리 --%>
<%@ page import="java.sql.Connection" %>
<%-- SQL을 만들어주는 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement" %>

<%-- 벡엔드 통신 --%>

<% 
// jsp 문법을 적을 수 있는 공간

  request.setCharacterEncoding("utf-8"); // 받아온 값에 대한 인코딩 설정(utf-8로 설정해주지 않으면 유티코드로 자동으로  되는데 그럼 한글이 깨짐)

  // String 타입의 idValue 변수를 만들겠다
  String idValue = request.getParameter("id");
  String pwValue = request.getParameter("pw");
  // request : 이전 페이지
  // request.getParameter() : 이전 페이지의 변수를 받겠다("키")


// DB 코드(라이브러리 쓸거임: 위에서 임포트 해야함)

// DB Connect 찾아오기 ////
// 마리아디비 커넥터의 
Class.forName("org.mariadb.jdbc.Driver"); // 커넥터를 찾아오는 부분(에러 : 커넥터 파일이 잘못됐거나, 디비 서버가 꺼져있거나, 디비가 설치가 안됐거나 등 디비 관련된 문제임)

// DB 통신 연결 ////
Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "stageus", "1234"); // db에 연결하는 부분(디비의 ip주소)
// jdbc:mariadb://localhost ->  : localhost데이터베이스 서버의 ip 주소
// 3306 : 마리아디비 포트
// web : 내가 사용할 디비 이름

// SQL 작성 ////
String sql = "INSERT INTO account (id, pw) VALUES (?, ?)"; // SQL을 만들어주는 라이브러리

// SQL 전송 준비 상태로 만들기 ////
PreparedStatement query = connect.prepareStatement(sql);
// 여기서의 쿼리 : 전송 준비 상태인 sql(명령어 덩어리)
query.setString(1, idValue); // ? 첫번째에 idValue 넣어줄것이다.
query.setString(2, pwValue);

// Query 전송 ////
query.executeUpdate();

%>

<%-- 프론트엔드 레이아웃(위 데이터를 사용한) --%>
<script>
// <%=idValue%> : jsp idValu변수를 갖다 쓰겠다
  console.log("<%=idValue%>")
  console.log("<%=pwValue%>")

  // 여기까지 내려왔으면 성공했다는 뜻이니 아래와 같은 코드 추가해주기
  alert("회원가입이 성공했습니다!")
  location.href = "index.html"

</script>

<%-- jsp에서 프론트로 넘어오는 값은 자료형이 무시된채로 raw 데이터가 넘어옴("ㄴㄹㅁ"를 입력하면 "ㄴㄹㅁ"가 아니라 ㄴㄹㅁ로 넘어옴) --%>
<%-- => 쌍따옴표를 넣어줘야 함 => (<%=idValue%>) 를 ("<%=idValue%>")로 해줘야함  --%>
