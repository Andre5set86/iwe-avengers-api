package com.iwe.avengers;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.iwe.avenger.dynamodb.entity.Avenger;
import com.iwe.avenger.lambda.response.HandlerResponse;
import com.iwe.avengers.dao.AvengerDAO;

public class UpdateAvengersHandler implements RequestHandler<Avenger, HandlerResponse> {

	
	private AvengerDAO dao = new AvengerDAO();
	
	@Override
	public HandlerResponse handleRequest(final Avenger avenger, final Context context) {
		
		Avenger updatedAvenger = null;
		
		context.getLogger().log("[#] - Searching avenger by id:" + avenger.getId());
		
		if(dao.search(avenger.getId()) != null) {
			context.getLogger().log("[#] - Avenger Found:" + avenger.getName());
			updatedAvenger = dao.update(avenger);
			context.getLogger().log("[#] - Avenger Updated:" + avenger.getName());
		}
		
		final HandlerResponse response = HandlerResponse.builder().setObjectBody(updatedAvenger).build();
		
		return response;
	
	}
	
}
