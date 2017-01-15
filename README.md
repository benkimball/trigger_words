# Token Analyzer

A Ruby answer to the TalentBuddy challenge *Trigger words* by Vlad Berteanu.

In the time since this was written, it appears that the original TalentBuddy challenge page has been transferred to udemy.com and is no longer available, so I have reproduced the original challenge below.

## The Challenge

Let's consider a context that was extracted during the previous challenge:

    Did you read -TITLE-  on Kindle yesterday?

In this example, **read** and **Kindle** are trigger words. These types of words signal that there's a high likelihood of finding a book title in their vicinity.

A _trigger word_ is a token that has two properties:

* it is frequent in the list of extracted contexts
* it is specific to the field of books

In order to identify trigger words we are going to assign a weight to each token. Let's call this weight: **IDF** ("inverse document frequency") and define it thus:

    IDF(token) = log(N / num_contexts(token))

where **N** is the total number of contexts we are working with, and **num_contexts(token)** represents the number of contexts that contain the given token.

Given a list of contexts and an integer number **m**, your task is to write a function that prints to stdout the first **m** tokens having the highest IDF value, one per line. If there are more tokens having the same IDF value they must be sorted in lexicographical order.

You may assume that the length of the contexts array will not exceed 1000, and that the length of a context string will not exceed 1000 characters.

Your function is expected to print the requested result and return in less than 2 seconds.

**Example**

Input

    contexts: ["to read -TITLE- while in",
               "to buy -TITLE- while in school",
               "buy -TITLE-"]
    m: 2

Output

    read
    school

In this example we are working with 3 contexts, so N = 3; therefore IDF("read") = log(3/1) = 1.09, and IDF("buy") = log(3/2) = 0.40.

## Installation

Clone this repo. You're done.

## Usage

    ./idf contexts_file.txt

...where `contexts_file.txt` is an ordinary text file with one context per line. Example files are included at `test/contexts.txt` and `ricardo_contexts.txt`.

## Testing

    ./run_tests
