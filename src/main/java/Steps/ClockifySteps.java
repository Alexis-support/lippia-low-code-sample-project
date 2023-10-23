package Steps;

import com.crowdar.api.rest.APIManager;
import io.cucumber.java.en.And;
import org.testng.Assert;

public class ClockifySteps {

    @And("the response array is empty")
    public void verificarEmptyArrayResponse(){
        Object actualJsonResponse = (Object) APIManager.getLastResponse().getResponse();
        Assert.assertEquals(actualJsonResponse, "[]","La lista no se encuentra vacia");
    }
}
