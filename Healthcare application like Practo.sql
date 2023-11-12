1. Identify the most requested appointment times:
  
SELECT
 DATE_FORMAT(AppointmentDateTime, '%Y-%m-%d %H:%i') AS AppointmentTime,
 COUNT(*) AS AppointmentCount
FROM
 Appointment
GROUP BY
 AppointmentTime
ORDER BY
 AppointmentCount DESC;


2. Analyze appointment patterns for specific doctors:
  
SELECT
 d.Name AS DoctorName,
 COUNT(*) AS AppointmentCount
FROM
 Appointment a
JOIN
 HealthcareProvider d ON a.DoctorID = d.DoctorID
GROUP BY
 DoctorName
ORDER BY
 AppointmentCount DESC;


3. Analyze patient demographics to tailor healthcare services:
  
SELECT
 Gender,
 COUNT(*) AS PatientCount
FROM
 Patient
GROUP BY
 Gender;


4. Evaluate doctor performance based on reviews and ratings:
  
SELECT
 d.Name AS DoctorName,
 AVG(r.Rating) AS AverageRating,
 COUNT(r.ReviewID) AS ReviewCount
FROM
 HealthcareProvider d
JOIN
 Review r ON d.DoctorID = r.DoctorID
GROUP BY
 DoctorName
ORDER BY
 AverageRating DESC;


5.Identify doctors with the highest patient satisfaction:
  
SELECT
 d.Name AS DoctorName,
 AVG(r.Rating) AS AverageRating
FROM
 HealthcareProvider d
JOIN
 Review r ON d.DoctorID = r.DoctorID
GROUP BY
 DoctorName
ORDER BY
 AverageRating DESC
LIMIT 1;


6.Analyze medical records for prevalent diseases or conditions:
  
SELECT
 Diagnosis,
 COUNT(*) AS DiagnosisCount
FROM
 MedicalRecord
GROUP BY
 Diagnosis
ORDER BY
 DiagnosisCount DESC;


7. Analyze the popularity of clinics/hospitals:
  
SELECT
 c.Name AS ClinicName,
 COUNT(*) AS AppointmentCount
FROM
 Clinic c
JOIN
 Appointment a ON c.ClinicID = a.ClinicID
GROUP BY
 ClinicName
ORDER BY
 AppointmentCount DESC;


8. Identify high-traffic locations:
  
SELECT
 l.Location,
 COUNT(*) AS AppointmentCount
FROM
 Location l
JOIN
 Clinic c ON l.LocationID = c.LocationID
JOIN
 Appointment a ON c.ClinicID = a.ClinicID
GROUP BY
 Location
ORDER BY
 AppointmentCount DESC;


9. Analyze payment patterns and identify preferred payment methods:
  
SELECT
 PaymentStatus,
 COUNT(*) AS PaymentCount
FROM
 Payment
GROUP BY
 PaymentStatus;


10. Identify areas for improvement based on patient feedback:
  
SELECT
 Comment,
 COUNT(*) AS CommentCount
FROM
 Review
GROUP BY
 Comment
ORDER BY
 CommentCount DESC;


11. Monitor changes in review trends over time:
  
SELECT
 DATE_FORMAT(Date, '%Y-%m') AS ReviewMonth,
 COUNT(*) AS ReviewCount
FROM
 Review
GROUP BY
 ReviewMonth
ORDER BY
 ReviewMonth;


12. Identify patients with frequent appointments:
  
SELECT
 p.Name AS PatientName,
 COUNT(*) AS AppointmentCount
FROM
 Patient p
JOIN
 Appointment a ON p.PatientID = a.PatientID
GROUP BY
 PatientName
ORDER BY
 AppointmentCount DESC;


13. Calculate revenue generated from appointments and services:
  
SELECT
 a.DoctorID,
 d.Name AS DoctorName,
 SUM(a.Amount) AS TotalRevenue
FROM
 Appointment a
JOIN
 HealthcareProvider d ON a.DoctorID = d.DoctorID
GROUP BY
 a.DoctorID, DoctorName
ORDER BY
 TotalRevenue DESC;


14. Monitor and analyze reasons for appointment cancellations:
  
SELECT
 Status,
 COUNT(*) AS CancellationCount
FROM
 Appointment
WHERE
 Status = 'Cancelled'
GROUP BY
 Status;
