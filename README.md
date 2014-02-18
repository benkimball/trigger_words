# Token Analyzer

A Ruby answer to the TalentBuddy challenge ["Trigger words"](http://www.talentbuddy.co/challenge/519c21a14af0110af3823062519c21a14af0110af3823064) by Vlad Berteanu

By Ben Kimball, ben@unionmetrics.com

## Installation

Clone this repo. You're done.

## Usage

    ./idf contexts_file.txt

...where `contexts_file.txt` is an ordinary text file with one context per line. Example files are included at `test/contexts.txt` and `ricardo_contexts.txt`.

## Testing

    ./run_tests
