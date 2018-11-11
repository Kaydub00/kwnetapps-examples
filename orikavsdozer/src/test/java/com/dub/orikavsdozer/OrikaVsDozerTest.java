/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dub.orikavsdozer;

import java.util.ArrayList;
import java.util.List;
import ma.glasnost.orika.MapperFacade;
import ma.glasnost.orika.MapperFactory;
import ma.glasnost.orika.impl.DefaultMapperFactory;
import org.dozer.DozerBeanMapper;
import org.junit.Test;

/**
 *
 * @author admin
 */
public class OrikaVsDozerTest {
    
    DozerBeanMapper dozer;
    
    MapperFacade orika;
    
    int iterations;
    
    List<Long> orikaSimpleMapTime;
    
    List<Long> dozerSimpleMapTime;
    
    
    @Test
    public void testEachMapper() {
        
        iterations = 1000;
        
        orikaSimpleMapTime = new ArrayList(iterations);
        dozerSimpleMapTime = new ArrayList(iterations);
        
        initOrika();
        initDozer();
        
        
        
        //we're going to map this simple object
        MapFromClass from = new MapFromClass();
        from.setId(Long.valueOf(1));
        from.setName("NameOfMappedObject");
        
        for(int i = 0; i < iterations; i++) {
            mapOrika(from);
        }
        
        for(int i = 0; i < iterations; i++) {
            mapDozer(from);
        }
        
        long dozerTotalTime = 0;
        for(long time : dozerSimpleMapTime) {
            dozerTotalTime = dozerTotalTime + time;
        }
        
        long orikaTotalTime = 0;
        for(long time : orikaSimpleMapTime) {
            orikaTotalTime = orikaTotalTime + time;
        }
        
        System.out.println("Dozer took this long total for 10000 mappings: " + dozerTotalTime);
        System.out.println("Average mapping took: " + dozerTotalTime/iterations);
        
        System.out.println("Orika took this long total for 10000 mappings: " + orikaTotalTime);
        System.out.println("Average mapping took: " + orikaTotalTime/iterations);
        
        
    }
    
    private void mapDozer(MapFromClass from) {
        //see how fast dozer does it
        long startTime = System.nanoTime();
        MapToClass dozerSimple = new MapToClass();
        dozer.map(from, dozerSimple);
        long endTime = System.nanoTime();
        long dozerSimpleRunTime = endTime - startTime;
        dozerSimpleMapTime.add(dozerSimpleRunTime);
        System.out.println("dozer time: " + dozerSimpleRunTime);
        
    }
    
    private void mapOrika(MapFromClass from) {
        //see how fast orika does it
        long startTime = System.nanoTime();
        MapToClass orikaSimple = new MapToClass();
        orika.map(from, orikaSimple);
        long endTime = System.nanoTime();
        long orikaSimpleRunTime = endTime - startTime;
        orikaSimpleMapTime.add(orikaSimpleRunTime);
        System.out.println("orika time: " + orikaSimpleRunTime);
    }
    
    private void manualMap(MapFromClass from, MapToClass to) {
        to.setId(from.getId());
        to.setName(from.getName());
    }
    
    private void initDozer() {
        dozer = new DozerBeanMapper();
    }
    
    private void initOrika() {
        MapperFactory factory = new DefaultMapperFactory.Builder().build();
        orika = factory.getMapperFacade();
        
    }
    
    public class MapToClass {
        private Long id;
        
        private String name;

        /**
         * @return the id
         */
        public Long getId() {
            return id;
        }

        /**
         * @param id the id to set
         */
        public void setId(Long id) {
            this.id = id;
        }

        /**
         * @return the name
         */
        public String getName() {
            return name;
        }

        /**
         * @param name the name to set
         */
        public void setName(String name) {
            this.name = name;
        }
        
    }
    
    public class MapFromClass {
        private Long id;
        
        private String name;

        /**
         * @return the id
         */
        public Long getId() {
            return id;
        }

        /**
         * @param id the id to set
         */
        public void setId(Long id) {
            this.id = id;
        }

        /**
         * @return the name
         */
        public String getName() {
            return name;
        }

        /**
         * @param name the name to set
         */
        public void setName(String name) {
            this.name = name;
        }
        
    }
}
