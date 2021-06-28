# Makers BnB

## Instructions/Help for Team

### Database Queries
- the DatabaseConnection object should automatically connect to our test dbs (hopefully)
- query from other objects by using:
`DatabaseConnection.query(sql: "SQL string here querying parameter $1 WHERE $2 = whatever", params: [param1, param2] )`

### Rspec focus
- You can optionally add `, :focus` before the do..end block of any rspec unit describe (including multiple tests) to 
  focus in on particular tests, e.g.
  ```
  describe '.add', :focus do
    tests here
   end
  ```
- you can add as many :focus points as you like, it will include each one with that tag
  => just remember to delete the `, :focus` when you're done please, so it doesn't get committed to main!
