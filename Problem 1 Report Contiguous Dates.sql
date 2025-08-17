# Write your MySQL query statement below
-- Step 1: Create a Common Table Expression (CTE) to compare the current row with the next two rows
WITH ConsecutiveNumsCTE AS (
    SELECT 
        l1.id AS CurrentID,        -- ID of the current row
        l1.num AS CurrentNum,      -- Number of the current row
        l2.num AS NextNum,         -- Number from the next row
        l3.num AS SecondNextNum    -- Number from the second next row
    FROM Logs l1
    -- Join the table with itself to get the next row (ID = CurrentID + 1)
    LEFT JOIN Logs l2
        ON l1.id = l2.id - 1
    -- Join the table again to get the second next row (ID = CurrentID + 2)
    LEFT JOIN Logs l3
        ON l1.id = l3.id - 2
)

-- Step 2: Select numbers that appear three times consecutively
SELECT DISTINCT CurrentNum AS ConsecutiveNums
FROM ConsecutiveNumsCTE
-- Filter rows where the current number is equal to both the next and the second next number
WHERE CurrentNum = NextNum AND NextNum = SecondNextNum;