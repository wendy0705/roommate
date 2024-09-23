package com.example.roommate.utils;

import lombok.extern.slf4j.Slf4j;

import java.util.List;

@Slf4j
public class SimilarityCalculationUtils {

    public static int compareTwoChoices(int a, int b) {
        if (a == b) {
            return 1;
        } else {
            return 0;
        }
    }

    public static double compareSimpleDistance(int personA, int personB, int distance) {

        double percentage = calculateSimpleSimilarityPercentage(personA, personB, distance);

        return percentage;
    }

    public static double calculateMaxDistance(int interval, int numFeatures, int length) {
        return Math.sqrt(length * numFeatures * Math.pow(interval, 2));
    }

    public static double calculateSimilarityPercentage(Integer[] vector1, Integer[] vector2, double maxDistance, boolean isTimeCalculation) {
        double distance;

        if (isTimeCalculation) {
            distance = calculateTimeEuclideanDistance(vector1, vector2);
        } else {
            distance = calculateEuclideanDistance(vector1, vector2);
        }
        double percentage = (1 - (distance / maxDistance));
        if (percentage <= 0) {
            percentage = 0;
        }
        return percentage;
    }

    public static double calculateTimeEuclideanDistance(Integer[] vector1, Integer[] vector2) {
        if (vector1.length != vector2.length) {
            throw new IllegalArgumentException("向量的大小必須相同");
        }

        double sum = 0.0;
        for (int i = 0; i < vector1.length; i++) {
            double diff = calculateTimeDifference(vector1[i], vector2[i]);
            sum += Math.pow(diff, 2);
        }
        return Math.sqrt(sum);
    }

    public static double calculateTimeDifference(Integer time1, Integer time2) {
        double diff = Math.abs(time1 - time2);
        return Math.min(diff, 24 - diff);
    }

    public static double calculateEuclideanDistance(Integer[] vector1, Integer[] vector2) {
        if (vector1.length != vector2.length) {
            throw new IllegalArgumentException("向量的大小必須相同");
        }

        double sum = 0.0;
        for (int i = 0; i < vector1.length; i++) {
            double diff = vector1[i] - vector2[i];
            sum += Math.pow(diff, 2);
        }
        return Math.sqrt(sum);
    }

    public static double calculateSimpleSimilarityPercentage(int value1, int value2, int maxDistance) {

        double distance = Math.abs(value1 - value2);

        double percentage = distance / maxDistance;
        return percentage;
    }

    public static <T> double calculateOrderedJaccardSimilarity(List<T> listA, List<T> listB) {
        int minSize = Math.min(listA.size(), listB.size());
        int maxSize = Math.max(listA.size(), listB.size());

        int intersectionSize = 0;
        int unionSize = maxSize;

        for (int i = 0; i < minSize; i++) {
            if (listA.get(i).equals(listB.get(i))) {
                intersectionSize++;
            }
        }

        return (double) intersectionSize / unionSize;
    }
}
