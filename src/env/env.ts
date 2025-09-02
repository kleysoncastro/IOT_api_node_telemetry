import "dotenv/config";

import { z } from "zod";

const envSchema = z.object({
	NODE_ENV: z.enum(["dev", "test", "prod"]).default("dev"),
	PORT: z.coerce.number().default(3004),
	JWT_SECRET: z.string(),
});

const parseEnv = envSchema.safeParse(process.env);

if (parseEnv.success === false) {
	console.error(
		"[MS Register]",
		"Erro Parse ENVIROMENT variable",
		parseEnv.error.format()
	);

	throw new Error("Invalid environment variable");
}

export const env = parseEnv.data;