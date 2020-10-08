package org.joven.consume.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient("serviceProvide1")
public interface FeignClientProvide {

    @RequestMapping(value = "/client1/hello", method = RequestMethod.POST)
    String hello();

    @RequestMapping(value = "/client1/hello2", method = RequestMethod.POST)
    String hello2(@RequestParam("name") String name);
}
