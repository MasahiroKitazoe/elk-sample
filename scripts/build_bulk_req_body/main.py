import json

def _is_json(input: str) -> bool:
    try:
        json.loads(input)
    except ValueError as e:
        return False
    return True


def main(log_file_path: str, output_file_path: str) -> None:
    """
    This script is used to generate the bulk request body for the
    bulk request to the Elasticsearch cluster. It reads the
    file path given in the first argument and generates the bulk request body
    for the bulk request to the Elasticsearch cluster.
    """
    with open(log_file_path, "r") as log_file:
        with open(output_file_path, "w") as output_file:
            for line in log_file:
                line = line.strip()
                if not line:
                    continue
                record = json.loads(line)
                if not _is_json(record["log"]):
                    continue
                record["log"] = json.loads(record["log"])
                output_file.write(json.dumps({"index": {}}))
                output_file.write("\n")
                output_file.write(json.dumps(record))
                output_file.write("\n")


if __name__ == "__main__":
    main("../../logs/apigateway", "../../bulk.json")
