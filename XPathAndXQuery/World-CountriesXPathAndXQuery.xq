(: Question 1 :)
(: Return the area of Mongolia.  :)

let $s := doc("countries.xml")/countries/country
for $a in $s
where $a/@name = "Mongolia"
return data($a/@area)

(: Question 2 :)
(: Return the names of all cities that have the same name as the country in which they are located.  :)

for $s in doc("countries.xml")//country
for $a in $s/city
where $s/@name = $a/name
return $a/name

(: Question 3 :)
(: Return the average population of Russian-speaking countries.  :)

let $s := doc("countries.xml")/countries/country
return avg($s[language="Russian"]/data(@population))

(: Question 4 :)
(: Return the names of all countries that have at least three cities with population greater than 3 million.  :)

doc("countries.xml")//country[count(city[population>3000000])>=3]/data(@name)

(: Question 5 :)
(: Create a list of French-speaking and German-speaking countries. :)

<result>
<French>
{for $s in doc("countries.xml")//country
where $s[language="French"]
return <country>{data($s/@name)}</country>}
</French>
<German>
{for $s in doc("countries.xml")//country
where $s[language="German"]
return <country>{data($s/@name)}</country>}
</German>
</result>

(: Question 6 :)
(: Return the countries with the highest and lowest population densities. Note that because the "/" operator has its own meaning in XPath and XQuery, the division operator is infix "div". To compute population density use "(@population div @area)". You can assume density values are unique.  :)
