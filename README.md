# eClassroom
This is a repository to hold the codebase for my dissertation. I am building a Jetty web app to provide a teaching tool, that makes it easy to track student progress. To see progress reports on the project visit my youtube playlist:

https://www.youtube.com/playlist?list=PLMr7li1270gzCz9S47pD2mVdiJB3QZsrp

##Research
My research has led me to decide on developing a tool which aids in the mastery approach of teaching, an approach that I believe is able to provide a good level of understanding to all students of a class, rather than a select few.

##Aims
The aim of the eClassroom is to provide a 'lesson' for students to run through at the start of a new topic to gauge current understanding, and at the end of each lesson to track understanding of concepts for each individual student. Each lesson begins with three placement questions, an easy, medium and hard question. Based on the outcome of these three placement questions a student will be set on either the easy, medium or hard root.

If a student is placed on the easy root, by getting a certain number of questions correct in a row, or overall, they can move up to the medium root. For example if a student is on the 5th question of the easy root, they will be given the 6th question of the medium root when they move up tier. Similarly if a student gets a certain number of questions in a row incorrect, they will drop down a tier.

Points are assigned for each correct answer on a root, not for the placement questions. 1 point will be assigned for an easy question, 3 points for a medium question and 5 points for a hard question. Based on the points total at the end of a lesson, the student can be set tasks or given resources. The maximum points available on any lesson is 50.

For example a student with less than 10 points may be asked to review the lesson material from that day, a student with 10-25 points may be given a reinforcement task, students with 25-40 points may be given some advanced questions, and a score of 40+ could provide the student with a Youtube video to watch. These tiers will be customisable for each individual lesson.

##Goals
The end goal of this project is a complete eClassroom website, allowing teachers to create classes of students, set lessons to the class, and view attempts at the lesson by each student. The aim of the tool is to provide a good environment for pre-learning at the start of a new topic, and to aid in the reinforcement of concepts at the end of each lesson.

##Running the code
To run the project at it's given state, download to your computer and load into eclipse, or another IDE. Run the main JettyServer.java file to start the server on port 8080, then navigate to localhost:8080 in your web browser. There is currently no persistent data stored by the server, so all user accounts are deleted on stopping of the server. In coming weeks I shall be hosting the webapp on AWS servers, email me at billy.rebecchi@googlemail.com to find out when the eClassroom Alpha will be going live.