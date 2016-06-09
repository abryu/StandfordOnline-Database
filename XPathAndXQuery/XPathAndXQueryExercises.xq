(: Question 1 :)
(: Return all Title elements (of both departments and courses). :)

let $d := doc("courses.xml")
return $d//Title

(: Question 2 :)
(: Return last names of all department chairs. :)

let $d := (doc("courses.xml")/Course_Catalog/Department)
for $x in $d/Chair/Professor 
return $x/Last_Name

(: Question 3 :)
(: Return titles of courses with enrollment greater than 500 . :)

let $a := doc("courses.xml")/Course_Catalog/Department
for $s in $a/Course 
where $s/@Enrollment > 500
return $s/Title

(: Question 4 :)
(: Return titles of departments that have some course that takes "CS106B" as a prerequisite. :)

let $c := doc("courses.xml")/Course_Catalog
for $a in $c/Department
where $a/Course/Prerequisites/Prereq = "CS106B"
return $a/Title

(: Question 5 :)
(: Return last names of all professors or lecturers who use a middle initial. Don't :)
(: worry about eliminating duplicates. :)

let $s := doc("courses.xml")/Course_Catalog/Department
return $s//(Professor|Lecturer)[(Middle_Initial)]/Last_Name

(: Question 6 :)
(: Return the count of courses that have a cross-listed course (i.e., that have "Cross-listed" :)
(: in their description). :)

let $catalog := doc('courses.xml')
return count($catalog//Course[contains(Description, "Cross-listed")])

(: Question 7 :)
(: Return the average enrollment of all courses in the CS department. :)

let $c := doc("courses.xml")
return $c//Department[@Code = "CS"]//avg(Course/@Enrollment)

(: Question 8 :)
(: Return last names of instructors teaching at least one course that has "system" :)
(: in its description and enrollment greater than 100. :)

let $s := doc("courses.xml")/Course_Catalog/Department
return $s//Course[contains(Description,"system") and @Enrollment > 100]//Last_Name

(: Question 9 :)
(: Return the course number of the course that is cross-listed as "LING180". :)

let $s := doc("courses.xml")/Course_Catalog/Department
return $s/Course[contains(Description,"LING180")]/data(@Number)


