import "dotenv/config";
import {app } from "./app";
import { env } from "@/env/env";

const port = env.PORT;

app.listen(port, () => {
	console.log("[ms] App run api-notifyer in port 🚀", port);
});