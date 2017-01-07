package SDingBa;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer;
import org.springframework.boot.context.embedded.EmbeddedServletContainerCustomizer;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Hello world!
 *
 */
@RestController
@EnableScheduling
@SpringBootApplication
public class App implements EmbeddedServletContainerCustomizer
{
    public static void main( String[] args )
    {
        System.out.println( "Hello World!" );
        SpringApplication.run(App.class, args);
    }

    @RequestMapping("/aaa")
    public String greeting() {
        return "Hello World!";
    }

    @Override
    public void customize(ConfigurableEmbeddedServletContainer container) {
        container.setPort(8082);
    }
}
