import "dotenv/config";
import {app } from "./app.js";
import { env } from "@/env/env.js";

const port = env.PORT;

app.listen(port, () => {
	console.log("[ms] App run api-notifyer in port 🚀", port);
});