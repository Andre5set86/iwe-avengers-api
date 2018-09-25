package com.iwe.avengers;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.iwe.avenger.dynamodb.entity.Avenger;
import com.iwe.avenger.lambda.response.HandlerResponse;
import com.iwe.avengers.dao.AvengerDAO;

public class CreateAvengersHandler implements RequestHandler<Avenger, HandlerResponse> {

	
	private final AvengerDAO dao = new AvengerDAO();
	
	@Override
	public HandlerResponse handleRequest(final Avenger newAvenger, final Context context) {

		if(newAvenger==null) {			
			return null;
		}
		
		context.getLogger().log("[#] - Creating new avenger:" + newAvenger.getName());
		
		Avenger createdAvenger = dao.create(newAvenger);
		
		context.getLogger().log("[#] - Avenger Created:" + newAvenger.getId());
		
		final HandlerResponse response = HandlerResponse.builder().setStatusCode(201).setObjectBody(createdAvenger).build();
		
		return response;

	}
}
