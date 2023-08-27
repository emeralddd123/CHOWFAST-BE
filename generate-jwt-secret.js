const fs = require("fs");
const crypto = require("crypto");
const dotenv = require("dotenv");

dotenv.config(); // Load existing environment variables from .env file

const jwtSecret = crypto.randomBytes(32).toString("hex");

// Update the .env file with the new JWT_SECRET value
const envFileContent = `
JWT_SECRET=${jwtSecret}
`;

fs.writeFileSync(".env", envFileContent);

console.log("JWT Secret generated and saved to .env file.");
