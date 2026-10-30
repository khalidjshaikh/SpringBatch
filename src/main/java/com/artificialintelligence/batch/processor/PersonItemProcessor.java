package com.artificialintelligence.batch.processor;

import com.artificialintelligence.batch.model.Person;
import org.springframework.batch.infrastructure.item.ItemProcessor;

public class PersonItemProcessor implements ItemProcessor<Person, Person> {

    @Override
    public Person process(Person item) {
        return new Person(item.getFirstName().toUpperCase(), item.getLastName().toUpperCase());
    }
}
