def parse_yaml(stream):
    import yaml
    return yaml.safe_load(stream)

def parse_json(stream):
    import json
    return json.loads(stream)

def parse_cson(stream):
    import cson
    return cson.loads(stream)

def parse(stream, ext):
    print(stream)
    print(ext)
    if ext in ['yaml', 'yml']:
        return parse_yaml(stream)
    elif ext == 'cson':
        return parse_cson(stream)
    elif ext == 'json':
        return parse_json(stream)
    else:
        raise Exception('unsupported format', ext)
