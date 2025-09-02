import { Request, Response } from "express";

async function healthcheckeAws(
	request: Request,
	reply: Response
) {

	return reply.status(200).send({ ok: "ok!" });

}


export { healthcheckeAws };