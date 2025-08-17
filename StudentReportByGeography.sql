SELECT 
    s.continent,
    ROUND(AVG(sub.grade), 2) AS average_grade
FROM
    Student s
    JOIN 
    Subjects sub
    ON s.student_id = sub.student_id
GROUP BY s.continent
ORDER BY s.continent;