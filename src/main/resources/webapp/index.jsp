<%@include file="/includes/cookie.jsp" %>

<html>
    
    <%@ page session="true"%>
        
    <head>
        
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css" type="text/css" />
    
        <%@include file="/includes/header.jsp" %>
        
    <div id="main">
        <h1>Welcome to eClassroom!</h1>
        <p>eClassroom is an online web portal designed to provide teachers with a purpose-built test system, that aids in the classification of student abilities. The apporach used is based on 'The Mastery Approach to teaching' which states students should aim for mastery in each subject.</p>
        <p>In order to achieve this I have built a test-system that gives students a variety of questions at three different levels; easy medium and hard. Based on their achievement over the course of a test, the student is posed questions at different difficulty levels. A detailed report is then shown to both the student and the teacher, with a detailed overview of how the student did on each question.</p>
        <p>eClassroom is a great tool for pre-learning an the reinforcement of concepts. At the start of a topic the teacher could use a set of questions to gauge students understanding from previous years. At the end of each lesson they can then ask another set of questions to gauge how much the students understanding has advanced.</p>
    </div>
        
        
</body>
</html>