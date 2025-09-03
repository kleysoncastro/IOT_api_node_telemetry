import { ZodError } from "zod";
import { env } from "@/env/env.js";
import cors from "cors";

import express from "express";
import type { Request, Response, NextFunction } from "express";
import { routes } from "@/http/routes.js";



const app = express();
app.use(express.json());
app.use(cors({
	origin: "*",
	methods: ["GET", "POST", "PUT", "DELETE"],
}));


app.use(routes);

app.use((error: Error, _request: Request, _response: Response, next: NextFunction) => {
	if (error instanceof ZodError) {
		return _response.status(400).json({
			message: "Validation Error",
			task: error.format(),
		});
	}

	if (env.NODE_ENV !== "prod") {
		console.error(error);
	}

	if (env.NODE_ENV === "prod") {
		//  Sentry config
	}

	_response.status(500).json({ message: "Internal server error!" });
	next();
});







export { app };